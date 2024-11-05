Return-Path: <netdev+bounces-142124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2059BD8F2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5571F283A17
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3E20D51E;
	Tue,  5 Nov 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="W7Zbl3gb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-05.simnet.is (smtp-out1-05.simnet.is [194.105.231.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48B1CCB2D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846548; cv=none; b=p4Y7WvIRLDdyChmbK7jAku22Bl0uU63xkE4WKr+tmgNX9RXmTaIO/yrGpOzEoj8VOBNZ1eHIfARsUvvplKz1INEt+PKSfpNGd9+BXFsuS0b4ieBJEOPzveR6IRCfkCYP8u9aMjmrVbjQGy7ITKZbybF5b0gCbmYfELczZuB9z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846548; c=relaxed/simple;
	bh=/lmggkNSH+EAX3q9rMYp7NnJ2lI7QRU5q6uufm2koag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ferztnktTluIMAsnBrmgsgxEienG/aBGKSaZma2C8fZyttCJj6q6r5xcLjJONW2dQMePm/lMkUUrYvp/z0nmMb86+7rZzgcdgZw9u5zAtZL34teta9JZsnRgTSGIsj2C7pA64UDr5xlzGQgKOlCiFLIWHfHly4O01xmkAJZSEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=W7Zbl3gb; arc=none smtp.client-ip=194.105.231.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730846545; x=1762382545;
  h=date:from:to:subject:message-id:mime-version;
  bh=hwelBx+CBN8QFq5WZtPQqwbzHyJJJZ/1Rl5wdn9UIPY=;
  b=W7Zbl3gbdQ3rFna2g1XDr3aIKDLdGu7rrF7dY9XJHi+KZQYGg8mlXhky
   yeokAFhbmhWk/+8snQ4JqyWpB0vYXiORpzD8CUnemRDJ8iw8YnRNJUNHy
   +xnheqGl0hiMLTbPRy3Rrn2p4lVGNPGJaBZWV7lrTQiy9Qj//6HgKg58V
   WSKEMCd62aiGWC9EVbDlyXEd27TdtMlu97GwICXhZ06qV5qOFpL4BZGlD
   mS+e5whfXB6sspsVounhPGPfZdR2bnzMuQWSIdwmgf7iyz9ETxV7XttNs
   C8ldBgra73Q2weHEni99WHtw7cjDsokVA9APAvCkcpTgjrmgXC862UVe4
   w==;
X-CSE-ConnectionGUID: ux+dZ4FwRSmX+UnwYq3ghg==
X-CSE-MsgGUID: CQJJTaweS7uCmbWlP1nhcg==
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2GvCQC/nSpnhVfoacJaHQIOLwUFEAkKgVWCQn2BZIgWD?=
 =?us-ascii?q?44fgRaCEpx2BwEBAQ8UAgECDhILBAEBAwEDhVEBAQ+JVSg4EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQ4BAQYBAQEBAQEGBwIQAQEBAUAOO4U1Rg2EB4ElAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CQSqCEF8JgngBgmQUr1mBNIEBgxzbF4FdEIFIAYVpgmIBhWmEd?=
 =?us-ascii?q?zwGgg2BFTWBc0p2gmEBA4giBIJIfESBNgyCDhIlgi+BEIRJgQ2EAIQlhCWBI?=
 =?us-ascii?q?4oMgWkDWSERAVUTFwsHBYF6A4NSgTmBUYMgSoNZgUJGPzeCE2lLOgINAjaCJ?=
 =?us-ascii?q?H2CToMYggWEcIRpgSMdNgoDC209NRQbnzABRoI3LzESAQE8RwqBBC0TAzAGB?=
 =?us-ascii?q?AseIVuSOhREj0SBRKFchCSGW4MwgguVQzOEBJM7DDqSSJh3o24ZhRuBfoF/L?=
 =?us-ascii?q?AcaCDA7gmcJSRkPjioZiDY2vi94OwIHCwEBAwmRAwEB?=
