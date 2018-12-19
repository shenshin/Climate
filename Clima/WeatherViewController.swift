//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ales Shenshin 19/12/2018.
//  Copyright (c) 2018 Ales Shenshin. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Константы
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "39ed13c579ea7a1447e1b92059983746"
    

    //Переменные экземпляра
    let locationManager : CLLocationManager = CLLocationManager()

    
    //IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Последовательносить шагов для запуска отслеживания GPS координат. Помимо этого внесены 2(3) добавления в Info.plist (см. 3 верхних строчки)
        //Третья сверху строчка (dictionary) в Info.plist разрешает смартфону обращаться к серверу погоды по незащищённому http протоколу
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let params : [String : String] = ["lat" : "\(location.coordinate.latitude)", "lon" : "\(location.coordinate.longitude)", "appid" : APP_ID]
            print(params)
        }
    }
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


