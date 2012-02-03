# Working with Moo(se)

## Object layer

We assume you understand in general what an object system is. In Perl there is the advantage, not like in many other languages, that you can pick the object system you wanna use. Perl as base language only use the concept of so called "blessed" hash references, to give the option for an object system, you can lookup this in [Perl Documentation perlobj](http://perldoc.perl.org/perlobj.html), but you will not need to understand blessing for first, cause its abstracted away through Moo or Moose in this case. This way it feels much more like the object systems you know from other languages, just a bit more cool ;).

[Moose](https://metacpan.org/release/Moose) is excellent documented and as a very good [Cookbook](https://metacpan.org/module/Moose::Cookbook) and a nice [Manual](https://metacpan.org/module/Moose::Manual) for getting into all details of it very easily. Moose is very heavy and gives a huge dimension of options, be aware if you really want to look into it, its the candy store of developers.... dont get fat ;).

[Moo](https://metacpan.org/release/Moo) is an upcoming project, and still in development. Many features are still to come, but its a slow and very hard process to find useful abstractions of Moose features so easily. The documentation is right now a minimum, but if you getting into the flow, you will not need many documentation, cause the set of functions is very limited and clear.

## Main concepts supported by Moo and Moose

The main mission of those object layer is to deliver a base set of functionality to define classes which can be instantiated, so they implement *new* into your package. Simple said:

In lib/Person.pm:

    package Person;

    use Moo;

and then inside a .pl file:

    use Person;
    
    my $person = Person->new;
	
    print (ref $person); # 'Person'
	
In this case **ref** is used to get the "class name" of the object. More explaination about ref you can find [here](http://perldoc.perl.org/perlref.html)

But they also delivers more options, like an attribute layer, roles and aspect orientated programming functions.

Moose in addition also offers a type system and a meta layer.

### has

The command **has** is to define attributes on your object, is more or less the same in Moo or in Moose, but one huge difference is the definition of the type for the attribute. Moose supports a full type system, which also lets you define own types and auto coerce of one type into another. Moo doesn't define a type system, even tho offers options to coerce and check the data, just different. In the general usage, **has** defines an attribute which leads to the creating of a combined getter/setter (if not defined differently).

So you could make a lib/Person.pm like this:

    package Person;

    use Moo; # or use Moose;

    has name => (
      is => 'ro',    # read-only
      required => 1, # required attribute
    );

    has nick => (
      is => 'rw',    # read / write
    );
	
You can now use this package to instantiate objects of this class:

    use Person;

    my $friend = Person->new( name => 'Peter Parker', nick => 'Peter' );

    print $friend->name;                  # 'Peter Parker'
    print $friend->nick;                  # 'Peter'

    $friend->nick('Spiderman');
    print $friend->nick;                  # 'Spiderman'

    $friend->name('J. Jonah Jameson');    # will fail, cause name is read-only
    my $nameless_friend = Person->new;    # will fail, cause name is required

Both object layer also has **lazy** and **builder** as options for **has**:

    package Person;

    use Moo; # or use Moose;

    has name => (
      is => 'ro',
      lazy => 1,
      builder => '_build_name',
    );
	
    sub _build_name { 'John Doe' }

Lazy means, that the attribute is only set, when its requested. Its normally safe to set this option, cause it avoids unnecessary calls. So if you now instantiate a Person without name, he will be called John Doe.

    use Person;

    my $friend = Person->new;	
    my $friends_name = $friend->name;   # 'John Doe'

You could also define a default value via the **default** instead of giving a builder, but we encourage you to make a builder, cause its much easier to extend.

    has name => (
      is => 'ro',                       # read-only
      default => sub { 'John Doe' },    # Do not make default => 'John Doe'!!
    );

#### has in Moo

#### has in Moose

## Aspect orientated programming

### before / after

### around

## Roles

### with

### requires

## Meta layer (Moose only)

TODO

## Type system (Moose only)

TODO

## Thoughts about object orientated programming