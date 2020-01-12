defmodule Ash.Oauth.Google do
  require IEx

  def get_info(token) do
    token
    |> get_user_profile # user
    |> normalize
  end

  defp get_user_profile(token) do
    Google.start
    body = Google.get!(token).body()
    IO.puts "TCL: body, #{inspect body}"

    body
  end

  defp normalize(body) do

    response = %{
      google_id: body[:sub],
      picture: body[:picture],
      first_name: body[:given_name],
      last_name: body[:family_name],
      email: body[:email]
    }
    response
  end
end
