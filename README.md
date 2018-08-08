# bazel-generated-node-modules-issue
Minimal example of bazel rules_typescript not working with a generated node_modules folder.

```
bazel run @nodejs//:yarn
bazel build //foo
```
