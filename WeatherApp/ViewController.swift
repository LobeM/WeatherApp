//
//  ViewController.swift
//  WeatherApp
//
//  Created by Lobe Musonda on 7/4/18.
//  Copyright © 2018 Lobe Musonda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    struct CurrentWeather: Decodable {
        let location: Location?
        let current: Current?
    }
    
    struct Location: Decodable {
        let name: String
    }
    
    struct Current: Decodable {
        
//        let last_updated_epoch: Int
//        let last_updated: String
        let temp_c: Double
//        let temp_f: String
//        let is_day: String
        let condition: Condition
//        let wind_mph: String
//        let wind_kph: String
//        let wind_degree: String
//        let wind_dir: String
//        let pressure_mb: String
//        let pressure_in: String
//        let precip_mm: String
//        let precip_in: String
//        let humidity: String
//        let cloud: String
//        let feelslike_c: String
//        let feelslike_f: String
//        let vis_km: String
//        let vis_miles: String
    }
    
    struct Condition: Decodable {
        let text: String
        let icon: String
    }
    
    var degree: Double!
    var condition: String!
    var imgURL: String!
    var city: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let url = URL(string: "http://api.apixu.com/v1/current.json?key=57592b9d9bda4fcc851180455180307&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))") else {return}
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error")
                return
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                print("response error")
                DispatchQueue.main.async {
                    self.cityLbl.text = "No matching city found"
                }
                return
            }
            guard let data = data else {
                print("data error")
                return
            }
            
            do {
                let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                self.degree = currentWeather.current?.temp_c
                self.condition = currentWeather.current?.condition.text
                let icon = currentWeather.current?.condition.icon
                self.imgURL = "http:\(icon!)"
                self.city = currentWeather.location?.name

                DispatchQueue.main.async {
                    self.degreeLbl.isHidden = false
                    self.conditionLbl.isHidden = false
                    self.imgView.isHidden = false
                    self.degreeLbl.text = "\(self.degree.description)°"
                    self.cityLbl.text = self.city
                    self.conditionLbl.text = self.condition
                    self.imgView.downloadImage(from: self.imgURL!)
                }
                
            } catch let jsonError {
                print("Error serializing json:",jsonError)
            }
        }
        task.resume()
    }
}


extension UIImageView {
    
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
    
}

