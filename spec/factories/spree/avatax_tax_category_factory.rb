FACTORY_BOT_CLASS.define do
  factory :avatax_tax_category, class: Spree::TaxCategory do
    name        { 'Tax category name' }
    description { 'Tax category description' }

    trait :clothing do
      name     { 'Clothing' }
      tax_code { ::Spree::TaxCategory::DEFAULT_TAX_CODES['Spree::LineItem'] }
    end

    trait :shipping do
      name     { 'Shipping' }
      tax_code { ::Spree::TaxCategory::DEFAULT_TAX_CODES['Spree::Shipment'] }
    end
  end
end
