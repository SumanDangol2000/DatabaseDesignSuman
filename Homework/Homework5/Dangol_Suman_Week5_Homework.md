# Week 5 Homework: Personalized Relational Algebra (with Results)

- **Student:** Suman  
- **Student ID:** S002  
- **Favorite Number:** 7  

## My Data Record

- **student_id:** S002  
- **studentName:** Suman  
- **favoriteNumber:** 7  
- **randomParagraph:** Mountains rise majestically against the horizon while eagles soar through endless skies.  

---

## Part 1: Word Extraction Queries

### Query 1: Find My Record
**Expression:**  
σstudentName = 'Suman'(StudentData)

**Result:**

| student_id | studentName | favoriteNumber | randomParagraph |
|------------|-------------|----------------|-----------------|
| S002       | Suman       | 7              | Mountains rise majestically against the horizon while eagles soar through endless skies. |

---

### Query 2: Extract 3rd Word
**My 3rd word:** majestically  

**Expression:**  
πWORD(randomParagraph, 3)(σstudentName='Suman'(StudentData))

**Result:**

| studentName | 3rd Word     |
|-------------|--------------|
| Suman       | majestically |

---

### Query 3: Extract 7th Word
**My 7th word:** inspiring  

**Expression:**  
πWORD(randomParagraph, 7)(σstudentName='Suman'(StudentData))

**Result:**

| studentName | 7th Word   |
|-------------|------------|
| Suman       | inspiring  |

---

### Query 4: Find all students whose favoriteNumber is greater than mine
**Expression:**  
σfavoriteNumber > 7(StudentData)

**Result (sample):**

| student_id | studentName       | favoriteNumber |
|------------|------------------|----------------|
| S006       | Emma Watson      | 31             |
| S007       | Michael Chen     | 99             |
| S008       | Sarah Johnson    | 14             |
| S009       | David Martinez   | 67             |
| …          | …                | …              |

---

### Query 5: Find all students whose favoriteNumber is less than mine
**Expression:**  
σfavoriteNumber < 7(StudentData)

**Result:**

| student_id | studentName     | favoriteNumber |
|------------|----------------|----------------|
| S067       | Peter Howard   | 2              |
| S081       | Carl Barnes    | 1              |
| …          | …              | …              |

---

### Query 6: Find students whose randomParagraph contains the same 3rd word as mine
**My 3rd word:** majestically  

**Expression:**  
σrandomParagraph CONTAINS 'majestically'(StudentData)

**Result:**

| student_id | studentName | favoriteNumber | randomParagraph |
|------------|-------------|----------------|-----------------|
| S002       | Suman       | 7              | Mountains rise majestically against the horizon while eagles soar through endless skies. |

---

### Query 7: Project only studentName and favoriteNumber for students with favoriteNumber between 20 and 50
**Expression:**  
πstudentName, favoriteNumber(σ20 ≤ favoriteNumber ≤ 50(StudentData))

**Result (sample):**

| studentName       | favoriteNumber |
|-------------------|----------------|
| Jennifer Lee      | 45             |
| Elizabeth Perez   | 26             |
| Joseph Harris     | 41             |
| …                 | …              |

---

### Query 8: Find my favoriteNumber using only my student_id
**Expression:**  
πfavoriteNumber(σstudent_id = 'S002'(StudentData))

**Result:**

| student_id | favoriteNumber |
|------------|----------------|
| S002       | 7              |

---

## Part 2: Set Operations and Multi-Record Comparisons

### Query 9: Union of two groups
**Goal:** Find all students where favoriteNumber > 50 OR favoriteNumber < 10  

**Expression:**  
σfavoriteNumber > 50(StudentData) ∪ σfavoriteNumber < 10(StudentData)

**Result (sample):**

| student_id | studentName     | favoriteNumber |
|------------|----------------|----------------|
| S007       | Michael Chen   | 99             |
| S009       | David Martinez | 67             |
| S011       | James Wilson   | 56             |
| S040       | Sandra Adams   | 9              |
| S067       | Peter Howard   | 2              |
| S081       | Carl Barnes    | 1              |

---

### Query 10: Set Difference
**Goal:** Find all students EXCEPT those with favoriteNumber between 20 and 80  

**Expression:**  
StudentData − σ20 ≤ favoriteNumber ≤ 80(StudentData)

**Result (sample):**

| student_id | studentName     | favoriteNumber |
|------------|----------------|----------------|
| S002       | Suman          | 7              |
| S007       | Michael Chen   | 99             |
| S081       | Carl Barnes    | 1              |
| S100       | Teresa Griffin | 7              |

---

### Query 11: Intersection
**Goal:** Find students whose favoriteNumber is BOTH > 30 AND < 70  

**Expression:**  
σfavoriteNumber > 30(StudentData) ∩ σfavoriteNumber < 70(StudentData)

**Result (sample):**

| student_id | studentName     | favoriteNumber |
|------------|----------------|----------------|
| S006       | Emma Watson    | 31             |
| S009       | David Martinez | 67             |
| S011       | James Wilson   | 56             |
| S027       | Joseph Harris  | 41             |
| S028       | Jessica Clark  | 64             |

---

### Query 12: Complex Projection
**Goal:** Show student_id and studentName for students with even favoriteNumbers  

**Expression:**  
πstudent_id, studentName(σfavoriteNumber % 2 = 0(StudentData))

**Result (sample):**

| student_id | studentName     |
|------------|----------------|
| S008       | Sarah Johnson  |
| S011       | James Wilson   |
| S022       | Elizabeth Perez  |
| S028       | Jessica Clark  |
| S001       | Geethika    |

---

### Query 13: Multi-condition Selection
**Goal:** Find students whose favoriteNumber = 7 AND studentName ≠ 'Suman'  

**Expression:**  
σ(favoriteNumber = 7) AND (studentName ≠ 'Suman')(StudentData)

**Result:**

| student_id | studentName     | favoriteNumber | randomParagraph |
|------------|----------------|----------------|-----------------|
| S100       | Teresa Griffin | 7              | Nanotechnology manipulates matter at atomic scale creating materials with novel properties. |

---

### Query 14: Comprehensive Query
**Goal:** Count students whose favoriteNumber is within ±10 of mine (−3 to 17)  

**Expression:**  
COUNT(σ(favoriteNumber ≥ -3) AND (favoriteNumber ≤ 17)(StudentData))

**Result:**

| Range   | Count |
|---------|-------|
| −3 to 17 | 17 students |

---