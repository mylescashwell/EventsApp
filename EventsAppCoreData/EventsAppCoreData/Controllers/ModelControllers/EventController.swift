//
//  EventController.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import CoreData

class EventController {
    
    //MARK: - Properties
    static let shared = EventController()
    var events: [Event] = []
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() {}


    //MARK: - Functions
    func createNewEvent(newEventTitle: String, newEventDate: Date) {
        let newEvent = Event(eventTitle: newEventTitle, eventDate: newEventDate)
        events.append(newEvent)
        CoreDataStack.saveContext()
    }
    
    func fetchEvents() {
        let fetchedEvents = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        events = fetchedEvents
    }
    
    func updateEvent(event: Event, newEventTitle: String, newEventDate: Date) {
        event.eventTitle = newEventTitle
        event.eventDate = newEventDate
        CoreDataStack.saveContext()
    }
    
    func isAttending(event: Event) {
        event.isAttending.toggle()
        CoreDataStack.saveContext()
    }
    
    func deleteEvent(event: Event) {
        if let index = events.firstIndex(of: event) {
            events.remove(at: index)
        }
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
}
