def _impl(ctx):
  files = []
  for f in ctx.files.node_modules:
    # NOTE: this prefix should actually be calculated correctly
    # but it's sufficient to demonstrate the problem
    prefix = "external/foo_deps" 
    dest_path = f.path[len(prefix) + 1:]
    dest_file = ctx.actions.declare_file(dest_path)
    files += [dest_file]
    ctx.actions.run_shell(
      inputs = [f],
      outputs = [dest_file],
      command = "cp %s %s" % (f.path, dest_file.path)
    )

  return [
    DefaultInfo(files = depset(files)),
  ] 

generated_node_modules = rule(
  _impl,
  attrs = {
    "node_modules": attr.label(
      doc = "Folder with existing node_modules.",
    ),
  },
)
