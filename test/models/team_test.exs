defmodule PlanningPoker.TeamTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.Team

  @valid_attrs %{coders: [], name: "some content", points: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Team.changeset(%Team{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Team.changeset(%Team{}, @invalid_attrs)
    refute changeset.valid?
  end
end
