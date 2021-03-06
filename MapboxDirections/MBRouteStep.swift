import Polyline

/**
 A `TransportType` specifies the mode of transportation used for part of a route.
 */
@objc(MBTransportType)
public enum TransportType: Int, CustomStringConvertible {
    // Possible transport types when the `profileIdentifier` is `MBDirectionsProfileIdentifierAutomobile` or `MBDirectionsProfileIdentifierAutomobileAvoidingTraffic`
    
    /**
     The route requires the user to drive or ride a car, truck, or motorcycle.
     
     This is the usual transport type when the `profileIdentifier` is `MBDirectionsProfileIdentifierAutomobile` or `MBDirectionsProfileIdentifierAutomobileAvoidingTraffic`.
     */
    case Automobile // automobile
    
    /**
     The route requires the user to board a ferry.
     
     The user should verify that the ferry is in operation. For driving and cycling directions, the user should also verify that his or her vehicle is permitted onboard the ferry.
     */
    case Ferry // automobile, walking, cycling
    
    /**
     The route requires the user to cross a movable bridge.
     
     The user may need to wait for the movable bridge to become passable before continuing.
     */
    case MovableBridge // automobile, cycling
    
    /**
     The route becomes impassable at this point.
     
     You should not encounter this transport type under normal circumstances.
     */
    case Inaccessible // automobile, walking, cycling
    
    // Possible transport types when the `profileIdentifier` is `MBDirectionsProfileIdentifierWalking`
    
    /**
     The route requires the user to walk.
     
     This is the usual transport type when the `profileIdentifier` is `MBDirectionsProfileIdentifierWalking`. For cycling directions, this value indicates that the user is expected to dismount.
     */
    case Walking // walking, cycling
    
    // Possible transport types when the `profileIdentifier` is `MBDirectionsProfileIdentifierCycling`
    
    /**
     The route requires the user to ride a bicycle.
     
     This is the usual transport type when the `profileIdentifier` is `MBDirectionsProfileIdentifierCycling`.
     */
    case Cycling // cycling
    
    /**
     The route requires the user to board a train.
     
     The user should consult the train’s timetable. For cycling directions, the user should also verify that bicycles are permitted onboard the train.
     */
    case Train // cycling
    
    public init?(description: String) {
        let type: TransportType
        switch description {
        case "driving":
            type = .Automobile
        case "ferry":
            type = .Ferry
        case "moveable bridge":
            type = .MovableBridge
        case "unaccessible":
            type = .Inaccessible
        case "walking":
            type = .Walking
        case "cycling":
            type = .Cycling
        case "train":
            type = .Train
        default:
            return nil
        }
        self.init(rawValue: type.rawValue)
    }
    
    public var description: String {
        switch self {
        case .Automobile:
            return "driving"
        case .Ferry:
            return "ferry"
        case .MovableBridge:
            return "moveable bridge"
        case .Inaccessible:
            return "unaccessible"
        case .Walking:
            return "walking"
        case .Cycling:
            return "cycling"
        case .Train:
            return "train"
        }
    }
}

/**
 A `ManeuverType` specifies the type of maneuver required to complete the route step. You can pair a maneuver type with a `ManeuverDirection` to choose an appropriate visual or voice prompt to present the user.
 
 In Swift, you can use pattern matching with a single switch statement on a tuple containing the maneuver type and maneuver direction to avoid a complex series of if-else-if statements or switch statements.
 */
@objc(MBManeuverType)
public enum ManeuverType: Int, CustomStringConvertible {
    /**
     The step requires the user to depart from a waypoint.
     
     If the waypoint is some distance away from the nearest road, the maneuver direction indicates the direction the user must turn upon reaching the road.
     */
    case Depart
    
    /**
     The step requires the user to turn.
     
     The maneuver direction indicates the direction in which the user must turn relative to the current direction of travel. The exit index indicates the number of intersections, large or small, from the previous maneuver up to and including the intersection at which the user must turn.
     */
    case Turn
    
    /**
     The step requires the user to continue after a turn.
     */
    case Continue
    
