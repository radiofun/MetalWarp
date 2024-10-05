//
//  Metal.metal
//  MetalWarpView
//
//  Created by Minsang Choi on 10/5/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;




[[ stitchable ]] half4 warp(float2 position, SwiftUI::Layer l, float2 size, float2 ct, float warp, float intensity) {

    // Baseline positioning, normalize everything
    float2 uv = position / size;
    float2 touch = ct / size;
    //calculate distance
    float distance = length(uv-touch);
    float warpFactor = warp / 40; //angle is now 0-1
    
    //make it non-linear
    float offsetfactor = warpFactor * warpFactor * intensity * intensity;
    //closest the stronger
    float displacefactor = (0.5 - distance);
    //convert it with size, add intensity
    float2 displacement = displacefactor * size * intensity;
    float2 newposition = (position + exp(displacement * warpFactor * 2));
    
    half3 f =  half3(l.sample(newposition+offsetfactor*intensity).r,l.sample(newposition+offsetfactor*0.1).g,l.sample(newposition-offsetfactor/5).b);

    // Return the final color with alpha set to 1.0
    return half4(f, 1.0);
}
