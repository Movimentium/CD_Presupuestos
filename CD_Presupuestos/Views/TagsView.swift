//  TagsView.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 31/3/25.
import SwiftUI

struct TagsView: View {
    @FetchRequest(sortDescriptors: []) private var tags: FetchedResults<CDTag>
    @Binding var selectedTags: Set<CDTag>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags) { tag in
                    Text(tag.nombre ?? "")
                        .padding(10)
                        .background(selectedTags.contains(tag) ? .blue : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .onTapGesture {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                }
            }
            .foregroundStyle(.white)
        }
    }
}

struct TagsView_Preview: View {
    @State private var selectedTags: Set<CDTag> = []
    
    var body: some View {
        TagsView(selectedTags: $selectedTags)
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}

#Preview {
    TagsView_Preview()
}
