module UsersHelper
  def load_role user
    User.roles.key(user.role.to_i).capitalize
  end
end
