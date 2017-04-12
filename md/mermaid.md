# hello mermaid
use previm

REF: knsv.github.io/mermaid

---
**sequenceDiagram2**
```mermaid
sequenceDiagram
  participant a
  participant b

  a->b: connect

  loop connection
    a->>b: req
    b->>a: res
  end

  opt opt req
    a->>b: send
  end

  b->>a: state

  alt state ok
    loop connection
      a->>b: req
      b->>a: res
    end
  else state invalid
    a->>a: keep wait
    a->>b: try c4
    Note right of a: then return get state
  end
```

---
**subgraph**
```mermaid
graph TD
subgraph sub
  node
  subgraph slave
    slaveNode1
    slaveNode2
    slaveNode1-->slaveNode2
  end
end
subgraph sub
  node2
end

node2-->node
slaveNode1-->node2
```

---
**line and subgraph**
```mermaid
%% comment
graph LR
  a-->b
  b-.->c
  c-.say.->d
  d==>e
  e==say==>f
  f--say---g
  g---|say|h

subgraph NewGroup
  a-->b
  i-->j
end
```

---
**gantt**
```mermaid
gantt
  title Gantt

  section Section
  A task :a1, 2017-01-01, 5d
  Another task memo: after a1, 5d
  section Another
  task in sec :2017-01-02, 3d
  another task :1d
```

---
**node**
```mermaid
graph TB
  id1
  id2[same id1]
  id3(q)
  id4((qq))
  id5>check]
  id6{d}
```

---
**TB**
```mermaid
graph TB
  a-->b
```

**BT**
```mermaid
graph BT
  a-->b
```

**RL**
```mermaid
graph RL
  a-->b
```

**LR**
```mermaid
graph LR
  a-->b
  a-->c
  a-->e

  b-->c
  c-->f
  f-->a
```

---
**sequence**
```mermaid
sequenceDiagram
  participant Alice
  participant Bob
  Alice->John: goto John
  loop Healthcheck
    John->John: one more
  end
  Note right of John: hi
  John-->Alice: line of - - -
  John->Bob: to Bob
  Bob-->John: hit stop
```

---
**hello mermaid!**
```mermaid
%% comment
%% TD same TB(top to bottom)
graph TD;
  A-->B;
  A-->C;
  D-->D;
  C-->E;
```
