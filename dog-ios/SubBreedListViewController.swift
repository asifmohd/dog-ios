//
//  SubBreedListViewController.swift
//  dog-ios
//
//  Created by Asif on 10/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import UIKit

class SubBreedListViewController: UIViewController {

    @IBOutlet weak var subBreedTableView: UITableView!

    var vm: SubBreedListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(vm != nil, "View Model must be set by the parentVC")

        let cellNib = UINib(nibName: BreedListTableViewCell.ReuseIdentifier, bundle: nil)
        self.subBreedTableView.register(cellNib, forCellReuseIdentifier: BreedListTableViewCell.ReuseIdentifier)
        self.subBreedTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension SubBreedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.subBreedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedListTableViewCell.ReuseIdentifier, for: indexPath) as! BreedListTableViewCell
        cell.breedNameLabel.text = self.vm.subBreedList[indexPath.row]
        return cell
    }
}
