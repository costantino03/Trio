
import Foundation
import UIKit

enum Icon_: String, CaseIterable, Identifiable {
    case primary = "trioBlack"
    case trioWhiteShadow
    case trioColorBG
    case trioWhite
    case trioCircledNoBackground
    case trio3D
    case wilford = "diabeetus"
    case catWithPod
    case catWithPodWhite = "catWithPodWhiteBG"
    var id: String { rawValue }
}

class Icons: ObservableObject, Equatable {
    @Published var appIcon: Icon_ = .primary

    static func == (lhs: Icons, rhs: Icons) -> Bool {
        lhs.appIcon == rhs.appIcon
    }

    func setAlternateAppIcon(icon: Icon_) {
        let iconName: String? = (icon != .primary) ? icon.rawValue : nil

        guard UIApplication.shared.alternateIconName != iconName else { return }

        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }

        appIcon = icon
    }

    init() {
        let iconName = UIApplication.shared.alternateIconName

        // An alternate icon that no longer exists in `Icon_` (e.g. renamed or removed in an update)
        // must fall back to the primary icon instead of crashing at launch.
        if let iconName = iconName, let icon = Icon_(rawValue: iconName) {
            appIcon = icon
        } else {
            appIcon = .primary
        }
    }
}
