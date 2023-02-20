# git-group-cloner

**WIP**

`git-group-cloner` is a script for cloning all projects in a GitLab or GitHub group while preserving the subgroups structure or flattening it. The script provides a convenient way to manage and backup all your projects in a single group.

## Features

- Clone all projects in a GitLab or GitHub group.
- Preserve the subgroups structure or flatten it.
- Pass arguments to `git clone` to control the cloning process.
- Specify the destination directory for cloning projects.
- Parallel cloning (up to 4 times faster) using either `xargs` or `rargs`.
- Support for custom values for `GITLAB_BASE_URL` and `GITHUB_BASE_URL`.
- POSIX-compliant.

## Dependencies

- `jq`: a lightweight and flexible command-line JSON processor.
- `git`: a distributed version control system.
- `xargs` or `rargs` (optional): a tool for building and executing command lines from standard input.

## Getting Started

Before you can use `git-group-cloner`, you need to set the `TOKEN` environment variable. This variable is used to authenticate with the GitLab or GitHub API.

### Setting the TOKEN Environment Variable

To set the `TOKEN` environment variable, you can use the following command:

```sh
export TOKEN=<private_token>
```

Replace `<private_token>` with your private token or access token. You can obtain a private token or access token from the GitLab or GitHub website (see the [FAQ](#faq)).

### Cloning Projects

Once you have set the `TOKEN` environment variable, you can use `git-group-cloner` to clone projects. For more information on using `git-group-cloner`, see the [Usage](#usage) section.

## Usage

```sh
git-group-cloner [platform] [list|clone] [--flatten] [--git-args <git-arguments>] [--dest-dir <destination_directory>] [--threads <number_of_threads>] [--use-ssh]
```

### Options

- `platform`: the platform to use (`gitlab` or `github`).
- `list`: list the group IDs and names.
- `clone`: clone all projects in the group.
- `--flatten`: flatten the subgroups structure.
- `--git-args <git-arguments>`: pass arguments to `git clone`.
- `--dest-dir <destination_directory>`: specify the destination directory for cloning projects.
- `--threads <number_of_threads>`: specify the number of cloning threads (default: 4).
- `--use-ssh`: Switch the cloning method from the default HTTPS to SSH.

### Examples

#### List the group IDs and names on GitLab

```sh
git-group-cloner gitlab list
```

#### Clone all projects in a GitHub group

```sh
git-group-cloner github clone <group_id>
```

#### Clone all projects in a GitLab group and flatten the subgroups structure

```sh
git-group-cloner gitlab clone --flatten <group_id>
```

#### Clone all projects in a GitHub group and specify the destination directory

```sh
git-group-cloner github clone --dest-dir ~/projects <group_id>
```

#### Clone all projects in a GitLab group and pass arguments to git clone

```sh
git-group-cloner gitlab clone --git-args "--depth 1 --branch dev" <group_id>
```

#### Clone all projects in a GitHub group using 2 cloning threads

```sh
git-group-cloner github clone --threads 2 <group_id>
```

### Clone all projects in a self-hosted GitLab group

```sh
export GITLAB_BASE_URL=https://my-gitlab.com
git-group-cloner gitlab clone <group_id>
```

### Clone all projects in a GitHub Enterprise group

```sh
export GITHUB_BASE_URL=https://api.my-github-enterprise.com
git-group-cloner github clone <group_id>
```

## FAQ

### Why use git-group-cloner?

`git-group-cloner` provides a convenient way to clone all projects in a GitLab or GitHub group while preserving the subgroups structure or flattening it. It also allows you to pass arguments to `git clone` to control the cloning process and specify the destination directory for cloning projects. With `git-group-cloner`, you can easily manage and backup all your projects in a single group.

### What is the difference between gitlab and github platforms?

`gitlab` and `github` are different platforms that host Git repositories. `gitlab` is a GitLab instance, while `github` is a GitHub organization. `git-group-cloner` supports both platforms and allows you to clone all projects in a group on either platform.

### How do I get my private token for GitLab?

You can get your private token from your GitLab account settings. Go to your profile settings, then access the "Access Tokens" section, and create a new token with the desired scope.

### How do I get my access token for GitHub?

You can get your access token from your GitHub account settings. Go to your settings, then access the "Developer settings", and click on "Personal access tokens". Create a new token with the desired scope.

### How do I get `jq`?

`jq` is a command-line JSON processor. You can download it from the [jq website](https://stedolan.github.io/jq/). On Linux, you can also install it using your package manager, for example:

```sh
sudo apt install jq
```

### What is `rargs` and how do I install it?

[`rargs`](https://github.com/lotabout/rargs) is a tool written in Rust for parallelizing the execution of shell commands.

`git-group-cloner` uses `rargs` to parallelize the cloning of projects, which can significantly speed up the cloning process.

If `rargs` is not found, `git-group-cloner` will fallback to using `xargs` or cloning one by one, depending on the availability of `xargs`.

See the `rargs` [README](https://github.com/lotabout/rargs/blob/master/README.md) for installation instructions.

### How do I clone all projects in a group?

To clone all projects in a group, you need to specify the platform (`gitlab` or `github`) and the group ID or group name. You can also specify the subgroups structure (flatten or preserve), pass arguments to `git clone`, specify the destination directory for cloning projects, and specify the number of cloning threads.

For example, to clone all projects in a GitLab group, you can use the following command:

```sh
git-group-cloner gitlab clone <group_id>
```

### How do I preserve the subgroups structure?

To preserve the subgroups structure, you don't need to do anything special. The default behavior of `git-group-cloner` is to preserve the subgroups structure.

For example, to clone all projects in a GitLab group and preserve the subgroups structure, you can use the following command:

```sh
git-group-cloner gitlab clone <group_id>
```

### How do I flatten the subgroups structure?

To flatten the subgroups structure, you need to specify the `--flatten` option.

For example, to clone all projects in a GitLab group and flatten the subgroups structure, you can use the following command:

```sh
git-group-cloner gitlab clone --flatten <group_id>
```

### How do I specify the destination directory for cloning projects?

To specify the destination directory for cloning projects, you need to use the `--dest-dir <destination_directory>` option.

For example, to clone all projects in a GitLab group and specify the destination directory, you can use the following command:

```sh
git-group-cloner gitlab clone --dest-dir ~/projects <group_id>
```

### How do I pass arguments to git clone?

To pass arguments to `git clone`, you need to use the `--git-args <git-arguments>` option.

For example, to clone all projects in a GitLab group and pass arguments to `git clone`, you can use the following command:

```sh
git-group-cloner gitlab clone --git-args "--depth 1 --branch dev" <group_id>
```

### How do I specify the number of cloning threads?

To specify the number of cloning threads, you need to use the `--threads <number_of_threads>` option. By default, `git-group-cloner` uses 4 cloning threads.

For example, to clone all projects in a GitLab group and specify 2 cloning threads, you can use the following command:

```sh
git-group-cloner gitlab clone --threads 2 <group_id>
```

### How do I use custom values for GITLAB_BASE_URL and GITHUB_BASE_URL?

To use custom values for `GITLAB_BASE_URL` and `GITHUB_BASE_URL`, you need to set the environment variables `GITLAB_BASE_URL` and `GITHUB_BASE_URL` before running `git-group-cloner`.

For example:

```sh
export GITLAB_BASE_URL=https://my-gitlab.com/api/v4/groups
git-group-cloner gitlab clone <group_id>
```

or:
```sh
env GITHUB_BASE_URL=https://api.my-github.com/orgs git-group-cloner github clone <group_id>
```

This allows you to use custom instances of GitLab and GitHub, rather than the default instances at `https://gitlab.com` and `https://github.com`, respectively.

## Contributing

If you find a bug or have an idea for a new feature, feel free to open an issue or submit a pull request. We welcome all contributions to `git-group-cloner`!

## License

`git-group-cloner` is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.