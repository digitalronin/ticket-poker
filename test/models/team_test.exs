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

  test "point strings" do
    assert Team.pre_process_points(nil) == []
    assert Team.pre_process_points("") == []
    assert Team.pre_process_points("1 2 3") == [1, 2, 3]
    assert Team.pre_process_points(" 1 2 3 ") == [1, 2, 3]
    assert Team.pre_process_points(" 1	2 x 3 ") == [1, 2, 3]
    assert Team.pre_process_points("2 1 3") == [1, 2, 3]
    assert Team.pre_process_points("1 1 2 3") == [1, 2, 3]
  end
end
