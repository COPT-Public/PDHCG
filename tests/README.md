# Installation and checker tests

Run `bash build.sh` after following INSTALL. All tests use bundled small models
with analytic solutions and return process exit 0 only if accepted.

tiny_qp.qps: x=(1,2), objective -9. Independent equality/nonnegativity
residual <=1e-6, objective error <=1e-4, coordinate error <=1e-4,
reported absolute dual residual <=1e-6 and OPTIMAL termination.

`run.py` uses NumPy to independently recompute the specified feasibility and
objective conditions from returned solution data. Every invocation creates a
new run-* output folder. The parent verification.json is reset before execution
and replaced with the result; no earlier solution is read. Missing output,
timeout, nonzero process exit, nonfinite values or failed checks cause failure.
The run folder contains command.json, solver.log and raw solver outputs.

`python3 tests/check_checker.py --project PDHCG` verifies two failure paths:
old correct results plus a no-op process must fail; newly generated incorrect
solutions must also fail. The real build.sh solve is the positive control.

To add a case:
1. Add a small model with an analytic expected answer to examples/ and describe
   its mathematics/expected answer in examples/README.md.
2. Extend generate_problem.py if the model is generated. In run.py add an explicit
   --case choice and the corresponding model, expected optimum and residual checks.
3. Add its command to build.sh (and add_test in the relevant CMakeLists if using
   CTest). Use the installed executable/consumer where applicable.
4. Confirm a real solve passes and deliberately bad output fails; record tolerances.

These tests do not benchmark performance or validate optional language interfaces.

## Continuous integration

The Installation checks workflow runs the two checker regressions on hosted
Ubuntu for pushes and pull requests. This CPU job tests the verifier's failure
detection; it does not compile or run the CUDA solver. The positive control is
the real installed-GPU-executable run performed by build.sh.

Maintainers can manually dispatch the same workflow with run_gpu=true on an
existing self-hosted Linux x64 runner labelled nvidia-gpu. That runner needs the
dependencies in INSTALL and Actions Runner >=2.327.1 for the Node.js 24 actions.
GPU execution is opt-in and is not required for the
hosted CPU job. GPU validation evidence is recorded separately in VALIDATION.md.
The original upstream test/ and tests/test_*.py suites are retained; they are
outside this small installation check's validated scope.
