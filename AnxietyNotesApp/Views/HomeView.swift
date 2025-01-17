import SwiftUI
import WidgetKit

struct HomeView: View {
    @State private var viewModel = HomeView.ViewModel.shared
    @EnvironmentObject var router: Router
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.indigo]
    }
    
    var body: some View {
        ZStack{
            VStack {
                if viewModel.notes.isEmpty{
                    VStack{
                        Image(.notebookBro1)
                            .resizable()
                            .frame(width: 198, height: 198)
                        VStack {
                            Text("Express your feeling")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 4)
                            Text("Start writing to help you calm and relieve your anxiety")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(.bottom, 16)
                }
            }
            .padding()
            .navigationTitle("How was your day?")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
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
                        List {
                            Picker("Sort By: ", selection: $viewModel.selectedPicker) {
                                ForEach(viewModel.sorter, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.inline)
                        }
                        .presentationCompactAdaptation(.none)
                        .frame(minWidth: 200, minHeight: 320)
                    }
                }
                ToolbarItem(placement: .bottomBar)
                {
                    NavigationLink(destination: NoteView()) {
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.indigo)
                    }
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
            
            //                ScrollView {
            List{
                ForEach(viewModel.notes, id: \.self) { note in
                    SmallCardView(note: note)
                        .listRowSeparator(.hidden)
                        .listSectionSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .overlay{
                            NavigationLink(destination: NoteView(note: note)) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .swipeActions{
                            Button(role: .destructive) {
                                viewModel.deleteNote(note: note)
                                viewModel.fetchNotes()
                                WidgetCenter.shared.reloadTimelines(ofKind: "NewNoteWidget")
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                viewModel.searchNote()
            }
            //                }
        }
        .background(Color.bg)
        .onChange(of: viewModel.selectedPicker) {
            viewModel.selectedEmotion = viewModel.selectedPicker
            viewModel.fetchNotesByEmotion()
        }
    }
}

#Preview {
    HomeView()
    //        .colorScheme(.dark)
}
