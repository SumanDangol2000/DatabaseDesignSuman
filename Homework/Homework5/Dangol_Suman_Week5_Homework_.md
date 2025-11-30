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

**Explanation:** Selection (σ) filters rows. Here it returns only the record where `studentName = 'Suman'`.  

**Result:**  
| student_id | studentName | favoriteNumber | randomParagraph |  
|------------|-------------|----------------|-----------------|  
| S002       | Suman       | 7              | Mountains rise majestically against the horizon while eagles soar through endless skies. |

---

### Query 2: Extract 3rd Word  
**Expression:**  
πWORD(randomParagraph, 3)(σstudentName='Suman'(StudentData))  

**Explanation:** First select Suman’s record, then project (π) the 3rd word from `randomParagraph`.  

**Result:**  
| studentName | 3rd Word     |  
|-------------|--------------|  
| Suman       | majestically |

---

### Query 3: Extract 7th Word  
**Expression:**  
πWORD(randomParagraph, 7)(σstudentName='Suman'(StudentData))  

**Explanation:** First select Suman’s record, then project the 7th word from `randomParagraph`.  

**Result:**  
| studentName | 7th Word   |  
|-------------|------------|  
| Suman       | while  |

---

### Query 4: Students with favoriteNumber > mine  
**Expression:**  
σfavoriteNumber > 7(StudentData)  

**Explanation:** Selects all students whose `favoriteNumber` is greater than 7.  

**Result (sample):**  
| student_id | studentName    | favoriteNumber |  
|------------|----------------|----------------|  
| S006       | Emma Watson    | 31             |  
| S007       | Michael Chen   | 99             |  
| S008       | Sarah Johnson  | 14             |  
| S009       | David Martinez | 67             |  

---

### Query 5: Students with favoriteNumber < mine  
**Expression:**  
σfavoriteNumber < 7(StudentData)  

**Explanation:** Selects all students whose `favoriteNumber` is less than 7.  

**Result:**  
| student_id | studentName   | favoriteNumber |  
|------------|---------------|----------------|  
| S067       | Peter Howard  | 2              |  
| S081       | Carl Barnes   | 1              |  

---

### Query 6: Same 3rd Word in randomParagraph  
**Expression:**  
σrandomParagraph CONTAINS 'majestically'(StudentData)  

**Explanation:** Selects students whose `randomParagraph` contains the word “majestically”.  

**Result:**  
| student_id | studentName | favoriteNumber | randomParagraph |  
|------------|-------------|----------------|-----------------|  
| S002       | Suman       | 7              | Mountains rise majestically against the horizon while eagles soar through endless skies. |

---

### Query 7: FavoriteNumber between 20 and 50  
**Expression:**  
πstudentName, favoriteNumber(σ20 ≤ favoriteNumber ≤ 50(StudentData))  

**Explanation:** Selects students with `favoriteNumber` between 20 and 50, then projects only `studentName` and `favoriteNumber`.  

**Result (sample):**  
| studentName     | favoriteNumber |  
|-----------------|----------------|  
| Jennifer Lee    | 45             |  
| Elizabeth Perez | 26             |  
| Joseph Harris   | 41             |  

---

### Query 8: Find favoriteNumber using student_id  
**Expression:**  
πfavoriteNumber(σstudent_id = 'S002'(StudentData))  

**Explanation:** Selects the record where `student_id = 'S002'` and projects only `favoriteNumber`.  

**Result:**  
| student_id | favoriteNumber |  
|------------|----------------|  
| S002       | 7              |

---

## Part 2: Set Operations and Multi-Record Comparisons

### Query 9: Union of two groups  
**Expression:**  
σfavoriteNumber > 50(StudentData) ∪ σfavoriteNumber < 10(StudentData)  

**Explanation:** Combines students with `favoriteNumber > 50` and those with `favoriteNumber < 10` using union (∪).  

**Result (sample):**  
| student_id | studentName   | favoriteNumber |  
|------------|---------------|----------------|  
| S007       | Michael Chen  | 99             |  
| S009       | David Martinez| 67             |  
| S011       | James Wilson  | 56             |  
| S040       | Sandra Adams  | 9              |  
| S067       | Peter Howard  | 2              |  
| S081       | Carl Barnes   | 1              |  

---

### Query 10: Set Difference  
**Expression:**  
StudentData − σ20 ≤ favoriteNumber ≤ 80(StudentData)  

**Explanation:** Returns all students except those with `favoriteNumber` between 20 and 80.  

**Result (sample):**  
| student_id | studentName     | favoriteNumber |  
|------------|----------------|----------------|  
| S002       | Suman          | 7              |  
| S007       | Michael Chen   | 99             |  
| S081       | Carl Barnes    | 1              |  
| S100       | Teresa Griffin | 7              |  

---

### Query 11: Intersection  
**Expression:**  
σfavoriteNumber > 30(StudentData) ∩ σfavoriteNumber < 70(StudentData)  

**Explanation:** Intersection (∩) returns students whose `favoriteNumber` is both greater than 30 and less than 70.  

**Result (sample):**  
| student_id | studentName     | favoriteNumber |  
|------------|----------------|----------------|  
| S006       | Emma Watson    | 31             |  
| S009       | David Martinez | 67             |  
| S011       | James Wilson   | 56             |  
| S027       | Joseph Harris  | 41             |  
| S028       | Jessica Clark  | 64             |  

---

### Query 12: Complex Projection (Even Numbers)  
**Expression:**  
πstudent_id, studentName(σfavoriteNumber % 2 = 0(StudentData))  

**Explanation:** Selects students with even `favoriteNumber` values, then projects only `student_id` and `studentName`.  

**Result (sample):**  
| student_id | studentName     |  
|------------|----------------|  
| S008       | Sarah Johnson  |  
| S011       | James Wilson   |  
| S022       | Elizabeth Perez|  
| S028       | Jessica Clark  |  
| S001       | Geethika       |  

---

### Query 13: Multi-condition Selection  
**Expression:**  
σ(favoriteNumber = 7) AND (studentName ≠ 'Suman')(StudentData)  

**Explanation:** Selects students whose `favoriteNumber = 7` but excludes Suman.  

**Result:**  
| student_id | studentName     | favoriteNumber | randomParagraph |  
|------------|----------------|----------------|-----------------|  
| S100       | Teresa Griffin | 7              | Nanotechnology manipulates matter at atomic scale creating materials with novel properties. |

---

### Query 14: Comprehensive Query (Count)  
**Expression:**  
COUNT(σ(favoriteNumber ≥ -3) AND (favoriteNumber ≤ 17)(StudentData))  

**Explanation:** Selects students whose `favoriteNumber` lies between −3 and 17, then counts them.  

**Result:**  
| Range   | Count |  
|---------|-------|  
| −3 to 17 | 17 students |

---
