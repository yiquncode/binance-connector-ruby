# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#get_sub_account_assets_v4' do
  let(:path) { '/sapi/v4/sub-account/assets' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.get_sub_account_assets_v4(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: 'test@test.com' } }
    it 'should return sub-account assets' do
      spot_client_signed.get_sub_account_assets_v4(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
