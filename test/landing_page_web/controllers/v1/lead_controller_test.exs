defmodule LandingPageWeb.V1.LeadControllerTest do
  use LandingPageWeb.ConnCase

  describe "POST /api/v1/leads" do
    setup(%{conn: conn, params: params}) do
      {:ok, [conn: post(conn, lead_path(conn, :create), params)]}
    end

    @tag params: %{"lead" => %{}}
    test "returns error response with invalid parms", %{conn: conn} do
      assert json_response(conn, 422) == %{
               "full_name" => ["can't be blank"],
               "email" => ["can't be blank"],
               "recaptcha_token" => ["can't be blank"]
             }
    end

    @tag params: %{
           "lead" => %{
             "full_name" => "John",
             "email" => "foo@bar.com",
             "recaptcha_token" => "foo"
           }
         }
    test "returns success response with valid params", %{conn: conn} do
      assert json_response(conn, 200) == %{
               "full_name" => "John",
               "email" => "foo@bar.com"
             }
    end

    @tag params: %{
           "lead" => %{
             "full_name" => "John",
             "email" => "foo@bar.com",
             "recaptcha_token" => "invalid"
           }
         }
    test "returns error response with invalid token", %{conn: conn} do
      assert json_response(conn, 422) == %{
               "recaptcha_token" => ["the response is invalid"]
             }
    end
  end
end
