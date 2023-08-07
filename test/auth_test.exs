defmodule AuthTest do
  use ExUnit.Case
  alias PocketFlask.Authenticate

  describe "auth_with_password/3" do
    test "returns a successful response when given valid credentials" do
      response =
        Authenticate.auth_with_password(
          "admins",
          "chris.aa.king@gmail.com",
          "chris.aa.king@gmail.com"
        )

      assert response.successful?
    end

    test "returns an error response when given invalid credentials" do
      response =
        Authenticate.auth_with_password("my_collection", "user@example.com", "wrong_password")

      assert response.error?
    end
  end
end
