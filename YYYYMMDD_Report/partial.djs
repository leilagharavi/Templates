\begingroup\efdlspecials
\isdljstrue
\makeatletter
\obeyspaces\obeylines\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljspartialiii{%
var _thereisdjs=true;
var partre = /rEval|rFrac/;
function rngCorrAnsButton()
{
    var theprecision,fieldname,theanswer;
    if (arguments.length==3) {
        var theformat=arguments[0];
        var fieldname=arguments[1];
        var theanswer=arguments[2];
    } else {
        var fieldname=arguments[0];
        var theanswer=arguments[1];
    }
    theanswer = partialExpand(0,theanswer);
    if (arguments.length==3)
        theanswer=util.printf(theformat,eval(theanswer));
    DisplayAnswer(fieldname,theanswer);
}
function partialExpand(level,Ans)
{
    Ans = correctPlusMinus(Ans)
    level += 1;
\db console.println("Enter level = " + level +": Ans: " + Ans);\db%
    var n=0, m, bP, eP, subExp;
    while ( true ) {
\db     console.println("Searching a level " + level);\db%
        try { m = Ans.match(partre); }
        catch (e) { break; }
        if ( m != null ) {
            bP = m.index + m[0].length;
            eP = FindBalP(Ans, bP, true);
\db         console.println("bP = " + bP + " : eP = " + eP);\db%
            var subExp = Ans.substring(bP+1, eP);
\db         console.println("Found \'" + subExp%
                + "\' at level = " + level);\db%
            // n = beginning of "rEval",
            // eP = beginning of balanced parens,
            // bP = end of balanced parens
            Ans = Ans.substring(0, m.index)
                + eval(m[0]+"(level,subExp)") + Ans.substring(eP+1);
\db         console.println("level = " + level%
                             +": New Ans: " + Ans);\db %
        } else {
            if ( level == 1 ) {
\db             console.println("Level 1 break");\db %
                break;
            }
        }
    }
\db console.println("Return Ans: " + Ans);\db%
    Ans = correctPlusMinus(Ans);
    return Ans;
}
function rEval(level, Ans)
{
    level += 1;
\db console.println("Enter rEval: level = "%
        + level +": Ans: " + Ans);\db%
    var n=0, m, bP, eP, subExp;
    while ( true )
    {
\db     console.println("Searching a level " + level);\db%
        try { m = Ans.match(partre); }
        catch (e) { break; }
        if ( m != null ) {
            bP = m.index + m[0].length;
            eP = FindBalP(Ans, bP, true);
\db         console.println("bP = " + bP + " : eP = " + eP);\db%
            var subExp = Ans.substring(bP+1, eP);
\db         console.println("Found \'" + subExp%
                + "\' at level = " + level);\db%
            // n = beginning of "rEval",
            // eP = beginning of balanced parens,
            // bP = end of balanced parens
            Ans = Ans.substring(0, m.index)
                +eval(m[0]+"(level,subExp)")+Ans.substring(eP+1);
\db         console.println("level = "%
                + level +": New Ans: " + Ans);\db %
        } else {
            Ans = ParseInput(Ans);
\db         console.println("Ready to eval at level = "%
                + level + ": Ans = " + Ans);\db%
            with(Math) { Ans = eval( Ans ) };
\db         console.println("After eval at level = "%
                + level + ": Ans = " + Ans);\db%
            break;
        }
    }
\db console.println("Return Ans: " + Ans);\db%
    return Ans;
}
function rFrac(level, Ans)
{
    level += 1;
\db console.println("Enter rFrac level = "%
        + level +": Ans: " + Ans);\db%
    var n=0, m, bP, eP, subExp;
    while ( true ) {
\db     console.println("Searching a level " + level);\db%
        try { m = Ans.match(partre); }
        catch (e) { break; }
        if ( m != null ) {
            bP = m.index + m[0].length;
            eP = FindBalP(Ans, bP, true);
\db         console.println("bP = "%
                + bP + " : eP = " + eP);\db%
            var subExp = Ans.substring(bP+1, eP);
\db         console.println("Found \'" + subExp%
                + "\' at level = " + level);\db%
            // n = beginning of "rEval",
            // eP = beginning of balanced parens,
            // bP = end of balanced parens
            Ans = Ans.substring(0, m.index)
                + eval(m[0]+"(level,subExp)") + Ans.substring(eP+1);
\db         console.println("level = " + level%
                +": New Ans: " + Ans);\db %
        } else {
            var numDenom = Ans.split("/");
            numDenom[0] = eval(numDenom[0]);
            numDenom[1] = eval(numDenom[1]);
            var g = gcd(numDenom[0], numDenom[1]);
            numDenom[0] /= g;
            numDenom[1] /= g;
            if ( numDenom[1] == 1)
                Ans = numDenom[0];
            else
                Ans = numDenom.join("/");
\db         console.println("Reduce: " + numDenom.join("/"));\db%
            break;
        }
    }
\db console.println("Return Ans: " + Ans);\db%
    return Ans;
}
function correctPlusMinus(Ans)
{
    Ans = "" + Ans;
    Ans  = Ans.replace(/\s*([\+-])\s*\1\s*/g, " + ");
    Ans  = Ans.replace(/\s*\+\s*-\s*/g, " - ");
    Ans  = Ans.replace(/\s*-\s*\+\s*/g, " - ");
    return Ans;
}
function gcd(a,b)
{
    var x = a, y = b, r;
    while (true)
    {
        r = x \% y;
        if ( r == 0 ) break;
        x = y;
        y = r;
    }
    return Math.abs(y);
}
function lcm (a,b) { return (a*b)/gcd(a,b); }
}%
\endgroup
\begingroup 
\catcode`\<=12 
\catcode`\>=12 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S/JavaScript/JS(\dljspartialiii) >> }
\xdef\objpartialiii{\the\pdflastobj\space0 R}
\endgroup 
