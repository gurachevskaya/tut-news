//
//  CLLocation+Ext.swift
//  tut-news
//
//  Created by Karina on 10/31/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    func fetchCountry(completion: @escaping (_ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion( $0?.first?.country, $1) }
    }
}