IronPort-PHdr: A9a23:ie0C0xLGfKydFt3yodmcuUoyDhhOgF2VFhUQ9oJijK9SN/z+uY/jO
 UrS+bNslwyBUYba7qdCjOzb++DlVHcb6JmM+HYFbNRXVhADhMlX1wwtCcKIEwv6efjtaSFSI
 Q==
IronPort-Data: A9a23:qZ1oh6+c6hCGM4OPLStqDrUDKn6TJUtcMsCJ2f8bNWPdYAuW94E1v
 jFHAgbba6GUNyC3ZY0lOpDrpAJE6NKA0N5T/DEcrSlnEXhG+ZrJWo7IcR2oYn7PcZLPHRI45
 ptDYYCecZ0+F3HQ+Er8aOa+pyhxhPmGT+utBLafYy0gFQJuFCss1nqP9wJBbqtA2LBVVCvQ5
 46vyyGmBHe6xCEyOGMM7uSEshwosfK1oC4Sul01bOxKu1nF0GIUSZgFIqqxMmH1KrW4ZdVWE
 tsvtpniuDuxwioQNz+FrlraWkYEGbeIbFHQ1ScNBPny2ENI9yFqj/4yavdMOBcK12XTtt0gk
 98lWb6YEFxwZvKW8Ag+v7i0NwkkYMWqLZeeeSDXXfS7lhCAKz20haw2UCnaBKVAks5vG2ZC6
 PcEHz4EaxGHloqezamyIgVWrp1LwPLDYsVG4xmM8RmDVax6GMmbHv2WjTNl9G5Yav5mTKe2i
 /UxMVKDXDyYCzVTN1EeDo4JnevArhETpBUB9Tp5DYJui4Ti5FQZPIrFabI5SfTWLSlhpXt0k
 0qdl4jP7r72A/TEodaN2irEauYiBkoXUqpKfFGz3qYCbFF+WgX/ofDZPLe2iaDRt6KwZz5QA
 1EEuSYc8YYtzneufprAWQKJuSWLvhFJDrK8E8VigO2M4rTV+BrcFGkBViRGeM1j7JZwWz0xy
 hmIhLsFBxQ24eHTECrAsO3P93XiZkD5LkdbDcMAZQEKy8LipYc+klTOVb6PFYbv1YakRmGok
 1hmqgAVvpcxsccU2p7k4HvCiQ2onsHPTgU6s1C/smWNtV8pNdH0O+RE82Pz6/tcIIuHZkeOs
 WJCmMWE6u0KS5aXm0SwrP4lArCy+7OXMTjEm1l/Dtx5rnKz+mW/O4FLiN1jGKt3GtsUOjPbP
 GHMgzhU1NxuOmSbdPR4Y43kXqzG0pPcPdjiU/nVaP9HbZ5waBKL8UlSiai4gzCFfK8EzfFXB
 HuLTftAG0r2HoxG91KLqwo1z74w2mUsxGbLX5fr3lH/iPyAZWWJD7YeWLdvUgzbxP3eyOk22
 48OXydv9/m5eLalCsUw2dVKRW3m1VBhWfjLRzV/L4Zv2DZOFmA7EOP2yrg8YYFjlKk9vr6Xp
 SniBhIAmQOu3iWvxeC2hpZLNOOHsXFX8CpTAMDQFQ/yhhDPnK72sPxBLsVfkUcPrrw8kpaYs
 MXpi+3bXqQeFWWbk9jsRZz8qIUqdBrDuO59F3fNXdTLRLY5H1ah0oa9ImPHqnJUZgLp7pRWn
 lFV/liAKXb1b185VJ6OAB9upnvt1UUgdBVaBRaXeYINJhy9r+CH6UXZ15cKHi3FEj2brhPy6
 upcKU1wSTXly2PtzOT0uA==
IronPort-HdrOrdr: A9a23:q5W9GqMpn24zpcBcTt6jsMiBIKoaSvp037AO7TEWdfU1SL3+qy
 nAppUmPHPP6Ar5O0tQ/exoWpPwJE80nKQdieJ6UNvMMjUO01HYTr2Kg7GSoAHdJw==
