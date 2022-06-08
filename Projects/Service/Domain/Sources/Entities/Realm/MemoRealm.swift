import RealmSwift
import Foundation

public final class MemoRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var isLock: Bool
    @Persisted var password: String
}
