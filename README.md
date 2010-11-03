# oneliner - a stupid simple command-line application framework

So there's [Thor](http://github.com/wycats/thor) and
[Commander](http://github.com/visionmedia/commander) and
[boson](http://github.com/cldwalker/boson) and a
[ton of other command-line application/task frameworks](http://delicious.com/tag/gem:type=task)
out there. So why another one? Well, it's quite selfish actually: I
wanted something quite specific, and none of the available frameworks
provided what I wanted.

 * Thor didn't lend itself to be easily integrated into my app, with
   module-namespaced commands split across files
 * Commander didn't support namespaces at all and was too DSL-ish for
   my taste
 * boson is more of a task/snippet manager than a framework for
   building command-line tools
 
Of course, all of these tools are great - I just wanted something
else.

*Note: this is the initial release*. Oneliner is sorely missing both
 argument validation and more sofisticated ARGV parsing (using
 optparse/whatever), but it's in the pipes.

## Defining commands
    
    require 'oneliner/command'
 
    module MyCommands 
      class Greet < Oneliner::Command
    
        description 'A friendly greeting'
      
        def run!(*args) 
          name = args.first 
          puts "Hello #{name}!" 
        end
    
      end
    end
    
## Compositing commands into an application

    require 'oneliner/app'
    require 'mycommands'
    
    class MyApp < Oneliner::App
      
      name 'myapp' # optional, defaults to the basename of the process
      description 'Example in the making' # optional
      
      commands MyCommands
    end
    
In your executable:

    #!/usr/bin/env ruby 
    MyApp.run!
    
Run it like this:

    ~$ ./path/to/executable greet "King Arthur"
    Hello King Arthur!

And that's all there is to it.

## Namespaces 
Namespaces are simply Ruby modules:

    module MyCommands 
      module My 
        module Nested 
          module Namespace
          
            class HelloWorld < Oneliner::Command
              ...
            end
            
          end 
        end
      end
    end
    
So we run it like this:

    ./path/to/executable my.nested.namespace.hello_world

## Bundled commands 

Oneliner bundled with a few generic commands in the
`Oneliner::Commands` module.

## User interfaces

Writing code for handling e.g. user input is boring and often results
in code duplication. The `ui` declaration allows us to specify a
module which implements the cross-cutting UI functionality. The
bundled `Oneliner::UI::Highline` module imports [highline](http://github.com/JEG2/highline)
into its namespace.

    class MyApp < Oneliner::App
    
      ui Oneliner::UI::Highline
    
    end
    
which becomes accessible in our commands like this:

    class BridgeKeeper < Oneliner::Command
    
      def run!(*args)
        velocity = ui.ask('What is the airspeed velocity of an unladen swallow?')
        puts "Your answered: #{velocity}"
      end
      
    end
