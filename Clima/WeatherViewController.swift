//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ales Shenshin 19/12/2018.
//  Copyright (c) 2018 Ales Shenshin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Константы
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "39ed13c579ea7a1447e1b92059983746"
    

    //Переменные экземпляра
    let locationManager : CLLocationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
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
    
    
    func getWeatherData(url: String, parameters: [String:String])->Void{
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Данные о погоде получены.")
                
                    if let weather = response.result.value {
                        let weatherJSON = JSON(weather)
                        self.updateWeatherData(json: weatherJSON)
                } else {
                    print("Получен пустой ответ от сервера")
                }
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Сервер погоды недоступен"
            }
        }
    }
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    func updateWeatherData(json: JSON){
        let tempResult = json["main"]["temp"]
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let params : [String : String] = ["lat" : "\(location.coordinate.latitude)", "lon" : "\(location.coordinate.longitude)", "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
            //print(params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


