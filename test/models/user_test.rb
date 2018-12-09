require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true, "Ha ez nem igaz, akkor nagyon nagy baj van"
  end

  test "encrypt password" do
    assert_equal users(:other).encrypted_password, Digest::SHA1.hexdigest('hidden'+users(:other).salt)
  end

  test "cannot save without email address" do
      u = User.new
      assert !u.save, "Houston, we have a problem"
    end
end
