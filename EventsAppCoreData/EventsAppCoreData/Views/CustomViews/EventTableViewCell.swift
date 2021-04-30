//
//  EventTableViewCell.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import UIKit

protocol EventCellAttendingDelegate: AnyObject {
    func eventButtonTapped(_ cell: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var isAttendingButton: UIButton!
    
    
    //MARK: - Properties
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: EventCellAttendingDelegate?
    
    //MARK: - Actions
    @IBAction func attendingButtonTapped(_ sender: Any) {
        delegate?.eventButtonTapped(self)
    }
    
    
    //MARK: - Functions
    func updateViews() {
        guard let event = event else { return }
        eventTitleLabel.text = event.eventTitle
        let image = event.isAttending ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "calendar.circle")
        isAttendingButton.setBackgroundImage(image, for: .normal)
    }
}
