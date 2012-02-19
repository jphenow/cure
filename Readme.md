## The cure

I don't know about you, but I'm tired of some of the cURL bullshit for testing
some API changes of an app. Say you have an API that limits users based on roles.
Once you're testing that your API does, in fact limit users corretly you're writing
gross, long `curl` commands or keeping a list of scripts that all basically do the
same thing.

Well here's an attempt to answer this. For now some environment variables will handle
your username/password, but the end goal is to allow easy multi-user management.

tl;dr trying to make `curl`s quicker and easier, with manageable sessions
