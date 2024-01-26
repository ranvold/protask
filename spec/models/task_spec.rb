# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'enums' do
    subject(:task) { described_class.new }

    it do
      expect(task).to define_enum_for(:status)
        .with_values(ready_to_go: 0, in_progress: 1, done: 2)
    end
  end

  describe 'scopes' do
    describe '.by_status' do
      let!(:ready_task) { create(:task, status: :ready_to_go) }
      let!(:progress_task) { create(:task, status: :in_progress) }
      let!(:done_task) { create(:task, status: :done) }

      it 'returns tasks with the specified status' do
        expect(described_class.by_status(:ready_to_go)).to include(ready_task)
        expect(described_class.by_status(:in_progress)).to include(progress_task)
        expect(described_class.by_status(:done)).to include(done_task)
      end

      it 'does not return tasks with other statuses' do
        expect(described_class.by_status(:ready_to_go)).not_to include(progress_task, done_task)
        expect(described_class.by_status(:in_progress)).not_to include(ready_task, done_task)
        expect(described_class.by_status(:done)).not_to include(ready_task, progress_task)
      end
    end
  end
end
