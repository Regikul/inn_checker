defmodule InnChecker.InnValidatorTest do
  use ExUnit.Case

  alias InnChecker.InnValidator

  test "valid 10-digit inn" do
    assert InnValidator.valid?("7830002293")
  end

  test "bad 10-digit inn" do
    assert not InnValidator.valid?("7831002293")
  end

  test "valid 12-digit inn" do
    assert InnValidator.valid?("500100732259")
  end

  test "bad 12-digit inn" do
    assert not InnValidator.valid?("500101732259")
  end

  test "too short inn" do
    assert not InnValidator.valid?("123")
  end

  test "too long inn" do
    assert not InnValidator.valid?("123456789123456")
  end

  test "not an inn" do
    assert not InnValidator.valid?("50010hello1732259")
  end
end
