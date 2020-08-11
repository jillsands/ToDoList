//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Jillian Sands on 8/10/20.
//  Copyright © 2020 Jillian Sands. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var listOfToDo : [ToDoCD] = []
    
    func getToDos() {
        if let accessToCoreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let dataFromCoreData = try? accessToCoreData.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                listOfToDo = dataFromCoreData
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfToDo.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let eachToDo = listOfToDo[indexPath.row]
        
        if let thereIsDescription = eachToDo.descriptionInCD {
            if eachToDo.importantInCD {
                cell.textLabel?.text = "‼️" + thereIsDescription
        } else {
              cell.textLabel?.text = eachToDo.descriptionInCD
        }
        }

        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eachToDo = listOfToDo[indexPath.row]
        
        performSegue(withIdentifier: "moveToCompletedToDoVC", sender: eachToDo)
    }

    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextAddToDoTVC = segue.destination as?
        AddToDoViewController {
            nextAddToDoTVC.previousToDoTVC = self
        }
        
        if let nextCompletedToDoVC = segue.destination  as? CompletedToDoViewController {
            if let chosenToDo = sender as? ToDoCD {
                nextCompletedToDoVC.selectedToDo = chosenToDo
                nextCompletedToDoVC.previousToDoTVC = self
            }
        }
        // Pass the selected object to the new view controller.
    }

}
