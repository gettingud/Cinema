require 'cinema'

describe Cinema::Examples::Period do
  let(:period_without_filters) {
    described_class.new('10:00'..'16:00') do
      description 'Спецпоказ'
      title 'The Terminator'
      price 50
      hall :green, :blue
    end
  }

  subject {
    described_class.new('10:00'..'16:00') do
      description 'Спецпоказ'
      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
      price 50
      hall :green, :blue
    end
  }

  context 'description' do
    its(:description) { is_expected.to eq('Спецпоказ') }
  end

  context 'time' do
    its(:time) {is_expected.to eq('10:00'..'16:00')}
  end

  context 'price' do
    its(:price) {is_expected.to eq(50)}
  end

  context 'hall' do
    its(:hall) {is_expected.to eq([:green, :blue])}
  end

  context 'filters' do
    its(:filters) {is_expected.to eq(genre: ['Action', 'Drama'], year: 2007..Time.now.year)}
  end

  context 'method_missing' do
    it 'creates fitlers method depending on block if no filter given' do
      expect(period_without_filters.filters).to eq(title: "The Terminator")
    end
  end

  context 'to_h' do
    its(:to_h) {is_expected.to eq(
       { time: '10:00'..'16:00',
        filters: {:genre=>["Action", "Drama"], :year=>2007..2017},
        price: 50,
        hall: [:green, :blue]
       }
      )}
  end
end