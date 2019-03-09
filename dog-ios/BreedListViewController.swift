//
//  BreedListViewController.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet weak var breedListTableView: UITableView!

    let vm = BreedListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: BreedListTableViewCell.ReuseIdentifier, bundle: nil)
        self.breedListTableView.register(cellNib, forCellReuseIdentifier: BreedListTableViewCell.ReuseIdentifier)
        self.vm.delegate = self
        self.vm.makeAPICall()
    }
}

extension BreedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.breedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedListTableViewCell.ReuseIdentifier, for: indexPath) as! BreedListTableViewCell
        cell.breedNameLabel.text = self.vm.breedList[indexPath.row]
        return cell
    }
}

extension BreedListViewController: BreedListViewModelDelegate {
    func dataLoaded() {
        self.breedListTableView.reloadData()
    }
}
