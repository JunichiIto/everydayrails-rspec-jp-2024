require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  describe "project names" do
    # ユーザー単位では重複したプロジェクト名を許可しないこと
    it "does not allow duplicate project names per user" do
      user = FactoryBot.create(:user)

      user.projects.create(
        name: "Test Project",
        )

      new_project = user.projects.build(
        name: "Test Project",
        )

      new_project.valid?
      expect(new_project.errors[:name]).to include("has already been taken")
    end

    # ⼆⼈のユーザーが同じ名前を使うことは許可すること
    it "allows two users to share a project name" do
      FactoryBot.create(:user).projects.create(
        name: "Test Project",
      )

      other_project = FactoryBot.create(:user).projects.build(
        name: "Test Project",
        )

      expect(other_project).to be_valid
    end
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

  # たくさんのメモが付いていること
  it "can have many tasks" do
    project = FactoryBot.create(:project, :with_tasks)
    expect(project.tasks.length).to eq 5
  end
end
