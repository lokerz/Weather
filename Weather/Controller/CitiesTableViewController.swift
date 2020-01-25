//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    let searchBarController = UISearchController(searchResultsController: nil)
    var cities = [City]()
    var filteredCities = [City]()
    var currentCity : City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCity()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupNavigationBar()
    }
    
    func setupCity(){
        cities = CityManager().loadCity().sorted{ $0.name < $1.name}
        tableView.reloadData()
    }
    
    func setupNavigationBar(){
        var color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if #available(iOS 12.0, *) {
            color = traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: color]
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        }
        self.navigationItem.rightBarButtonItem?.tintColor = color
        self.navigationController?.navigationBar.tintColor = color
    }
    
    @IBAction func currentLocationButtonAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindCurrentLocation", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredCities.count : cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = (isFiltering() ? filteredCities : cities)[indexPath.row]
        cell.textLabel?.text = "\(city.name), \(city.province), \(city.country)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCity = (isFiltering() ? filteredCities : cities)[indexPath.row]
        if isFiltering() || searchBarController.isActive {
            searchBarController.isActive = false
            dismiss(animated: false) {
                self.performSegue(withIdentifier: "unwindToMain", sender: self)
            }
        }
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainViewController{
            if segue.identifier == "unwindToMain" {
                destination.currentCity = currentCity
                destination.isUsingCurrentLocation = false
            } else if segue.identifier == "unwindCurrentLocation" {
                destination.isUsingCurrentLocation = true
            }
        }
    }
}
/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

