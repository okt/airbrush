<div align="center">

![Airbrush Icon](airbrush.png?raw=true "Airbrush")
# Airbrush
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white "Xcode")
![objective-c](https://img.shields.io/badge/Objective--c-000000?style=for-the-badge&logo=apple&logoColor=white "objective-c")
[![Discord](https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white "Discord")](https://discord.gg/tgGWqvep)
</div>


**Airbrush** is a [MacForge](https://github.com/MacEnhance/MacForge) plugin designed to make it easier than ever to apply system wide themes to macOS 10.14 and above.

## Installation

1. Download the latest [Release](https://github.com/i-pwl/airbrush/releases)
2. Unzip the `airbrush.zip` contents to: `/Library/Application Support/MacEnhance/Plugins (Disabled)`
3. Unzip your theme of choice to: `/Library/Airbrush`
4. Launch MacForge and enable the **Airbrush** plugin


## Theme Creation
### Images
Within `/Library/Airbrush` currently the **Airbrush** plugin will accept the following images:

- `Minimize.png`
  Width: 28px,
  Height: 28px
- `Close.png`
  Width: 28px,
  Height: 28px
- `Zoom.png`
  Width: 28px,
  Height: 28px
- `SegmentBack.png`
  Width: 40px,
  Height: 52px
  Slices: Segment
- `SegmentBackAlt.png`
- `MiniSegmentBack.png`
  Width: 32px,
  Height: 38px,
  Slices: MiniSegment
- `MiniSegmentBackAlt.png`
  
- `Titlebar.png`
- `MiniTitlebar.png`
  
These dimensions are just a starting point, and with adjusted slice margins the border gaps, heights, and widths of the images can be adjusted.

### Config File
Images can be configured with slicing margins (Top, Left, Bottom, Right), using `Config.ini`:
```ini
[Settings]
Author = Bedtime
NineSlicing = 14, 16, 22, 16

[Slices]
Segment = 14, 16, 22, 16
MiniSegment = 14, 14, 14, 14
Button = 1, 1, 1, 1
```

<hr />

## Help & Development

Please submit issues here: [Submit](https://github.com/i-pwl/airbrush/issues/new)
  
Join the discussion on Discord: https://discord.gg/tgGWqvep