require "test_helper"

class ChefTest < ActiveSupport::TestCase
	def setup
		@chef = Chef.new(chefname: "John", email: "john@example.com")
	end

	test "chef should be valid" do
		assert @chef.valid?
	end

	test "chefname should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname should not be to long" do
		@chef.chefname = "a" * 41
		assert_not @chef.valid?
	end

	test "chefname should not be to short" do
		@chef.chefname = "aa"
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email should not be to long" do
		@chef.email = "a" * 101 + "@example.com"
		assert_not @chef.valid?
	end

	test "email adress should be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end

	test "email validation should accept valid adresses" do
		valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first,last@eem.au laura+joe@monk.cm]
		valid_addresses.each do |va|
			@chef.email = va
			assert @chef.valid?, '#{va.inspect} should be valid'
		end
	end

	test "email validation should reject invalid adresses" do
		invalid_adresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com ]
		invalid_adresses.each do |inva|
			@chef.email = inva
			assert_not @chef.valid?, '#{inva.inspect} should be invalid'
		end
	end


end