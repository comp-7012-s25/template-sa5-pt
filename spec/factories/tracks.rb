# frozen_string_literal: true

# == Schema Information
#
# Table name: tracks
#
#  id                :bigint           not null, primary key
#  length_in_seconds :integer
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :track do
    album

    title { 'Song' }
    length_in_seconds { 2 }
  end
end
