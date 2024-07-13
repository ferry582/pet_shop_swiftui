//
//  SignupFormValidatorTests.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 27/04/24.
//

import XCTest
@testable import Pet_Shop

final class SignupFormValidatorTests: XCTestCase {

    private var validator: AuthValidator!
    
    override func setUp() {
        validator = AuthValidatorImpl()
    }
    
    override func tearDown() {
        validator = nil
    }

    func test_signup_with_empty_email_error_thrown() {
        XCTAssertThrowsError(try validator.validateSignUp(email: "", password: "123", confirmPassword: "123"), "Error for empty email should be thrown")
        
        do {
            _ = try validator.validateSignUp(email: "", password: "123", confirmPassword: "123")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidEmailEmpty, "Expecting an error of invalid empty email")
        }
    }
    
    func test_signup_with_empty_password_error_thrown() {
        XCTAssertThrowsError(try validator.validateSignUp(email: "test@mail.com", password: "", confirmPassword: "123"), "Error for empty password should be thrown")
        
        do {
            _ = try validator.validateSignUp(email: "test@mail.com", password: "", confirmPassword: "123")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidPasswordEmpty, "Expecting an error of invalid empty password")
        }
    }
    
    func test_signup_with_empty_confirm_password_error_thrown() {
        XCTAssertThrowsError(try validator.validateSignUp(email: "test@mail.com", password: "123", confirmPassword: ""), "Error for empty confirm password should be thrown")
        
        do {
            _ = try validator.validateSignUp(email: "test@mail.com", password: "123", confirmPassword: "")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidConfirmPasswordEmpty, "Expecting an error of invalid empty confirm password")
        }
    }
    
    func test_signup_with_invalid_email_entry_error_thrown() {
        XCTAssertThrowsError(try validator.validateSignUp(email: "test@mail", password: "123", confirmPassword: "123"), "Error for invalid email entry should be thrown")
        
        do {
            _ = try validator.validateSignUp(email: "test@mail.com", password: "", confirmPassword: "123")
        } catch {
            guard let validatorError = error as? AuthValidatorImpl.AuthValidatorError else {
                XCTFail("Wrong type of error, expecting auth validation error")
                return
            }
            
            XCTAssertEqual(validatorError, AuthValidatorImpl.AuthValidatorError.invalidPasswordEmpty, "Expecting an error of invalid email entry")
        }
    }

}
