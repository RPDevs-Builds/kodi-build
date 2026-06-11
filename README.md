# Kodi Build Hub 🚀

Welcome to the central orchestration hub for all things Kodi. This repository manages the automated compilation and distribution of Kodi Core, Plugins, Scripts, Scrapers, and Inputstream addons across multiple platforms.

## Build & Distribution Status

| Component | Platform | Piers (master) Status | Omega Status | Release Repository |
|:---|:---:|:---:|:---:|:---|
| **Kodi Core** | Linux 64 | [![Piers](https://github.com/IamRPDev/xbmc-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/xbmc-build/actions) | [![Omega](https://github.com/IamRPDev/xbmc-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/xbmc-build/actions) | [xbmc-build-linux64](https://github.com/IamRPDev/xbmc-build-linux64) |
| | Windows 64 | | | [xbmc-build-win64](https://github.com/IamRPDev/xbmc-build-win64) |
| | Android ARM64 | | | [xbmc-build-android-arm64](https://github.com/IamRPDev/xbmc-build-android-arm64) |
| | OSX 64 | | | [xbmc-build-osx64](https://github.com/IamRPDev/xbmc-build-osx64) |
| **Plugins** | Linux 64 | [![Piers](https://github.com/IamRPDev/repo-plugins-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/repo-plugins-build/actions) | [![Omega](https://github.com/IamRPDev/repo-plugins-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/repo-plugins-build/actions) | [repo-plugins-build-linux64](https://github.com/IamRPDev/repo-plugins-build-linux64) |
| | Windows 64 | | | [repo-plugins-build-win64](https://github.com/IamRPDev/repo-plugins-build-win64) |
| | Android ARM64 | | | [repo-plugins-build-android-arm64](https://github.com/IamRPDev/repo-plugins-build-android-arm64) |
| | OSX 64 | | | [repo-plugins-build-osx64](https://github.com/IamRPDev/repo-plugins-build-osx64) |
| **Scripts** | Linux 64 | [![Piers](https://github.com/IamRPDev/repo-scripts-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/repo-scripts-build/actions) | [![Omega](https://github.com/IamRPDev/repo-scripts-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/repo-scripts-build/actions) | [repo-scripts-build-linux64](https://github.com/IamRPDev/repo-scripts-build-linux64) |
| | Windows 64 | | | [repo-scripts-build-win64](https://github.com/IamRPDev/repo-scripts-build-win64) |
| | Android ARM64 | | | [repo-scripts-build-android-arm64](https://github.com/IamRPDev/repo-scripts-build-android-arm64) |
| | OSX 64 | | | [repo-scripts-build-osx64](https://github.com/IamRPDev/repo-scripts-build-osx64) |
| **Scrapers** | Linux 64 | [![Piers](https://github.com/IamRPDev/repo-scrapers-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/repo-scrapers-build/actions) | [![Omega](https://github.com/IamRPDev/repo-scrapers-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/repo-scrapers-build/actions) | [repo-scrapers-build-linux64](https://github.com/IamRPDev/repo-scrapers-build-linux64) |
| | Windows 64 | | | [repo-scrapers-build-win64](https://github.com/IamRPDev/repo-scrapers-build-win64) |
| | Android ARM64 | | | [repo-scrapers-build-android-arm64](https://github.com/IamRPDev/repo-scrapers-build-android-arm64) |
| | OSX 64 | | | [repo-scrapers-build-osx64](https://github.com/IamRPDev/repo-scrapers-build-osx64) |
| **FFmpegDirect**| Linux 64 | [![Piers](https://github.com/IamRPDev/inputstream.ffmpegdirect-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/inputstream.ffmpegdirect-build/actions) | [![Omega](https://github.com/IamRPDev/inputstream.ffmpegdirect-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/inputstream.ffmpegdirect-build/actions) | [ffmpegdirect-linux64](https://github.com/IamRPDev/inputstream.ffmpegdirect-build-linux64) |
| | Windows 64 | | | [ffmpegdirect-win64](https://github.com/IamRPDev/inputstream.ffmpegdirect-build-win64) |
| | Android ARM64 | | | [ffmpegdirect-android-arm64](https://github.com/IamRPDev/inputstream.ffmpegdirect-build-android-arm64) |
| | OSX 64 | | | [ffmpegdirect-osx64](https://github.com/IamRPDev/inputstream.ffmpegdirect-build-osx64) |
| **Adaptive** | Linux 64 | [![Piers](https://github.com/IamRPDev/inputstream.adaptive-build/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/IamRPDev/inputstream.adaptive-build/actions) | [![Omega](https://github.com/IamRPDev/inputstream.adaptive-build/actions/workflows/build.yml/badge.svg?branch=Omega)](https://github.com/IamRPDev/inputstream.adaptive-build/actions) | [adaptive-linux64](https://github.com/IamRPDev/inputstream.adaptive-build-linux64) |
| | Windows 64 | | | [adaptive-win64](https://github.com/IamRPDev/inputstream.adaptive-build-win64) |
| | Android ARM64 | | | [adaptive-android-arm64](https://github.com/IamRPDev/inputstream.adaptive-build-android-arm64) |
| | OSX 64 | | | [adaptive-osx64](https://github.com/IamRPDev/inputstream.adaptive-build-osx64) |

## Repository Architecture

This ecosystem uses a three-tier model:
1.  **Hub (`kodi-build`)**: This repository. Orchestrates triggers and monitors the fleet.
2.  **Builders (`-build`)**: Contain the GitHub Action logic and compilation scripts for both **Piers** and **Omega** branches.
3.  **Distributors (`-build-<os>`)**: Dedicated repositories that host the final compiled installers as GitHub Releases, ensuring clean isolation and high availability.

---
*Maintained by IamRPDev*
