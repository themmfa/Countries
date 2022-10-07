import SwiftUI

struct CountryDetailView: View {
    @ObservedObject var countryDetailViewModel: CountryDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if countryDetailViewModel.countryDetail != nil {
                ///  Since the GeoDB Api provide flags in svg format, I used another api to get country flags from country codes.
                AsyncImage(url: URL(string: "https://countryflagsapi.com/png/\(countryDetailViewModel.countryDetail!.code)")) { image in
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
                        Text(countryDetailViewModel.countryDetail!.name)
                    }
                    .padding(.bottom, 20)
                    Link(destination: URL(string: "https://www.wikidata.org/wiki/\(countryDetailViewModel.countryDetail!.wikiDataId)")!, label: {
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
            else {
                ProgressView()
            }
        }
        .onAppear {
            countryDetailViewModel.getCountryDetail()
        }
    }
}
