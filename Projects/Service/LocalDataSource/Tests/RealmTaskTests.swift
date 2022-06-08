// swiftlint:disable all

import XCTest
import Quick
import Nimble
import RealmSwift
@testable import LocalDataSource

final class TestObject: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String = ""

    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

final class RealmTaskTests: QuickSpec {
    override func spec() {
        describe("RealmTask에서") {
            var realm: Realm!
            var realmTask: RealmTask!
            beforeEach {
                let config = Realm.Configuration(inMemoryIdentifier: self.name)
                let realms = try? Realm(configuration: config)
                realm = realms
                realmTask = RealmTask(realm: realm)
            }
            context("더미값들을 넣고 fetchObjectsResutls를 하면") {
                let dummy: [TestObject] = [
                    .init(name: "test1"),
                    .init(name: "test2"),
                    .init(name: "test3")
                ]
                beforeEach {
                    realmTask.add(dummy)
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("더미값과 fetch해온 값이 같다") {
                    let fetched = realmTask.fetchObjectsResults(for: TestObject.self).toArray()
                    expect(dummy).to(equal(fetched))
                }
            }
            context("더미값을 add하면") {
                let dummy: TestObject = .init(name: "test1")
                beforeEach {
                    realmTask.add(dummy)
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("Realm DB에 저장된다") {
                    let fetched = realm.object(ofType: TestObject.self, forPrimaryKey: dummy.id)
                    expect(dummy).to(equal(fetched))
                }
            }
            context("더미값들을 add하면") {
                let dummy: [TestObject] = [
                    .init(name: "test1"),
                    .init(name: "test2"),
                    .init(name: "test3")
                ]
                beforeEach {
                    realmTask.add(dummy)
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("Realm DB에 저장된다") {
                    let fetched = realm.objects(TestObject.self).toArray()
                    expect(dummy).to(equal(fetched))
                }
            }
            context("더미값을 add하고 이름을 'ASd'로 업데이트하면") {
                let dummy = TestObject(name: "Test")
                beforeEach {
                    realmTask.add(dummy)
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("Realm DB에서 이름이 바뀐다") {
                    let fetched = realm.object(ofType: TestObject.self, forPrimaryKey: dummy.id)
                    expect("Test").to(equal(fetched?.name))
                    dummy.update {
                        $0.name = "ASd"
                    }
                    realmTask.set(dummy)
                    expect("ASd").to(equal(fetched?.name))
                }
            }
            context("더미값들을 add하고 전체 이름을 ASDf로 업데이트하면") {
                let dummy: [TestObject] = [
                    .init(name: "test1"),
                    .init(name: "test2"),
                    .init(name: "test3")
                ]
                beforeEach {
                    realmTask.add(dummy)
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("Realm DB에서 위 사항들이 반영된다") {
                    let fetched = realm.objects(TestObject.self).toArray()
                    expect(dummy.map(\.name)).to(equal(fetched.map(\.name)))
                    dummy.forEach {
                        $0.update {
                            $0.name = "ASDf"
                        }
                    }
                    expect(dummy.map(\.name)).to(equal(fetched.map { _ in "ASDf" }))
                }
            }
            context("더미값을 추가하고 삭제하면") {
                let dummy = TestObject(name: "Test")
                let dummy2 = TestObject(name: "ASDF")
                afterEach {
                    realmTask.deleteAll()
                }
                it("RealmTask에서 fetch하면 빈 배열이 온다") {
                    realmTask.add(dummy)
                    let fetched = realmTask.fetchObjectsResults(for: TestObject.self)
                    expect(fetched.count).to(equal(1))
                    realmTask.delete(dummy)
                    expect(fetched.count).to(equal(0))
                }
                it("Realm에서 찾을 시 nil이 나온다") {
                    realmTask.add(dummy2)
                    let fetched = realm.object(ofType: TestObject.self, forPrimaryKey: dummy2.id)
                    expect(dummy2).to(equal(fetched))
                    realmTask.delete(dummy2)
                    let fetched2 = realm.objects(TestObject.self).first
                    expect(fetched2).to(beNil())
                }
            }
            context("더미값들을 추가하고 deleteAll을 하면") {
                let dummy: [TestObject] = [
                    .init(name: "test1"),
                    .init(name: "test2"),
                    .init(name: "test3")
                ]
                beforeEach {
                    realmTask.add(dummy)
                    realmTask.deleteAll()
                }
                afterEach {
                    realmTask.deleteAll()
                }
                it("RealmTask에서 fetch할 때 빈 배열이 나온다") {
                    let fetched = realmTask.fetchObjectsResults(for: TestObject.self).toArray()
                    expect(fetched).to(equal([]))
                }
            }
        }
    }
}
