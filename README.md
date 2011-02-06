## Thor Tasks

Contains a bunch of generators written in thor.

### Gen

**Gen** is a generator generator. It is used to create new Thor
generators. It generates them and sets up rspec for simple testing.

    $ thor help gen
    Tasks:
      thor gen:group NAME   # Generate a "class Name < Thor::Group generator
      thor gen:help [TASK]  # Describe available tasks or one specific task
      thor gen:single NAME  # Generate a "class Name < Thor" generator


#### gen:group

    $ thor help gen:group
    Usage:
      thor gen:group NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method per task


##### Example
    $ thor gen:group group_task -t do_one do_two
          create  group_task.thor/main.thor
          create  group_task.thor/templates/sample.txt.tt
          create  group_task.thor/spec
          create  group_task.thor/spec/integration/main_spec.rb
          create  group_task.thor/spec/spec_helper.rb


#### gen:single

    $ thor help gen:single
    Usage:
      thor gen:single NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method per task

    Generate a "class Name < Thor" generator


##### Example

    $ thor gen:single new_task -t do_something
          create  new_task.thor/main.thor
          create  new_task.thor/templates/do_something/sample.txt.tt
          create  new_task.thor/spec
          create  new_task.thor/spec/integration/main_spec.rb
          create  new_task.thor/spec/spec_helper.rb
