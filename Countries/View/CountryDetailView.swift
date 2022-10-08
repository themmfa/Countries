import SwiftUI

struct CountryDetailView: View {
    var countryModel: CountryModel
    @ObservedObject var homeViewModel: HomeViewModel

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
                }
                .padding(.bottom, 20)
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
