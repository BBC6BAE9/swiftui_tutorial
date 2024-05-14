# SwiftUI最佳实践

作者：bbc6bae9

## 1、为什么用SwiftUI？

（1）**简单**：简单到社区里多设计师在做独立开发，然而对于OC和Swift的成熟开发者来讲，掌握SwiftUI后开发完整的原型产品大概需要一周的时间即可完成。开发效率惊人。

![pic1](./images/pic1.png)

（2）**跨平台**：在github上你可以看到越来越多的开源客户端项目开始往SwiftUI上进行迁移。因为维护多个平台的App是一件成本非常高的事情。

（3）**官方支持**：因为利益紧密相关，曾经在一篇技术博客看到一句话：”因为切实的经济利益相关，只有苹果自己才会真正的为自己生态的开发者考虑。“， 二三方框架不好用的根源也在这里。

> Apple：技术交给我，你们去搞创新，咱们一起赚钱。
>
> 二三方框架：没钱、没声誉、没好处。不好意思，停止维护，已交给社区。

（4）**代码简洁优雅**：相对固定的开发套路，大大的降低了开发难度和可维护性。这些年的工作经验让我发现，工程师的是非常有创造力的一个群体，他们创造了`MVC`、`MVCS`、`MVVM`、`MVP`、`VIPER`架构模式。除了这些写到教科书的设计模式。具体到每个团队里面，还有更多骚到不行的代码设计和写法（他们的确很精妙，但是很难懂！），SwiftUI和UIKit一样，是一个空白的画布，你可以用任意架构和代码设计进行开发。但是整体上看SwiftUI是响应式UI框架，从官方的demo和社区的最佳实践来看，整体还是更适合MVVM。具体的最佳实践，可以参考文章下面的部分。

（5）**兼容性好**： Swift无缝兼容Objective-C，SwiftUI无缝兼容UIKit，以前的代码仍然可以使用。

（6）**响应式**：因为是响应式，天然的尺寸自适应，比如iPad在横竖屏时候的不同表现，自带系统的丝滑动画。比起写死frame的，反复判断横竖屏的代码（尽管autolayout也可以解决，代码量稍多），不可不谓666

（7）**可预览**：可预览对我来说最大的好处就是，如果我接手了某个视图的开发，不需要辛苦的构造数据，不停的查看代码的上下文来分析，所见即所得，在当前视图即可完成开发和迭代

## 2、简单的UI

关于简单UI的开发市面上大概不会有比官方swiftui tutorials更好的教程了，完成学习后，你将掌握

1、 [创建自定义视图](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views)

2、 [使用列表和导航](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)

