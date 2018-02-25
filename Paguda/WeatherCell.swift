//
//  WeatherCell.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 25/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell
{
    @IBOutlet var dayLabel: UILabel!
    
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    
    @IBOutlet var weatherIconImage: UIImageView!
}
