module UsersHelper
  def load_role user
    user.role.capitalize
  end
end
