# sky2-infra

Configuration management of ruby-sky2 server.

## Setup

```
bundle install
```

And make sure that `ssh ruby-sky2` succeeds.

Note: Currently this repository assumes the ssh user is "k0kubun".

## Dry-run

```
bin/hocho-apply -n
```

## Apply

```
bin/hocho-apply
```
