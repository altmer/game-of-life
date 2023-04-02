require 'spec_helper'
require 'game_of_life'

RSpec.describe GameOfLife do
  subject { GameOfLife.new(board) }

  context 'simple situation' do
    let(:board) do
      [
        [1, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 1],
        [0, 0, 0, 1]
      ]
    end

    it 'returns initial state correctly' do
      expect(subject.current_state).to eq(board)
    end

    it 'dies after one turn' do
      subject.tick
      expect(subject.current_state).to eq(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ]
      )
    end
  end

  context 'some cells survive' do
    let(:board) do
      [
        [1, 1, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 1, 1],
        [0, 0, 1, 1]
      ]
    end

    it 'correctly survives and comes to life' do
      subject.tick
      expect(subject.current_state).to eq(
        [
          [1, 1, 0, 0],
          [1, 0, 1, 0],
          [0, 1, 1, 1],
          [0, 0, 1, 1]
        ]
      )
    end
  end

  context 'overpopulation' do
    let(:board) do
      [
        [1, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end

    it 'correctly survives and comes to life' do
      subject.tick
      expect(subject.current_state).to eq(
        [
          [1, 0, 1, 0],
          [1, 0, 1, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ]
      )
      subject.tick
      expect(subject.current_state).to eq(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ]
      )
    end
  end

  context 'small board' do
    let(:board) do
      [
        [1]
      ]
    end

    it 'correctly survives and comes to life' do
      subject.tick
      expect(subject.current_state).to eq(
        [
          [0]
        ]
      )
    end
  end

  context 'small board' do
    let(:board) do
      [
        []
      ]
    end

    it 'correctly survives and comes to life' do
      expect { subject }.to raise_error('invalid board')
    end
  end
end