
import SwiftUI

struct SmallCardView: View {
    let note: Note?
    
    var body: some View {
        let colors: [Color] = {
            if let note = note {
                return Feelings(label: note.sumEmotion)?.feelingColor ?? [.clear, .clear]
            } else {
                return [.black, .white]
            }
        }()
        VStack(alignment: .leading){
            HStack (spacing: 10 ){
                if let note = note{
                    VStack(alignment: .leading){
                        Text(note.title!)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        HStack{
                            Text(DateFormatter.localizedString(from: note.date, dateStyle: .short, timeStyle: .none))
                                .opacity(0.75)
                                .font(.caption)
                                .padding(.trailing, 1)
                            Text(note.content!)
                                .opacity(0.75)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
                Spacer()
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: colors[1], location: 0.00),
                                Gradient.Stop(color: colors[0], location: 1.00)
                            ]),
                            startPoint: UnitPoint(x: 0.86, y: 1),
                            endPoint: UnitPoint(x: 0.16, y: 0)
                        )
                    )
                    .frame(width: 17)
            }
            .padding(.horizontal, 25)
        }
        .frame(width: 361, height: 65)
        .background(Color(UIColor.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
