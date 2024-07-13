//
//  LoginFormValidatorTests.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 26/04/24.
//

import XCTest
@testable import Pet_Shop

final class LoginFormValidatorTests: XCTestCase {

    private var validator: AuthValidator!
    
    override func setUp() {
        validator = AuthValidatorImpl()
    }
    
    override func tearDown() {
        validator = nil
    }

    func test_login_with_empty_email_error_thrown() {
        XCTAssertThrowsError(try validator.validateLogIn(email: "", password: "123"), "Error for empty email should be thrown")
        
        do {
            _ = try validator.validateLogIn(email: "", password: "123")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidEmailEmpty, "Expecting an error of invalid empty email")
        }
    }
    
    func test_login_with_empty_password_error_thrown() {
        XCTAssertThrowsError(try validator.validateLogIn(email: "test@mail.com", password: ""), "Error for empty password should be thrown")
        
        do {
            _ = try validator.validateLogIn(email: "test@mail.com", password: "")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidPasswordEmpty, "Expecting an error of invalid empty password")
        }
    }
    
    func test_login_with_invalid_email_entry_error_thrown() {
        XCTAssertThrowsError(try validator.validateLogIn(email: "test@mail", password: "123"), "Error for invalid email entry should be thrown")
        
        do {
            _ = try validator.validateLogIn(email: "test@mail", password: "123")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidEmail, "Expecting an error of invalid email entry")
        }
    }
}
