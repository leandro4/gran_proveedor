require 'test_helper'

module Api
  module V1
    module Providers
      module Products
        class CreateQuestionTest < Api::ApiIntegrationTest
          let(:user) { create(:user) }

          let(:provider) { create(:provider) }
          let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }
          let(:product) { create(:product, provider: provider)}

          let(:valid_params) {{
            question: FFaker::Lorem.sentence
          }}

          before do
            log_user;
          end

          def log_user
            user
          end

          it "[Example] returns success" do
            post_product_question(product, valid_params)

            assert_response :success
          end

          it "Create a question for the product" do
            assert_difference("product.questions.count", 1) do
              post_product_question(product, valid_params)
            end
          end

          def post_product_question(product, params)
            post "/api/v1/providers/#{product.provider.id}/products/#{product.id}/questions/", params
          end
        end
      end
    end
  end
end
