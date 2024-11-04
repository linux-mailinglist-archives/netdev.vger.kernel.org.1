Return-Path: <netdev+bounces-141716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8F9BC193
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B4F1C21C79
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA218C009;
	Mon,  4 Nov 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="Z7xXHIGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-05.simnet.is (smtp-out1-05.simnet.is [194.105.231.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCC18BBA0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763935; cv=none; b=GnS5jNL79QVsNxR+/UeVo8ZaeW+4CMfbn3IRIBwFQU5LBaN/giP7/B/ouObJ7eJlMnUh6poUmS3g67/acpaLhYKsHEctLQaSwVCLAgCmBP4maP0N3dX0xHLACgW1rEgTtMjzIWhx7d55WkDf2LRjNZ8c59CVJknps7OYqE5VXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763935; c=relaxed/simple;
	bh=kVHoYqBlIJy/PNir0IWY5WuqvrMFkhwFRsGa7pQv+2M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fXlCAZ/RK3vRuF4dfR7xdhEUXf8zv6/9icVQNNYq2aVc5RtIMbA+G2/pPNRAsYFDdIMLNu1vO2MubImoDN91+36x/vrY5hr9otLXJWxtDGGIzNAZv6HPCWrJAVH3aZz9DrAtrgNW8yyhqOYOGjcz95ab5wqBvEOKUO1gBo8OKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=Z7xXHIGK; arc=none smtp.client-ip=194.105.231.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730763931; x=1762299931;
  h=date:from:to:subject:message-id:mime-version;
  bh=6EC1i/8AKW/ghdCabcKvsXZv2KX1bzbCmYAzTYZmaR8=;
  b=Z7xXHIGK3j88PfInJ6x3fm7xgYf1Lejd5LuzDjNoME+bu0AjgaR/JnIt
   C8bdwtTSYMsF7lnbvFvV88OSw/fTfGyxZs4ofu9WqdiykYO0SUwIzN6Wo
   DI6QOaSzDN9llNcGItBHVWsvyiUuY818TMAvyiO9di7i6D8Cz0yOXsmak
   SV6ULVK2lVv5OBmaq5xcbNnge0Qt17uwT98+x6CaRaajNJC6MREQuToe2
   joZ7EXNZtZR8gciphHVOnif9vZ9y5q8rCHQu7SBKyAhamNKo6hHW11Hde
   J2UR7THtbIAxDJk0jz5yv3EnWtTUqKqf9j+rnKwt3mWosvggqRU732wmC
   Q==;
X-CSE-ConnectionGUID: lrPLZejCSgWHLWPO5l2GyQ==
X-CSE-MsgGUID: 6DN148NXRLeLexIRbicmDA==
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2GeAwBdWSlnhVfoacJaHgEBCxIMQINvKH2BZIgljgIdg?=
 =?us-ascii?q?yicdgcBAQEPNQ8EAQEEgg+NKig4EwECBAEBAQEDAgMBAQEBAQEBAQ4BAQYBA?=
 =?us-ascii?q?QEBAQEGBwIQAQEBAUAOO4U1Rg2FLCyCe1+DAQGCZK9AgTSBAYMc2xeBXBCBS?=
 =?us-ascii?q?IVqgmIBhWmEdzwGgg2BSoFzgUCLBwSCMhV8gXcMgg4SJYIvgRCFVogmjz2Ba?=
 =?us-ascii?q?QNZIREBVRMXCwcFgXkDg1GBOYFRgyBKg1mBQkY/N4ITaU06Ag0CNoIkfYJQg?=
 =?us-ascii?q?xiCBYRwhGx9HTYKAwttPTUUG58dAUaCOC89BgI8UYEEIx0DMAYECx58kk1Ej?=
 =?us-ascii?q?0OBRKFbhCSGW4MwgguVQzOEBJM7DDqSRph3pAaFG4F+gX8sBxoIMDuCZwlJG?=
 =?us-ascii?q?Q+OKhmBDAEHhyK/Hng7AgcLAQEDCZMsAQE?=
IronPort-PHdr: A9a23:rNbvKRSe60PMVoG1+f8PSHcpGNpso5DLVj580XJGo6lLbrzm+In+e
 RSCo+5siVnEQcPa8KEMh+nXtvXmXmoNqdaEvWsZeZNBHxkClY0NngMmDcLEQU32JfLndWo7S
 cJFUlINwg==
