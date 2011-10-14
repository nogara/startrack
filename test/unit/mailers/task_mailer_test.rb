require 'test_helper'

class TaskMailerTest < ActionMailer::TestCase
  tests TaskMailer

  def setup
    @task = tasks(:room_galaxy)
    @watcher = tasks(:room_galaxy).watchers.first
    @watchers_changes = {}
    @watchers_changes[:added] = [tasks(:room_galaxy).watchers.first]
    @watchers_changes[:removed] = [tasks(:room_galaxy).watchers.last]
    @changes = tasks(:room_galaxy).type
    @task_notification = TaskMailer.task_notification(@watcher, @task, @changes, @watchers_changes)
  end

  test "comment notification" do
    assert_equal ["startrack@example.com.br"], @task_notification.from
    assert_equal ["kirk@example.com"], @task_notification.to
    assert_equal "[First Journey] The task #938857913 - Room the galaxy has been updated", @task_notification.subject
    assert_equal "text/plain; charset=UTF-8", @task_notification.content_type
    assert_equal read_fixture('task_notification').join, @task_notification.body.to_s
  end
end
