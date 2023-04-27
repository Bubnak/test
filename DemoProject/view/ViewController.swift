//
//  ViewController.swift
//  DemoProject
//
//  Created by Bubna K on 27/4/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var coordinator: ChildCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo Project"
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!
    public var qInterator: QuestionInteractorInterface?
    
    func initInterator(qInterator: QuestionInteractorInterface) {
        self.qInterator = qInterator
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.qInterator?.getTopQuestions{ [weak self] in
            self?.tableView.reloadData()
        }
    }

    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qInterator?.questionsPresenter.count ?? 0 // viewModel.questionsVM.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = qInterator?.questionsPresenter[indexPath.row].title
        return cell
    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