    /**
     The step requires the user to continue on the current road as it changes names.
     
     The step’s name contains the road’s new name. To get the road’s old name, use the previous step’s name.
     */
    case PassNameChange
    
    /**
     The step requires the user to merge onto another road.
     
     The maneuver direction indicates the side from which the other road approaches the intersection relative to the user.
     */
    case Merge
    
    /**
     The step requires the user to take a entrance ramp (slip road) onto a highway.
     */
    case TakeOnRamp
    
    /**
     The step requires the user to take an exit ramp (slip road) off a highway.
     
     The maneuver direction indicates the side of the highway from which the user must exit. The exit index indicates the number of highway exits from the previous maneuver up to and including the exit that the user must take.
     */
    case TakeOffRamp
    
    /**
     The step requires the user to choose a fork at a Y-shaped fork in the road.
     
     The maneuver direction indicates which fork to take.
     */
    case ReachFork
    
    /**
     The step requires the user to turn at either a T-shaped three-way intersection or a sharp bend in the road where the road also changes names.
     
     This maneuver type is called out separately so that the user may be able to proceed more confidently, without fear of having overshot the turn. If this distinction is unimportant to you, you may treat the maneuver as an ordinary `Turn`.
     */
    case ReachEnd
    
    /**
     The step requires the user to get into a specific lane in order to continue along the current road.
     
     The maneuver direction is set to `StraightAhead`. Each of the first intersection’s usable approach lanes also has an indication of `StraightAhead`. A maneuver in a different direction would instead have a maneuver type of `Turn`.
     
     This maneuver type is called out separately so that the application can present the user with lane guidance based on the first element in the `intersections` property. If lane guidance is unimportant to you, you may treat the maneuver as an ordinary `Continue` or ignore it.
     */
    case UseLane
     
    /**
     The step requires the user to enter, traverse, and exit a roundabout (traffic circle or rotary).
     
     The step has no name, but the exit name is the name of the road to take to exit the roundabout. The exit index indicates the number of roundabout exits up to and including the exit to take.
     */
    case TakeRoundabout
    
    /**
     The step requires the user to enter, traverse, and exit a large, named roundabout (traffic circle or rotary).
     
     The step’s name is the name of the roundabout. The exit name is the name of the road to take to exit the roundabout. The exit index indicates the number of rotary exits up to and including the exit that the user must take.
     */
    case TakeRotary
    
    /**
     The step requires the user to enter and exit a roundabout (traffic circle or rotary) that is compact enough to constitute a single intersection.
     
     The step’s name is the name of the road to take after exiting the roundabout. This maneuver type is called out separately because the user may perceive the roundabout as an ordinary intersection with an island in the middle. If this distinction is unimportant to you, you may treat the maneuver as either an ordinary `Turn` or as a `TakeRoundabout`.
     */
    case TurnAtRoundabout
    
    /**
     The step requires the user to respond to a change in travel conditions.
     
     This maneuver type may occur for example when driving directions require the user to board a ferry, or when cycling directions require the user to dismount. The step’s transport type and instructions contains important contextual details that should be presented to the user at the maneuver location.
     
     Similar changes can occur simultaneously with other maneuvers, such as when the road changes its name at the site of a movable bridge. In such cases, `HeedWarning` is suppressed in favor of another maneuver type.
     */
    case HeedWarning
    
    /**
     The step requires the user to arrive at a waypoint.
     
     The distance and expected travel time for this step are set to zero, indicating that the route or route leg is complete. The maneuver direction indicates the side of the road on which the waypoint can be found (or whether it is straight ahead).
     */
    case Arrive
    
    /**
     The step requires the user to arrive at an intermediate waypoint.
     
     This maneuver type is only used by version 4 of the Mapbox Directions API.
     */
    case PassWaypoint // v4
    
