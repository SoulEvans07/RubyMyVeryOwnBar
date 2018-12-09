require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true, "Ha ez nem igaz, akkor nagyon nagy baj van"
  end

  test "encrypt password" do
    assert_equal users(:other_user).encrypted_password, Digest::SHA1.hexdigest('hidden'+users(:other_user).salt)
  end

  test "cannot save without email address" do
      u = User.new
      assert !u.save, "Houston, we have a problem"
    end
end
