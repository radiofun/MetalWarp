# MetalWarp

An iOS app with two interactive Metal shader demos: a touch-driven image warp with chromatic aberration, and a light-distortion effect on a blurred circle.

## What it does

The app presents two tabs, each showcasing a different real-time `layerEffect` shader:

- **Warp tab** — Drag your finger over a sample image to push and distort pixels around the touch point. Chromatic aberration splits the R, G, and B channels at different offsets for a lens-like fringe.
- **Circle tab** — A blurred white circle is warped by a light-distortion shader. Control the distortion angle and blur radius with sliders.

## Features

- Two Metal `stitchable` shaders: `warp` and `light`
- Touch-driven distortion center via `DragGesture`
- Chromatic aberration (per-channel displacement) in the warp shader
- Real-time sliders for warp factor, intensity, angle, and blur
- SwiftUI `TabView` navigation between the two demos

## Tech Stack

- **SwiftUI** — layout, gestures, sliders, tab navigation
- **Metal** — `stitchable` fragment shaders via the SwiftUI Shader API
- **Xcode 16+**

## Requirements

- Xcode 16+
- iOS 17+

## How to Run

1. Open `MetalWarpView/MetalWarpView.xcodeproj` in Xcode.
2. Select a simulator or device running iOS 17+.
3. Build and run (`⌘R`).
4. Use the sliders and drag gestures in each tab to explore the effects.
