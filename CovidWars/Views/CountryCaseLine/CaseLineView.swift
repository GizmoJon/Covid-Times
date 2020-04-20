import SwiftUI

struct CaseLineView: View {
  @State var viewModel: CaseLineVieModel
  
  var body: some View {
    VStack(alignment: .center, spacing: 0, content:{
      countryRow
      HStack {
        infectedColumn
        deathsColumn
        recoveredColumn
      }
    }).background(Color(UIColor.secondarySystemBackground))
      .cornerRadius(10)
  }
  
  var countryRow: some View {
    HStack {
      Text(viewModel.countryName)
        .fontWeight(.heavy)
        .padding()
      Spacer()
      
      Button(action: {
        print("Save to something")
      }) {
        Text("*")
      }.padding()
        .hidden()
    }
  }
  
  var deathsColumn: some View {
    VStack {
      Image("dead")
        .renderingMode(.template)
        .foregroundColor(Color(UIColor.systemRed))
        .padding()
      Text("\(viewModel.deaths) (+\( viewModel.growthDead)")
        .padding()
    }
  }
  
  var recoveredColumn: some View {
    VStack {
      Image("recovery")
        .renderingMode(.template)
        .foregroundColor(Color(UIColor.systemGreen))
        .padding()
      Text("\(viewModel.recovered) (+\(viewModel.growthRecovered))")
        .padding()
    }
  }
  
  var infectedColumn: some View {
    VStack {
      Image("virus")
        .renderingMode(.template)
        .foregroundColor(Color(UIColor.systemYellow))
        .padding()
      Text("\(viewModel.confirmed) (+\(viewModel.growthConfirmed)")
        .padding()
    }
  }
}

struct CaseLineView_Previews: PreviewProvider {
  static var previews: some View {
    CaseLineView(viewModel: CaseLineVieModel(countryName: "Italy", covidCases: [CovidCase(date: Date(), recovered: 2, deaths: 3, confirmed: 4)]))
  }
}
