" Jezyki Programowania - Projekt II - Smalltalk
Autorzy:
    Ostap Lozovyy
    Michał Matysiak 
    Mateusz Dobry "

Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa okrag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'
!


!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"
	nazwa := nowaNazwa.
	wierzcholki := Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.
	okrag := nil.
!!

!Wielokat methodsFor: 'accessing'!

nazwa
	"podaje nazwe wielokata"
	^nazwa.
!

nazwa: nowa_nazwa
	"ustawia nowa nazwe wielokata"
	nazwa := nowa_nazwa.
!!

!Wielokat methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"
	^ self subclassResponsibility.
!!

!Wielokat methodsFor: 'modifiers'!
    
wysrodkuj
    "Ustawia srodek wielokąta na srodek ukladu wspolrzednych, jeśli jest to możliwe"
    ^ self subclassResponsibility.
!!

!Wielokat methodsFor: 'actions'!
    
wpiszOkrag
    "Tworzy okrąg wpisany w wielokąt, jeśli jest to możliwe"
    ^ self subclassResponsibility.
!

pole
    "liczy pole wielokatu"
    ^ self subclassResponsibility.
!!
	
!Wielokat methodsFor: 'printing'!

drukuj
    "wypisuje nazwe, wierzcholki, pola wielokata i okregu wpisanego (jesli istnieje)"
    
    Transcript show: 'Nazwa: ', nazwa; cr.
    Transcript show: 'Wierzcholki: '; cr.
    wierzcholki do: [ :w | Transcript show:  '[', (w x roundTo: 0.01) printString, ', ', (w y roundTo: 0.01) printString, ']'; cr ].
    Transcript show: 'Pole: ', (self pole roundTo: 0.01) printString; cr.
    
    okrag ifNotNil: [
        okrag drukuj.
    ].

!!
    


Wielokat subclass: #Kwadrat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'
!


!Kwadrat methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"
	| p |

	p := self pole + figura pole.
	^(Kwadrat new) initialize: p sqrt.
!!

!Kwadrat methodsFor: 'modifiers'!
    
wysrodkuj
    "ustawia srodek figury na srodek ukladu wspolrzednych"
    | dx dy |

    dx := ((wierzcholki at: 2) x + (wierzcholki at: 1) x) / 2.0.
    dy := ((wierzcholki at: 4) y + (wierzcholki at: 1) y) / 2.0.

    1 to: wierzcholki size do: [ :index | 
        | w nowyPunkt |
		w := wierzcholki at: index.
        nowyPunkt := (w x - dx)@(w y - dy).
		wierzcholki at: index put: nowyPunkt.
    ].
    okrag ifNotNil: [
        okrag srodek: 0@0.
    ].

	self drukuj.
!!

!Kwadrat methodsFor: 'actions'!

wpiszOkrag
    "wpisuje okrag do kwadratu"
    | srodekPolowy promien |
    srodekPolowy := ((wierzcholki at: 1) + (wierzcholki at: 3)) / 2.0.
    promien := ((wierzcholki at: 2) x - (wierzcholki at: 1) x) / 2.0.

    okrag ifNil: [
        okrag := Okrag new initialize: promien srodek: srodekPolowy.
        Transcript show: 'BENG'; cr.
    ].
    ^okrag.
!

pole
	"licz pole kwadratu"
	| bok |
	bok := (wierzcholki at: 2) x - (wierzcholki at: 1) x.

	^bok squared.
!!

!Kwadrat methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 4 name: 'Kwadrat'.
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: bok@bok.
	wierzcholki at: 4 put: 0@bok.
!!
	
	

Wielokat subclass: #SzesciokatForemny
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'JezykiProgramowania'
!
    
    
!SzesciokatForemny methodsFor: 'arithmetic'!

+ figura
    "dodaj 2 figury w sensie pola"
    | p |
    
    p := self pole + figura pole.
    ^(SzesciokatForemny new) initialize: (2*p / ((3 sqrt)*3)) sqrt.
!!
    
!SzesciokatForemny methodsFor: 'modifiers'!
    
wysrodkuj
    "ustawia srodek figury na srodek ukladu wspolrzednych"
    | dx dy |

    dx := ((wierzcholki at: 4) x + (wierzcholki at: 1) x) / 2.0.
    dy := ((wierzcholki at: 4) y + (wierzcholki at: 1) y) / 2.0.
    1 to: wierzcholki size do: [ :index | 
        | w nowyPunkt |
		w := wierzcholki at: index.
        nowyPunkt := ((w x) - dx)@((w y) - dy).
		wierzcholki at: index put: nowyPunkt.
    ].
    okrag ifNotNil: [
        okrag srodek: 0@0.
    ].
    
    self drukuj.
!!
    
!SzesciokatForemny methodsFor: 'actions'!

wpiszOkrag
    "wpisuje okrag do szesciokata foremnego"
    | srodekPolowy promien |
    
    srodekPolowy := ((wierzcholki at: 1) + (wierzcholki at: 4)) / 2.0.
    promien := ((wierzcholki at: 3) x - (wierzcholki at: 1) x) / 2.0.
    
    okrag ifNil: [
        okrag := Okrag new initialize: promien srodek: srodekPolowy.
        Transcript show: 'BENG'; cr.
    ].
    ^okrag. 
!

pole
    "licz pole szesciokata foremnego"
    | bok |

	bok := (wierzcholki at: 6) y - (wierzcholki at: 1) y.
    ^ 3*(bok squared)*(3 sqrt) / 2.
!!
    
!SzesciokatForemny methodsFor: 'initialize-release'!

initialize: bok
    "tworz szesciokat foremny o podanym boku"
    
    super initialize: 6 name: 'SzesciokatForemny'.
    wierzcholki at: 2 put: ((3 sqrt) / 2 * bok)@((-1) * bok / 2.0).
    wierzcholki at: 3 put: ((3 sqrt) * bok)@0.
    wierzcholki at: 4 put: ((3 sqrt) * bok)@bok.
    wierzcholki at: 5 put: ((3 sqrt) / 2 * bok)@(bok * 1.5).
    wierzcholki at: 6 put: 0@bok.
!!
    


Object subclass: #Okrag
    instanceVariableNames: 'promien srodek'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'JezykiProgramowania'
!


!Okrag methodsFor: 'initialize-release'!

initialize: promienWartosc srodek: srodekPunkt
    "Konstruktor obiektu - okregu z promieniem i srodkiem"
    promien := promienWartosc.
    srodek := srodekPunkt.
!!

!Okrag methodsFor: 'accessing'!

promien
    "podaje promien okregu"
    ^promien
!

promien: nowy_promien
    "ustawia nowy promien okregu"
    promien := nowy_promien
!

srodek
    "podaje srodek okregu"
    ^srodek
!

srodek: nowy_srodek
    "ustawia nowy srodek okregu"
    srodek := nowy_srodek
!!

!Okrag methodsFor: 'printing'!

drukuj
    "wypisuje nazwe, srodek i promien okregu"
    Transcript show: 'Okrag: '; cr.
    Transcript show: 'Srodek: [', (srodek x roundTo: 0.01) printString, ', ', (srodek y roundTo: 0.01) printString, ']'; cr.
    Transcript show: 'Promien: ', (promien roundTo: 0.01) printString; cr.
!!

    
    
    
" test "
x := Kwadrat new initialize: 4.
x wpiszOkrag.
x drukuj. 
x wysrodkuj.

y := SzesciokatForemny new initialize: 3.
y wpiszOkrag.
y drukuj.
y wysrodkuj.
