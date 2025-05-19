import Foundation

extension Double {
    func toPercentageString() -> String {
        let percentageValue = self * 100
        return String(format: "%.0f%%", percentageValue)
    }
}