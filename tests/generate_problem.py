from pathlib import Path
DATA={'expected.json': '{\n  "x": [\n    1,\n    2\n  ],\n  "objective": -9,\n  "solution_tolerance": 0.0001,\n  "residual_tolerance": 1e-06\n}', 'tiny_qp.qps': 'NAME          TINYQP\nROWS\n N  COST\n E  EQ1\nCOLUMNS\n    X1        COST     -2             EQ1       1\n    X2        COST     -8             EQ1       1\nRHS\n    RHS1      EQ1       3\nBOUNDS\n LO BND1      X1        0\n LO BND1      X2        0\nQUADOBJ\n    X1        X1        2\n    X2        X2        4\nENDATA\n'}
root=Path(__file__).resolve().parents[1]/"examples"
root.mkdir(exist_ok=True)
for name,text in DATA.items(): (root/name).write_text(text,encoding="utf-8")
print("Generated analytical problems in",root)
