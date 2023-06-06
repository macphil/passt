# :de: NSubstitute.ForPartsOf

## Ausgangssituation

Angenommen, es soll eine Methode getestet werden, welche leider nicht vollständig entkoppelt bzw. per Injection gemokt werden kann.

Dann hat man eine Chance, wenn die Methodenaufrufe innerhalb der zu testenden Methode **`virtual`** sind.

In dem kleinen Beispiel gibt es eine Methode, welche üblicherweise 2 (zwei) zurück gibt. Im *echten* Leben könnte dies eine externe Methode sein, welche wir gerade nicht Mocken können.

### Beispielklasse »GermanMath«

```c#
public class GermanMath
{
    // must be virual to be overridable
    public virtual int Zwei() => 2;
 
    public int Addiere(int a, int b) => a + b;
 
    public int Multipliziere(int a, int b) => a * b;
 
    public int Hoch(int basis, int exponent) => (int)System.Math.Pow(basis, exponent);
 
    public int HochZwei(int basis) => Hoch(basis, Zwei());
}
```

### Beispielmethoden zum »normalen« Test

```c#
private GermanMath _sut;
[SetUp]
public void SetUp()
{
    _sut = new GermanMath();
}
[TestCase(1, 3, ExpectedResult = 4)]
[TestCase(2, 3, ExpectedResult = 5)]
[TestCase(3, 3, ExpectedResult = 6)]
public int Addition_Tests(int x, int y) => _sut.Addiere(x, y);
 
[TestCase(1, 3, ExpectedResult = 3)]
[TestCase(2, 3, ExpectedResult = 6)]
[TestCase(3, 3, ExpectedResult = 9)]
public int Multilpiziere_Tests(int x, int y) => _sut.Multipliziere(x, y);
 
[TestCase(1, 3, ExpectedResult = 1)]
[TestCase(2, 3, ExpectedResult = 8)]
[TestCase(3, 3, ExpectedResult = 27)]
public int Hoch_Tests(int x, int y) => _sut.Hoch(x, y);
 
[TestCase(1, ExpectedResult = 1)]
[TestCase(2, ExpectedResult = 4)]
[TestCase(3, ExpectedResult = 9)]
public int Hoch2_Tests(int i) => _sut.HochZwei(i);
```

## NUnit-Test ForPartsOf

Dazu wird beim Arrange

- `Substitute.`**`ForPartsOf`** die konkreten Klasse instanziiert (sollte klar sein, weswegen das **_nicht_** mit einem Interface geht ...)
- per `When(x => x.zuMockendeMethode()).`**`DoNotCallBase()`**  sichergestellt werden, dass die Methode wirklich nicht aufgerufen wird (kann sonst unschöne Seiteneffekte haben....)
- mit **`ReturnsForAnyArgs`** (…) ein arrangiertes Objekt zurückgeben

> :arrow_right: Die zu mockende Methode muss **`public virtual`** sein :exclamation:

### Beispielmethode TestForPartsOf

```c#
[Test]
public void Hoch2_with3_TestForPartsOf()
{
    // arrange
    var three = 3;
    var mockedCalculator = Substitute.ForPartsOf<GermanMath>();
    mockedCalculator.When(x => x.Zwei()).DoNotCallBase();
    mockedCalculator.Zwei().ReturnsForAnyArgs(three);
 
    // act
    var result = mockedCalculator.HochZwei(three);
 
    // assert
    Assert.That(mockedCalculator.Zwei(), Is.EqualTo(three)); //-- NSubstitute - test. MUST NOT DO THIS IN REAL CASES
    Assert.That(result, Is.EqualTo(27));
}
```
