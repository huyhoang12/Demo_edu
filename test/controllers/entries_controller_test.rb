require 'test_helper'

class entriesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
	@entry = entries(:orange)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'entry.count' do
      post :create, entry: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'entry.count' do
      delete :destroy, id: @entry
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong entry" do
    log_in_as(users(:michael))
    entry = entries(:ants)
    assert_no_difference 'entry.count' do
      delete :destroy, id: entry
    end
    assert_redirected_to root_url
  end



end
