require 'test_helper'

class entryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @entry = @user.entries.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @entry.valid?
  end

  test "user id should be present" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end
  test "content should be present" do
    @entry.content = "   "
    assert_not @entry.valid?
  end

  test "content should be at most 140 characters" do
    @entry.content = "a" * 141
    assert_not @entry.valid?
  end

  test "order should be most recent first" do
    assert_equal entries(:most_recent), entry.first
  end

end
