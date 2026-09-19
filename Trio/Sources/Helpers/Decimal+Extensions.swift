import CoreGraphics
import Foundation

extension Double {
    init(_ decimal: Decimal) {
        self.init(truncating: decimal as NSNumber)
    }

    func roundedDouble(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    init(_ decimal: Decimal) {
        self.init(Double(decimal))
    }
}

extension Int16 {
    var minutes: TimeInterval {
        TimeInterval(self) * 60
    }

    /// Crash-safe conversion: NaN becomes 0, out-of-range and infinite values saturate to `Int16.min` / `Int16.max`.
    /// `Int16(_: Double)` traps on NaN, infinity and overflow, so use this for values coming from external data.
    init(saturating value: Double) {
        if value.isNaN {
            self = 0
        } else if value >= Double(Int16.max) {
            self = Int16.max
        } else if value <= Double(Int16.min) {
            self = Int16.min
        } else {
            self = Int16(value)
        }
    }

    /// Crash-safe conversion from `Decimal`, see `init(saturating: Double)`.
    init(saturating value: Decimal) {
        self.init(saturating: Double(truncating: value as NSDecimalNumber))
    }
}

extension CGFloat {
    init(_ decimal: Decimal) {
        self.init(Double(decimal))
    }
}
