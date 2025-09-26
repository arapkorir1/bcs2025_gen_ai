# Guess from 1 to 10 game 

Overview: Evolving a guess then number game from Python to Jac, introducing key concepts like objects, walkers, graphs, and AI integration.
Code is courtesy of https://www.jac-lang.org/learn/jac_in_a_flash/

### Steps Implemented

* **Step 0:** Python baseline (`step0.py`)
* **Step 1:** Jac translation (`step1.jac`)
* **Step 2:** Added `has` field declarations (`step2.jac`)
* **Step 3:** Separated implementation using `impl` (`step3.jac`)
* **Step 4:** Refactored to Object-Spatial Programming (Graphs) using `walker` and `node` (`step4.jac`)
* **Step 5:** Scale-Agnostic Setup (Running as a server):
    * To run as a local server: `jac serve step5.jac`. Access at `http://127.0.0.1:8000`.
    * For cloud: `jac cloud deploy step5.jac` (requires Jaseci cloud setup).
* **Step 6:** AI integration for dynamic hints using `byLLM` (`step6.jac`).

### How to Run

1.  Ensure you have `jaclang` installed. For Step 6, install with `pip install jaclang[byllm]`.
2.  Navigate to the `/week1/jac_in_a_flash/` folder.
3.  Execute any `.jac` file using: `jac run <file_name>.jac`
4.  Execute the first python file with `python3 <file_name>.py`