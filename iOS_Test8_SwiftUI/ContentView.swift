//
//  ContentView.swift
//  iOS_Test8_SwiftUI
//
//  Created by Wei Sun on 2021/12/31.
//

import SwiftUI


extension View {
    func snapshot(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        var targetSize = controller.view.intrinsicContentSize
        targetSize.width = size.width
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            print(controller.view.bounds)
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view:UIView? = controller.view
        
        print("view.bounds is \(view!.bounds)")
        print("view.frame is \(view!.frame)")
        print("view.superview is \(view!.superview)")
        
        var targetSize = controller.view.intrinsicContentSize
        //targetSize.width = size.width
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        //view?.backgroundColor = .clear
        view?.backgroundColor = .white
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            print(controller.view.bounds)
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}



struct TestPopToRootInTab: View {
    @State private var selection = 0
    @State private var resetNavigationID = UUID()

    var body: some View {

        let selectable = Binding(        // << proxy binding to catch tab tap
            get: { self.selection },
            set: { self.selection = $0

                // set new ID to recreate NavigationView, so put it
                // in root state, same as is on change tab and back
                self.resetNavigationID = UUID()
        })

        return TabView(selection: selectable) {
            self.tab1()
                .tabItem {
                    Image(systemName: "1.circle")
                }.tag(0)
            self.tab2()
                .tabItem {
                    Image(systemName: "2.circle")
                }.tag(1)
        }
    }

    private func tab1() -> some View {
        NavigationView {
            NavigationLink(destination: TabChildView()) {
                Text("Tab1 - Initial")
            }
        }.id(self.resetNavigationID) // << making id modifiable
    }

    private func tab2() -> some View {
        Text("Tab2")
    }
}

struct TabChildView: View {
    var number = 1
    var body: some View {
        NavigationLink("Child (number)",
            destination: TabChildView(number: number + 1))
    }
}

//struct TestPopToRootInTab_Previews: PreviewProvider {
//    static var previews: some View {
//        TestPopToRootInTab()
//    }
//}


class TestObject: ObservableObject {
    @Published var count:Int = 0
    var notPublishedInt:Int = 99
    
    init() {
        print("init function of TestObject called.")
    }
}


struct ContentView: View {
    //W.S.:
    //  Swift will automatically observe simple types (primitive types and structures) for us. It knows how to detect any change inside simple types like primitive and structures.
    //  Swift, however, by design, does NOT automatically know (or try to know) how to observe for change for class instances (class references indeed). That is why we need to let the class extend from ObservableObject and use @published?? to indicate the fields whose change does matter, if we ever want to make the change of certain fields trigger the UI update for SwiftUI (or just to notify the observer of the changes in these specific/@published?? fields).
    //
    @State var testObjectAsState = TestObject() //Compiles OK and can run without crashing. But it is really a bad usage!!!
    @StateObject var testObjectAsStateObject = TestObject()
    @ObservedObject var testObject = TestObject()
    @State var stateIntValue = 0
    
    var body: some View {
        
        //Text("Hello, world!")
        //    .padding()
    
        //TestPopToRootInTab()
        
        VStack {
            Text("Hello")
                .padding(.bottom)
            
            Button("Increase count") {
                testObject.count = testObject.count + 1
            }
            .padding(.bottom)
            
            Button("Increase notPublishedInt") {
                testObject.notPublishedInt = testObject.notPublishedInt + 1
                
                print("notPublishedInt is \(testObject.notPublishedInt)")
            }
            .padding(.bottom)
            
            Button("Increase stateIntValue") {
                stateIntValue = stateIntValue + 1
            }
            .padding(.bottom)
            
            Button("Take screenshot") {
                let theImage:UIImage = self.snapshot()
            }
            .padding(.bottom)
            
            //if testObject.$count % 2 == 0 { //Won't compile: Cannot convert value '$count' of type 'Published<Int>.Publisher' to expected type 'Int', use wrapped value instead
            if testObject.count % 2 == 0 {
                Text("count is \(testObject.count). Is an even number")
            }
            
            if testObject.notPublishedInt % 2 == 0 {
                Text("notPublishedInt is \(testObject.notPublishedInt). Is an even number")
            }
            
            if stateIntValue % 2 == 0 {
                Text("stateIntValue is \(stateIntValue)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        TestPopToRootInTab()
    }
}
