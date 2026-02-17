{-
### I need to read the paper 3.3 parts later

5 → 9 Pages

Function Types

A,B : Set -- Set = Type
A → B : Set

products and sums

A × B : Set
A + B : Set
A ⊎ B : Set -- disjoint union

Don't have A ∪ B : Set neither A ∩ B : Set
These are evil operations, because they depend on elemends 

-}

record _×_ (A B : Set) : Set where
  field
    proj₁ : A
    proj₂ : B

open _×_
-- C-c C-d derive type

variable
  A B C : Set

{-
_,_ : A → B → A × B
(a , b) .proj₁ = {!a!} --coppatern matching
(a , b) .proj₂ = {!b!}

-- #### Agda make case C-c C-c
 copattern matching
to define an element of a record, you
need to say what are its projections.-}

{- I need A × B to have C-
should i derive this to lambda idk
λ f a b = f λ a () ?
λ f a b = λ f ?
λ f a b = λ f a b ?
λ f a b = λ f (a b) → "C"

-}
curry : (A × B → C) → (A → B → C)
curry f a b = f (record { proj₁ = a ; proj₂ = b })

{-C-c C-, to show goal and context
*quick notes: g : A → B → C & x A × B -- the goals is to reach C 
-}
uncurry : (A → B → C) → (A × B → C)
uncurry g x = g (proj₁ x) (proj₂ x)
{-to understand this parte i need to look the top definition of proj₁ and proj₂-}
-- these two functions are inverses. 
-- how is this isomorphism called? adjuncion
-- explain the relation between function and products
-- function are "right adjoint" to product.
--ABOVE IS PRODUCT-- 
--------
-- ⊎ --

data _⊎_ (A B : Set) : Set where
  inj₁ : A → A ⊎ B
  inj₂ : B → A ⊎ B

-- sum, coproduct, disjoint union

{-
  just simplification
  f : A → C 
  g : B → C
-}

case : (A → C) → (B → C) → (A ⊎ B → C)
case f g (inj₁ a) = f a -- x C-c C-c case
case f g (inj₂ b) = g b

-- uncurry case

-- i will try to solve this first
-- ** I can use lambda for this
-- i need to define A → C 
{-
uncase : (A ⊎ B → C) → (A → C) × (B → C)
proj₁ (uncase f) a = f (inj₁ a)
proj₂ (uncase f) b = f (inj₂ b)
-}
-- these functions are inverse to each other
-- they witness that ⊎ is left adjoint (of the diagonal)
-- if functions are the right adjoint of products
-- what is the left adjoint of sums  (⊎)?

-- data is defined by constructors _⊎_ , _×_
-- codata(record) is define by destructors _×_ . _→_

data _x'_ (A B : Set) : Set where
  _,_ : A → B → A x' B

--proj₁' : A × B → A
--proj₁'  (a , b) = a --patter matchign
  
-- binary products and sums
-- nullary, empty products, empty sum? 

record ⊤ : Set where
  constructor tt
  
{-
tt : ⊤
tt = record {!!}
-}
-- the unit type, it has exactly one element tt,
-- empty 
data ⊥ : Set where

-- this is the empty type, no elements.
case⊥ : ⊥ → C
case⊥ () -- impossible pattern - bcs return nothing? 
--------


{-
propositional logic, classical : prop = Bool

Some definition: 
Prop is Agda’s built-in sort of definitionally proof-irrelevant propositions. It is similar to the sort Set, but all elements of a type in Prop are considered to be (definitionally) equal.

prop = propositional

prop = judgment ? 

https://agda.readthedocs.io/en/latest/language/prop.html
pp = https://inria.hal.science/hal-01859964/

Really cool article - https://ncatlab.org/nlab/show/propositional+logic+as+a+dependent+type+theory

-}

prop = Set -- the type of vidence

variable
  P Q R : prop
  
infixl 5 _∧_
_∧_ : prop → prop → prop 
P ∧ Q = P × Q 

infixl 3 _∨_
_∨_ : prop → prop → prop
P ∨ Q = P ⊎ Q

infixl 2 _⇒_
_⇒_ : prop → prop → prop
P ⇒ Q = P → Q

-- propositions as types explanation

True : prop
True = ⊤

False : prop
False = ⊥

¬ : prop → prop
¬ P = P ⇒ False

infixl 1 _⇔_
_⇔_ : prop → prop → prop
P ⇔ Q = (P ⇒ Q) ∧ (Q ⇒ P)

{-
deMorgan : ¬ (P ∨ Q) ⇔  ¬ P ∧ ¬ Q
deMorgan .proj₁ x = (λ p → x (inj₁ p)) , λ q → x (inj₂ q)
deMorgan .proj₂ y (inj₁ p) = proj₁ y p
deMorgan .proj₂ y (inj₂ q) = proj₂ y q


deMorgan': ¬ (P ∨ Q) ⇔  ¬ P ∧ ¬ Q
deMorgan': ?
-}

