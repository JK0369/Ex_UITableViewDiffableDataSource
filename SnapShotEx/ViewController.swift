//
//  ViewController.swift
//  SnapShotEx
//
//  Created by 김종권 on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {

    // <Section, Item>, 단 Item은 Hashable
    var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    var colors: [UIColor] = [.blue, .green, .gray, .brown, .cyan, .lightGray, .purple]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        // cell의 모양 - (cellForRowAt과 동일)
        dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            cell.backgroundColor = self.colors[indexPath.row % self.colors.count]

            return cell
        })
        tableView.dataSource = dataSource

        // tableView에 들어갈 Section, Item 초기화
        var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()
        snapshot.appendSections([0]) // 주의: section하나를 안넣어주면 에러
        snapshot.appendItems([UUID(), UUID(), UUID()])
        dataSource.apply(snapshot)
    }

    @IBAction func didTapAppendButton(_ sender: Any) {
        var snapshot = dataSource.snapshot()

        snapshot.appendItems([UUID()])
        dataSource.apply(snapshot)
    }

    @IBAction func didTapInsertButton(_ sender: Any) {
        var snapshot = dataSource.snapshot()

        if let first = snapshot.itemIdentifiers.first {
            snapshot.insertItems([UUID()], afterItem: first)
        }

        dataSource.apply(snapshot)
    }

    @IBAction func didTapDeleteButton(_ sender: Any) {
        var snapshot = dataSource.snapshot()

        if let lastItem = snapshot.itemIdentifiers.last {
            snapshot.deleteItems([lastItem])
        }
        dataSource.apply(snapshot)
    }

    @IBAction func didTapNextSceneButton(_ sender: Any) {
        
    }
}
