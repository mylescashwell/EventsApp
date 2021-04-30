//
//  EventListTableViewController.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import UIKit

class EventListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchEvents()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        let event = EventController.shared.events[indexPath.row]
        cell.event = event
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EventDetailViewController else { return }
            let event = EventController.shared.events[indexPath.row]
            destinationVC.event = event
        }
    }
}

//MARK: - Extensions
extension EventListTableViewController: EventCellAttendingDelegate {
    func eventButtonTapped(_ cell: EventTableViewCell) {
        guard let event = cell.event else { return }
        EventController.shared.isAttending(event: event)
        cell.updateViews()
    }
}
