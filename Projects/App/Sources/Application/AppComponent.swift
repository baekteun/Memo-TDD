import NeedleFoundation
import RootFeature

final class AppComponent: BootstrapComponent {

    var rootComponent: RootComponent {
        RootComponent(parent: self)
    }
}