X-Talos-CUID: 9a23:12gwHm6liMSS7fl/3dss6V5XFvJ5XGLn93LgYHK+FldwE7KVRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Afaq8nQwvi6CrqWcLM4HE+jF1YruaqI+XKmIxmIo?=
 =?us-ascii?q?LgJaZHil6BDOl1TK3SYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="8'?scan'208";a="23397808"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 22:42:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id C11164170FEA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:42:21 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id iBbKX7lA3q_P for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 22:42:21 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 213D341A16AD
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:42:21 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id e5pTaBlFGgb0 for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 22:42:21 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id F28334170FEA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:42:20 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8SFh-000000001aP-3uM3
	for netdev@vger.kernel.org;
	Tue, 05 Nov 2024 22:42:21 +0000
Date: Tue, 5 Nov 2024 22:42:21 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-maxrate.8: some remarks and editorial changes for this manual
Message-ID: <ZyqfTZWejPMsFQWz@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ABHQcWKZEZv8RwR2"
Content-Disposition: inline


--ABHQcWKZEZv8RwR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  The man page is from Debian:

Package: iproute2
Version: 6.11.0-1
Severity: minor
Tags: patch

  Improve the layout of the man page according to the "man-page(7)"
guidelines, the output of "mandoc -lint T", the output of
"groff -mandoc -t -ww -b -z", that of a shell script, and typographical
conventions.

-.-

  Output from a script "chk_man" is in the attachment.

-.-

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

diff --git a/dcb-maxrate.8 b/dcb-maxrate.8.new
index d03c215..cc415ef 100644
--- a/dcb-maxrate.8
+++ b/dcb-maxrate.8.new
@@ -3,25 +3,24 @@
 dcb-maxrate \- show / manipulate port maxrate settings of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B maxrate
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb maxrate show dev
-.RI DEV
+.I DEV
 .RB "[ " tc-maxrate " ]"
 
 .ti -8
 .B dcb maxrate set dev
-.RI DEV
+.I DEV
 .RB "[ " tc-maxrate " " \fIRATE-MAP " ]"
 
 .ti -8
@@ -34,7 +33,7 @@ the DCB (Data Center Bridging) subsystem
 .IR TC " := { " \fB0\fR " .. " \fB7\fR " }"
 
 .ti -8
-.IR RATE " := { " INTEGER "[" \fBbit\fR "] | " INTEGER\fBKbit\fR " | "
+.IR RATE " := { " INTEGER "[" \fBbit\fR "] | " INTEGER\fBKbit\fR " |"
 .IR INTEGER\fBMib\fR " | " ... " }"
 
 .SH DESCRIPTION
@@ -45,7 +44,7 @@ egress from a given traffic class.
 
 .SH PARAMETERS
 
-The following describes only the write direction, i.e. as used with the
+The following describes only the write direction, i.e., as used with the
 \fBset\fR command. For the \fBshow\fR command, the parameter name is to be used
 as a simple keyword without further arguments. This instructs the tool to show
 the value of a given parameter. When no parameters are given, the tool shows the
@@ -60,13 +59,13 @@ The rates can use the notation documented in section PARAMETERS at
 .BR tc (8).
 Note that under that notation, "bit" stands for bits per second whereas "b"
 stands for bytes per second. When showing, the command line option
-.B -i
+.B \-i
 toggles between using decadic and ISO/IEC prefixes.
 
 .SH EXAMPLE & USAGE
 
-Set rates of all traffic classes to 25Gbps, except for TC 6, which will
-have the rate of 100Gbps:
+Set rates of all traffic classes to 25\~Gbit/s, except for TC 6,
+which will have the rate of 100\~Gbit/s:
 
 .P
 # dcb maxrate set dev eth0 tc-maxrate all:25Gbit 6:100Gbit
@@ -76,7 +75,8 @@ Show what was set:
 .P
 # dcb maxrate show dev eth0
 .br
