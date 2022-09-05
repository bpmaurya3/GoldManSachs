//
//  PictureDetailsViewController.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

class PictureDetailsViewController: BaseViewController {

    // Outlets
    @IBOutlet private weak var tableView: UITableView!

    // Properties
    var viewModel: PictureDetailsViewModel!

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    // Helper functions

    private func setupUI() {
        self.title = LocalizedStrings.PictureList.navTitle
        if let model = self.viewModel.getDataSource().first {
            self.setFavIcon(model: model)
        }
        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.register(cell: PlanetTableCell.self)
        self.tableView.dataSource = self
    }

    @objc private func didTapFavButton() {
        if let model = self.viewModel.getDataSource().first {
            let updatedModel = self.viewModel.saveFavPlanetIntoDB(url: model.imageUrl, isFav: !model.isFavourite)
            self.setFavIcon(model: updatedModel)
        }
    }

    private func setFavIcon(model: PlanetCellModel?) {
        let image = model?.isFavourite == true ? UIImage(named: "faveIcon") : UIImage(named: "fav2")
        let favButton = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapFavButton))
        self.navigationItem.rightBarButtonItems = [favButton]

    }
}

// MARK:-  UITableView Datasource
extension PictureDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getDataSource().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: PlanetTableCell.self, at: indexPath)
        cell.configure(using: self.viewModel.getDataSource()[indexPath.row], cellType: .detail)
        return cell
    }
}
