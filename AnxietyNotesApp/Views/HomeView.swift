import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeView.ViewModel.shared
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.indigo]
    }
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.bg
                    .ignoresSafeArea()

                VStack {
                    VStack{
                        Image(.notebookBro1) // test branch ages
                            .resizable()
                            .frame(width: 198, height: 198)
                        VStack {
                            Text("Start Writing")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 4)
                            Text("Express and understand your feelings,\n bring clarity to your thoughts.")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(.bottom, 16)
                    
                    
                }
                .padding()
                .navigationTitle("NoteInMood")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        Button {
                            viewModel.showingPopover = true
                        } label: {
                            HStack(spacing: 3)
                            {
                                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                    .foregroundColor(.indigo)
                            }
                        }
                        .popover(isPresented: $viewModel.showingPopover) {
                            Text("Your content here")
                                .font(.headline)
                                .padding()
                                .frame(minWidth: 200, minHeight: 200)
                                .presentationCompactAdaptation(.popover)
                        }
                        
                        //                        NavigationLink(destination: self) {
                        //                                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        //                                    .foregroundColor(.indigo)
                        //                        }
                    }
                    ToolbarItem(placement: .bottomBar)
                    {
                        NavigationLink(destination: NoteView() .navigationBarBackButtonHidden(true)) {
                            
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.indigo)
                        }
                    }
                }
                .toolbarBackground(.visible, for: .bottomBar)
                
                ScrollView {
                     ForEach(viewModel.notes, id: \.self) { note in
                         SmallCardView(note: note)
                     }
                }//.padding(.top, 10)
                
                
            }
            .onChange(of: viewModel.notes) {
                for note in viewModel.notes{
                    print(note.title ?? "")
                }
            }
        }

    }
    
    
}

#Preview {
    HomeView()
//        .colorScheme(.dark)
}
