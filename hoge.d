import std.stdio;


extern(C)
{
    uint fib(uint n)
    {
        writeln("shine!");
        if(n <= 1)
        {
            return n;
        }
        return fib(n - 1) + fib(n - 2);
    }
}
