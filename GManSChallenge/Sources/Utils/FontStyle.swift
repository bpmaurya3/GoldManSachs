//
//  FontStyle.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

enum FontStyle {
    case systemFont(size: CGFloat)
    case systemFontSemiBold(size: CGFloat)
    case systemFontBold(size: CGFloat)

    /**
     The font for a font style. Typically the developer should set the
     attributed text using attributedString(for:) or attributes, which
     includes the font.
     */
    var font: UIFont {
        switch self {
        case .systemFont(let size):
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .systemFontSemiBold(let size):
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case .systemFontBold(let size):
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }

    private var kern: CGFloat {
        switch self {
        case .systemFont:
            return 0
        case .systemFontBold:
            return 0.35
        case .systemFontSemiBold:
            return -0.41
        }
    }

    func attributedString(for string: String,
                          attributes: [NSAttributedString.Key: Any]? = nil,
                          alignment: NSTextAlignment? = nil,
                          lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSMutableAttributedString {
        let allAttributes = self.attributes(attributes: attributes, alignment: alignment, lineBreakMode: lineBreakMode)
        return NSMutableAttributedString(string: string, attributes: allAttributes)
    }

    func attributes(attributes: [NSAttributedString.Key: Any]? = nil,
                    alignment: NSTextAlignment? = nil,
                    lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> [NSAttributedString.Key: Any] {
        let predefinedAttributes: [NSAttributedString.Key: Any] = [
            .font: self.font,
            .kern: self.kern,
            .paragraphStyle: self.paragraphStyle(alignment: alignment, lineBreakMode: lineBreakMode)
        ]

        let result = attributes.map { ($0 as Dictionary).union(predefinedAttributes) } ?? predefinedAttributes
        return result
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func paragraphStyle(alignment: NSTextAlignment? = nil,
                                lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSMutableParagraphStyle {
        var lineHeightMultiple: CGFloat
        switch self {
        case .systemFont:
            lineHeightMultiple = 1.26
        case .systemFontSemiBold, .systemFontBold:
            lineHeightMultiple = 1.16
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineBreakMode = lineBreakMode
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }

        return paragraphStyle
    }
}
