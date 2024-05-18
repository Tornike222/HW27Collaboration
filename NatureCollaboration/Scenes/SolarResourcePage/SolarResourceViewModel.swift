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
    
    func formatSolarData(with address: String?, completion: @escaping (String?) -> Void) {
        fetchSolarData(with: address) { solarData in
            guard let solarData = solarData else {
                completion("Failed to fetch data")
                return
            }
            let averageDNI = solarData.outputs.avgDni.annual
            let averageGHI = solarData.outputs.avgGhi.annual
            let averageLatTilt = solarData.outputs.avgLatTilt.annual
            let solarDataText = """
                Average Direct Normal Irradiance: \(averageDNI)
                Average Global Horizontal Irradiance: \(averageGHI)
                Average Tilt at Latitude: \(averageLatTilt)
                """
            completion(solarDataText)
        }
    }
}

