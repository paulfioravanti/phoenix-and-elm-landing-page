defmodule LandingPageWeb.V1.LeadControllerTest do
  use LandingPageWeb.ConnCase

  describe "POST /api/v1/leads" do
    setup(%{conn: conn, params: params}) do
      conn =
        conn
        |> post(lead_path(conn, :create), params)

      {:ok, [conn: conn, lead: params["lead"]]}
    end

    @tag params: %{"lead" => %{}}
    test "returns error response with invalid parms", %{conn: conn} do
      assert json_response(conn, 422) == %{
               "full_name" => ["can't be blank"],
               "email" => ["can't be blank"]
             }
    end

    @tag params: %{"lead" => %{"full_name" => "John", "email" => "foo@bar.com"}}
    test "returns success response with valid params", %{conn: conn, lead: lead} do
      assert json_response(conn, 200) == lead
    end
  end
end