-tc-maxrate 0:25Gbit 1:25Gbit 2:25Gbit 3:25Gbit 4:25Gbit 5:25Gbit 6:100Gbit 7:25Gbit
+tc-maxrate 0:25Gbit 1:25Gbit 2:25Gbit 3:25Gbit 4:25Gbit 5:25Gbit 6:100Gbit \
+7:25Gbit
 
 .SH EXIT STATUS
 Exit status is 0 if command was successful or a positive integer upon failure.

--ABHQcWKZEZv8RwR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-maxrate.8"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8  <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  So any 'generator' should check its products with the above mentioned
'groff', 'mandoc',  and additionally with 'nroff ...'.

  This is just a simple quality control measure.

  The 'generator' may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Input text line longer than 80 bytes.

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  Not beginning each input sentence on a new line.
Lines should thus be shorter.

  See man-pages(7), item 'semantic newline'.

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -u <out1> <out2>

and for groff, using

"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - "

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output of 'diff -u' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option "-warnings=w"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT="-ww -b -z"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-.

Output from "mandoc -T lint dcb-maxrate.8": (possibly shortened list)

mandoc: dcb-maxrate.8:6:2: WARNING: skipping paragraph macro: sp after SH
mandoc: dcb-maxrate.8:79:83: STYLE: input text line longer than 80 bytes: tc-maxrate 0:25Gbit ...

-.-.

Change (or include a "FIXME" paragraph about) misused SI (metric)
numeric prefixes (or names) to the binary ones, like Ki (kibi), Mi
(mebi), Gi (gibi), or Ti (tebi), if indicated.
If the metric prefixes are correct, add the definitions or an
explanation to avoid misunderstanding.

68:Set rates of all traffic classes to 25Gbps, except for TC 6, which will
69:have the rate of 100Gbps:
72:# dcb maxrate set dev eth0 tc-maxrate all:25Gbit 6:100Gbit
79:tc-maxrate 0:25Gbit 1:25Gbit 2:25Gbit 3:25Gbit 4:25Gbit 5:25Gbit 6:100Gbit 7:25Gbit

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
24:.RI DEV

-.-.

Change a HYPHEN-MINUS (code 0x2D) to a minus(-dash) (\-),
if it
is in front of a name for an option,
is a symbol for standard input,
is a single character used to indicate an option,
or is in the NAME section (man-pages(7)).
N.B. - (0x2D), processed as a UTF-8 file, is changed to a hyphen
(0x2010, groff \[u2010] or \[hy]) in the output.

63:.B -i

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

48:The following describes only the write direction, i.e. as used with the

-.-.

Wrong distance between sentences in the input file.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier, when they belong to the same line,
and the same phrase.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

N.B.

  The number of lines affected can be too large to be in a patch.

48:The following describes only the write direction, i.e. as used with the
49:\fBset\fR command. For the \fBshow\fR command, the parameter name is to be used
50:as a simple keyword without further arguments. This instructs the tool to show
51:the value of a given parameter. When no parameters are given, the tool shows the
58:for details. Keys are TC indices, values are traffic rates in bits per second.
62:stands for bytes per second. When showing, the command line option

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.

Line 79, length 83

tc-maxrate 0:25Gbit 1:25Gbit 2:25Gbit 3:25Gbit 4:25Gbit 5:25Gbit 6:100Gbit 7:25Gbit


-.-.

Use the name of units in text; use symbols in tables and
calculations.
The rule is to have a (no-break, \~) space between a number and
its units (see "www.bipm.org/en/publications/si-brochure")

68:Set rates of all traffic classes to 25Gbps, except for TC 6, which will

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "
37:.IR RATE " := { " INTEGER "[" \fBbit\fR "] | " INTEGER\fBKbit\fR " | "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':679: macro 'IR'
troff: backtrace: file '<stdin>':37
troff:<stdin>:37: warning: trailing space in the line


--ABHQcWKZEZv8RwR2--

