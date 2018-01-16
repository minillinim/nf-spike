#!/usr/bin/env nextflow

infile = file(params.infile)

process run_manager {
  input:
    file 'input.txt' from infile
  output:
    stdout into manager_output

  '''
  /app/nf-spike manager input.txt
  '''
}

process run_worker {
  maxForks 4

  input:
    stdin _ from manager_output.splitText()
  output:
    stdout into worker_output

  '''
  /app/nf-spike worker
  '''
}

process run_final {
  input:
    stdin _ from worker_output
    output:
      stdout into reporter_output

  '''
  /app/nf-spike reporter
  '''
}

reporter_output.println { "$it" }
