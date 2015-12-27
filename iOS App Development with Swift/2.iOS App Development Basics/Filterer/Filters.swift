//
//  AppDelegate.swift
//  Filterer.2
//
//  Created by Scarlett on 11/10/15.
//  Copyright © 2015 Scarlett. All rights reserved.
//

// Filter
class filters {
    
    // Red Channel
    static func redChannel(image: RGBAImage, adjustment: Double) -> RGBAImage {
        return filters.adjustChannels(image, redChannel: adjustment, blueChannel: 0, greenChannel: 0)
    }
    
    // Blue Channel
    static func blueChannel(image: RGBAImage, adjustment: Double) -> RGBAImage {
        return filters.adjustChannels(image, redChannel: 0, blueChannel: adjustment, greenChannel: 0)
    }
    
    // Green Channel
    static func greenChannel(image: RGBAImage, adjustment: Double) -> RGBAImage {
        return filters.adjustChannels(image, redChannel: 0, blueChannel: 0, greenChannel: adjustment)
    }
    
    // Brightness
    static func brightness(image: RGBAImage, diff: Double) -> RGBAImage {
        return filters.adjustChannels(image, redChannel: diff, blueChannel: diff, greenChannel: diff)
    }
    
    
    // Channel adjustment
    static func adjustChannels(image: RGBAImage, redChannel: Double, blueChannel: Double, greenChannel: Double) -> RGBAImage {
        
        for idx in 0..<image.pixels.count {
            var pixel = image.pixels[idx]
            
            pixel.red = UInt8(max(0,min(255,(Double(pixel.red) + Double(pixel.red) * redChannel))))
            pixel.blue = UInt8(max(0,min(255,(Double(pixel.blue) + Double(pixel.blue) * blueChannel))))
            pixel.green = UInt8(max(0,min(255,(Double(pixel.green) + Double(pixel.green) * greenChannel))))
            
            image.pixels[idx] = pixel
        }
        
        return image
    }
    
    // Greyscale conversion
    static func greyscale(image: RGBAImage) -> RGBAImage {
        
        for idx in 0..<image.pixels.count {
            var pixel = image.pixels[idx]
            
            let avgCol = UInt8((Int(pixel.red) + Int(pixel.blue) + Int(pixel.green)) / 3)
            
            pixel.red = avgCol
            pixel.green = avgCol
            pixel.blue = avgCol
            
            image.pixels[idx] = pixel
        }
        
        return image
    }
}


//A dictionary of filter presets
let filterPresets = [
    
    // Whiten
    "whiten": { (image: RGBAImage) -> RGBAImage in
        return filters.brightness(image, diff: 0.2)
    },
    
     // Sweet
    "sweet": { (image: RGBAImage) -> RGBAImage in
        return filters.blueChannel(filters.redChannel(image, adjustment: 0.8), adjustment: 0.2)
    },
    
    
    // Dreamy
    "dreamy": { (image: RGBAImage) -> RGBAImage in
        var manipulatedImage = filters.greenChannel(image, adjustment: -0.2)
        manipulatedImage = filters.blueChannel(manipulatedImage, adjustment: -0.5)
        manipulatedImage = filters.redChannel(manipulatedImage, adjustment: 0.5)
        
        return manipulatedImage
    },
    
    
    // Cool
    "cool": { (image: RGBAImage) -> RGBAImage in
        var manipulatedImage = filters.greenChannel(image, adjustment: 0.1)
        manipulatedImage = filters.blueChannel(manipulatedImage, adjustment: 0.5)
        manipulatedImage = filters.redChannel(manipulatedImage, adjustment: -0.2)
        
        return manipulatedImage
        
        
    },
    
    
    // Black and White
    "blackWhite": { (image: RGBAImage) -> RGBAImage in
        return filters.brightness(filters.greyscale(image), diff: 0)
    }
]

// Image processing
class ImageProcess {
    var image: RGBAImage
    
    init(image: RGBAImage) {
        self.image = image
    }
    
    func applyFilters(filterList: [String]) -> RGBAImage {
        for f in filterList {
            image = filterPresets[f]!(image)
        }
        return image
    }
}



