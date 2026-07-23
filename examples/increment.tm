# 1. Nach rechts laufen bis zum Ende der Zahl (Such-Phase)
q0 0 q0 0 R
q0 1 q0 1 R

# 2. Auf dem ersten Blank rechts anhalten und 1 Schritt zurück nach links gehen
q0 B q1 B L

# 3. Das Inkrementieren von rechts nach links durchführen (Übertrags-Phase)
# Eine 1 wird zu 0, und wir müssen weiter nach links laufen (Carry Bit)
q1 1 q1 0 L

# Eine 0 wird zu 1 - Fertig! Wir müssen keinen Übertrag mehr tragen.
q1 0 q2 1 N

# Ein Blank bedeutet: Die Zahl war nur 1en (z.B. 111). Wir schreiben eine 1 davor - Fertig!
q1 B q2 1 N
