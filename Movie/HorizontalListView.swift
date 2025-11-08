//
//  HorizontalListView.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

//Vstack alignment paramter is for there children how to align This only matters when child views have different widths or the VStack has more width than its children.

//LazyHStack{}  LazyHStack: Lazy — builds children on demand. Better for long lists or expensive child views.

//Here ForEach is a SwiftUI View that repeats a subview for each item.
        //VStack{
        //    ForEach()
        //}

// here my ForEach(titles,id:\.self) the id is self so the title it slef becomes id if any image has the same id then duplicate image doesn't come



import SwiftUI

struct HorizontalListView: View {
    let header : String
    let titles : [Title]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(titles){title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120,height:200)
                    }
                }
            }
        }
        .frame(height:250)
        .padding(10)
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMovieString, titles: Title.previewTitles)
}
