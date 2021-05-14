
import Foundation
import UIKit

struct WeatherModel{
    
    let cityName:String
    let temp:Double
    let weatherId:Int
    
    let cloudyArray=[UIImage(imageLiteralResourceName: "Cloudy-1.jpg"), UIImage(imageLiteralResourceName: "Cloudy-2.jpg"), UIImage(imageLiteralResourceName: "Cloudy-3.jpg"), UIImage(imageLiteralResourceName: "Cloudy-4.jpg")]
    let drizzleArray=[UIImage(imageLiteralResourceName: "drizzle-1.jpg"), UIImage(imageLiteralResourceName: "Drizzle-2.jpg")]
    let fogArray=[UIImage(imageLiteralResourceName: "FOG-1.jpg"),UIImage(imageLiteralResourceName: "FOG-2.jpg"),UIImage(imageLiteralResourceName: "FOG-3.jpg")]
    let rainyArray=[UIImage(imageLiteralResourceName: "Rainy-1.jpg"), UIImage(imageLiteralResourceName: "Rainy-2.jpg"), UIImage(imageLiteralResourceName: "Rainy-3.jpg"), UIImage(imageLiteralResourceName: "Rainy-4.jpg")]
    let snowArray=[UIImage(imageLiteralResourceName: "Snow-1.jpg"), UIImage(imageLiteralResourceName: "Snow-2.jpg"), UIImage(imageLiteralResourceName: "Snow-3.jpg"), UIImage(imageLiteralResourceName: "Snow-4.jpg")]
    let sunnyArray=[UIImage(imageLiteralResourceName: "Sunny-1.jpg"), UIImage(imageLiteralResourceName: "Sunny-2.jpg"), UIImage(imageLiteralResourceName: "Sunny-3.jpg"), UIImage(imageLiteralResourceName: "Sunny-4.jpg")]
    let thunderArray=[UIImage(imageLiteralResourceName: "Thunder-1.jpg"), UIImage(imageLiteralResourceName: "Thunder-2.jpg"), UIImage(imageLiteralResourceName: "Thunder-3.jpg"), UIImage(imageLiteralResourceName: "Thunder-4.jpg")]
    
    var tempString: String{
        return String(format: "%0.1f", temp)
    }
    
    var weatherType:String{
        
        switch(weatherId){
        
        case 200...232:
            return "cloud.bolt.rain"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.heavyrain"
            
        case 600...622:
            return "cloud.snow.fill"
            
        case 700...781:
            return "cloud.fog.fill"
            
        case 801...804:
            return "cloud.fill"
            
        default:
            return  "sun.max.fill"
            
        }
    }
    var image:UIImage{
        switch(weatherType){
        case "cloud.bolt.rain":
            return thunderArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        case "cloud.drizzle":
            return drizzleArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        case "cloud.heavyrain":
            return rainyArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        case "cloud.snow.fill":
            return snowArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        case "cloud.fog.fill":
            return fogArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        case "cloud.fill":
            return cloudyArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
        default:
            return sunnyArray.randomElement() ?? UIImage(imageLiteralResourceName: "dark_background.pdf")
            }
    }
    var text:String{
        switch(weatherType){
        case "cloud.bolt.rain":
            return "The temperature in \(cityName) is \(tempString) degrees. Thunderstorm Predicted. Stay indoors, don't prove you are an idiot"
        case "cloud.drizzle":
            return "The temperature in \(cityName) is \(tempString) degrees. High chances of precipitaion in some areas"
        case "cloud.heavyrain":
            return "The temperature in \(cityName) is \(tempString) degrees. Chances of heavy rainfall. Better carry an umbrella."
        case "cloud.snow.fill":
            return "The temperature in \(cityName) is \(tempString) degrees. Snowfall expected. Enjoy the winters."
        case "cloud.fog.fill":
            return "The temperature in \(cityName) is \(tempString) degrees. It will be foggy today. Be careful while driving"
        case "cloud.fill":
            return "The temperature in \(cityName) is \(tempString) degrees. It will most likely be cloudy today with chances of light rainfall"
        default:
            return "The temperature in \(cityName) is \(tempString) degrees. It will be sunny outside."
            }

        
    }
    
    
    init(cityName:String, temp:Double, weatherId:Int){
        
        self.cityName=cityName
        self.temp=temp
        self.weatherId=weatherId
        
    }
    
}
