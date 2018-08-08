workspace(name = "bazel_generated_node_modules_issue")

# TypeScript rules depend on running Node.js.
http_archive(
    name = "build_bazel_rules_nodejs",
    urls = ["https://github.com/bazelbuild/rules_nodejs/archive/0.11.3.zip"],
    strip_prefix = "rules_nodejs-0.11.3",
    sha256 = "e8842fa5f5e38f2c826167ff94323d4b5aabd13217cee867d971d6f860cfd730"
)

# build_bazel_rules_nodejs depends on skylib
http_archive(
    name = "bazel_skylib",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/0.3.1.zip"],
    strip_prefix = "bazel-skylib-0.3.1",
    sha256 = "95518adafc9a2b656667bbf517a952e54ce7f350779d0dd95133db4eb5c27fb1",
)

# ts_web_test depends on the web testing rules to provision browsers.
http_archive(
    name = "io_bazel_rules_webtesting",
    urls = ["https://github.com/bazelbuild/rules_webtesting/archive/0.2.1.zip"],
    strip_prefix = "rules_webtesting-0.2.1",
    sha256 = "7d490aadff9b5262e5251fa69427ab2ffd1548422467cb9f9e1d110e2c36f0fa",
)

# ts_devserver depends on the Go rules.
# See https://github.com/bazelbuild/rules_go#setup for the latest version.
http_archive(
    name = "io_bazel_rules_go",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.13.0/rules_go-0.13.0.tar.gz"],
    sha256 = "ba79c532ac400cefd1859cbc8a9829346aa69e3b99482cd5a54432092cbc3933",
)

# go_repository is defined in bazel_gazelle
http_archive(
    name = "bazel_gazelle",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.13.0/bazel-gazelle-0.13.0.tar.gz"],
    sha256 = "bc653d3e058964a5a26dcad02b6c72d7d63e6bb88d94704990b908a1445b8758",
)

# Include @bazel/typescript in package.json#devDependencies
local_repository(
    name = "build_bazel_rules_typescript",
    path = "node_modules/@bazel/typescript",
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")

# Point to the package.json file so Bazel can run the package manager for you.
node_repositories(package_json = ["//:package.json"])

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()
go_register_toolchains()

load("@io_bazel_rules_webtesting//web:repositories.bzl", "browser_repositories", "web_test_repositories")

web_test_repositories()
browser_repositories(
    chromium = True,
)

load("@build_bazel_rules_typescript//:defs.bzl", "ts_setup_workspace")

ts_setup_workspace()

load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

yarn_install(
    name = "foo_deps",
    package_json = "//foo_deps:package.json",
    yarn_lock = "//foo_deps:yarn.lock",
)
