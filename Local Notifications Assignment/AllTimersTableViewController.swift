//  ViewController.swift
//  Local Notifications Assignment

import UIKit
import UserNotifications
import CoreData

//class AllTimersTableViewController: UITableViewController {
//
//    var items = [Tasks]()
////
////    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      //  FetchData()
//    }
//
//    //////////////////////////////////Table view functions /////////////////////////////////////////////////
//       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           // dequeue the cell from our storyboard
//           let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
//
//           cell.textLabel?.text = "\(items[indexPath.row].startTime!)"
//        //   cell.detailsLabel.text = items[indexPath.row].details!
//        //   cell.dateLabe.text = "\(items[indexPath.row].date!)"
//
////           if items[indexPath.row].status{
////               cell.accessoryType = .checkmark
////           }else{
////               cell.accessoryType = .detailDisclosureButton
////           }
//           return cell
//       }
//
//       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return items.count
//       }
//
//       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//              let navigationController = segue.destination as! UINavigationController
//              let addItemTableVC = navigationController.topViewController as! newDayViewController
//              addItemTableVC.delegate = self
           
//           if sender is NSIndexPath {
//               let indexPath = sender as! NSIndexPath
//               let item = items[indexPath.row]
//               addItemTableVC.item = item.title
//               addItemTableVC.itemDetails = item.details
//            //   addItemTableVC.itemDate = item.date
//               addItemTableVC.indexPath = indexPath
//           }
       
   //    }
       
//       func newDayViewController(_ controller: addItemViewController, didFinishAddingItem text: String, details itemDetails: String, date itemDate: Date, at indexPath: NSIndexPath?) {
//
//           if let ip = indexPath {
//               let item = items[ip.row]
//               item.title = text
//               item.details = itemDetails
//               item.date = itemDate
//           }
//           else{
//               let item = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedObjectContext) as! Tasks
//               item.title = text
//               item.details = itemDetails
//               item.date = itemDate
//               items.append(item)
//           }
//
//           do{
//              try managedObjectContext.save()
//
//           } catch{print("\(error)")}
//
//           dismiss(animated: true, completion: nil)
//           tableView.reloadData()
//       }
       
//       func cancelItemViewController(_ controller: addItemViewController, didPressCancelButton button: UIBarButtonItem) {
//           dismiss(animated: true, completion: nil)
//       }

       //function for delete with a swipe
//       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//           let item = items[indexPath.row]
//           managedObjectContext.delete(item)
//
//           do{
//              try managedObjectContext.save()
//           } catch{print("\(error)")}
//
//           items.remove(at: indexPath.row)
//           tableView.reloadData()
//       }
       
      // function perform something to a clicked row
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .none
//        }
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .checkmark{
//                cell.accessoryType = .detailDisclosureButton
//                let item = items[indexPath.row]
//                item.status = false
//                items[indexPath.row].status = false
//            }else{
//                cell.accessoryType = .checkmark
//                let item = items[indexPath.row]
//                item.status = true
//                items[indexPath.row].status = true
//            }
//
//          //  managedObjectContext..(item)
//
//            do{
//               try managedObjectContext.save()
//            } catch{print("\(error)")}
//
//            tableView.reloadData()
//        }
//    }

//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//           performSegue(withIdentifier: "ItemSegue", sender: indexPath)
//    }
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       ///////////////////////////////////////////////////////DataBase Function////////////////////////////////////////
//       func FetchData(){
//               let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//
//               do{
//               let result = try managedObjectContext.fetch(request)
//               items = result as! [Tasks]
//               }
//               catch
//               {
//                   print("\(error)")
//               }
//       }


//}

