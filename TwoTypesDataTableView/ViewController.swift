//
//  ViewController.swift
//  TwoTypesDataTableView
//
//  Created by Anhdzai on 12/14/17.
//  Copyright © 2017 Anhdzai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var switchToggle: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var numberDataSource = NumberDataSource()
    var wordDataSource = WordDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = numberDataSource
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if sender.isOn {
            tableView.dataSource = numberDataSource
        } else {
            tableView.dataSource = wordDataSource
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = segue.destination as? ViewControllerOne,
        let index = tableView.indexPathForSelectedRow {
            if switchToggle.isOn {
                data.indexData = "\(numberDataSource.numberData[index.row])"
            } else {
                data.indexData = wordDataSource.wordData[index.row]
            }
        }
    }
    
    @IBAction func unwindFromAdd(_ sender: UIStoryboardSegue) {
        if let data = sender.source as?  ViewControllerOne {
            if let index = tableView.indexPathForSelectedRow {
                if switchToggle.isOn {
                    let initialValue = numberDataSource.numberData[index.row]
                    numberDataSource.numberData[index.row] = Int(data.indexData!) ?? initialValue
                } else {
                    wordDataSource.wordData[index.row] = data.indexData ?? ""
                }
                tableView.reloadRows(at: [index], with: .none)
            } else {
                if switchToggle.isOn {
                    let dataIndex = Int(data.indexData!) ?? 0
                    numberDataSource.numberData.append(dataIndex)
                } else {
                    let dataIndex = data.indexData!
                    wordDataSource.wordData.append(dataIndex)
                }
                tableView.reloadData()
            }
        }
    }
}


extension UITableViewDelegate {
}

class WordDataSource: NSObject, UITableViewDataSource {
    
    var wordData = ["một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín", "mười"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Index", for: indexPath)
        cell.textLabel?.text = wordData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wordData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

class NumberDataSource: NSObject, UITableViewDataSource {
    
    var numberData = [Int](1...10)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Index", for: indexPath)
        cell.textLabel?.text = "\(numberData[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numberData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