IronPort-Data: A9a23:GoHWKKl0UqTIeo37uY/jnbXo5gxzJkRdPkR7XQ2eYbSJt16W5oEne
 lBvCjHdVaLbPHygOZtoPN7k6BtG+dKXi5UnVgpcGRpFFipDoJXIVdjAJ0r9NS+cccScEBo84
 shONdOcIphqECeMrU2mO+K88yUmiqrRS+OmBrSaa3khHlE4ECp8gk5ox4bV7mIQbf2RWmth7
 vuu/JWAULPc5wNJD440106igEg+4Pmo6DpG71dgO6lF41aOnSkeAclAe/3tIiqiTNAFN+PrH
 OyrIJORpziAp0h3Yj+GfhcXVmVQH9Y+6CDX0iI+t5CK20UE/mpqlP9jaJLwUG8P4x2Rhdd91
 d5RgpK5TAYtL8Xklf8UO/ViO3gW0ZZupvmeeBBTjeTJlxeaKiK0n600ZK0LFdRwFthfUDAmG
 cMwcFjhXjjb78qqzbSyTPVbh8hLBKEH66tG5xmMZRmAZRoXacirr5fivLe07x9s7ix6JssyU
 uJCAdZZgLssVDUUUrsfIMpWcO5FHRATeRUAwL6ejfJfD2Q+UGWdeVUiWTbYUoXieClboqqXj
 mbcx0DLDxMxD9Og6R66ylXxgrXgjBquDer+FJXgnhJrqEOS3XBWGhwTTUG8sej80hf4RdNEN
 woV4ULCr4BrpRDtF4GgGUfj+jjU4XbwWPIJewE+wAuC4rHV5gCUGi4FVVatbfR875VoG2B3h
 zdlmfu3KRo27O2zeUi5+5OZvRKIMykeKEMrMHpsoQwtuIWz8d5i0nojVO1LFqOpgtDrMS//z
 irMryUkgbgXy8kR2M2GEUvvnTO3ut3bTwst/ALHTyf9t0VnZZW5IY2zgbTG0RpeBIKDdn2zs
 XovoMehzMQxNbbQkHaiUdxYSdlF+M25GDHbhFduGbwo+DKs52OvcOhsDNdWeBcB3iEsJW+BX
 aPDhT698qO/K1OLVsdKj2+ZFcUx0e3yFNH9TPfEf58WO95vdRSbuiB1DaJx44wPuBZ2+U3cE
 c7KGSpJMZr8If88pNZRb7xEuYLHPghkmQvuqWnTlnxLK4a2an+PUqsiO1CTdO0/567siFyKq
 I4Aa5bSmkwOC7WWjszrHWg7cQBiwZ8TWMieliCrXrfZf2KK5Ul4V6SPmO1Jl3JNxfQKyY8kA
 U1RqmcDlAqu2iybQel7QnVibLqnXZgXkJ7IFXFEALpc4FB6OdzHxP5GK/MfI+J9nMQ9lqEcc
 hXwU57bahi5Ym+co2xFBXQ8xaQ+HCmWafWmY3L7PWlgJMcxH2QkOLbMJ2PSycXHNQLv3eNWn
 lFq/lqzrUYrL+i6MPvrVQ==
IronPort-HdrOrdr: A9a23:LoJOu60uB5CqdsiTxa8KqAqjBIIkLtp133Aq2lEZdPU1SKClfq
 WV98jzuiWatN98Yh8dcKm7Sc+9qCrnhOdICOsqXYtKLTOGhILAFugLh+bfKlbbak7DH4BmpM
 NdWpk7JNrsDUVryebWiTPIdOrIGeP3kpxAU92uqktQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AnOWDHmnqcwcwK/USkAAA9idDOUPXOXnH9FPiLk2?=
 =?us-ascii?q?TMmlWaJmqcXjN/PlLgvM7zg=3D=3D?=
X-Talos-MUID: 9a23:FfMpCQShfwtxaS2zRXSyqBc7aJdO056KBWQAgbQ8sciPMABZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="8'?scan'208";a="23266459"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 23:44:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id E302041A16B7
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:44:19 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id c-DTtXQb4bNi for <netdev@vger.kernel.org>;
 Mon,  4 Nov 2024 23:44:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 6B7B141A16B8
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:44:19 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Fbz5JwKw9XAJ for <netdev@vger.kernel.org>;
 Mon,  4 Nov 2024 23:44:19 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 5624C41A16B7
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:44:19 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t86k8-000000000v0-2Bmi
	for netdev@vger.kernel.org;
	Mon, 04 Nov 2024 23:44:20 +0000
Date: Mon, 4 Nov 2024 23:44:20 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-apptrust.8: some remarks and editorial changes for this manual
Message-ID: <ZylcVAmsr55YK38b@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7gK7vZtQK73LsW9t"
Content-Disposition: inline


--7gK7vZtQK73LsW9t
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

  Output from a script "chk_manual" is in the attachment.

-.-

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>


