//
//  MainViewController.swift
//  DenverStartupWeekDemo
//
//  Created by Danilo Caetano on 9/28/15.
//  Copyright © 2015 UIGuigo. All rights reserved.
//

import UIKit
import MapKit

private let eventCellIdentifier = "EventCell"
private let segueIdentifier = "DetailSegue"
private let metersToMiles = 0.000621371

class Event: NSObject {
    var title: String = ""
    var information: String = ""
    var date: String = ""
    var time: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var zipcode: String = ""
    var distance: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: Vars
    private var events = [Event]()
    private var selectedEvent = Event()
    private let currentLatitude = 39.744700
    private let currentLongitude = -104.988707
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUpThatData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdentifier {
            let destination = segue.destinationViewController as! DetailViewController
            destination.event = selectedEvent
        }
    }
    
    // MARK: Private methods
    private func fillUpThatData() { /* For demo purposes, grabbed data directly from http://www.denverstartupweek.org/schedule */
        
        createEventObject("What’s An Accessible App, And Why Does It Matter?",
            information: "In the U.S. alone, nearly 6.7 million people 16 and older are visually impaired — meaning, even with corrective lenses, they must use alternative methods to engage in activities that people with vision can do. Developing apps that are accessible means making it possible for those millions of blind and visually impaired people to do things like manage their health with iTriage and track sales leads via Salesforce the way sighted people do. \n\nIn this session, Denver-based experts Patrick Leonard, CTO of iTriage/Aetna Digital Products, and Mike Hess, Blind Institute of Technology founder and executive director, will do a little show-and-tell on what goes into developing apps that are accessible for the blind and visually impaired based on real apps that are in development. \n\nThey’ll also discuss the challenges they must overcome as a development team, and why making your apps accessible is a win for you as well as your users.",
            date: "Thursday, October 1",
            time: "12PM - 1:30PM",
            address: "475 17th St., Ste. 200",
            city: "Denver",
            state: "CO",
            zipcode: "80202",
            distance: 0.0,
            latitude: 39.744700,
            longitude: -104.988707)
        
        createEventObject("Virtual Reality 101",
            information: "One part philosophical, one part technical, this session will make you question what is real and yearn for more Virtual Reality in your life. \n\nA survey of the history of Virtual Reality will bring us from inception to the present day. It will be explained how, with mostly free and open source tools, beginning developers can create Virtual Reality content and experiences today.\n\nModern Virtual Reality systems, including those publicly available, and those only privately viewable will be reviewed in detail.\n\nA surprise national speaker guest, with actionable expertise in the Virtual Reality domain will join Mark Scheel for this session.\n\nAnother surprise opportunity will be more available to attendees of this session, but open to all of Denver Startup Week. Stay tuned for more.\n\nIs our reality real, or are we just ghosts in the machine? You won't want to miss this thought provoking discussion, multimedia content and technical lessons that this session will feature.\n\nMark Scheel is a local Android developer who has spoken at every Denver Startup Week. This year he will speak in cities around the world including Boston, Los Angeles, San Francisco, Dallas, Paris, Boulder and Denver. He loves to trail run and snowboard in the mountains when he isn't hacking away on various projects. You can follow him on Twitter at @5280mark.",
            date: "Monday, September 28",
            time: "2PM - 3:30PM",
            address: "1475 Lawrence Street, 5th Floor",
            city: "Denver",
            state: "CO",
            zipcode: "80202",
            distance: 0.0,
            latitude: 39.747534,
            longitude: -104.998340)
        
        createEventObject("Design vs. Dev: It Doesn’t Have To Be This Way",
            information: "This panel will bridge both the Design Track and the Development Track. \n\nAnyone who has managed or worked on a team creating a digital product or website knows exactly what I’m talking about when I say design vs dev. It is like there is an unwritten rule that designers and developers should not like each other and it is their personal responsibility to make the others job as hard as possible. Why is this? \n\nIs it a difference in personalities? A problem of egos? A lack of rudimentary social skills? \n\nPerhaps. Or just maybe, designer and developers have never be offered an alternative and they are just following the path they believe their role is supposed to by living up to and projecting the stereotypes passed on to them. The individuals on this panel have all grappled at finding better ways for teams of designers and developers to work together more efficiently and more effectively. The panel will discuss how they have found success and what continues to trip them up today. Panelists include:\n\nBree Thomas, Developer at Mode Set, Co-Founder of The Aha Method and formerly Group Account Director at Factory Design Labs \n\nMario Rini, Digital Director at Strada Advertising, formerly Creative Director at io \n\nOlivia James, Marketing Program Manager at K2. \n\nBryan Lesniewski, UX Designer and Product Owner at TransUnion \n\nJason Hummel, Founder and Development Lead at Chalk \n\nJustin Gitlin, Director/Developer at Mode Set \n\nModerator:\nIan T. Nordeck, Creative Director and Consultant, former Creative Director at SpireMedia \n\nCoffee and light breakfast provided. \n\nHosted by: Ian T. Nordeck",
            date: "Thursday, October 1",
            time: "10AM - 11:30AM",
            address: "3461 Ringsby Court #220",
            city: "Denver", state: "CO",
            zipcode: "80202",
            distance: 0.0,
            latitude: 39.772329,
            longitude: -104.983799)
        
        collectionView.reloadData()
    }
    
    private func createEventObject(title: String, information: String, date: String, time: String, address: String, city: String, state: String, zipcode: String, distance: Double, latitude: Double, longitude: Double) {
        let newEvent = Event()
        newEvent.title = title
        newEvent.information = information
        newEvent.date = date
        newEvent.time = time
        newEvent.address = address
        newEvent.city = city
        newEvent.state = state
        newEvent.zipcode = zipcode
        newEvent.latitude = latitude
        newEvent.longitude = longitude
        newEvent.distance = calculateDistanceFromCurrentUserLocation(newEvent.latitude, eventLongitude: newEvent.longitude)
        events.append(newEvent)
    }
    
    private func calculateDistanceFromCurrentUserLocation(eventLatitude: CLLocationDegrees, eventLongitude: CLLocationDegrees) -> Double {
        let currentLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let objectLocation = CLLocation(latitude: eventLatitude, longitude: eventLongitude)
        return objectLocation.distanceFromLocation(currentLocation) * metersToMiles
    }
    
    // MARK: CollectionView methods
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let eventCell = collectionView.dequeueReusableCellWithReuseIdentifier(eventCellIdentifier, forIndexPath: indexPath) as! EventCollectionViewCell
        let eventAtIndex = events[indexPath.row] as Event
        
        eventCell.eventLabel.text = eventAtIndex.title
        eventCell.eventDateTime.text = "\(eventAtIndex.date) \n\(eventAtIndex.time)"
        eventCell.eventAddress.text = eventAtIndex.address
        eventCell.eventCityStateZip.text = "\(eventAtIndex.city), \(eventAtIndex.state) \(eventAtIndex.zipcode)"
        eventCell.eventDistance.text = String(format: "%.2f miles from here", eventAtIndex.distance)
        return eventCell
    }

    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let eventAtIndex = events[indexPath.row] as Event
        selectedEvent = eventAtIndex
        performSegueWithIdentifier(segueIdentifier, sender: self)
    }
}

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets/IBActions
    @IBOutlet var eventWhat: UILabel!
    @IBOutlet var eventWhen: UILabel!
    @IBOutlet var eventWhere: UILabel!
    @IBOutlet var numberOfAttendees: UILabel!
    @IBOutlet var eventDescription: UITextView!
    
    @IBAction func getDirections() {
        print("Get directions selected")
    }
    
    // MARK: Vars
    internal var event = Event()
    
    // MARK: Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fillOutData()
    }
    
    // MARK: Private methods
    private func fillOutData() {
        eventWhat.text = event.title
        eventWhen.text = "\(event.date) \n\(event.time)"
        eventWhere.text = "\(event.address) \n\(event.city) \(event.state), \(event.zipcode)"
        numberOfAttendees.text = "Number of attendees: \(arc4random_uniform(250) + 1)"
        eventDescription.text = event.information
    }
}

final class EventCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var eventDateTime: UILabel!
    @IBOutlet var eventAddress: UILabel!
    @IBOutlet var eventCityStateZip: UILabel!
    @IBOutlet var eventDistance: UILabel!
}

