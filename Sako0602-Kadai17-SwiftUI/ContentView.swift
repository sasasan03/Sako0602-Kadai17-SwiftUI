//
//  ContentView.swift
//  Sako0602-Kadai17-SwiftUI
//
//  Created by sako0602 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresentedAddView = false
    @State private var isPresentedEditVIew = false
    @State var editFruit: FruitsData? = nil
    @State private var fruitArray = [
        FruitsData(name: "りんご", isChecked: false),
        FruitsData(name: "みかん", isChecked: true),
        FruitsData(name: "バナナ", isChecked: false),
        FruitsData(name: "パイナップル", isChecked: true)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitArray.indices, id: \.self) { index in
                    HStack{
                        Button {
                            fruitArray[index].isChecked.toggle()
                        } label: {
                            HStack{
                                Image(systemName: fruitArray[index].isChecked
                                      ? "checkmark"
                                      : ""
                                )
                                .foregroundColor(Color.red)
                                .frame(width: 30, height: 30)
                                Text(fruitArray[index].name)
                            }
                        }
                        .foregroundColor(Color.black)
                        Spacer()
                        Button {
                            editFruit = fruitArray[index]
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }.onDelete { fruitIndex in
                    fruitArray.remove(atOffsets: fruitIndex)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentedAddView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .padding()
                }
            }
            .sheet(isPresented: $isPresentedAddView) {
                FruitsAddView(
                    save: { name in
                        fruitArray.append(FruitsData(name: name, isChecked: false))
                        isPresentedAddView = false
                    } ,cancel: {
                        isPresentedAddView = false
                    }
                )
            }
            .sheet(item: $editFruit) { editFruit in
                EditView (
                    fruitNewItem: editFruit.name,
                    save: { name in
                        guard let index = fruitArray.firstIndex(where: {
                            $0.id == editFruit.id
                        }) else { return }
                        fruitArray[index].name = name
                        fruitArray[index].isChecked = false
                        isPresentedEditVIew = false
                    },
                    cancel: {
                        isPresentedEditVIew = false
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
