require 'ariel'
require 'ariel_test_case'

class TestLearner < Ariel::TestCase
  include Fixtures

  def setup
    #Examples stolen from the STALKER paper. Target to extract is the area
    #codes.
    @e=@@labeled_addresses
    @learner=Ariel::Learner.new(*@e)
  end

  def test_set_seed
    assert_equal @e[1], @learner.current_seed # LabeledStream with smallest label_index
  end

  def test_generate_initial_candidates
    @learner.direction=:forward
    @learner.generate_initial_candidates
    c=@learner.candidates
    assert (c.include? Ariel::Rule.new(:forward, [["("]]))
    assert (c.include? Ariel::Rule.new(:forward, [[:anything]]))
    assert (c.include? Ariel::Rule.new(:forward, [[:punctuation]]))
  end

  def test_refine
    @learner.current_rule=Ariel::Rule.new(:forward, [["<b>"]])
    assert @learner.refine
    @learner.current_rule=Ariel::Rule.new(:forward, [["<b>", "Palms"], ["Phone"]])
    assert @learner.refine
  end

  def test_learn_rule
    rule=@learner.learn_rule :forward
    p rule
  end
end
