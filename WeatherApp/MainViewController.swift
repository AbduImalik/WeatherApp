//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abdulmalik on 05/05/1443 AH.
//

import UIKit
import Alamofire
class MainViewController: UIViewController {

    @IBOutlet weak var loaderActivity: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    var cityId = "108410"

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "CityValueChanges"), object: nil)
        
        
        getWeatherInfo()
        
    }
    
    func getWeatherInfo(){
        loaderActivity.startAnimating()
        let parameters = ["id": cityId,"appid":"375550e4cb96adb8f7e9101b4181151a"]

        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parameters,encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result  = response.value {
                let JSON = result as! NSDictionary
                let main = JSON["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                temp = temp - 272.15
                temp = Double(round(1000 * temp)/1000)
                let pressure = main["pressure"] as! Double
                let humidity = main["humidity"] as! Double
                self.loaderActivity.stopAnimating()
                self.pressureLabel.text = String(pressure)
                self.tempLabel.text = "\(temp)°"
                self.humidityLabel.text = String(humidity)
            }
        }
        

    }
    
    @objc func cityChanged(notification : Notification){
        if let city = notification.userInfo?["city"] as? City {
            cityNameLabel.text = city.name
            cityId = city.cityID
            
            getWeatherInfo()
            
        }
    }

}

