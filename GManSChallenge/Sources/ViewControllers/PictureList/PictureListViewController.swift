//
//  PictureListViewController.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import UIKit

class PictureListViewController: BaseViewController {

    // Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var chooseADateBackView: UIView!
    @IBOutlet private weak var txtDatePicker: UITextField!
    @IBOutlet private weak var clearDateButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    // Properties
    private let datePicker = UIDatePicker()
    var viewModel: PictureListViewModel!

    // MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.listenObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getPlanetForSelectedSegment(index: self.viewModel.lastSelectedSegmentIndex)
    }

    // Helper functions
    private func setupUI() {
        self.title = LocalizedStrings.PictureList.navTitle
        self.setupTableView()
        self.activityIndicatorView.startAnimating()
        self.clearDateButton.isHidden = self.txtDatePicker.text?.isEmpty == true
    }

    private func setupTableView() {
        self.tableView.register(cell: PlanetTableCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func listenObserver() {
        self.viewModel.notifyToReload = { [weak self] in
            self?.tableView.reloadData()
        }

        self.viewModel.showHideLoadingIndicator = { [weak self] isShow in
            isShow ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.hidesWhenStopped = true
        }
    }

    // MARK:-  Actions
    //Hanle segment value changed
    @IBAction func handleSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewModel.getPlanetForSelectedSegment(index: 0)
            self.chooseADateBackView.isHidden = false
        case 1:
            self.viewModel.getPlanetForSelectedSegment(index: 1)
            self.chooseADateBackView.isHidden = true
        default:
            break
        }
    }

    // Clear the selected date & load all data
    @IBAction func clearDate(_ sender: Any) {
        self.txtDatePicker.text = nil
        self.viewModel.selectedDateString = nil
        self.viewModel.getPlanetForSelectedSegment(index: 0)
        self.clearDateButton.isHidden = self.txtDatePicker.text?.isEmpty == true
    }
}

// MARK: TableView Datasource

extension PictureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getDataSource().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: PlanetTableCell.self, at: indexPath)
        cell.configure(using: self.viewModel.getDataSource()[indexPath.row], cellType: .list)
        return cell
    }
}

// MARK: TableView Delegate

extension PictureListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.openDetails?(self.viewModel.getDataSource()[indexPath.row])
    }
}

// MARK: Textfield Delegate

extension PictureListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showDatePicker()
    }
}

// MARK: Date Picker

extension PictureListViewController {
    func showDatePicker() {
        //Formate Date
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.maximumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: LocalizedStrings.Global.done, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: LocalizedStrings.Global.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        self.txtDatePicker.inputAccessoryView = toolbar
        self.txtDatePicker.inputView = self.datePicker

    }

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.txtDatePicker.text = formatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
        self.viewModel.fetchPlanetFromServer(date: self.txtDatePicker.text)
        self.clearDateButton.isHidden = self.txtDatePicker.text?.isEmpty == true
    }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
}