    public init?(description: String) {
        let type: ManeuverType
        switch description {
        case "depart":
            type = .Depart
        case "turn":
            type = .Turn
        case "continue":
            type = .Continue
        case "new name":
            type = .PassNameChange
        case "merge":
            type = .Merge
        case "on ramp":
            type = .TakeOnRamp
        case "off ramp":
            type = .TakeOffRamp
        case "fork":
            type = .ReachFork
        case "end of road":
            type = .ReachEnd
        case "use lane":
            type = .UseLane
        case "rotary":
            type = .TakeRotary
        case "roundabout":
            type = .TakeRoundabout
        case "roundabout turn":
            type = .TurnAtRoundabout
        case "notification":
            type = .HeedWarning
        case "arrive":
            type = .Arrive
        case "waypoint": // v4
            type = .PassWaypoint
        default:
            return nil
        }
        self.init(rawValue: type.rawValue)
    }
    
    public var description: String {
        switch self {
        case .Depart:
            return "depart"
        case .Turn:
            return "turn"
        case .Continue:
            return "continue"
        case .PassNameChange:
            return "new name"
        case .Merge:
            return "merge"
        case .TakeOnRamp:
            return "on ramp"
        case .TakeOffRamp:
            return "off ramp"
        case .ReachFork:
            return "fork"
        case .ReachEnd:
            return "end of road"
        case .UseLane:
            return "use lane"
        case .TakeRotary:
            return "rotary"
        case .TakeRoundabout:
            return "roundabout"
        case .TurnAtRoundabout:
            return "roundabout turn"
        case .HeedWarning:
            return "notification"
        case .Arrive:
            return "arrive"
        case .PassWaypoint: // v4
            return "waypoint"
        }
    }
}

/**
 A `ManeuverDirection` clarifies a `ManeuverType` with directional information. The exact meaning of the maneuver direction for a given step depends on the step’s maneuver type; see the `ManeuverType` documentation for details.
 */
@objc(MBManeuverDirection)
public enum ManeuverDirection: Int, CustomStringConvertible {
    /**
     The maneuver requires a sharp turn to the right.
     */
    case SharpRight
    
    /**
     The maneuver requires a turn to the right, a merge to the right, or an exit on the right, or the destination is on the right.
     */
    case Right
    
    /**
     The maneuver requires a slight turn to the right.
     */
    case SlightRight
    
    /**
     The maneuver requires no notable change in direction, or the destination is straight ahead.
     */
    case StraightAhead
    
    /**
     The maneuver requires a slight turn to the left.
     */
    case SlightLeft
    
    /**
     The maneuver requires a turn to the left, a merge to the left, or an exit on the left, or the destination is on the right.
     */
    case Left
    
    /**
     The maneuver requires a sharp turn to the left.
     */
    case SharpLeft
    
    /**
     The maneuver requires a U-turn when possible.
     
     Use the difference between the step’s initial and final headings to distinguish between a U-turn to the left (typical in countries that drive on the right) and a U-turn on the right (typical in countries that drive on the left). If the difference in headings is greater than 180 degrees, the maneuver requires a U-turn to the left. If the difference in headings is less than 180 degrees, the maneuver requires a U-turn to the right.
     */
    case UTurn
    
    public init?(description: String) {
        let direction: ManeuverDirection
        switch description {
        case "sharp right":
            direction = .SharpRight
        case "right":
            direction = .Right
        case "slight right":
            direction = .SlightRight
        case "straight":
            direction = .StraightAhead
        case "slight left":
            direction = .SlightLeft
        case "left":
            direction = .Left
        case "sharp left":
            direction = .SharpLeft
        case "uturn":
            direction = .UTurn
        default:
            return nil
        }
        self.init(rawValue: direction.rawValue)
    }
    
    public var description: String {
        switch self {
        case .SharpRight:
            return "sharp right"
        case .Right:
            return "right"
        case .SlightRight:
            return "slight right"
        case .StraightAhead:
            return "straight"
        case .SlightLeft:
            return "slight left"
        case .Left:
            return "left"
        case .SharpLeft:
            return "sharp left"
        case .UTurn:
            return "uturn"
        }
    }
}

extension String {
    internal func tagValuesSeparatedByString(separator: String) -> [String] {
        return componentsSeparatedByString(separator).map { $0.stringByTrimmingCharactersInSet(.whitespaceCharacterSet()) }.filter { !$0.isEmpty }
    }
}

/**
 Encapsulates all the information about a road.
 */
