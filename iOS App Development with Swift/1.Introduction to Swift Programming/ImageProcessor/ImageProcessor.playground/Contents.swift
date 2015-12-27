import UIKit

let image = UIImage(named: "sample")!

// parameters that can be altered to get the optimal process
let redParameter = 255
let greenParameter = 255
let blueParameter = 255
let alphaParameter = 255
let blackParameter = 5
let whiteParameter = 3

class ImageProcessor{
    var filters: [String] = []
    var totalRGBAS = [Int](count:5, repeatedValue: 0)
    var avgRGBAS = [Int](count:5, repeatedValue: 0)
    
    init(flts: [String]) {
        filters = flts
    }
    
    func getTotal(rgbaImage: RGBAImage) {
        print("start")
        totalRGBAS = [Int](count:5, repeatedValue: 0)
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                print(Int(pixel.red))
                
                totalRGBAS[0] += Int(pixel.red)
                print("start")
                totalRGBAS[1] += Int(pixel.green)
                totalRGBAS[2] += Int(pixel.blue)
                totalRGBAS[3] += Int(pixel.alpha)
                print(totalRGBAS[0])
            }
        }
        totalRGBAS[4] = totalRGBAS[0] + totalRGBAS[1] + totalRGBAS[2] + totalRGBAS[3]
    
    }

    func getAvg(rgbaImage: RGBAImage) {
        avgRGBAS = [Int](count:5, repeatedValue: 0)
        getTotal(rgbaImage)
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        avgRGBAS[0] = totalRGBAS[0] / pixelCount
        avgRGBAS[1] = totalRGBAS[1] / pixelCount
        avgRGBAS[2] = totalRGBAS[2] / pixelCount
        avgRGBAS[3] = totalRGBAS[3] / pixelCount
        avgRGBAS[4] = totalRGBAS[4] / pixelCount
    }


    func processFilters(rgbaImage: RGBAImage)  -> UIImage {

        for filter in filters {
            print("Process \(filter) !")
            
            switch filter {
                case "redFilter":
                    for y in 0..<rgbaImage.height {
                        for x in 0..<rgbaImage.width {
                            
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
                            
                            pixel.red = UInt8(redParameter)
                            
                            rgbaImage.pixels[index] = pixel
                        }
                    }
                
                case "greenFilter":
                    for y in 0..<rgbaImage.height {
                        for x in 0..<rgbaImage.width {
                            
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
                            
                            pixel.green = UInt8(greenParameter)
                            
                            rgbaImage.pixels[index] = pixel
                        }
                    }
                
                case "blueFilter":
                    for y in 0..<rgbaImage.height {
                        for x in 0..<rgbaImage.width {
                    
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
                            
                            pixel.blue = UInt8(blueParameter)
                    
                            rgbaImage.pixels[index] = pixel
                        }
                    }
                
                case "alphaFilter":
                    for y in 0..<rgbaImage.height {
                        for x in 0..<rgbaImage.width {
                            
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
                            
                            pixel.alpha = UInt8(alphaParameter)
                            
                            rgbaImage.pixels[index] = pixel
                        }
                    }
                
                case "blackwhiteFilter":
                    print("start")
                    getAvg(rgbaImage)
                    print("here")
                    var sum = 0
                    var avg = 0
                    
                    for y in 0..<rgbaImage.height {
                        for x in 0..<rgbaImage.width {
                            
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
                            sum = Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)
                            avg = sum / 3
                            print("here")
                            if sum > avgRGBAS[4] {
                                let change = UInt8(max(0, min(255, (avg + blackParameter))))
                                pixel.red = change
                                pixel.green = change
                                pixel.blue = change
                            } else {
                                let change = UInt8(max(0, min(255, (avg - whiteParameter))))
                                pixel.red = change
                                pixel.green = change
                                pixel.blue = change
                            }
                            print("here")
                            rgbaImage.pixels[index] = pixel
                        }
                    }

                default:
                    print("Nothing to change!")
            }
        }
        let newImage = rgbaImage.toUIImage()!
        return newImage
    }
    
}

var filters: [String] = ["blackwhiteFilter", "alphaFilter"]
var processor: ImageProcessor = ImageProcessor(flts: filters)
var rgbaImage = RGBAImage(image: image)!

processor.processFilters(rgbaImage)
