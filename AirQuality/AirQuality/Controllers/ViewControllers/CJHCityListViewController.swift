//
//  CJHCityListViewController.swift
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import UIKit

class CJHCityListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var state: String?
    var country: String?
    
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let state = state, let country = country else {return}
        
        CJHCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (city) in
            self.cities = city
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? CJHCityDetailViewController else {return}
            let cityToSend = cities[indexPath.row]
            let stateToSend = state
            let countryToSend = country
            destination.state = stateToSend
            destination.country = countryToSend
            destination.city = cityToSend
            
            
        }
    }
    

    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension CJHCityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    
}
