import RealmSwift
import Realm
import Combine
import Utility

protocol ObjectPropertyUpdatable {}
extension ObjectPropertyUpdatable where Self: Object {
    func update(_ block: (Self) throws -> Void) rethrows {
        try? self.realm?.safeWrite {
            try? block(self)
        }
    }
}
extension Object: ObjectPropertyUpdatable {}

protocol RealmTaskType: AnyObject {

    func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>?,
        sortProperty: String?,
        ordering: OrderingType
    ) -> AnyPublisher<[T], Never>

    func fetchObjectsResults<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>?,
        sortProperty: String?,
        ordering: OrderingType
    ) -> Results<T>

    func add(_ object: Object?)
    func add(_ objects: [Object]?)
    func set(_ object: Object?)
    func set(_ objects: [Object]?)
    func delete(_ object: Object?)
    func delete(_ objects: [Object]?)
    func deleteAll()
}

public final class RealmTask {

    static let shared = RealmTask()

    private let realm: Realm

    init() {
        guard let realm = try? Realm() else { fatalError() }
        self.realm = realm
    }

    init(realm: Realm) {
        self.realm = realm
    }

}
