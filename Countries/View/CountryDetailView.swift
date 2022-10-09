import SwiftUI

/// The page user going to see when clicks to country bar.

struct CountryDetailView: View {
    var countryModel: CountryModel
    @ObservedObject var homeViewModel: HomeViewModel

    /// This function checks the countryList array and find the index of the passed country model.
    /// After find the index, we can use it for changing the isFav parameter of the object in the actual array

    func getIndex() -> Int {
        let index = homeViewModel.countryList.firstIndex(where: { $0.id == countryModel.id })!
        return index
    }

    var body: some View {
        VStack(alignment: .leading) {
            ///  Since the GeoDB Api provide flags in svg format, I used another api to get country flags from country codes.
            AsyncImage(url: URL(string: "https://countryflagsapi.com/png/\(countryModel.code)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 200)

            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Country Code:")
                        .font(.system(.body))
                        .fontWeight(.bold)
                    Text(countryModel.code)
                    Spacer()
                    Button(action: {
                        let countryIndex = getIndex()
                        homeViewModel.countryList[countryIndex].isFaved = !homeViewModel.countryList[countryIndex].isFaved

                    }) {
                        Image(systemName: "star.fill")
                            .foregroundColor(homeViewModel.countryList[getIndex()].isFaved ? .black : .gray)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.bottom, 20)

                /// I added this text property to show I'm requesting country detail from from api which stated in the pdf.
                Text(countryModel.flagImageUri ?? "No flag url")
                    .font(.system(.subheadline))

                Link(destination: URL(string: "https://www.wikidata.org/wiki/\(countryModel.wikiDataId)")!, label: {
                    Label("For More Information", systemImage: "arrow.right")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                })
                .padding(.bottom, 20)
            }
            .padding()
            Spacer()
        }
        .onAppear {
            homeViewModel.getCountryDetail(countryModel.code)
        }
    }
}
