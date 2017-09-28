//
//  Search_Controller_Delegate.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/24/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import MapboxGeocoder


class Search_Controller_Delegate: NSObject,
    UISearchBarDelegate, UISearchDisplayDelegate,
    UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate
{
    var searchController : UISearchController!
	var search_table: UITableView!
    var geocode_api : API_Geocode!

    var call : (([GeocodedPlacemark]) -> ())? = nil

	var shouldShowSearchResults : Bool!

    init(theview : UIViewController)
    {
        super.init()
        self.setup_search_bar(searchresults : theview)
        geocode_api = API_Geocode()
	}

	func callback(thecallback : @escaping ([GeocodedPlacemark]) -> ())
	{
		self.call = thecallback
	}

    func setup_search_bar(searchresults : UIViewController)
    {
        print("setup_search_bar")
		self.shouldShowSearchResults = false
		self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.delegate = self
		self.searchController.searchResultsUpdater = self
		self.searchController.dimsBackgroundDuringPresentation = true
		self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Where To?"
		self.searchController.definesPresentationContext = true
        
        search_table = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        search_table.delegate      =   self
        search_table.dataSource    =   self
        search_table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
       /* search_table.contentInset = UIEdgeInsets(top: 0.0, left: searchController.searchBar.bounds.size.height, bottom: 0.0, right: 0.0)
        search_table.contentOffset = CGPoint(x: 0.0, y: -searchController.searchBar.bounds.size.height)*/
    }
    
    func anchor_table(theview : UIViewController, theview2 : UIView)
    {
       // theview.view.addSubview(search_table)
      //  search_table.topAnchor.constraint(equalTo: self.searchController.searchBar.bottomAnchor,constant: 0).isActive = true
      //  search_table.bottomAnchor.constraint(equalTo: theview.view.bottomAnchor,constant: 0).isActive = true
       // search_table.leftAnchor.constraint(equalTo: theview.view.leftAnchor,constant: 0).isActive = true
        //search_table.rightAnchor.constraint(equalTo: theview.view.rightAnchor,constant: 0).isActive = true
    }

    func willPresentSearchController(_ searchController: UISearchController)
    {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async
		{
            DispatchQueue.main.async
			{
                searchController.searchResultsController?.view.isHidden = false
            }
        }
    }
	
    func didPresentSearchController(_ searchController: UISearchController)
	{
        searchController.searchResultsController?.view.isHidden = false
    }
    
    func add_to_uiview(theview : UIView)
    {
        theview.addSubview(searchController.searchBar)
		searchController.searchBar.sizeToFit()
		searchController.searchBar.autoresizingMask = UIViewAutoresizing.flexibleWidth
	}

	func get_search_controller()-> UISearchController
	{
		return self.searchController
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
	{
		self.shouldShowSearchResults = true
		print("searchBar searchBarTextDidBeginEditing")

		//tblSearchResults.reloadData()
	}


	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		//tblSearchResults.reloadData()
		print("searchBar searchBarCancelButtonClicked")

	}


	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {

		print("searchBar searchBarSearchButtonClicked")

		if !shouldShowSearchResults
		{
			self.shouldShowSearchResults = true
		}

		searchController.searchBar.resignFirstResponder()
		searchController.resignFirstResponder()
		searchController.searchBar.endEditing(true);
		DispatchQueue.global(qos: .background).async { [weak self]
		() -> Void in

			guard let strongSelf = self
					else
			{
				return
			}
			strongSelf.geocode_api.search_address(the_address: searchBar.text!, loc_user: _NAV_.user(), callback: strongSelf.call!)
		}
	}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("cellforRowat");
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }



    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
	{}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
	{
		print("searchBar textDidChange")
	}

	 func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
	{
		return true
	}

	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
	{
        
    }

	func updateSearchResults(for searchController: UISearchController)
	{
		filterContentForSearchText(searchText: searchController.searchBar.text!)
	}

    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        print("filterContentForSearchText");
        func filterContentForSearchText(searchText: String, scope: String = "All") {
    /*        filteredResult = result.filter { item in
                return item.name!.lowercaseString.containsString(searchText.lowercaseString)
            }
            listTableView.reloadData()*/
        }
        //search_table.reloadData()
    }
}
