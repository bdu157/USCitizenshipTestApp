//
//  MainTableViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let modelViewController = ModelViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelViewController.imgUrlArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        self.loadImage(for: cell, indexPath: indexPath)
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadImage(for cell: UITableViewCell, indexPath: IndexPath) {
        let imageUrl = self.modelViewController.imgUrlArray[indexPath.row]
        
        self.modelViewController.fetchImages(imgUrlString: imageUrl) { (result) in
            if let result = try? result.get() {
                let image = UIImage(data: result)
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.textLabel?.text = "\(result)"
                }
            }
        }
    }

}
