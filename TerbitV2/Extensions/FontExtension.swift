import SwiftUI

extension Font {
    
    // MARK: - Poppins Font
    
    /// Returns a Poppins font with the specified weight and size
    static func poppins(_ weight: PoppinsWeight, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
    
    // Predefined sizes with Poppins Regular
    static func poppinsHeadingLarge() -> Font {
        return .poppins(.regular, size: 32)
    }
    
    static func poppinsHeadingMedium() -> Font {
        return .poppins(.regular, size: 24)
    }
    
    static func poppinsHeadingSmall() -> Font {
        return .poppins(.regular, size: 18)
    }
    
    static func poppinsBodyLarge() -> Font {
        return .poppins(.regular, size: 16)
    }
    
    static func poppinsBodyMedium() -> Font {
        return .poppins(.regular, size: 14)
    }
    
    static func poppinsBodySmall() -> Font {
        return .poppins(.regular, size: 12)
    }
    
    // Bold Variants
    static func poppinsBoldHeading() -> Font {
        return .poppins(.bold, size: 24)
    }
    
    static func poppinsBoldBody() -> Font {
        return .poppins(.bold, size: 16)
    }
    
    // Medium Variants
    static func poppinsMediumHeading() -> Font {
        return .poppins(.medium, size: 20)
    }
    
    static func poppinsMediumBody() -> Font {
        return .poppins(.medium, size: 14)
    }
}

enum PoppinsWeight: String {
    case thin = "Poppins-Thin"
    case thinItalic = "Poppins-ThinItalic"
    case extraLight = "Poppins-ExtraLight"
    case extraLightItalic = "Poppins-ExtraLightItalic"
    case light = "Poppins-Light"
    case lightItalic = "Poppins-LightItalic"
    case regular = "Poppins-Regular"
    case italic = "Poppins-Italic"
    case medium = "Poppins-Medium"
    case mediumItalic = "Poppins-MediumItalic"
    case semiBold = "Poppins-SemiBold"
    case semiBoldItalic = "Poppins-SemiBoldItalic"
    case bold = "Poppins-Bold"
    case boldItalic = "Poppins-BoldItalic"
    case extraBold = "Poppins-ExtraBold"
    case extraBoldItalic = "Poppins-ExtraBoldItalic"
    case black = "Poppins-Black"
    case blackItalic = "Poppins-BlackItalic"
} 
