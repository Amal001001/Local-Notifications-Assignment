//  ViewController.swift
//  Local Notifications Assignment

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController {

    var items = [Tasks]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var runningTimer = false
    let timerinMinutes = ["5 Minutes", "10 Minutes", "20 Minutes", "30 Minutes"]
    var timerDuration = 0
    var timerForNotification = 0
    
    var totalTimeCounter = 0
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var workUntilLabel: UILabel!
    
    @IBAction func StartTimerButton(_ sender: UIButton) {
        if runningTimer == true{
            runningTimer = false
            items.last?.status = "canceled"
            items.last?.finished = false
            tableView.reloadData()
        }
          if timerDuration == 0{
            settingTime(timerDuration: 5)
              timerForNotification = 5
          }else if timerDuration == 1{
            settingTime(timerDuration: 10)
              timerForNotification = 10
          }else if timerDuration == 2{
            settingTime(timerDuration: 20)
              timerForNotification = 20
          }else{
            settingTime(timerDuration: 30)
              timerForNotification = 30
          }
        
        //////////////////////////////////////notification part

        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]){(granted, error) in}
        
        // Step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Timer"
        content.body = "Time's up!"
        content.sound = .default
        
        // Step 3: Create the notification trigger
        let date = Date().addingTimeInterval(TimeInterval(timerForNotification * 60))
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Step 4: Create the request
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
        }
        
    }
    
    func settingTime(timerDuration: Int){
        runningTimer = true
        
        totalTimeLabel.text = "Total Time: \(totalTimeCounter)"
        timerLabel.text = "0 hours, \(timerDuration) min"
        
           let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
        
           let timeInDay = Date().addingTimeInterval(Double(timerDuration) * 60.0)
        
           workUntilLabel.text = "Work until: \(formatter.string(from: timeInDay))"
        
        //////////////////////add to database
        let item = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedObjectContext) as! Tasks
        
        item.status = "running Timer"
        item.timerAmount = Int16(timerDuration)
        item.startTime = "\(formatter.string(from: Date()))"
        item.endTime = "\(formatter.string(from:timeInDay))"
        items.append(item)
                   
        do{
           try managedObjectContext.save()
                               
        } catch{print("\(error)")}
        tableView.reloadData()
        
    }
    
    func afterTheNotification(){
        ////////////////////////////if timer rang add to total
        items.last?.finished = true
        items.last?.status = "finished"
        totalTimeCounter += Int(items.last!.timerAmount)
    }
    
    func cancelingTimer(){
        if runningTimer{
            runningTimer = false
            items.last?.status = "canceled"
            items.last?.finished = false
            workUntilLabel.text = ""

            do{
               try managedObjectContext.save()

            } catch{print("\(error)")}
            tableView.reloadData()
        }
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        cancelingTimer()
    }
    
    
    @IBAction func newDayBarButton(_ sender: UIBarButtonItem) {
        items.removeAll()
        
        //////// clean the core data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tasks")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch {print("\(error)")}

        do{
           try managedObjectContext.save()
        } catch{print("\(error)")}
        tableView.reloadData()
    }
    
    @IBAction func logButton(_ sender: UIButton) {
        logStackView.isHidden = false
    }
    
    //////////////////////////Log view
    @IBOutlet weak var logStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func backButton(_ sender: UIButton) {
        logStackView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /////table view
        logStackView.isHidden = true
        tableView.dataSource = self
        FetchData()
        //////////////picker
        timerPicker.dataSource = self
        timerPicker.delegate = self
        ////////////////setting labels text
        totalTimeLabel.text = "Total Time: \(totalTimeCounter)"
        timerLabel.text = "0 hours, 0 min"
        workUntilLabel.text = ""
        
    }

}

//////////////////////////////////////UIPickerView
extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timerinMinutes.count
    }
  
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timerinMinutes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerDuration = row
        }
}

/////////////////////////Table view functions /////////////////////////////
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // dequeue the cell from our storyboard
           let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(items[indexPath.row].startTime!)- \(items[indexPath.row].endTime!) ..\(items[indexPath.row].timerAmount) minutes timer\n\(items[indexPath.row].status!)"
        //   cell.detailsLabel.text = items[indexPath.row].details!
        //   cell.dateLabe.text = "\(items[indexPath.row].date!)"

//           if items[indexPath.row].status{
//               cell.accessoryType = .checkmark
//           }else{
//               cell.accessoryType = .detailDisclosureButton
//           }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return items.count
    }
    
    func FetchData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
    
        do{
           let result = try managedObjectContext.fetch(request)
           items = result as! [Tasks]
        }catch{
               print("\(error)")
        }
    }
}

extension ViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        ////////////////////////////if timer rang add to total i.e the timer completed
        afterTheNotification()
    }
}
