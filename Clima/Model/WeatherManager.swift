import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager:WeatherManager , _ weather: WeatherModel)
    func didEncounterError(_ error: Error)
}

struct WeatherManager{
    
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=dd3fc707ce1cbcf9302d09ed4494c75a&units=metric"
    
    var delegate:WeatherManagerDelegate?
    
    
    func getWeatherAtLocation(city: String){
        let cityNameFinal=city.replacingOccurrences(of: " ", with: "+")
        let urlName="\(weatherURL)&q=\(cityNameFinal)"
        performRequest(urlName)
    }
    
    func getWeatherAtLocation(_ lat:CLLocationDegrees, _ lon:CLLocationDegrees){
        let urlName="\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlName)
    }
    
    func performRequest(_ urlName: String){
        
        if let url = URL(string: urlName ){
            let session=URLSession(configuration: .default)
            let task=session.dataTask(with: url) { data, URLResponse, error in
                if(error == nil){
                    if let safeData = data{
                        
                        if let weather = self.parseJSON(safeData){
                            self.delegate?.didUpdateWeather(self, weather)
                        }
                    }
                }
                if(error != nil){
                    self.delegate?.didEncounterError(error!)
                    return
                }
            }
            task.resume() 
        }
    }
    
    func parseJSON(_ weather: Data)->WeatherModel?{
        
        do{
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weather)
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(cityName: cityName, temp: temp, weatherId: id)
            return weather
        }
        catch{
            self.delegate?.didEncounterError(error)
            return nil
        }
    }
    
    
    
    
    
}


