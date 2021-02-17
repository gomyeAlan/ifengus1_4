//
//  PublicSearchBar.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI
import UIKit


struct PublicSearchBar: View {
  @Binding var text: String
  
  var body: some View {
    SearchBar(text: $text)
      .padding(.horizontal, 2)
  }
}


struct SearchBar: UIViewRepresentable {
  @Binding var text: String
  
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
      _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
        let searchtxt = self.text
        if (searchtxt != "") {
            print("\(searchtxt)====")
            //Fetch data from URLSession
//            SearchListView(search: <#T##SearchArchiveListModel#>)
            
        } else {
            print("Please input search key")
        }
    }
  }
  
  func makeCoordinator() -> SearchBar.Coordinator {
    return Coordinator(text: $text)
  }
  
  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.autocapitalizationType = .none
    searchBar.searchBarStyle = .minimal
    searchBar.enablesReturnKeyAutomatically = false
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    uiView.text = text
    uiView.placeholder = "疫情 汽车 奥运"
  }
  
}

extension UIViewRepresentable {
    func pressesEnd(_ presses: Set<UIPress>, with even: UIPressesEvent) {
        guard let key = presses.first?.key else { return }

                switch key.keyCode {
                case .keyboardSpacebar:
                    print("keyboardSpacebar")
                default:
                    print("default")
                }
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        PublicSearchBar(text: .constant("Search"))
    }
}
