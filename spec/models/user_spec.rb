require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :suggests}
  end

  context "validates" do
    it "is invalid" do
      is_expected.to validate_presence_of(:password)
        .with_message(I18n.t("activerecord.errors.models.user.password.blank"))
    end
    it "password too short" do
      is_expected.to validate_length_of(:password).is_at_least(Settings.pass_min)
        .with_message(I18n.t("activerecord.errors.models.user.attributes.password.too_short"))
    end
    it "password must match" do
      is_expected.to validate_confirmation_of(:password)
        .with_message(I18n.t("activerecord.errors.models.user.password.confirmation"))
    end
    it "is empty email" do
      is_expected.to validate_presence_of(:email)
        .with_message(I18n.t("activerecord.errors.models.user.email.blank"))
    end
    it "is not uniqueness" do
      is_expected.to validate_uniqueness_of(:email).case_insensitive
        .with_message(I18n.t("activerecord.errors.models.user.email.taken"))
    end
    it "is invalid" do
      is_expected.not_to allow_value("invalid_email").for(:email)
        .with_message(I18n.t("activerecord.errors.models.user.email.invalid"))
    end
    it "name is too long" do
      is_expected.to validate_length_of(:name).is_at_most(Settings.name_max)
        .with_message(I18n.t("activerecord.errors.models.user.name.too_long"))
    end
  end
  it {is_expected.to define_enum_for(:role)}
end
