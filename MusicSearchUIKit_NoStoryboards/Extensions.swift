import Foundation
import UIKit

extension String {
    func makeSearchString() -> String {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        let mapped = String(trimmed.map {
            $0 == " " || $0 == "\n" ? "+" : $0
        })
        return mapped
    }
}

extension UIImageView {
    func applyShadow(){
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.contentMode = .scaleAspectFill
    }
    
}