struct Road {
    let names: [String]?
    let codes: [String]?
    let destinations: [String]?
    let destinationCodes: [String]?
    let rotaryNames: [String]?
    
    init(name: String, ref: String?, destination: String?, rotaryName: String?) {
        var codes: [String]?
        if !name.isEmpty, let ref = ref {
            // Mapbox Directions API v5 encodes the ref separately from the name but redundantly includes the ref in the name for backwards compatibility. Remove the ref from the name.
            let parenthetical = "(\(ref))"
            if name == ref {
                self.names = nil
            } else {
                self.names = name.stringByReplacingOccurrencesOfString(parenthetical, withString: "").tagValuesSeparatedByString(";")
            }
            codes = ref.tagValuesSeparatedByString(";")
        } else if !name.isEmpty, let codesRange = name.rangeOfString("\\(.+?\\)$", options: .RegularExpressionSearch, range: name.startIndex..<name.endIndex) {
            // Mapbox Directions API v4 encodes the ref inside a parenthetical. Remove the ref from the name.
            let parenthetical = name.substringWithRange(codesRange)
            if name == ref {
                self.names = nil
            } else {
                self.names = name.stringByReplacingOccurrencesOfString(parenthetical, withString: "").tagValuesSeparatedByString(";")
            }
            codes = parenthetical.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "()")).tagValuesSeparatedByString(";")
        } else {
            self.names = name.isEmpty ? nil : name.tagValuesSeparatedByString(";")
            codes = ref?.tagValuesSeparatedByString(";")
        }
        
        // Mapbox Directions API v5 combines the destination’s ref and name.
        if let destination = destination where destination.containsString(": ") {
            let destinationComponents = destination.componentsSeparatedByString(": ")
            self.destinationCodes = destinationComponents.first?.tagValuesSeparatedByString(",")
            self.destinations = destinationComponents.dropFirst().joinWithSeparator(": ").tagValuesSeparatedByString(",")
        } else {
            self.destinationCodes = nil
            self.destinations = destination?.tagValuesSeparatedByString(",")
        }
        
        self.codes = codes
        self.rotaryNames = rotaryName?.tagValuesSeparatedByString(";")
    }
}

/**
 A `RouteStep` object represents a single distinct maneuver along a route and the approach to the next maneuver. The route step object corresponds to a single instruction the user must follow to complete a portion of the route. For example, a step might require the user to turn then follow a road.
 
 You do not create instances of this class directly. Instead, you receive route step objects as part of route objects when you request directions using the `Directions.calculateDirections(options:completionHandler:)` method, setting the `includesSteps` option to `true` in the `RouteOptions` object that you pass into that method.
 */
@objc(MBRouteStep)
public class RouteStep: NSObject, NSSecureCoding {
    // MARK: Creating a Step
    
    internal init(finalHeading: CLLocationDirection?, maneuverType: ManeuverType?, maneuverDirection: ManeuverDirection?, maneuverLocation: CLLocationCoordinate2D, name: String, coordinates: [CLLocationCoordinate2D]?, json: JSONDictionary) {
        transportType = TransportType(description: json["mode"] as! String)
        
        let road = Road(name: name, ref: json["ref"] as? String, destination: json["destinations"] as? String, rotaryName: json["rotary_name"] as? String)
        if maneuverType == .TakeRotary || maneuverType == .TakeRoundabout {
            names = road.rotaryNames
            exitNames = road.names
        } else {
            names = road.names
            exitNames = nil
        }
        codes = road.codes
        destinationCodes = road.destinationCodes
        destinations = road.destinations
        
        let maneuver = json["maneuver"] as! JSONDictionary

        if let instructions = maneuver["instruction"] as? String {
            self.instructions = instructions
        } else if let mt = maneuverType, md = maneuverDirection {
            instructions = "\(mt) \(md)"
        } else if let mt = maneuverType {
            instructions = String(mt)
        } else if let md = maneuverDirection {
            instructions = String(md)
        } else {
            instructions = ""
        }

        distance = json["distance"] as? Double ?? 0
        expectedTravelTime = json["duration"] as? Double ?? 0
        
        let intersectionsJSON = json["intersections"] as? [JSONDictionary]
        intersections = intersectionsJSON?.map { Intersection(json: $0) }
        
        initialHeading = maneuver["bearing_before"] as? Double
        self.finalHeading = finalHeading
        self.maneuverType = maneuverType
        self.maneuverDirection = maneuverDirection
        exitIndex = maneuver["exit"] as? Int
        
        self.maneuverLocation = maneuverLocation
        self.coordinates = coordinates
    }
    
