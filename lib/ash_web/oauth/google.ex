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
    body
  end

  defp normalize(body) do

    response = %{
      oauth_id: body[:sub],
      oauth_provider: "Google",
      picture: body[:picture],
      first_name: body[:given_name],
      last_name: body[:family_name],
      email: body[:email]
    }
    response
  end
end
