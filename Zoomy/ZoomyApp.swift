// Douglas Hill, June 2024

import SwiftUI

@main
struct ZoomyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(catPhotos: sampleCatPhotos, nonCatPhotos: sampleNonCatPhotos)
        }
    }
}