    /**
     Initializes a new route step object with the given JSON dictionary representation.
     
     Normally, you do not create instances of this class directly. Instead, you receive route step objects as part of route objects when you request directions using the `Directions.calculateDirections(options:completionHandler:)` method, setting the `includesSteps` option to `true` in the `RouteOptions` object that you pass into that method.
     
     - parameter json: A JSON dictionary representation of a route step object as returnd by the Mapbox Directions API.
     */
    public convenience init(json: [String: AnyObject]) {
        let maneuver = json["maneuver"] as! JSONDictionary
        let finalHeading = maneuver["bearing_after"] as? Double
        let maneuverType = ManeuverType(description: maneuver["type"] as! String)
        let maneuverDirection = ManeuverDirection(description: maneuver["modifier"] as? String ?? "")
        let maneuverLocation = CLLocationCoordinate2D(geoJSON: maneuver["location"] as! [Double])
        
        let name = json["name"] as! String
        
        var coordinates: [CLLocationCoordinate2D]?
        switch json["geometry"] {
        case let geometry as JSONDictionary:
            coordinates = CLLocationCoordinate2D.coordinates(geoJSON: geometry)
        case let geometry as String:
            coordinates = decodePolyline(geometry, precision: 1e5)!
        default:
            coordinates = nil
        }
        
        self.init(finalHeading: finalHeading, maneuverType: maneuverType, maneuverDirection: maneuverDirection, maneuverLocation: maneuverLocation, name: name, coordinates: coordinates, json: json)
    }
    
    public required init?(coder decoder: NSCoder) {
        let coordinateDictionaries = decoder.decodeObjectOfClasses([NSArray.self, NSDictionary.self, NSString.self, NSNumber.self], forKey: "coordinates") as? [[String: CLLocationDegrees]]
		
        coordinates = coordinateDictionaries?.flatMap({ (coordinateDictionary) -> CLLocationCoordinate2D? in
            if let latitude = coordinateDictionary["latitude"], let longitude = coordinateDictionary["longitude"] {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            } else {
                return nil
            }
        })
        
        guard let decodedInstructions = decoder.decodeObjectOfClass(NSString.self, forKey: "instructions") as String? else {
            return nil
        }
        instructions = decodedInstructions
		
        initialHeading = decoder.containsValueForKey("initialHeading") ? decoder.decodeDoubleForKey("initialHeading") : nil
        finalHeading = decoder.containsValueForKey("finalHeading") ? decoder.decodeDoubleForKey("finalHeading") : nil
        
        guard let maneuverTypeDescription = decoder.decodeObjectOfClass(NSString.self, forKey: "maneuverType") as String? else {
            return nil
        }
        maneuverType = ManeuverType(description: maneuverTypeDescription)
        let maneuverDirectionDescription = decoder.decodeObjectOfClass(NSString.self, forKey: "maneuverDirection") as! String
        maneuverDirection = ManeuverDirection(description: maneuverDirectionDescription)
        
        if let maneuverLocationDictionary = decoder.decodeObjectOfClasses([NSDictionary.self, NSString.self, NSNumber.self], forKey: "maneuverLocation") as? [String: CLLocationDegrees],
            let latitude = maneuverLocationDictionary["latitude"],
            let longitude = maneuverLocationDictionary["longitude"] {
            maneuverLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            maneuverLocation = kCLLocationCoordinate2DInvalid
        }
        
        exitIndex = decoder.containsValueForKey("exitIndex") ? decoder.decodeIntegerForKey("exitIndex") : nil
        exitNames = decoder.decodeObjectOfClasses([NSArray.self, NSString.self], forKey: "exitNames") as? [String]
        distance = decoder.decodeDoubleForKey("distance")
        expectedTravelTime = decoder.decodeDoubleForKey("expectedTravelTime")
        names = decoder.decodeObjectOfClasses([NSArray.self, NSString.self], forKey: "names") as? [String]
        
        guard let transportTypeDescription = decoder.decodeObjectOfClass(NSString.self, forKey: "transportType") as? String else {
            return nil
        }
        transportType = TransportType(description: transportTypeDescription)
        
        codes = decoder.decodeObjectOfClasses([NSArray.self, NSString.self], forKey: "codes") as? [String]
        destinationCodes = decoder.decodeObjectOfClasses([NSArray.self, NSString.self], forKey: "destinationCodes") as? [String]
        destinations = decoder.decodeObjectOfClasses([NSArray.self, NSString.self], forKey: "destinations") as? [String]
        
        intersections = decoder.decodeObjectOfClasses([NSArray.self, Intersection.self], forKey: "intersections") as? [Intersection]
    }
    
