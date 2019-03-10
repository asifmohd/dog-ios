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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let selectedRowIndexPath = self.breedListTableView.indexPathForSelectedRow else {
            return
        }
        self.breedListTableView.deselectRow(at: selectedRowIndexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SubBreedListViewController,
            let currentSelectedIndexPath = self.breedListTableView.indexPathForSelectedRow else {
            return
        }
        let breed = self.vm.breedList[currentSelectedIndexPath.row]
        guard let subBreeds = self.vm.breedMap[breed] else {
            return
        }
        vc.vm = SubBreedListViewModel(breedList: subBreeds)
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

extension BreedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = self.vm.breedList[indexPath.row]
        guard let subBreeds = self.vm.breedMap[breed] else {
            return
        }
        if subBreeds.count > 0 {
            self.performSegue(withIdentifier: "showSubBreedList", sender: nil)
        } else {
            // show images VC
        }
    }
}

extension BreedListViewController: BreedListViewModelDelegate {
    func dataLoaded() {
        self.breedListTableView.reloadData()
    }
}
