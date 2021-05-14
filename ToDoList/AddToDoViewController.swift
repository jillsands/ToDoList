//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Jillian Sands on 8/10/20.
//  Copyright © 2020 Jillian Sands. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    
    var previousToDoTVC = ToDoTableViewController()
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var switchInput: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let accessToCoreData = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let dataFromCoreData = accessToCoreData.persistentContainer.viewContext

        let newToDo = ToDoCD(context: dataFromCoreData)

        //these lines give the object information from the user input
             newToDo.descriptionInCD = descriptionInput.text
             newToDo.importantInCD = switchInput.isOn

        //This is like clicking "save"! Our new object is now safe in Core Data!
             accessToCoreData.saveContext()

        //this send the user back to the Table View Controller
             navigationController?.popViewController(animated: true)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
