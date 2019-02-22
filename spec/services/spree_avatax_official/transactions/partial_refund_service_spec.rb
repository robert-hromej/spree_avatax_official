require 'spec_helper'

describe SpreeAvataxOfficial::Transactions::PartialRefundService do
  describe '#call' do
    subject do
      described_class.call(
        order:        order,
        refund_items: refund_item
      )
    end

    let(:order)       { create(:order_with_line_items) }
    let(:refund_item) { { line_item => line_item.quantity - 1 } }
    let(:line_item)   { order.line_items.first }

    it 'creates ReturnInvoice' do
      VCR.use_cassette('spree_avatax_official/transactions/refund/partial_refund_success') do
        order.update(state: :complete)

        result   = subject
        response = result.value

        expect(result.success?).to eq true
        expect(response['type']).to eq 'ReturnInvoice'
        expect(response['status']).to eq 'Committed'
        expect(response['lines'].size).to eq 1
        expect(SpreeAvataxOfficial::Transaction.count).to eq 1
      end
    end
  end
end