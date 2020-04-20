import Foundation
import SwiftUI

struct SuccessStateView: View {
  var casesViewModels: [CaseLineVieModel]
  init(_ viewModels: [CaseLineVieModel]) {
    self.casesViewModels = viewModels
  }
  var body: some View {
    ZStack {
      CountryList(viewModels: casesViewModels).zIndex(0)
    }
  }
}

struct CountryList: View {
  let viewModels: [CaseLineVieModel]
  @State var searchQuery: String = ""
  
  var body: some View {
    List {
      Section(header: SearchBar(text: self.$searchQuery)) {
        ForEach(viewModels.filter {
          self.searchQuery.isEmpty ? true : "\($0.countryName)".contains(self.searchQuery)
        }, id: \.self) { country in
          NavigationLink(destination: CountryHistoryView(viewModel: CountryHistoryViewModel(with: country.covidCases))) {
            CaseLineView(viewModel: country)
          }
        }
      }
    }
    .onAppear {
      UITableView.appearance().separatorStyle = .none
    }
  }
}
