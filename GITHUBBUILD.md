# GitHub Build Fleet: Architecture & Infrastructure Guide

This guide details the multi-tiered GitHub build system used for high-performance, cross-platform compilation of Kodi and its primary add-ons. It is designed to be portable to other `gemini-cli` projects requiring a "Hub-Builder-Distributor" model.

---

## 1. Architecture Overview

The fleet operates across three distinct repository tiers. This high-complexity model is specifically designed for large projects (e.g., Kodi Core) where a single repository would face rate limits or resource exhaustion.

### Tier 1: The Hub (`kodi-build`)
- **Role**: Command and Control.
- **Functions**:
    - Stores the fleet manifest (`sources.yaml`).
    - Orchestrates the entire fleet via `orchestrate-fleet.yml`.
    - **Status Aggregation**: Hosts a `fleet-status.json` and a `status-aggregator.yml` workflow to receive real-time build updates from the fleet.
    - **Depends-as-a-Service**: Weekly builds of the `tools/depends` system, delivered via GitHub Releases to all Builder nodes.

### Tier 2: The Builders (e.g., `xbmc-build`, `inputstream.adaptive-build`)
- **Role**: Compilation & Packaging.
- **Functions**:
    - Clones upstream source code.
    - Executes heavy C++ compilation using local or hosted runners.
    - **Pre-Flight Validation**: Audits the local environment (SDKs, paths, auth) before starting heavy compilation.
    - Uploads artifacts directly to Tier 3 (Distributors).

### Tier 3: The Distributors (e.g., `xbmc-build-win64`, `xbmc-build-linux64`)
- **Role**: Artifact Hosting & Release.
- **Functions**:
    - Receives compiled binaries via `workflow_dispatch` or `gh release`.
    - Acts as a permanent host for binary releases for specific OS/Architecture pairs.

---

## 2. Fleet Stability Architecture (V2)

The 2026 refactor introduced five key pillars of stability to ensure the fleet remains operational under high load.

### 2.1 Depends-as-a-Service
To eliminate the 45-60 minute bootstrap time required for `tools/depends` on every run, the Hub now performs a weekly "pre-compilation" for all target platforms.
- **Workflow**: `build-depends.yml` runs on the Hub, archives the `xbmc-deps` directory, and publishes it to a release.
- **Consumption**: Builders download and extract this archive at the start of their run, ensuring 100% toolchain parity and a 90% reduction in "bootstrap failure" risk.

### 2.2 Verified Base Image Pipeline
Local runners no longer build Dockerfiles on the host. This prevents configuration drift between nodes.
- **Registry**: Images are pushed to **GHCR** (`ghcr.io/rpdevs-builds/runner-linux-builder`).
- **Lifecycle**: `docker-publish.yml` builds new images upon Dockerfile changes. Runners are configured to `image: ghcr.io/...:latest` and pull the verified state on restart.

### 2.3 Rate-Limit Aware Orchestration
Standard polling for 30+ repositories exhausts the 5,000 requests/hour limit. We pivoted to a **Push-Based** status model.
- **Hub Aggregator**: A dedicated `repository_dispatch` handler on the Hub.
- **Builder Hook**: An `always()` step at the end of the `build.yml` workflow that dispatches its status, conclusion, and run URL back to the Hub.
- **Result**: API consumption dropped by ~95%, and the Hub maintains a single source of truth in `fleet-status.json`.

### 2.4 Pre-Flight Validation
To prevent "Ghost Failures" (builds that fail 2 hours in due to a missing header or misconfigured SDK), every job begins with a rapid environment audit.
- **Checks**: Verifies `ccache` health, Android NDK presence, `gh` CLI authentication, and platform-specific headers (e.g., `waylandpp`, `libdisplay-info`).

### 2.5 Automated Workspace Housekeeping
Self-hosted runners accumulate high amounts of disk bloat from Docker layers and volume remnants.
- **Workflow**: `housekeeping.yml` runs weekly to execute `docker system prune -af` and clean the GitHub Actions `_work` directories, ensuring 100% disk availability for the next build cycle.

---

## 3. OS-Specific Build Logic

We use a unified build approach centered around Kodi's internal `depends` system.

### Linux (Ubuntu 22.04)
- **Method**: Native CMake.
- **Logic**: Uses system libraries. For missing modern libraries (e.g., `libdisplay-info`), the runner image includes a manual source-build step.
- **Flags**: `-DAPP_RENDER_SYSTEM=gl` and a suite of `-DENABLE_INTERNAL_*` flags to ensure build hermeticity.

### Cross-Platform (Windows, Android, macOS)
- **Method**: `depends` Integration.
- **Priority**: Always attempt to download `Depends-as-a-Service` tarballs first. Fall back to manual `make -C tools/depends` only if the release asset is missing.

---

## 4. Local Runner Infrastructure (The "Runner Farm")

### Deployment (`runners/docker-compose.yml`)
```yaml
services:
  linux-builder:
    image: ghcr.io/rpdevs-builds/runner-linux-builder:latest
    container_name: kodi-linux-builder
    restart: always
    environment:
      - GH_OWNER=RPDevs-Builds
      - GH_TOKEN=${GH_PAT}
```

---

## 5. Maintenance & Tooling

### `_update_workflows_api.py`
The "Fleet Commander" script. It uses the GitHub API to update `build.yml` across all 30+ repos simultaneously. It is the primary mechanism for deploying new stability hooks and platform flags to the entire fleet in seconds.

### `monitor.zsh`
The real-time dashboard. Optimized for Zsh, it provides a high-density matrix view of the fleet's health, now optimized to work alongside the Hub's status aggregator.

---
*Maintained by RPDevs-Builds*
