defmodule LandingPage.Clients.GoogleRecaptchaMock do
  def verify("invalid"), do: {:ok, %{success: false}}
  def verify(_token), do: {:ok, %{success: true}}
end
