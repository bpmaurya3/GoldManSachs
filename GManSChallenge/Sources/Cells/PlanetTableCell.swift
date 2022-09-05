//
//  PlanetTableCell.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

class PlanetTableCell: UITableViewCell, NibRegister {

    @IBOutlet private weak var planetImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var explanationLabel: UILabel!
    @IBOutlet private weak var videoIcon: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.activityIndicatorView.hidesWhenStopped = true
    }

    override func prepareForReuse() {
        self.planetImageView.image = nil
        self.dateLabel.text = nil
        self.titleLabel.text = nil
        self.explanationLabel.text = nil
        self.videoIcon.isHidden = true
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.hidesWhenStopped = true
    }

    func configure(using cellModel: PlanetCellModel, cellType: CellType) {

        self.titleLabel.attributedText = FontStyle.systemFontSemiBold(size: 17).attributedString(for: cellModel.title, attributes: [.foregroundColor: ColorPalette.black.color])
        self.dateLabel.attributedText = FontStyle.systemFontSemiBold(size: 13).attributedString(for: cellModel.date, attributes: [.foregroundColor: ColorPalette.black.color])
        self.explanationLabel.attributedText = FontStyle.systemFont(size: 13).attributedString(for: cellModel.explanation, attributes: [.foregroundColor: ColorPalette.black.color])

        self.explanationLabel.numberOfLines = cellType == .detail ? 0 : 3
        self.videoIcon.isHidden = cellModel.mediaType == .image
        let imageUrl = cellModel.mediaType == .image ? cellModel.imageUrl : cellModel.thumbUrl
        self.planetImageView.downloadImage(imageUrl, activityView: self.activityIndicatorView)

    }
}

extension PlanetTableCell {
    enum CellType {
        case list
        case detail
    }
}
