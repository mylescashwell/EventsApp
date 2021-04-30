//
//  EventDetailViewController.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var newEventBanner: UILabel!
    

    //MARK: - Properties
    var event: Event?
    var date: Date?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let eventTitleText = eventTitleTextField.text, !eventTitleText.isEmpty else { return }
        if let event = event {
            event.eventTitle = eventTitleText
            EventController.shared.updateEvent(event: event, newEventTitle: eventTitleText, newEventDate: eventDatePicker.date)
        } else {
            EventController.shared.createNewEvent(newEventTitle: eventTitleText, newEventDate: eventDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventDatePickerChanged(_ sender: Any) {
        date = eventDatePicker.date
    }
    
    
    //MARK: - Functions
    func updateViews() {
        guard let event = event else { return }
        eventTitleTextField.text = event.eventTitle
        if let dateOfEvent = event.eventDate {
            eventDatePicker.date = dateOfEvent
        }
        
        if let eventTitle = event.eventTitle {
            eventTitleTextField.text = eventTitle
            newEventBanner.text = "Edit This Event"
        } else {
            newEventBanner.isHidden = false
        }
    }
}
