//
//  ImageWarpView.swift
//  MetalWarpView
//
//  Created by Minsang Choi on 10/5/24.
//

import SwiftUI

struct ImageWarpView: View {
    @State private var position = CGPoint(x:180,y:180)
    @State private var imageSize = CGSize(width: 360, height: 360)

    @State private var warpfactor : Double = 1
    @State private var intensity : Double = 0.5

    var body: some View {
        ZStack {
            Image("sample")
                .resizable()
                .frame(width:360,height: 360)
                .scaledToFill()
                .layerEffect(
                    ShaderLibrary.warp(
                        .float2(imageSize),
                        .float2(position),
                        .float(warpfactor),
                        .float(intensity)
                    ), maxSampleOffset: CGSize(width:320,height:360)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in position = value.location }
                )
            VStack{
                Text("Warp: \(String(format: "%.2f", warpfactor)), Strength: \(String(format: "%.2f", intensity))")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.white)
                    .padding()
                HStack{
                    Text("Warp")
                        .font(.system(size:12,design:.monospaced))
                        .foregroundStyle(.white)
                        .frame(width:50)
                    
                    Slider(value: $warpfactor, in: 0...5)
                        .tint(.gray)
                }
                HStack{
                    Text("Str")
                        .font(.system(size:12,design:.monospaced))
                        .foregroundStyle(.white)
                        .frame(width:50)
                    
                    Slider(value: $intensity, in: 0...1)
                        .tint(.gray)
                }

            }
            .offset(y:280)
            .padding()
        }
    }
}

#Preview {
    ImageWarpView()
}
