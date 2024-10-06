//
//  CircleView.swift
//  MetalWarpView
//
//  Created by Minsang Choi on 10/5/24.
//

import SwiftUI


struct CircleView: View {
    @State private var position = CGPoint(x:180,y:180)
    @State private var imageSize = CGSize(width: 360, height: 360)
    @State private var angle : Double = 100
    @State private var blur : Double = 40

    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .frame(width:360,height: 360)
                .scaledToFill()
                .blur(radius: blur)
                .layerEffect(
                    ShaderLibrary.light(
                        .float2(imageSize),
                        .float2(position),
                        .float(angle)
                    ), maxSampleOffset: CGSize(width:320,height:360)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in position = value.location }
                )
            VStack{
                Text("Angle: \(String(format: "%.2f", angle)), Blur: \(String(format: "%.2f", blur))")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.white)
                    .padding()
                HStack{
                    Text("Ang")
                        .font(.system(size:12,design:.monospaced))
                        .foregroundStyle(.white)
                        .frame(width:50)
                    
                    Slider(value: $angle, in: 0...360)
                        .tint(.gray)
                }
                
                HStack{
                    Text("BLR")
                        .font(.system(size:12,design:.monospaced))
                        .foregroundStyle(.white)
                        .frame(width:50)
                    
                    Slider(value: $blur, in: 0...100)
                        .tint(.gray)
                }
            }
            .offset(y:280)
            .padding()
        }
    }
}

#Preview {
    CircleView()
}