    public static func supportsSecureCoding() -> Bool {
        return true
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        let coordinateDictionaries = coordinates?.map { [
            "latitude": $0.latitude,
            "longitude": $0.longitude,
            ] }
        coder.encodeObject(coordinateDictionaries, forKey: "coordinates")
        
        coder.encodeObject(instructions, forKey: "instructions")
        
        if let initialHeading = initialHeading {
            coder.encodeDouble(initialHeading, forKey: "initialHeading")
        }
        if let finalHeading = finalHeading {
            coder.encodeDouble(finalHeading, forKey: "finalHeading")
        }
        
        coder.encodeObject(maneuverType?.description, forKey: "maneuverType")
        coder.encodeObject(maneuverDirection?.description, forKey: "maneuverDirection")
        
        coder.encodeObject(intersections, forKey: "intersections")
        
        coder.encodeObject([
            "latitude": maneuverLocation.latitude,
            "longitude": maneuverLocation.longitude,
        ], forKey: "maneuverLocation")
        
        if let exitIndex = exitIndex {
            coder.encodeInteger(exitIndex, forKey: "exitIndex")
        }
        
        coder.encodeObject(exitNames, forKey: "exitNames")
        coder.encodeDouble(distance, forKey: "distance")
        coder.encodeDouble(expectedTravelTime, forKey: "expectedTravelTime")
        coder.encodeObject(names, forKey: "names")
        coder.encodeObject(transportType?.description, forKey: "transportType")
        coder.encodeObject(codes, forKey: "codes")
        coder.encodeObject(destinationCodes, forKey: "destinationCodes")
        coder.encodeObject(destinations, forKey: "destinations")
    }
    
    // MARK: Getting the Step Geometry
    
    /**
     An array of geographic coordinates defining the path of the route step from the location of the maneuver to the location of the next step’s maneuver.
     
     The value of this property may be `nil`, for example when the maneuver type is `Arrive`.
     
     Using the [Mapbox iOS SDK](https://www.mapbox.com/ios-sdk/) or [Mapbox macOS SDK](https://github.com/mapbox/mapbox-gl-native/tree/master/platform/macos/), you can create an `MGLPolyline` object using these coordinates to display a portion of a route on an `MGLMapView`.
     */
    public let coordinates: [CLLocationCoordinate2D]?
    
    /**
     The number of coordinates.
     
     The value of this property may be zero, for example when the maneuver type is `Arrive`.
     
     - note: This initializer is intended for Objective-C usage. In Swift code, use the `coordinates.count` property.
     */
    public var coordinateCount: UInt {
        return UInt(coordinates?.count ?? 0)
    }
    
