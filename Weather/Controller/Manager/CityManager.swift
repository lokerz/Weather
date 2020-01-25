//
//  CityManager.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation

class CityManager {
    
    func loadCity() -> [City]{
        var cities = [City]()
        if let data = readDataFromCSV(fileName: "world-cities", fileType: "csv") {
            cities = csv(data: cleanRows(file: data))
        }
        return cities
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\"", with : "")
        return cleanFile
    }
    
    func csv(data: String) -> [City]{
        var city = [City]()
        let rows = data.components(separatedBy: "\n")
        for i in 1..<rows.count-1 {
            let columns = rows[i].components(separatedBy: ",")
            let tempCity = City(
                id : columns[3],
                name : columns[0],
                province: columns[2],
                country : columns[1]
            )
            city.append(tempCity)
        }
        return city
    }
}
