import Foundation

extension Date {
    func formatAsString(using format: String = "dd-MM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // Convenient accessor specifically for dd-MM-yyyy format
    var ddMMyyyyString: String {
        return formatAsString(using: "dd-MM-yyyy")
    }
}

// Usage examples:
// let dateString = myDate.formatAsString() // Uses default "dd-MM-yyyy"
// let dateString = myDate.formatAsString(using: "MM/dd/yyyy") // Custom format
// let dateString = myDate.ddMMyyyyString // Direct access to dd-MM-yyyy format 