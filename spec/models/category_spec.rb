require "rails_helper"

RSpec.describe Category, type: :model do
  context "associations" do
    it {is_expected.to have_many :products}
    it {is_expected.to have_many :subcategories}
    it {is_expected.to have_one :parent}
  end

  context "validates" do
    it "is empty" do
      is_expected.to validate_presence_of(:name)
        .with_message(I18n.t("activerecord.errors.models.category.attributes.name.blank"))
    end
    it "is uniqueness" do
      is_expected.to validate_uniqueness_of(:name).case_insensitive
        .with_message(I18n.t("activerecord.errors.models.category.attributes.name.taken"))
    end
    it "is too long" do
      is_expected.to validate_length_of(:name).is_at_most(Settings.category_max)
        .with_message(I18n.t("activerecord.errors.models.category.attributes.name.too_long"))
    end
  end
end
