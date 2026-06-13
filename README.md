# Kodi Build Hub 🚀

Welcome to the central orchestration hub for the RPDevs-Builds Kodi ecosystem. This repository manages the automated compilation and distribution of Kodi Core and its primary binary and python add-ons across a multi-tiered repository fleet.

## Build & Distribution Status

| Component | Piers (v22) Status | Omega (v21) Status | Build/Release Repository |
|:---|:---:|:---:|:---|
| **Kodi Core** | [![Piers](https://github.com/RPDevs-Builds/xbmc-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/xbmc-build/actions) | [![Omega](https://github.com/RPDevs-Builds/xbmc-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/xbmc-build/actions) | [xbmc-build](https://github.com/RPDevs-Builds/xbmc-build) |
| **Plugins** | [![Piers](https://github.com/RPDevs-Builds/repo-plugins-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/repo-plugins-build/actions) | [![Omega](https://github.com/RPDevs-Builds/repo-plugins-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/repo-plugins-build/actions) | [repo-plugins-build](https://github.com/RPDevs-Builds/repo-plugins-build) |
| **Scripts** | [![Piers](https://github.com/RPDevs-Builds/repo-scripts-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/repo-scripts-build/actions) | [![Omega](https://github.com/RPDevs-Builds/repo-scripts-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/repo-scripts-build/actions) | [repo-scripts-build](https://github.com/RPDevs-Builds/repo-scripts-build) |
| **Scrapers** | [![Piers](https://github.com/RPDevs-Builds/repo-scrapers-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/repo-scrapers-build/actions) | [![Omega](https://github.com/RPDevs-Builds/repo-scrapers-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/repo-scrapers-build/actions) | [repo-scrapers-build](https://github.com/RPDevs-Builds/repo-scrapers-build) |
| **FFmpegDirect**| [![Piers](https://github.com/RPDevs-Builds/inputstream.ffmpegdirect-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/inputstream.ffmpegdirect-build/actions) | [![Omega](https://github.com/RPDevs-Builds/inputstream.ffmpegdirect-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/inputstream.ffmpegdirect-build/actions) | [inputstream.ffmpegdirect-build](https://github.com/RPDevs-Builds/inputstream.ffmpegdirect-build) |
| **Adaptive** | [![Piers](https://github.com/RPDevs-Builds/inputstream.adaptive-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/RPDevs-Builds/inputstream.adaptive-build/actions) | [![Omega](https://github.com/RPDevs-Builds/inputstream.adaptive-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/RPDevs-Builds/inputstream.adaptive-build/actions) | [inputstream.adaptive-build](https://github.com/RPDevs-Builds/inputstream.adaptive-build) |

## 🏗️ Fleet Stability Architecture

This fleet utilizes a custom-built infrastructure designed for high-performance C++ builds.

- **Depends-as-a-Service:** Weekly pre-compilation of the `tools/depends` system, delivered via GitHub Releases to all Builder nodes to ensure 100% environment parity and fast start times.
- **Verified Runner Pipeline:** Local Docker runners use verified images hosted on **GHCR**, updated automatically upon Dockerfile changes.
- **Pre-Flight Validation:** Every build job performs a rapid 10-second environment audit before beginning compilation to ensure SDKs and auth are properly configured.
- **Automated Housekeeping:** Weekly scheduled cleanup of Docker layers and workspace volumes to prevent disk exhaustion on heavy runner nodes.
- **Rate-Limit Aware Orchestration:** Builders utilize webhook-based "check-ins" to update the Hub aggregator, drastically reducing API polling.

## 📦 Distribution Model
- **Kodi Core:** Distributed via platform-specific repositories ([Linux](https://github.com/RPDevs-Builds/xbmc-build-linux64), [Windows](https://github.com/RPDevs-Builds/xbmc-build-win64), [Android](https://github.com/RPDevs-Builds/xbmc-build-android-arm64), [OSX](https://github.com/RPDevs-Builds/xbmc-build-osx64)).
- **Binary Addons:** Built and hosted directly on their respective Builder repository releases.

## 🛠️ Infrastructure Management
- **Hub (`kodi-build`)**: This repository. Orchestrates triggers, manages `sources.yaml`, and hosts the runner farm configurations.
- **Runners**: Managed via `docker-compose.yml` in the `runners/` directory.

---
*Maintained by RPDevs-Builds*
