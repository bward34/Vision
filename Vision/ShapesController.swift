//
//  ShapesController.swift
//  Vision
//
//  Created by Brandon Ward on 11/17/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit

class ShapesController: UIViewController, UITableViewDataSource {
    
    let shapeData = ["Cube", "Sphere", "Cone"]
    
    //how many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //hoy many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (shapeData.count)
    }
    
    //contents
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = shapeData[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
