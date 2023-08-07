# BEGIN: 8f7a1d9b9f8a
defmodule AdminTest do
  use ExUnit.Case

  describe "create_admin/2" do
    test "creates an admin with valid email and password" do
      email = "test@example.com"
      password = "test_password"

      assert {:ok, %{"id" => id}} = PocketFlask.Admin.create_admin(email, password)
      assert id > 0
    end

    test "returns an error with invalid email" do
      email = "invalid_email"
      password = "test_password"

      assert {:error, %{"message" => "Invalid email format"}} =
               PocketFlask.Admin.create_admin(email, password)
    end

    test "returns an error with invalid password" do
      email = "test@example.com"
      password = "short"

      assert {:error, %{"message" => "Password must be at least 8 characters long"}} =
               PocketFlask.Admin.create_admin(email, password)
    end
  end
end

# END: 8f7a1d9b9f8a
