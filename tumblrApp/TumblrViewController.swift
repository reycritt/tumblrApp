//
//  TumblrViewController.swift
//  tumblrApp
//
//  Created by Crittenden, Rey  on 2/3/20.
//  Copyright © 2020 Crittenden, Rey . All rights reserved.
//

import UIKit

class TumblrViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [[String: Any]]()//Creates a dictionary with the data type (here is String) and the value (here is Any, for any data type)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.dataSource = self
        //tableView.delegate = self
        
        
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.posts = dataDictionary["results"] as! [[String: Any]]//Sets movies as all values of dictionary type String of Any values under the "results" hash of the movie API
                //self.tableView.reloadData()//Upon loading, information is held but not displayed. Reloading the table view allows movies.count to display and use its values (calls all functions in table view)
                print(dataDictionary)//prints all values within the API
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//Asking for number of rows
        return posts.count//Returns how many rows in the list/table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//The cell to be displayed; can be used as a template for multiple rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! TumblrCell//Saves space by recycling existing, unused cells; "as!" casts to MovieCell, allowing the UI file to be used
        
        let post = posts[indexPath.row]//A movie will be set as a movie from movies dictionary based on the row number
        if let photos = post["photos"] as? [[String: Any]] {
             // photos is NOT nil, we can use it!
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let URLstring = originalSize["url"] as! String
            let url = URL(string: URLstring)
        }
        
        
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
/*
 For anything related to UI interface, such as the view controllers and table cells, create a Coca file. Swift is for programming, and SwiftUI is for views.
 Cells will go in there own file since they can be repeated. The table goes into the view controller.
 */
