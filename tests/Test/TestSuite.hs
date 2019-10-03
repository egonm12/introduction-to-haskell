module Test.TestSuite ( module Test.TestSuite ) where

import Test.Tasty.Hspec


spec_testSuite :: Spec
spec_testSuite = describe "Test suite" $ parallel $ do
  it "can test things" $
    1 + 1 `shouldBe` 2

  it "can test multiple things" $ do
    1 + 1 `shouldBe` 2
    1 + 2 `shouldBe` 3