--- dcb-apptrust.8	2024-11-04 19:51:38.581034458 +0000
+++ dcb-apptrust.8.new	2024-11-04 20:04:44.751223062 +0000
@@ -3,33 +3,33 @@
 dcb-apptrust \- show / configure per-selector trust and trust order of the
 application priority table of the DCB (Data Center Bridging) subsystem.
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B apptrust
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb apptrust show dev
-.RI DEV
+.I DEV
 .RB "[ " order " ]"
 
 .ti -8
 .B dcb apptrust set dev
-.RI DEV
-.RB "[ " order "
+.I DEV
+.RB "[ " order
 .IR "SEL-LIST" " ]"
 
 .ti -8
 .IR SEL-LIST " := [ " SEL-LIST " ] " SEL
 
 .ti -8
-.IR SEL " := { " ethtype " | " stream-port " | " dgram-port " | " port " | " dscp " | " pcp " } "
+.IR SEL " := { " ethtype " | " stream-port " | " dgram-port " | " port " | " \
+dscp " | " pcp " }"
 
 .SH DESCRIPTION
 
@@ -40,10 +40,13 @@ Application Priority Table, see
 for details on how to configure app table entries.
 
 Selector trust can be used by the
-software stack, or drivers (most likely the latter), when querying the APP
-table, to determine if an APP entry should take effect, or not. Additionally, the
-order of the trusted selectors will dictate which selector should take
-precedence, in the case of multiple different APP table selectors being present.
+software stack, or drivers (most likely the latter),
+when querying the APP table,
+to determine if an APP entry should take effect, or not.
+Additionally,
+the order of the trusted selectors will dictate which selector should take
+precedence,
+in the case of multiple different APP table selectors being present.
 
 .SH COMMANDS
 
@@ -53,25 +56,27 @@ Display all trusted selectors.
 
 .TP
 .B set
-Set new list of trusted selectors. Empty list is effectively the same as
-removing trust entirely.
+Set new list of trusted selectors.
+Empty list is effectively the same as removing trust entirely.
 
 .SH PARAMETERS
 
-The following describes only the write direction, i.e. as used with the
-\fBset\fR command. For the \fBshow\fR command, the parameter name is to be used
-as a simple keyword without further arguments. This instructs the tool to show
-the values of a given parameter.
+The following describes only the write direction, i.e.,
+as used with the \fBset\fR command.
+For the \fBshow\fR command,
+the parameter name is to be used as a simple keyword without further
+arguments.
+This instructs the tool to show the values of a given parameter.
 
 .TP
 .B order \fISEL-LIST
-\fISEL-LIST\fR is a space-separated list of selector names. Possible selector
-values are:
-.B ethtype,
-.B stream-port,
-.B dgram-port,
-.B port,
-.B dscp,
+\fISEL-LIST\fR is a space-separated list of selector names.
+Possible selector values are:
+.BR ethtype ,
+.BR stream-port ,
+.BR dgram-port ,
+.BR port ,
+.BR dscp ,
 and
 .B pcp
 

--7gK7vZtQK73LsW9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-apptrust.8"

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

Output from "mandoc -T lint dcb-apptrust.8": (possibly shortened list)

mandoc: dcb-apptrust.8:6:2: WARNING: skipping paragraph macro: sp after SH
mandoc: dcb-apptrust.8:25:16: STYLE: unterminated quoted argument
mandoc: dcb-apptrust.8:44:81: STYLE: input text line longer than 80 bytes: table, to determine ...

-.-.


Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
24:.RI DEV

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

61:The following describes only the write direction, i.e. as used with the

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

44:table, to determine if an APP entry should take effect, or not. Additionally, the
56:Set new list of trusted selectors. Empty list is effectively the same as
61:The following describes only the write direction, i.e. as used with the
62:\fBset\fR command. For the \fBshow\fR command, the parameter name is to be used
63:as a simple keyword without further arguments. This instructs the tool to show
68:\fISEL-LIST\fR is a space-separated list of selector names. Possible selector

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.

Line 32, length 97

.IR SEL " := { " ethtype " | " stream-port " | " dgram-port " | " port " | " dscp " | " pcp " } "

Line 44, length 81

table, to determine if an APP entry should take effect, or not. Additionally, the


-.-.

Split a punctuation from a single argument, if a two-font macro is meant

70:.B ethtype,
71:.B stream-port,
72:.B dgram-port,
73:.B port,
74:.B dscp,

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "
25:.RB "[ " order "
32:.IR SEL " := { " ethtype " | " stream-port " | " dgram-port " | " port " | " dscp " | " pcp " } "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':679: macro 'IR'
troff: backtrace: file '<stdin>':32
troff:<stdin>:32: warning: trailing space in the line

-.-.

--7gK7vZtQK73LsW9t--

