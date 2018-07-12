require "rails_helper"

RSpec.describe Admin::ProductsController, type: :controller do
  let(:user) {create :user, role: :admin}
  before {sign_in user}
  let(:category) {create :category}
  let(:product) {create :product, category_id: category.id}
  let(:valid_attributes) do
    FactoryBot.attributes_for :product, category_id: category.id
  end
  let(:invalid_attributes) do
    { name: ""}
  end
  describe "GET #index" do
    before {get :index}
    it "populates an array of all products" do
      product_1 = create :product, category_id: category.id
      expect(assigns :products).to match_array [product, product_1]
    end
    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context "found product" do
      before {get :show, params: {id: product}}
      it "assigns the request product to @product" do
        expect(assigns :product).to eq product
      end
    end

    context "not found product" do
      it "redirects to product#index" do
        get :show, params: {id: 0}
        is_expected.to respond_with(404)
      end
    end
  end

  describe "GET #new" do
    before {get :new}
    it "assigns a new Product to @product" do
      expect(assigns :product).to be_a_new Product
    end
    it "renders the :new template" do
      is_expected.to render_template :new
    end
  end

  describe "GET #edit" do
    context "found product" do
      before {get :edit, params: {id: product}}
      it "assigns the request product to @product" do
        expect(assigns :product).to eq product
      end
      it "renders the :edit template" do
        is_expected.to render_template :edit
      end
    end

    context "not found product" do
      it "redirects to product#index" do
        get :edit, params: {id: 0}
        is_expected.to respond_with(404)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect {post :create, params: {product: valid_attributes}}
          .to change(Product, :count).by(1)
      end
    end
    context "with invalid attributes" do
      before {post :create, params: {product: invalid_attributes}}
      it "does not save the new product" do
        is_expected.not_to change(Product, :count)
      end
      it "re-renders the :new template" do
        
        is_expected.to render_template :news
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before {patch :update, params: {id: product, product: valid_attributes}}
      it "locates the requested @product" do
        expect(assigns :product).to eq product
      end
      it "redirects to products" do
        is_expected.to redirect_to admin_products_path
      end
    end

    context "with invalid attributes" do
      before {patch :update, params: {id: product, product: invalid_attributes}}
      it "locates the requested @product" do
        expect(assigns :product).to eq product
      end
      it "re-renders the :edit template" do
        is_expected.to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "can delete" do
      before {delete :destroy, params: {id: product}}
      it "soft deletes the product" do
        product.reload
        is_expected.to change(Product, :count).by(-1)
      end
      it "renders index template" do
        is_expected.to redirect_to admin_products_path
      end
    end

    context "can't delete" do
      before {delete :destroy, params: {id: 0}}
      it "render index template" do
        is_expected.to redirect_to admin_products_path
      end
      it "show notice message" do
        expect(flash[:danger]).to eq I18n.t("error_message")
      end
    end
  end
end
