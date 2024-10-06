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
    float warpFactor = warp / 40;
    
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

//Light CA
[[ stitchable ]] half4 light(float2 position, SwiftUI::Layer l, float2 size, float2 ct, float angle) {

    // Baseline positioning, normalize everything
    float2 uv = position / size;
    float2 center = ct / size;
    float2 direction = uv-center;
    float distance = length(direction);
    float normalizedAngle = angle / 40;
    
    //non-linear curves for offsetfactor, make it smaller
    float offsetfactor = normalizedAngle * normalizedAngle * 2;
    //farther from the center of the image, it gets larger, amplified by normalized angle
    float displacefactor = 1.0 - (distance * distance) * normalizedAngle * 2;
    //make new position more non-linear, and then add displace factor, make them smaller (larger the number, smaller it gets)
//    float2 newposition = position + position * displacefactor * 2;
    //sin makes repated pattern
//    float2 newposition = position * sin(displacefactor * 3.14);
    //multiply creates different effects
    float2 newposition = position * pow(displacefactor,2);
    
    //reset the colors
    half3 c = half3(l.sample(newposition+offsetfactor).r,l.sample(newposition+offsetfactor*0.2).g,l.sample(newposition-offsetfactor).b);

    // Return the final color with alpha set to 1.0
    return half4(c, 1.0);
}
