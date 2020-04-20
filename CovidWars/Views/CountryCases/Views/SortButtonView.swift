import Foundation
import SwiftUI


struct SortButton: View {
  @ObservedObject var viewModel: CountryCasesViewModel
  @State var actionSheetPresented: Bool = false
  
  var body: some View {
    VStack {
      Button(action: {
        self.actionSheetPresented = !self.actionSheetPresented
      }) {
        Text("Sort")
      }
    }.actionSheet(isPresented: $actionSheetPresented) {
      ActionSheet(
        title: Text("Sort by"),
        buttons: [
          .default(
            Text("Deaths"),
            action: {
              self.viewModel.sortType =  .byDeaths
          }),
          .default(
            Text("Infected"),
            action: {
              self.viewModel.sortType =  .byConfirmed
          }),
          .default(Text("Alphabetically"),
                   action: {
                    self.viewModel.sortType =  .alphabetically
          }),
          .cancel()
      ])
    }
  }
}