    /**
     Retrieves the coordinates.
     
     The array may be empty, for example when the maneuver type is `Arrive`.
     
     Using the [Mapbox iOS SDK](https://www.mapbox.com/ios-sdk/) or [Mapbox macOS SDK](https://github.com/mapbox/mapbox-gl-native/tree/master/platform/macos/), you can create an `MGLPolyline` object using these coordinates to display a portion of a route on an `MGLMapView`.
     
     - parameter coordinates: A pointer to a C array of `CLLocationCoordinate2D` instances. On output, this array contains all the vertices of the overlay.
     - returns: True if the step has coordinates and `coordinates` has been populated, or false if the step has no coordinates and `coordinates` has not been modified.
     
     - precondition: `coordinates` must be large enough to hold `coordinateCount` instances of `CLLocationCoordinate2D`.
     
     - note: This initializer is intended for Objective-C usage. In Swift code, use the `coordinates` property.
     */
    public func getCoordinates(coordinates: UnsafeMutablePointer<CLLocationCoordinate2D>) -> Bool {
        guard let stepCoordinates = self.coordinates else {
            return false
        }
        
        for i in 0..<stepCoordinates.count {
            coordinates.advancedBy(i).memory = stepCoordinates[i]
        }
        return true
    }
    
    // MARK: Getting Details About the Maneuver
    
    /**
     A string with instructions explaining how to perform the step’s maneuver.
     
     You can display this string or read it aloud to the user. The string does not include the distance to or from the maneuver. If you need localized or customized instructions, you can construct them yourself from the step’s other properties or use [osrm-text-instructions](https://github.com/Project-OSRM/osrm-text-instructions).
     
     - note: If you use MapboxDirections.swift with the Mapbox Directions API, this property is formatted for display to the user. If you use OSRM directly, this property contains a basic string that only includes the maneuver type and direction. Use [osrm-text-instructions](https://github.com/Project-OSRM/osrm-text-instructions) to construct a complete instruction string for display.
     */
    public let instructions: String
    
    public override var description: String {
        return instructions
    }
    
    /**
     The user’s heading immediately before performing the maneuver.
     */
    public let initialHeading: CLLocationDirection?
    
    /**
     The user’s heading immediately after performing the maneuver.
     
     The value of this property may differ from the user’s heading after traveling along the road past the maneuver.
     */
    public let finalHeading: CLLocationDirection?
    
    /**
     The type of maneuver required for beginning this step.
     */
    public let maneuverType: ManeuverType?
    
    /**
     Additional directional information to clarify the maneuver type.
     */
    public let maneuverDirection: ManeuverDirection?
    
    /**
     The location of the maneuver at the beginning of this step.
     */
    public let maneuverLocation: CLLocationCoordinate2D
    
    /**
     The number of exits from the previous maneuver up to and including this step’s maneuver.
     
     If the maneuver takes place on a surface street, this property counts intersections. The number of intersections does not necessarily correspond to the number of blocks. If the maneuver takes place on a grade-separated highway (freeway or motorway), this property counts highway exits but not highway entrances. If the maneuver is a roundabout maneuver, the exit index is the number of exits from the approach to the recommended outlet.
     
     In some cases, the number of exits leading to a maneuver may be more useful to the user than the distance to the maneuver.
     */
    public let exitIndex: Int?
    
    /**
     The names of the roundabout exit.
     
     This property is only set for roundabout (traffic circle or rotary) maneuvers. For the signposted names associated with a highway exit, use the `destinations` property.
     
     If you display a name to the user, you may need to abbreviate common words like “East” or “Boulevard” to ensure that it fits in the allotted space.
     */
    public let exitNames: [String]?
    
    // MARK: Getting Details About the Approach to the Next Maneuver
    
    /**
     The step’s distance, measured in meters.
     
     The value of this property accounts for the distance that the user must travel to go from this step’s maneuver location to the next step’s maneuver location. It is not the sum of the direct distances between the route’s waypoints, nor should you assume that the user would travel along this distance at a fixed speed.
     */
    public let distance: CLLocationDistance
    
    /**
     The step’s expected travel time, measured in seconds.
     
     The value of this property reflects the time it takes to go from this step’s maneuver location to the next step’s maneuver location under ideal conditions. You should not assume that the user would travel along the step at a fixed speed. The actual travel time may vary based on the weather, traffic conditions, road construction, and other variables. If the step makes use of a ferry or train, the actual travel time may additionally be subject to the schedules of those services.
     */
    public let expectedTravelTime: NSTimeInterval
    
