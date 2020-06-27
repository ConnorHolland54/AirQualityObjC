//
//  CJHCityDetailViewController.swift
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import UIKit

class CJHCityDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    
    var city: String?
    var state: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city, let state = state, let country = country else {return}

        CJHCityAirQualityController.fetchData(forCity: city , state: state, country: country) { (cityData) in
            DispatchQueue.main.async {
                self.nameLabel.text = "City: \(cityData.city)"
                self.countryLabel.text = "Country: \(cityData.country)"
                self.stateLabel.text = "State: \(cityData.state)"
                self.aqiLabel.text = "Air Quality Index: \(cityData.pollution.airQualityIndex)"
                self.tempLabel.text = "Temperature: \(cityData.weather.temperature) degrees celsius"
                self.humidityLabel.text = "Humidity: \(cityData.weather.humidity)"
                self.windSpeedLabel.text = "Wind Speed: \(cityData.weather.windSpeed)"
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
