//
//  Event+Convenience.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import CoreData

extension Event {
    @discardableResult convenience init(eventTitle: String, eventDate: Date, isAttending: Bool = false, uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.eventTitle = eventTitle
        self.eventDate = eventDate
        self.isAttending = isAttending
        self.uuid = uuid
    }
}

extension Event {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
