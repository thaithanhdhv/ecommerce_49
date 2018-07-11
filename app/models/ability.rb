class Ability
  include CanCan::Ability

  def initialize user
    can :read, :all
    can :search, Product
    if user.present?
      can :create, Comment
      can %i(update destroy), Comment, user_id: user.id
      can :create, Rating
      can :update, User, user_id: user.id
      can :create, Order
      can :cancel, Order, user_id: user.id
      return unless user.admin?
      can :manage, :all
    end
  end
end
