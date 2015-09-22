defmodule Support.SessionController do
  use Support.Web, :controller

  alias Support.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    user = Repo.get_by(User, email: email)
    if user && User.check_password(password, user.encrypted_password) do
      conn
      |> put_flash(:info, "logged in")
      |> put_session(:current_user, user.id)
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "Incorrect email or password")
      |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> put_flash(:info, "logged out")
    |> put_session(:current_user, nil)
    |> redirect(to: "/")
  end

end
