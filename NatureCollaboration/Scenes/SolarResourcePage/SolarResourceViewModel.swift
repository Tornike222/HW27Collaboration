//
//  SolarResourceViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//
//
//
import Foundation
import NetworkPackage

final class SolarResourceViewModel {
    
    func fetchSolarData(with address: String?, completion: @escaping (SolarData?) -> Void) {
        guard let address = address else {
            completion(nil)
            return
        }
        let urlString = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?api_key=gLzFj4SUXuHTIOnRXEoclwCczMigabc4GZfHcnyy&address=\(address)"
        NetworkService().getData(urlString: urlString) { (result: SolarData?, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
            } else {
                completion(result)
            }
        }
    }
}
