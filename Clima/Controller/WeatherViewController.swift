import UIKit
import CoreLocation
import AVFoundation
import Firebase
import GoogleSignIn

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var citySearch: UITextField!
    @IBOutlet weak var background: UIImageView!
    
    
    var weatherManager=WeatherManager()
    var locationManager=CLLocationManager()
    var synthesizer=AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate=self
        weatherManager.delegate=self
        citySearch.delegate = self
        synthesizer.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func relocateButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        citySearch.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citySearch.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(citySearch.text == ""){
            citySearch.placeholder="This field can't be empty"
            return false
        }
        else{
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityName=citySearch.text{
            weatherManager.getWeatherAtLocation(city: cityName)
        }
        citySearch.text=""
    }
}
//MARK: - WeatherManagerDelegate and AVSpeechSynthesizerDelegate
extension WeatherViewController: WeatherManagerDelegate, AVSpeechSynthesizerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.tempString
            self.cityLabel.text=weather.cityName
            self.conditionImageView.image=UIImage(systemName: weather.weatherType )
            self.background.image=weather.image
            let speech=AVSpeechUtterance(string: weather.text)
            speech.voice=AVSpeechSynthesisVoice(language: "en-UK")
            speech.rate=0.535
            self.synthesizer.speak(speech)
        }
        
    }
    func didEncounterError(_ error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.citySearch.placeholder="Enter a proper city name"

        }
    }
}
//MARK: - LocationManagerDelegate
extension WeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            weatherManager.getWeatherAtLocation(location.coordinate.latitude, location.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        citySearch.placeholder="Enter a proper city name"
    }
}

