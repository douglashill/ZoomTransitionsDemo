// Douglas Hill, June 2024

import SwiftUI

struct ContentView: View {
  let catPhotos: [Photo]
  let nonCatPhotos: [Photo]
  @State private var presentedPhoto: Photo?
  @Namespace private var namespace

  var body: some View {
    NavigationStack {
      List {
        Section(header: Text("Navigation Stack")) {
          ForEach(catPhotos) { photo in
            NavigationLink {
              PhotoDetail(photo: photo)
                .navigationTransition(.zoom(sourceID: photo, in: namespace))
            } label: {
              HStack {
                PhotoThumbnail(photo: photo)
                  .matchedTransitionSource(id: photo, in: namespace)
                Text(photo.caption)
              }
            }
          }
        }
        Section(header: Text("Full Screen Cover")) {
          ForEach(nonCatPhotos) { photo in
            Button {
              presentedPhoto = photo
            } label: {
              HStack {
                PhotoThumbnail(photo: photo)
                  .matchedTransitionSource(id: photo, in: namespace)
                Text(photo.caption)
              }
            }
          }
        }
      }
      .fullScreenCover(item: $presentedPhoto) { photo in
        NavigationStack {
          PhotoDetail(photo: photo)
            .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                Button {
                  presentedPhoto = nil
                } label: {
                  Text("Done")
                }
              }
            }
        }
        .navigationTransition(.zoom(sourceID: photo, in: namespace))
      }
      .navigationTitle("Cats of Athens")
    }
  }
}

private struct PhotoThumbnail: View {
  let photo: Photo

  var body: some View {
    Image(photo.assetName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxHeight: 120)
  }
}

private struct PhotoDetail: View {
  let photo: Photo

  var body: some View {
    Image(photo.assetName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .navigationTitle(photo.caption)
  }
}

struct Photo: Identifiable, Hashable {
  let assetName: String
  let caption: String

  var id: String {
    assetName
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(assetName)
  }
}

// MARK: - Sample data and preview

let sampleCatPhotos = [
  Photo(assetName: "cat1", caption: "Bench cat"),
  Photo(assetName: "cat2", caption: "Fluffy cat"),
  Photo(assetName: "cat3", caption: "Street cat"),
]

let sampleNonCatPhotos = [
  Photo(assetName: "cat4", caption: "Not a cat"),
]

#Preview {
  ContentView(catPhotos: sampleCatPhotos, nonCatPhotos: sampleNonCatPhotos)
}
