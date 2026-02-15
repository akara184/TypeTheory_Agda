{-
doing some exercises


Exercises for TYP at MGS 2021

-}

open import Data.Nat
open import Data.Bool

variable
  A B C : Set

{- 1. -}

add3 : ℕ → ℕ
add3 x = x + 3

tw : (A → A) → A → A
tw f n = f (f n)
-- evaluate
-- tw tw add3 1

-- derive the result (in a comment) step by step
{-
tw tw add3 1
= tw (tw) add3 1
= tw (tw add3) 1
= (tw add3) ((tw add3) 1)
= add3 (add3 1)  -- first (tw add3) 1
= 1 + 3 + 3
= 7
-}

-- derive lambda terms with the following types

f₀ : (A → B) → (B → C) → (A → C)
f₀ = λ f g a → g (f a)

--f₁ : (A → B) → ((A → C) → C) → ((B → C) → C)
--f₁ = λ f g h → g λ a → h (f a)
--f₁ = λ f g h → g (λ a → h (f a))

--f₁ : (B → C) → (A → B) → A → C
--f₁ = λ f g h → f (g h)

f₁ : A → (A → B) → B
f₁ = λ f g → g f

f₂ : (A → B → C) → (A → B) → A → C
f₂ = λ f g h → f h (g h)

{-
Comentários explicativos:

f : A → (B → C)
g : B
h : A
f h : B → C
(f h) g : C
-}

{- resposta do f1 
f₁ = λ f g h → g λ a → h (f a)
f₁ = λ f g h → g (λ a → h (f a))

f : A → B
g : (A → C) → C
h : B → C
h ∘ f : A → C

Então h ∘ f : A → C — ou seja, podemos aplicar h depois de f para transformar A em C.
-}

{- 3.
(A → B) F
(A → C) →  
(B → C) → 
-}

-- Advanced (see lecture notes 2.4)
{-
Derive a function tw-c which behaves the same as tw 
using only S, K (and I which is defined using S and K below).
-}

-- K : A → B → A
K : A → B → A
K = λ a b → a

-- S : (A → B → C) → (A → B) → A → C
S : (A → B → C) → (A → B) → A → C
S = λ f g x → f x (g x)

-- I : A → A
I : A → A
I {A} = S K (K {B = A})

-- tw-c : (A → A) → A → A
-- tw-c = {!!}