    /**
     The names of the road or path leading from this step’s maneuver to the next step’s maneuver.
     
     If the maneuver is a turning maneuver, the step’s names are the name of the road or path onto which the user turns. If you display a name to the user, you may need to abbreviate common words like “East” or “Boulevard” to ensure that it fits in the allotted space.
     
     If the maneuver is a roundabout maneuver, the outlet to take is named in the `exitNames` property; the `names` property is only set for large roundabouts that have their own names.
     */
    public let names: [String]?
    
    /**
     Any route reference codes assigned to the road or path leading from this step’s maneuver to the next step’s maneuver.
     
     A route reference code commonly consists of an alphabetic network code, a space or hyphen, and a route number. You should not assume that the network code is globally unique: for example, a network code of “NH” may indicate a “National Highway” or “New Hampshire”. Moreover, a route number may not even uniqely identify a route within a given network.
     
     If a highway ramp is part of a numbered route, its reference code is contained in this property. On the other hand, guide signage for a highway ramp usually indicates route reference codes of the adjoining road; use the `destinationCodes` property for those route reference codes.
     */
    public let codes: [String]?
    
    // MARK: Getting Additional Step Details
    
    /**
     The mode of transportation used for the step.
     
     This step may use a different mode of transportation than the overall route.
     */
    public let transportType: TransportType?
    
    /**
     Any route reference codes that appear on guide signage for the road leading from this step’s maneuver to the next step’s maneuver.
     
     This property is typically available in steps leading to or from a freeway or expressway. This property contains route reference codes associated with a road later in the route. If a highway ramp is itself part of a numbered route, its reference code is contained in the `codes` property.
     
     A route reference code commonly consists of an alphabetic network code, a space or hyphen, and a route number. You should not assume that the network code is globally unique: for example, a network code of “NH” may indicate a “National Highway” or “New Hampshire”. Moreover, a route number may not even uniqely identify a route within a given network. A destination code for a divided road is often suffixed with the cardinal direction of travel, for example “I 80 East”.
     */
    public let destinationCodes: [String]?
    
    /**
     Destinations, such as [control cities](https://en.wikipedia.org/wiki/Control_city), that appear on guide signage for the road leading from this step’s maneuver to the next step’s maneuver.
     
     This property is typically available in steps leading to or from a freeway or expressway.
     */
    public let destinations: [String]?
    
    /**
     An array of intersections along the step.
     
     Each item in the array corresponds to a cross street, starting with the intersection at the maneuver location indicated by the coordinates property and continuing with each cross street along the step.
    */
    public let intersections: [Intersection]?
}

// MARK: Support for Directions API v4

extension ManeuverType {
    private init?(v4Description: String) {
        let description: String
        switch v4Description {
        case "bear right", "turn right", "sharp right", "sharp left", "turn left", "bear left", "u-turn":
            description = "turn"
        case "enter roundabout":
            description = "roundabout"
        default:
            description = v4Description
        }
        self.init(description: description)
    }
}

extension ManeuverDirection {
    private init?(v4TypeDescription: String) {
        let description: String
        switch v4TypeDescription {
        case "bear right", "bear left":
            description = v4TypeDescription.stringByReplacingOccurrencesOfString("bear", withString: "slight")
        case "turn right", "turn left":
            description = v4TypeDescription.stringByReplacingOccurrencesOfString("turn ", withString: "")
        case "u-turn":
            description = "uturn"
        default:
            description = v4TypeDescription
        }
        self.init(description: description)
    }
}

internal class RouteStepV4: RouteStep {
    internal convenience init(json: JSONDictionary) {
        let maneuver = json["maneuver"] as! JSONDictionary
        let heading = maneuver["heading"] as? Double
        let maneuverType = ManeuverType(v4Description: maneuver["type"] as! String)
        let maneuverDirection = ManeuverDirection(v4TypeDescription: maneuver["type"] as! String)
        let maneuverLocation = CLLocationCoordinate2D(geoJSON: maneuver["location"] as! JSONDictionary)
        
        let name = json["way_name"] as! String
        
        self.init(finalHeading: heading, maneuverType: maneuverType, maneuverDirection: maneuverDirection, maneuverLocation: maneuverLocation, name: name, coordinates: nil, json: json)
    }
}