3、 [处理用户输入](https://developer.apple.com/tutorials/swiftui/handling-user-input)

4、 [绘图](https://developer.apple.com/tutorials/swiftui/drawing-paths-and-shapes)

5、 [动画](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)

6、 [复杂页面](https://developer.apple.com/tutorials/swiftui/composing-complex-interfaces)

7、 [掌握UI控件](https://developer.apple.com/tutorials/swiftui/working-with-ui-controls)

8、 [兼容UIKit](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)

9、 [开发watchOS](https://developer.apple.com/tutorials/swiftui/creating-a-watchos-app)

10、 [开发macOS](https://developer.apple.com/tutorials/swiftui/creating-a-macos-app)

## 3、MVVM基础

MVVM设计模式和响应式框架天生绝配。

`Model`：本地或者远程请求来的数据

`viewModel`：直接与页面进行交互，详情View上的用户操作

`View`：SwiftUI.View，响应viewModel的数据变化

![pic2](./images/pic2.png)

## 4、带有网络请求的页面

我们在ViewModel引入一个网络请求的状态的变量，View来监听这个变量

```swift
enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case.success(let t) = self {
            return t
        }
        return nil
    }
}
```

empty：是页面正处于加载状态

success(T)：数据已经请求成功，返回的数据是T

failure(Error)：网络请求失败，Error是具体的错误（可以在ViewModel中处理，也可以在View上展示）

View代码

```swift
import SwiftUI

public struct DemoPage: View {
    // MARK: Lifecycle
    public init() {
        self.getPage()
    }

    // MARK: Public

    public var body: some View {
        switch self.pageVM.phase {
        case .empty:
            ProgressView()
        case .success(let netResponse):
            ScrollView {
                ListView(response: netResponse)
                Color.clear.task {
                    self.loadMore()
                }
            }
        case .failure(_):
            ErrorPage(action: {
                self.getPage()
            }, title: "加载失败", buttonTitle: "立即重试")
        }
    }

    // MARK: Internal

    /// 数据请求的vm
    @ObservedObject var pageVM: UNPageViewModel

    // MARK: Private

    /// 获取页面数据
    private func getPage() {
        Task {
            await pageVM.refreshPage()
        }
    }
    
    /// 获取更多数据
    private func loadMore() {
        Task {
            await pageVM.loadMore()
        }
    }
}
```

ViewModel代码

```
@MainActor
class DemoPageViewModel: ObservableObject {
		/// 网络请求状态
    @Published var phase = UNDataFetchPhase<NetResponse>.empty
    
    func refreshPage(){
		   // ...
		   // 网络请求结束后给phase赋值
		   phase = ...
    }
    
    func loadMore(){
       // ...
    }
}
```

Model代码

```swift
struct NetResponse {
	// ...
}
```



## 5、复杂卡片页面

![pic3](./images/pic3.png)

一句话：给页面和每个卡片一个ViewModel

针对复杂的页面，后台一般会下发若干层级的页面

```json
[{
    "title": "Top Frameworks",
    "blocks": [{
        "title": "block1",
        "subTitle": "swiftUI"
    }, {
        "title": "block2",
        "subTitle": "React"
    }, {
        "title": "block3",
        "subTitle": "Angular"
    }, {
        "title": "block4",
        "subTitle": "Vue.js"
    }]
}, {
    "title": "Popular Languages",
    "blocks": [{
        "title": "block5",
        "subTitle": "JavaScript"
    }, {
        "title": "block6",
        "subTitle": "Python"
    }, {
        "title": "block7",
        "subTitle": "Java"
    }, {
        "title": "block8",
        "subTitle": "Swift"
    }]
}]
```

红色的是`大卡`，紫色的是`子卡`

> 每张卡片都有自己的Model、View和ViewModel
>
> 页面也有自己的Model、View和ViewModel

talk is cheap: [complex_card_in_swiftui](./complex_card_in_swiftui)

## 6、架构设计

由于SwiftUI缺乏最佳实践作指导，实际开发的过程中，发现很多问题：导航栈上的页面重复init、tab页面一次性加载的问题。仔细梳理了关于架构的需求之后，我们无论是SwiftUI还是UIKit的App在架构设计上的需求都是一致的：

1、`页面组织`：每个Tab能懒加载自己的模块，每个Tab有一个根页面，根页面有自己独立的导航，可以不听的push下去

2、`路由`：这涉及到站内站外的路由问题，目的是为了进行页面间的接耦

### 6.1 页面组织问题

(1) tab的根页面懒加载

```swift
struct LazyView<Content: View>: View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}

struct VBTabView: View {
    @Environment(Router.self) private var router
    
    /// 推荐
    var feedPage: some View = LazyView(HomePage())
    
    /// 我的
    var profilePage: some View = LazyView(ProfilePage())
    
    var body: some View {
        TabView(selection: self.router.tabBinding) {        
            TabPage(tab: .home) {
                feedPage
            }
            TabPage(tab: .profile) {
                profilePage
            }
        }
    }
}
```

(2) 独立导航

```swift
import SwiftUI

struct TabPage<Content: View>: View {
    let tab: Tab
    let content: () -> Content

    var body: some View {
        NavStack(tab: self.tab) {
            self.content()
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .detail(let cid):
                        VideoDetailPage(cid: cid)
                    case .userSpacePage(let mid):
                        UpSpacePage(mid: mid)
                    case .userInfo:
                        UserInfoPage()
                    }
                })
        }
        .tabItem {
            tab.label()
        }
        .tag(self.tab)
    }
}
```

### 6.2 站内外路由

站内路由

```swift
// 站内路由
enum Route: Hashable {
    // 视频详情页
    case detail(cid: Int)

    // 个人空间
    case userSpacePage(mid: Int)
}
```

站外路由

```swift
import SwiftUI

@main
struct ScaffoldApp: App {
    @State var router: Router = .init()
    private static let scheme = "txvideo" // 协议头
    private static let host = "v.qq.com" // 域名
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(self.router)
                .onOpenURL(perform: { url in
                    // 判断外链的协议头和域名是否符合约定
                    guard url.scheme == ScaffoldApp.scheme,
                          url.host() == ScaffoldApp.host else {
                        return
                    }
                    let path = url.path()
                    // 详情页面的路由处理
                    if path == "detail" {
                        if let params = url.params(),
                           let cid = params["cid"],
                            let cidInt = Int(cid)
                        {
                            router.pushToActiveTab(route: .detail(cid: cidInt))
                        }
                    }
                })
        }
    }
}
```

最后，传统艺能，talk is cheap: [scaffold_swiftui](./scaffold_swiftui)
 
