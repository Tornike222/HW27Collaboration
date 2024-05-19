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

protocol SolarResourceViewModelDelegate: AnyObject {
    func showError(_ error: String)
    func startAnimation()
    func stopAnimation()
}

final class SolarResourceViewModel {
    
    weak var delegate: SolarResourceViewModelDelegate?
    
    private func fetchSolarData(with address: String?, completion: @escaping (SolarData?) -> Void) {
        guard let address = address, !address.isEmpty else {
            delegate?.showError("Please enter a valid address.")
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
                completion("Please enter valid address")
                return
            }
            
            let averageDNI = solarData.outputs?.avgDni?.annual ?? 0.0
            let averageGHI = solarData.outputs?.avgGhi?.annual ?? 0.0
            let averageLatTilt = solarData.outputs?.avgLatTilt?.annual ?? 0.0
            let solarDataText = """
                        Annual Average Information:
                        Average Direct Normal Irradiance: \(averageDNI)
                        Average Global Horizontal Irradiance: \(averageGHI)
                        Average Tilt at Latitude: \(averageLatTilt)
                        """
            completion(solarDataText)
        }
    }
}



