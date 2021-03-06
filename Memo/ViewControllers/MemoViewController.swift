//
//  MemoViewController.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import UIKit

class MemoViewController: UITableViewController {
    
    let vm: MemoViewModel = MemoViewModel.shared
    @IBOutlet var nav: UINavigationItem!
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav.title = NSLocalizedString("Memo📝", comment: "Memo📝")
        self.refreshControl = UIRefreshControl()
        table.refreshControl = refreshControl!
        self.refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        vm.loadMemo() { success in
            if success {self.table.reloadData()}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    @objc func refresh(){
        self.table.reloadData()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (self.refreshControl!.isRefreshing) {
            self.self.refreshControl!.endRefreshing()
            vm.loadMemo() { success in
                if success {self.table.reloadData()}
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cnt = indexPath.item
        self.performSegue(withIdentifier: "ShowMemo", sender: vm.getMemo(cnt))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.memoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        
        let cnt = indexPath.item
        cell.update(memo: vm.getMemo(cnt))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vm.delete(num: indexPath.row){ success in
                if success {
                    print(indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMemo" {
            let vc = segue.destination as? WriteViewController
            if let memo = sender as? Memo {
                vc?.memo = memo
                vc?.isUpdate = true
            }
        }
    }
    
}
