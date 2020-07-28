require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    before(:all) do
      User.destroy_all
    end
    

    context "password does not password confirmation" do
    it "fails to create user" do
      user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1233')
      
      expect(user.errors[:password_confirmation]).to be_present

    end
  end

  context "if  password confirmation is missing" do
    it "fails to create user" do
      user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234')
      
      expect(user.errors[:password_confirmation]).to be_present

    end

  end
  context "if  password  is missing" do
    it "fails to create user" do
      user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password_confirmation:'1234')
        
      expect(user.errors[:password]).to be_present
  
    end

  end

  context "if  email  is missing" do
    it "fails to create user" do
      user = User.create(first_name:'BOB',last_name:'Michael',password:'1234',password_confirmation:'1234')
        
      expect(user.errors[:email]).to be_present
  
    end

  end
  context "if  first name  is missing" do
    it "fails to create user" do
      user = User.create(last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1234')
        
      expect(user.errors[:first_name]).to be_present
  
    end

  end

  context "if  last name  is missing" do
    it "fails to create user" do
      user = User.create(first_name:'BOB',email:"bob@mail.com",password:'1234',password_confirmation:'1234')
        
      expect(user.errors[:last_name]).to be_present
  
    end
  end
    context "if  email is already taken" do
      it "fails to create user" do
        user1 = User.create(first_name:'BOB',last_name:"Michael",email:"bob@mail.com",password:'1234',password_confirmation:'1234')
        user2 = User.create(first_name:'BOB',last_name:"Michael",email:"bob@mail.com",password:'1234',password_confirmation:'1234')
        expect(user2.errors[:email]).to be_present
    
      end

    end

    context "emails are unique not case sensitive" do
      it "fails to create user" do
        user1 = User.create(first_name:'BOB',last_name:"Michael",email:"bob@mail.com",password:'1234',password_confirmation:'1234')
        user2 = User.create(first_name:'BOB',last_name:"Michael",email:"BoB@MAiL.COM",password:'1234',password_confirmation:'1234')
        expect(user2.errors[:email]).to be_present
    
      end

    end

    context "if  password is short" do
      it "fails to create user" do
        user = User.create(first_name:'BOB',last_name:"Michael",email:"bob@mail.com",password:'123',password_confirmation:'123')
        expect(user.errors[:password]).to be_present
    
      end

    end


  end

  describe ".authenticate_with_credentials " do
    context "if credentials are correct" do
      it "will return the user" do
         user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1234')

         result = User.authenticate_with_credentials(user.email,user.password)
         expect(result).to eql(user)


        end
    end

    context "if email is wrong" do
      it "will return nil" do
         user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1234')

         result = User.authenticate_with_credentials('bo@mail.com',user.password)
         expect(result).to be_nil


        end
    end

    context "if password is wrong" do
      it "will return the nil" do
         user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1234')

         result = User.authenticate_with_credentials(user.email,'12345')
         expect(result).to be_nil



        end
    end

    context "if user input email with whitespace" do
      it "will return the user" do
         user = User.create(first_name:'BOB',last_name:'Michael',email:"bob@mail.com",password:'1234',password_confirmation:'1234')

         result = User.authenticate_with_credentials("  bob@mail.com  ",user.password)
         expect(result).to eql(user)



        end
    end

    context "if user input email with wrong case" do
      it "will return the user" do
         user = User.create(first_name:'BOB',last_name:'Michael',email:"Bob@MaIL.coM",password:'1234',password_confirmation:'1234')

         result = User.authenticate_with_credentials("Bob@MaIL.CoM",user.password)
         expect(result).to eql(user)



        end
    end



    
    

  end

end
