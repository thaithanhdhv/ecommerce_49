require "rails_helper"

RSpec.describe Product, type: :model do
  context "associations" do
    it {is_expected.to have_many :order_details}
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many :comments}
    it {is_expected. to belong_to :category}
  end
  it {is_expected.to delegate_method(:name).to(:category).with_prefix(:category)}

  context "validates" do
    it "name is blank" do
      is_expected.to validate_presence_of(:nqwame)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.name.blank"))
    end
    it "price is blank" do
      is_expected.to validate_presence_of(:price)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.price.blank"))
    end
    it "quantity is blank" do
      is_expected.to validate_presence_of(:quantity)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.quantity.blank"))
    end
    it "is interger" do
      is_expected.to validate_numericality_of(:quantity).only_interger
        .with_message(I18n.t("activerecord.errors.models.product.attributes.quantity.not_an_integer"))
    end
    it "must greater than zero" do
      is_expected.to validate_numericality_of(:quantity).is_greater_than(Settings.quantity.zero)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.quantity.greater_than"))
    end
    it "description is blank" do
      is_expected.to validate_presence_of(:description)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.description.blank"))
    end
    it "is too long" do
      is_expected.to validate_length_of(:description).is_at_most(Settings.description_max)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.description.too_long"))
    end
  end
end
