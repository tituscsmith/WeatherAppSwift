




//out of date






import SwiftUI

struct ForecastImage: View {
    @Binding var imageName: String
//    @Binding var imageName2: String
//    @Binding var imageName3: String
//    @Binding var imageName4: String
//    @Binding var imageName5: String
//    @Binding var imageName6: String
    var body: some View {
        
        Image(imageName).resizable()
            .frame(width: 50, height: 50).clipShape(Circle())
        //.shadow(radius: 10)
    }
}

struct ForecastImage_Previews: PreviewProvider {
    static var previews: some View {
        ForecastImage(imageName: .constant("NULL")/*, imageName2: .constant("NULL")
        , imageName3: .constant("NULL"), imageName4: .constant("NULL")
        , imageName5: .constant("NULL"), imageName6: .constant("NULL")*/)
    }
}
