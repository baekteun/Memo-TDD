import Utility
import ThirdPartyLib
import Realm
import RealmSwift
import Foundation

public final class MemoRealm: Object {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var title: String = ""
    @Persisted public var content: String = ""
    @Persisted public var isLock: Bool = false
    @Persisted public var password: String?

    public required convenience init(
        title: String,
        content: String,
        isLock: Bool,
        password: String?
    ) {
        self.init()
        self.title = title
        self.content = content
        self.isLock = isLock
        self.password = password
    }
}
