# sky2-infra

Configuration management of ruby-sky2 server.

## Setup

```
bundle install
```

And make sure that `ssh ruby-sky2` succeeds.

## Local operations

### Prerequisites

```
envchain --set sudo SUDO_PASSWORD
```

### Dry-run

```
bin/apply -n
```

### Apply

```
bin/apply
```
