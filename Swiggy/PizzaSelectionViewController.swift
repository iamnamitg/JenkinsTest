//
//  PizzaViewController.swift
//  Swiggy
//
//  Created by Namit on 25/10/18.
//  Copyright © 2018 Namit. All rights reserved.
//

import UIKit

class PizzaSelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var variants:VariantsModel?
    var excludeList:[[Exclude_list]]?
    var filteredExclusionList:[[Exclude_list]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "PizzaSelectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        self.fetchVariantsData()
        self.addResetButton()
    }
    
    func addResetButton(){
        let btn1 = UIButton(type: .system)
        btn1.setTitle("Reset", for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(reset), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.setRightBarButton(item1, animated: true)
    }
    
    @objc func reset(){
        if let selectedIndexPaths = self.tableView.indexPathsForSelectedRows{
            for indexPath in selectedIndexPaths{
                self.tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
    
    func fetchVariantsData(){
        _ = PizzaSelectionUsecase().fetchVairations().done { variants -> Void in
            self.variants = variants
            self.excludeList = variants.variants?.exclude_list
            self.tableView.reloadData()
            self.tableView.allowsMultipleSelection = true
        }
    }
    
    func checkForExclusions(){
        self.filteredExclusionList = self.excludeList
        if let selectedIndexPaths = self.tableView.indexPathsForSelectedRows{
            for indexPath in selectedIndexPaths{
                self.filteredExclusionList = filterExclusionList(exclusionList: self.filteredExclusionList, indexPath: indexPath)
            }
            
            if let result = self.filteredExclusionList{
                if result.count == 1 && selectedIndexPaths.count > 1{
                    if result[0].count == selectedIndexPaths.count{
                        if let lastIndexPath = selectedIndexPaths.last{
                            self.tableView.deselectRow(at: lastIndexPath, animated: false)
                            self.displayAlert()
                        }
                    }
                }
            }
        }
    }
    
    func filterExclusionList(exclusionList:[[Exclude_list]]?, indexPath:IndexPath) -> [[Exclude_list]]?{
        if let excludeList = exclusionList{
            let result = excludeList.filter { (excludeItemArray:[Exclude_list]) -> Bool in
                return excludeItemArray.filter({ (excludeItem:Exclude_list) -> Bool in
                    guard let groupId = excludeItem.group_id, let groupIntValue = Int(groupId), let varId = excludeItem.variation_id, let varIntValue = Int(varId) else{
                        return false
                    }
                    
                    guard let variants = variants, let groups = variants.variants?.variant_groups, let variantGroup = groups[indexPath.section] as? Variant_groups, let variantArray = variantGroup.variations, let variation = variantArray[indexPath.row] as? Variations, let variationId = variation.id, let variationIntValue = Int(variationId) else{
                        
                        return false
                    }
                    
                    return groupIntValue == indexPath.section+1 && variationIntValue == varIntValue
                }).count > 0
            }
            
            return result
        }
        
        return nil
    }
    
    func displayAlert(){
        let alert = UIAlertController(title: "Error", message: "This selection not available", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension PizzaSelectionViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let variants = variants, let groups = variants.variants?.variant_groups, let variantGroup = groups[section] as? Variant_groups else{
            return nil
        }
        
        return variantGroup.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let variants = variants, let groups = variants.variants?.variant_groups else{
            return 0
        }
        
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let variants = variants, let groups = variants.variants?.variant_groups, let variantGroup = groups[section] as? Variant_groups, let variantArray = variantGroup.variations else{
            return 0
        }
        
        return variantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PizzaSelectionTableViewCell{
            
            guard let variants = variants, let groups = variants.variants?.variant_groups, let variantGroup = groups[indexPath.section] as? Variant_groups, let variantArray = variantGroup.variations, let variation = variantArray[indexPath.row] as? Variations else{
                return UITableViewCell()
            }
            
            cell.variation = variation
            return cell
        }
        
        return UITableViewCell()
    }
}

extension PizzaSelectionViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPaths = tableView.indexPathsForSelectedRows{
            for indexP in indexPaths{
                if indexP.section == indexPath.section && indexP.row != indexPath.row{
                    self.tableView.deselectRow(at: indexP, animated: false)
                }
            }
        }
        self.checkForExclusions()
    }
}

