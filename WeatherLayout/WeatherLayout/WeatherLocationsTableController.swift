//
//  WeatherLocationsTableController.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 28/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class WeatherLocationsTableController: UITableViewController {
    
    @IBOutlet weak var addLocationButton: UIBarButtonItem!
    
    let queue = NSOperationQueue()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationsManager.sharedInstance.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("weatherLocationCell", forIndexPath: indexPath) as UITableViewCell
        
        //cell.textLabel?.text = LocationsManager.sharedInstance.locations[indexPath.row].cityName.capitalizedString
        
        let locationForCell = LocationsManager.sharedInstance.locations[indexPath.row]
        
        cell.textLabel?.text = locationForCell.capitalizedString
        
        //getWeatherDataForCell(locationForCell, forIndexPath: indexPath)
        
        //cell.detailTextLabel?.text = LocationsManager.sharedInstance.locations[indexPath.row].getTemperatureAsString()
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showLocationFromTable" {
            
            let originatingCell = sender as! UITableViewCell
        
            let selectedLocationIndex = tableView.indexPathForCell(originatingCell)!
            
            LocationsManager.sharedInstance.selectedLocationIndex = UInt(selectedLocationIndex.row)
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue.name = "queue za tableVC"
        
        queue.maxConcurrentOperationCount = 2
        
    }
    
    override func viewWillAppear(animated: Bool) {

        tableView.reloadData()

        if LocationsManager.sharedInstance.locations.count > 0 {

            for location in LocationsManager.sharedInstance.locations {

                let index = LocationsManager.sharedInstance.locations.indexOf(location)

                queue.addOperation(refreshWeatherForCell(indexPathOfCellToRefresh: NSIndexPath(forRow: index!, inSection: 0), locationForCell: location, thisVC: self))

            }

        }

    }
    
}