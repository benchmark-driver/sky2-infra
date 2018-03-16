# sky2-infra

Configuration management of ruby-sky2 server.

## Setup

```
bundle install
```

And make sure that `ssh ruby-sky2` succeeds.

Note: Currently this repository assumes the ssh user is "k0kubun".

## Local operations

### Dry-run

```
bin/apply -n
```

### Apply

```
bin/apply
```

## Server operations

### Install Ruby revisions

```
git -C ~/ruby pull origin trunk
ruby-builder revision r62448..r62573 -d ~/ruby
```
