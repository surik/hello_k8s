~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()


environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"?ZomzSW2Kh&{tz,@;lHe|qz,fb!1RMC&uGuGip~ZUo8eT.%J9G?.F`!amS:_ljRc"
end

environment :prod do
  set include_erts: false
  set include_src: false
  set cookie: :").7l,0KO7[cO&Mg;O%HCUW7godgG_^0FmDa3>TeCVtf5PmUk[QXdpFf9{c*1@wW8"
  set vm_args: "rel/vm.args"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :hello_k8s do
  set version: current_version(:hello_k8s)
  set applications: [
    :runtime_tools
  ]
  set commands: [
    migrate: "rel/commands/migrate"
  ]
end

