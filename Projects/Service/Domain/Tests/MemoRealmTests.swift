// swiftlint:disable all
import XCTest
import Quick
import Nimble
import Domain
import ThirdPartyLib

final class MemoRealmTests: QuickSpec {
    override func spec() {
        describe("MemoRealm 객체를 생성하고") {
            var memo: MemoRealm!
            beforeEach {
                memo = MemoRealm()
            }
            it("memo의 title의 기본값이 ''이다") {
                expect(memo.title).to(beEmpty())
            }
            it("memo의 content의 기본값이 ''이다") {
                expect(memo.content).to(beEmpty())
            }
            it("memo의 isLock의 기본값이 false이다") {
                expect(memo.isLock).to(beFalse())
            }
            it("memo의 password의 기본값이 nil이다") {
                expect(memo.password).to(beNil())
            }
            context("title을 'asdf'로 설정하면") {
                beforeEach {
                    memo.title = "asdf"
                }
                it("memo의 title이 'asdf'가 된다") {
                    expect(memo.title).to(equal("asdf"))
                }
            }
            context("content를 'test'로 설정하면") {
                beforeEach {
                    memo.content = "test"
                }
                it("memo의 content가 'test'가 된다") {
                    expect(memo.content).to(equal("test"))
                }
            }
            context("isLock을 true로 설정하면") {
                beforeEach {
                    memo.isLock = true
                }
                it("memo의 isLock이 true가 된다") {
                    expect(memo.isLock).to(beTrue())
                }
            }
            context("password를 'password'로 설정하면'") {
                beforeEach {
                    memo.password = "password"
                }
                it("memo의 password가 'password'가 된다") {
                    expect(memo.password).to(equal("password"))
                }
            }
            it("Memo에 id를 제외한 convenience init으로 엔티티를 만들 수 있다") {
                memo = MemoRealm(title: "Test", content: "Asdf", isLock: false, password: nil)
                expect(memo).toNot(beNil())
                expect(memo.title).to(equal("Test"))
                expect(memo.content).to(equal("Asdf"))
                expect(memo.isLock).to(beFalse())
                expect(memo.password).to(beNil())
            }
        }
    }
}
