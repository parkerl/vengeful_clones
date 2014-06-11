# VengefulClones

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'vengeful_clones'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vengeful_clones
    
## Motivation

A long time ago, in a codebase far, far away....

It is a period of test driven strife. Mocks 
and stubs striking from long forgotten specs 
have hidden sinister bugs among inocent implmentations.

Let me tell you a story of a coder named Charlie on a 
tragic and fateful day. Hackers, hear me out. 
This could happen to you!

Charlie was charged with maintaining the critical code 
that made the final determination of the the Death Star's ability to fire its superlaser. This was accomplished via a long and complex method that checked the balance in the force, accounted for windage, etc. etc.
We shall spare you further details. Being a concencious coder, Charlie decided to extract the messiness into a collaborating class in orer to conduct further refactoring, like so:

```
def fire_the_death_star!
  DeathStar.fire unless SuperlaserReddinessValidator.new.check_for_systems_not_ready
end
```

He didn't want to handle all those messy details in his specs so
he wrote a test using a mock like:

```
fake_validator = mock(:fake_rediness_validator, check_for_systems_not_ready: false)
SuperlaserReddinessValidator.stub(:new).and_return(fake_validator)

DeathStar.should_receive(:fire)
fire_the_death_star!
```

Charlie's refactoring was so sucessful that all the Emperor's coders were soon using his extracted class all over the place. They liked his tests too, and so
his mocks proliferated.

Sadly Charlie was killed in a subsequent rebel attack before pairing with
anyone else on the original bit of code. Ironically, this was because according to his well factored code the superlaser was not able to be fired.


Fast forward to the future days of the distant past. 

The Emperor is pissed that someone, somewhere screwed up something that caused the superlaser to not function costing him a Death Star. He now wants feedback if the laser fails to fire so he knows whose trachea to have crushed. His coders, eager to keep breathing, quickly redesign Charlie's original class to return an OpenStruct that indicates success or failure and reports errors like so:

```
#original
def check_for_systems_not_ready
  return true unless all_systems_go
  false
end

#newfangled
def check_for_systems_not_ready
  rediness_state = OpenStruct.new
  rediness_state.laser_should_not_fire = !all_systems_go
  rediness_state.systems_not_ready = systems_at_fault
  rediness_state
end
```

After all the tests of that class are altered for the new design, they run the entire test suite and everything is green. 

Unfortunatly, during the next rebel attack the Death Star will not fire even though all system are good to go. 

Now let's replay the story using vengeful clones.


## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
