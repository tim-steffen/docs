---
layout: default
nav_section: "install"
---

# Pulumi Release Notes

## 0.9.8 

### Pulumi Console and managed stacks

New in this release is the [Pulumi Console](https://beta.pulumi.com) and stacks that are managed by Pulumi. This is the recommended way to safely deploy cloud applications.
- `pulumi stack init` now creates a Pulumi managed stack. For a local stack, use `--local`. To learn more, see the tutorial [Create and work with managed stacks](../how-to/cloud-stack.html). 
- All Pulumi CLI commands now work with managed stacks. Login to Pulumi via `pulumi login`.
- The [Pulumi Console](https://beta.pulumi.com) provides a management experience for stacks. You can view the currently deployed resources (along with the AWS ARNs) and see logs from the last update operation.
For more information, see the documentation articles [Using the Pulumi Console](../how-to/console.html) and [Use Travis to continuously deploy Pulumi programs](../how-to/cicd-with-travis.html).

### Components and output properties

-  Support for component resources([pulumi #340](https://github.com/pulumi/pulumi/issues/340)), enabling grouping of resources into logical components. This provides an improved view of resources during `preview` and `update` operations in the CLI ([pulumi #417](https://github.com/pulumi/pulumi/issues/417)).
  ```
  + pulumi:pulumi:Stack: (create)
     [urn=urn:pulumi:donna-testing::url-shortener::pulumi:pulumi:Stack::url-shortener-donna-testing]
     + cloud:table:Table: (create)
        [urn=urn:pulumi:donna-testing::url-shortener::cloud:table:Table::urls]
        + aws:dynamodb/table:Table: (create)
              [urn=urn:pulumi:donna-testing::url-shortener::cloud:table:Table$aws:dynamodb/table:Table::urls]
  ```
- A stack can have *output properties*, defined as `export let varName = val`. You can view the last deployed value for the output property using `pulumi stack output varName` or in the Pulumi Console.

### Resource naming

Resource naming is now more consistent, but there is a new file format for checkpoint files for both local and managed stacks. 

> If you created stacks in the 0.8 release, you should destroy them with the 0.8 CLI, then recreate with the 0.9.x CLI.

### Support for configuration secrets
- Store secrets securely in configuration via `pulumi config set --secret`. chris
- The verbs for `config` are now consistent, via `get`, `set`, and `rm`. See [Consistent config verbs #552](https://github.com/pulumi/pulumi/issues/552).

### Logging

- [**experimental**] Support for the `pulumi logs` command ([pulumi #527](https://github.com/pulumi/pulumi/issues/527)). Unified logging is available in all of the `@pulumi/cloud` components ([pulumi-cloud #40](https://github.com/pulumi/pulumi-cloud/issues/40)). These features now work:
   - To see new logs as they arrive, use `--follow`
   - Use `--since` to limit to recent logs, such as `pulumi logs --since=1h`
   - Filter to specific resources with `--resource`. This filters to a particular component and its child resources (if any), such as `pulumi logs --resource examples-todoc57917fa --since 1h`

### Other features

- Support for `.pulumiignore`, for files that should not be uploaded when deploying a managed stack through Pulumi. [pulumi-service \#122](https://github.com/pulumi/pulumi-service/issues/122)
- [Allow overriding a `Pulumi.yaml`'s entrypoint #575](https://github.com/pulumi/pulumi/issues/575). To specify the entry directory, specify `main` in `Pulumi.yaml`. For instance, `main: a/path/to/main/`.
- Support for *protected* resources. A resource can be marked as `protect: true`, which prevents deletion of the resource. For example, `let res = new MyResource("precious", { .. }, { protect: true });`. To "unprotect" the resource, change `protect: false` then run `pulumi update`. See [Allow resources to be flagged "protected" #689](https://github.com/pulumi/pulumi/issues/689).
- Changed defaults for workspace and stack configuration. See [Workspace configuration is error prone #714](https://github.com/pulumi/pulumi/issues/714).
- Allow configuring the number of availability zones in auto-cluster via the setting `cloud-aws:config:ecsAutoClusterNumberOfAZs`. See [Provide config for auto-cluster's number of availability zones #300](https://github.com/pulumi/pulumi-cloud/issues/300).
- [Save configuration under the stack by default](https://github.com/pulumi/pulumi/issues/693).
- [Create an endpoint for downloading the Pulumi SDK via beta.pulumi.com #372](https://github.com/pulumi/pulumi-service/issues/372).

### Bug fixes
- Improved SDK installer. It automatically creates directories as needed, configures node modules, and prints out friendly error messages. ([pulumi-home #49](https://github.com/pulumi/home/issues/49), [pulumi-home #52](https://github.com/pulumi/home/issues/52), [pulumi-home #53](https://github.com/pulumi/home/issues/53), [pulumi-home #54](https://github.com/pulumi/home/issues/54), [pulumi-home #69](https://github.com/pulumi/home/issues/69))
- [Switch to use \`\-\-password\-stdin\` on Docker CLI \#152](https://github.com/pulumi/pulumi-cloud/issues/152)
- [Better diffing in CLI output, especially for Lambdas \#454](https://github.com/pulumi/pulumi/issues/454)
- [Aggregate container logs into shared pulumi\-app\-log\-collector \#93](https://github.com/pulumi/pulumi-cloud/issues/93)
- [Implement strong read consistency on cloud.Table #44](https://github.com/pulumi/pulumi-cloud/issues/44)
- [Improved error when Docker is not running #309](https://github.com/pulumi/pulumi-service/issues/309)
- Add an HTTP cache for GitHub API requests for a user's organization membership. See [Exhausting GitHub rate limiting requests on behalf of users #413](https://github.com/pulumi/pulumi-service/issues/413).
- [`main` does not set working dir correctly for Lambda zip #667](https://github.com/pulumi/pulumi/issues/667)
- [Better error when invalid access token is used in `pulumi login` #640](https://github.com/pulumi/pulumi/issues/640)
- [Eliminate the top-level Stack from all URNs #647](https://github.com/pulumi/pulumi/issues/647)
- [Improve performance of "cold" requests to PPC #368](https://github.com/pulumi/pulumi-service/issues/368)
- [Store user account credentials safely #112](https://github.com/pulumi/pulumi-ppc/issues/112)
- [Service API for Encrypting and Decrypting secrets #221](https://github.com/pulumi/pulumi-service/issues/221)
- [Make CLI resilient to network flakiness #763](https://github.com/pulumi/pulumi/issues/763)
- [Some PPC messages aren't colorized #152](https://github.com/pulumi/pulumi-ppc/issues/152)
- [Support --since and --resource on `pulumi logs` when targeting the service #431](https://github.com/pulumi/pulumi-service/issues/431)
- [Pulumi unable to serialize non-integers #694](https://github.com/pulumi/pulumi/issues/694)
- [Stop buffering CLI output #660](https://github.com/pulumi/pulumi/issues/660)