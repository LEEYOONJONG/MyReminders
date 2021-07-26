//
//  ViewController.swift
//  MyReminders
//
//  Created by YOONJONG on 2021/07/26.
//
import UserNotifications
import UIKit

class ViewController: UIViewController {
    @IBOutlet var table: UITableView!
    var models = [MyReminder]() //start with empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
    }

    @IBAction func didTapAdd(){
        //show add vc
    }
    @IBAction func didTapTest(){
        // fire test noti
        // request noti permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success {
                // schedule test
                self.scheduleTest()
            }
            else if let error = error{
                print("error occured")
                
            }
        })
        
    }
    func scheduleTest(){
        //3 main pieces. 1. request, 2. content(body, sound,,,), 3. trigger
        //위치에 도달하면 알림주는 것도 가능
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "My long body. My long body. My long body."
        let targetDate = Date().addingTimeInterval(10)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second ], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print("something went wrong")
            }
        })
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        return cell
        
    }
}

struct MyReminder{
    let title:String
    let date:Date
    let identifier:String
}
