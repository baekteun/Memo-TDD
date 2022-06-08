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

public final class RealmTask: RealmTaskType {
    static let shared = RealmTask()

    private let realm: Realm

    init() {
        guard let realm = try? Realm() else { fatalError() }
        self.realm = realm
    }

    init(realm: Realm) {
        self.realm = realm
    }

    func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> AnyPublisher<[T], Never> {
        let res = fetchObjectsResults(
            for: type,
            filter: filter,
            sortProperty: sortProperty,
            ordering: ordering
        ).toArray()
        return Just(res).eraseToAnyPublisher()
    }
    func fetchObjectsResults<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> Results<T> {
        var res = realm.objects(type)
        if let filter = filter {
            switch filter {
            case let .predicate(query):
                res = res.filter(query)
            case let .string(query):
                res = res.filter(query)
            case let .where(query):
                res = res.where(query)
            }
        }
        if let sortProperty = sortProperty {
            res = res.sorted(byKeyPath: sortProperty, ascending: ordering == .ascending)
        }
        return res
    }

    func add(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object)
        }
    }

    func add(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects)
        }
    }

    func set(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object, update: .all)
        }
    }

    func set(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects, update: .all)
        }
    }

    func delete(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.delete(object)
        }
    }

    func delete(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.delete(objects)
        }
    }

    func deleteAll() {
        try? realm.safeWrite {
            realm.deleteAll()
        }
    }
}
