require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
  
    it "shouldn't save if password and password confirmation are different" do
      user = User.new(name: "Dan", email: "yahoo.gov", password: "doesnt", password_confirmation: "match")

      user.save
      expect(user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end

    it "should save if password and password confirmation are the same" do
      user = User.new(name: "Dan", email: "yahoo.gov", password: "match", password_confirmation: "match")

      user.save
      expect(user.errors.full_messages).to be_empty
    end

    it "must not allow duplicate emails in the database" do
      user1 = User.new(name: "Dan", email: "Yorly.bong", password: "12345", password_confirmation: "12345")
      user1.save
      user2 = User.new(name: "Don", email: "YOrLy.BonG", password: "12345", password_confirmation: "12345")
      user2.save

      expect(user2.errors.full_messages).to eq ["Email has already been taken"]
    end

    it "must not allow a user to save without providing a name" do
    user = User.new(name: nil, email: "yorly.dong", password: "12345", password_confirmation: "12345")
    user.save

    expect(user.errors.full_messages).to eq ["Name can't be blank"]
    
    end

    it "must not allow a user to save without providing an email" do
      user = User.new(name: "Don", email: nil, password: "12345", password_confirmation: "12345")
      user.save
  
      expect(user.errors.full_messages).to eq ["Email can't be blank"]
      
    end

    it "should require a minimum length for a password" do
    
      user = User.new(name: "Don", email: "Yorly.bong", password: 'shrt', password_confirmation: 'shrt')
      user.save
      expect(user.errors.full_messages).to eq ["Password is too short (minimum is 5 characters)"]
    
    end
  end

  describe ".authenticate_with_credentials" do
  
    before do 
      @user = User.create(name: "Dan", email: "Yahoo.gov", password: "12345", password_confirmation: "12345")
    end
    
    it "should return a user when given valid credentials" do

      email = "Yahoo.gov"
      password = "12345"

      expected = User.authenticate_with_credentials(email, password)

      expect(expected.name).to eq(@user.name)
    end
  
    it "should return nil when given invalid credentials" do
      email = "Yahoo.gov"
      password = "24353"
    
      expected = User.authenticate_with_credentials(email, password)
    
      expect(expected).to be_nil
    end

    it "should login successfully with whitespace around the email" do
      email = "   Yahoo.gov"
      password = "12345"

      expected = User.authenticate_with_credentials(email, password)

      expect(expected.name).to eq(@user.name)
    
    end

    it "should login successfully with an email in varied case" do
      email = "yAhOO.GoV"
      password = "12345"
      
      expected = User.authenticate_with_credentials(email, password)

      expect(expected.name).to eq(@user.name)

    end

  end

end
