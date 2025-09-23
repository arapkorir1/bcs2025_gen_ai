import jaseci

# Load and run the Jac program
js = jaseci.Session()
js.load_program('trend_tracker.jac')
result = js.walker_run('init')
print(result)
