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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
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
                self.cityLabel.text = "1 Погода недоступна"
            }
        }
    }
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    func updateWeatherData(json: JSON){
        if let temperature = json["main"]["temp"].double {
            //температура
            weatherDataModel.temperature = Int(temperature - 273.15)
            //город
            weatherDataModel.city = json["name"].stringValue
            //погодные условия - числовой код
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            //перевод числового кода в описание (название иконки)
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        updateUIWithWeatherData()
        } else {
            cityLabel.text = "2 Погода не доступна"
        }
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
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
    
    
    func userEnteredANewCityName(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
    
}


