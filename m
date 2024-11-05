Return-Path: <netdev+bounces-142042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B29BD2EC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D830DB21617
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C61DE2C2;
	Tue,  5 Nov 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="b84z+Gqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EA1DD0FA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825764; cv=none; b=et1etKzhXEfN/HESwxMuanQ7+6DYk6eeTzSPrnqIoyAJ61/8n6zgU8KJFTF5Lql7OYB5/MOuJ7AKW0WmLzIwjS1l9Nniq5CY7Bkx5u0xbJ9gOyriJpTv5jL6FBqc6/1Q5S8jjgzz67fbNJg1m/In4nKWmNlMIA9SV+EqlYLkDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825764; c=relaxed/simple;
	bh=n2QX//HOz990g+zBBMT1PBCu0oHsY/TPRT21kr+b/kA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eGX2dESDR1Aw9b46qeLjsUrBSQZa1d9GOPrV6Zsw1ibEY/0ZjzphT1M22NldGNf7FemaGZfbx+Zgi/y5LjW5wWBqQnawGuQZycmP+adH5c+Vv1PNQsrzGtiUb1OsA0TcR3PKeaQxzYi9chmxFDCFoVasihazI26QGlLfIXExp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=b84z+Gqc; arc=none smtp.client-ip=194.105.232.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730825761; x=1762361761;
  h=date:from:to:subject:message-id:mime-version;
  bh=KTpMBkjVVBm7WIIkQlKbS+RS6GDiWeU4UWcrGmiHFMw=;
  b=b84z+GqcLDv9/PKh9pQwL0lcQ13COklsdyQBYdd9Ne4DdNkyJSfBzwJt
   30jDyWOelcK9rllU08GR4IytZvjqrfqatzOIAoKFB6yiYuhFWoAbtljUE
   VPxTxvujBa1GxrjvVGeM+fbtoeh3GQy6T5mEW3167r0GdwMISI9oA8QDs
   2Kp80iq3vAVlmP1br//0wFR97lhcTuVCPBWOzuTA5TYophFSVUChAiOQp
   pixot6dkYSnHgBIjV+i48/8EC72r7aAOcwjWtXsrIs2aCDTg20W86C9tj
   KD0OZ89EnKYahMfscOtNVVYsqc1V+UYRkgQ8V3iIMCTssV8R1ixyB8yvU
   w==;
X-CSE-ConnectionGUID: GaYbL2qDRui+n6cCtkze+w==
X-CSE-MsgGUID: a9h3ISvDTQuEBRkVVzI/9A==
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2G9CQDsSCpnhVfoacJaHAEBAQ0BLgEBBAQBAQ4BAQcBA?=
 =?us-ascii?q?QmBUwKCGih9gWSIJY4fgyicdgcBAQEPFAIBAg4SCwQBAQMBA4VRAQEPiVUoN?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQEBDgEBBgEBAQEBAQYHAhABAQEBQA47hTVGD?=
 =?us-ascii?q?YQHgSUBAQEBAQEBAQEBAQEBHQJBKoIQXwmCeAGCZBSvKYE0gQGDHNsXgV0Qg?=
 =?us-ascii?q?UgBhWmCYgGFaYR3PAaCDYFKgQZtgUCCYQEDiCIEgkh8gXoMgg4SJYIvgRCFV?=
 =?us-ascii?q?ogljzyBaQNZIREBVRMXCwcFgXoDg1KBOYFRgyBKg1mBQkY/N4ITaUs6Ag0CN?=
 =?us-ascii?q?oIkfYJOgxiCBYRwhGl8HTYKAwttPTUUG58cAUaCNy8xEgIVJ1GBBC0TAzAGB?=
 =?us-ascii?q?AseIVuSOhREj0SBRKFchCSGW4MwgguVQzOEBJM7DDqSSJh3o24ZhRuBfYIAL?=
 =?us-ascii?q?AcaCDA7gmcJSRkPjioZgQwBB4ciNr56eDsCBwsBAQMJkVEBAQ?=
IronPort-PHdr: A9a23:s9eAxhYdJEn5fQtcsmCiDCP/LTAChN3EVzX9i7I8jq5WN6O+49G6Y
 ArE5PBrgUOPXJ6Io/5Hiu+DtafmVCRA5Juaq3kNfdRKUANNksQZmQEsQYaFBET3IeSsbnk8G
 8JPPGI=
IronPort-Data: A9a23:b8CvKK7Wkzz+Rwc8nllDLQxRtJDHchMFZxGqfqrLsTDasI4TYxWz/
 BJMATLpZ67UfDe3OcciO9+rpw9Q78OX0N5T/DEc+3xjECMapJHOCYjAcxj+M3KcIpCdEktp5
 pxBNtCQcplpRXWNq0imbuG+pCAij6jZH+WjWLXPNnl/SFI7FCx+0HqP9wJBbqtA2LBVVCvQ4
 YioyyGmBHe6xCEyOGMM7uSEshwosfK1oC4Sul01bOxKu1nF0GIUSZgFIqqxMmH1KrW4ZdVWE
 tsvtpniuDuxwioQNz+FrlraWhFaHrLZZVjU0yQKUvCo20IY+3xsiKtia6sVZxcP1W2Ett0gk
 98lWb6YEFxwZvKW8Ag+v7i0NwkkYMWqLZeeeSDXXfS7lhCAKz20haw2UCnaBKVAks5vG2ZC6
 PcEHz4EaxGHloqezamyIgVWrp1LwPLDYsVG4xmM8RmDVax6GMmbHv2RjTNl9G5Yav5mTKe2i
 /UxMVKDXDyYCzVTN1EeDo4JnevArhETpBUB9Tp5DYJui4Ti5FQZPIrFabI5SfTWLSlhpXt0k
 0qdl4jP7r72A/TEodaN2irEauYiBkoXUqpKfFGz3qYCbFF+WgX/ofDZPLe2iaDRt6KwZz5QA
 2MdyyAK97EezlGqDd+jVDako2yJ/QFJDrK8E8VigO2M4rTV+BrcFGkBViRGeM1j7JZwWz0xy
 hmIhLsFBxQ24eHTECrAsO3P93XiZkD5LkdbDcMAZQEKy8LipYc+klTOVb6PFYbv0oekSG2pm
 1hmqgA31rVIrPUV+5mC4H3tuTGSmIroCV8cs1C/smWNtV8pNdH0O+RE82Pz6/tcIIuHZkeOs
 WJCmMWE6u0KS5aXm0SwrP4lArCy+7OXMTjEm1l/Dtx5rnKz+mW/O4FLiN1jGKt3GukNSDXNO
 lb/gx5Qp5kNN1C2br16IJ3kXqzG0pPcPdjiU/nVaP9HbZ5waBKL8UlSiai4gzCFfK8EzfFXB
 HuLTftAG0r2HoxG91KLqwo1z74w2mUsxGbLX5fr3lH/iPyAZWWJD7YeWLdvUgzbxP3eyOk22
 48OXydv9/m5eLalCsUw2dVKRW3m1VBhWfjLRzV/L4Zv2DZOFmA7EOP2yrg8YYFjlKk9vr6Xp
 SniBhIAmQOu3iWvxeC2hpZLNOOHsXFX8CpTAMDQFQ/yhhDPnK72sPxBLsVfkUcPrrw8kpaYs
 MXpi+3bXqQeFWWbk9jsRZz8qIUqdBrDuO59F3fNXdTLRLY5H1ah0oa9ImPHqnJUZgLp7pRWn
 lFV/liAKXb1b185VJ6OAB9upnvt1UUgdBVaAxGScoAKIhWxmGWoQgSo5sIKzwg3AU2r7lOnO
 8y+WH/0ecGlT1cJzeT0
IronPort-HdrOrdr: A9a23:BBHzQ6yP1RWHSqXAZgiAKrPwM71zdoMgy1knxilNoDhuA6qlfq
 GV7ZMmPHDP6Qr5NEtBpTniAtjlfZq/z+8R3WB5B97LN2OK1ATHEGgI1/qB/9SPIVycytJg
X-Talos-CUID: =?us-ascii?q?9a23=3AJEHjAGpIoUDNwBePSkPoWILmUe8sQ3f5lm78GVK?=
 =?us-ascii?q?5SmA3Q5aJSk2du7wxxg=3D=3D?=
X-Talos-MUID: 9a23:kseI/ArLvj4LiQOz55wezzgzNJxJ2LqCNHkQvL88uPe6Jw03ah7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; 
   d="8'?scan'208";a="24299410"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 16:54:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 6482341A1693
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:54:48 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id J6xIF4Ij9yqy for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 16:54:47 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id B976E41A169F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:54:47 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kFvn3ESu85va for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 16:54:47 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id A4A194199026
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:54:47 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8MpM-000000000jA-44Rw
	for netdev@vger.kernel.org;
	Tue, 05 Nov 2024 16:54:48 +0000
Date: Tue, 5 Nov 2024 16:54:48 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-buffer.8: some remarks and editorial changes for this manual
Message-ID: <ZypN2Fv_tBCT_AY2@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kGtXsRRkLDQgiJ3d"
Content-Disposition: inline


--kGtXsRRkLDQgiJ3d
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



--- dcb-buffer.8	2024-11-05 00:32:12.449059896 +0000
+++ dcb-buffer.8.new	2024-11-05 01:01:52.385065995 +0000
@@ -3,27 +3,26 @@
 dcb-buffer \- show / manipulate port buffer settings of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B buffer
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb buffer show dev
-.RI DEV
+.I DEV
 .RB "[ " prio-buffer " ]"
 .RB "[ " buffer-size " ]"
 .RB "[ " total-size " ]"
 
 .ti -8
 .B dcb buffer set dev
-.RI DEV
+.I DEV
 .RB "[ " prio-buffer " " \fIPRIO-MAP " ]"
 .RB "[ " buffer-size " " \fISIZE-MAP " ]"
 
@@ -46,35 +45,43 @@ the DCB (Data Center Bridging) subsystem
 .IR BUFFER " := { " \fB0\fR " .. " \fB7\fR " }"
 
 .ti -8
-.IR SIZE " := { " INTEGER " | " INTEGER\fBK\fR " | " INTEGER\fBM\fR " | " ... " }"
+.IR SIZE " := { " INTEGER " | " INTEGER\fBK\fR " | " INTEGER\fBM\fR " | " \
+\&... " }"
 
 .SH DESCRIPTION
 
 .B dcb buffer
 is used to configure assignment of traffic to port buffers based on traffic
-priority, and sizes of those buffers. It can be also used to inspect the current
-configuration, as well as total device memory that the port buffers take.
+priority, and sizes of those buffers.
+It can be also used to inspect the current configuration,
+as well as total device memory that the port buffers take.
 
 .SH PARAMETERS
 
 For read-write parameters, the following describes only the write direction,
-i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
-parameter name is to be used as a simple keyword without further arguments. This
-instructs the tool to show the value of a given parameter. When no parameters
-are given, the tool shows the complete buffer configuration.
+i.e., as used with the \fBset\fR command.
+For the \fBshow\fR command,
+the parameter name is to be used as a simple keyword without further
+arguments.
+This instructs the tool to show the value of a given parameter.
+When no parameters are given,
+the tool shows the complete buffer configuration.
 
 .TP
 .B total-size
 A read-only property that shows the total device memory taken up by port
-buffers. This might be more than a simple sum of individual buffer sizes if
+buffers.
+This might be more than a simple sum of individual buffer sizes if
 there are any hidden or internal buffers.
 
 .TP
 .B prio-buffer \fIPRIO-MAP
 \fIPRIO-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
-for details. Keys are priorities, values are buffer indices. For each priority
-sets a buffer where traffic with that priority is directed to.
+for details.
+Keys are priorities, values are buffer indices.
+For each priority sets a buffer where traffic with that priority is directed
+to.
 
 .TP
 .B buffer-size \fISIZE-MAP
@@ -93,8 +100,8 @@ Configure the priomap in a one-to-one fa
 .P
 # dcb buffer set dev eth0 prio-buffer 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
 
-Set sizes of all buffers to 10KB, except for buffer 6, which will have the size
-1MB:
+Set sizes of all buffers to 10\~kibibytes (KiB),
+except for buffer 6, which will have the size 1\~mebibyte (MiB):
 
 .P
 # dcb buffer set dev eth0 buffer-size all:10K 6:1M

--kGtXsRRkLDQgiJ3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-buffer.8"

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

Output from "mandoc -T lint dcb-buffer.8": (possibly shortened list)

mandoc: dcb-buffer.8:6:2: WARNING: skipping paragraph macro: sp after SH

-.-.


Change (or include a "FIXME" paragraph about) misused SI (metric)
numeric prefixes (or names) to the binary ones, like Ki (kibi), Mi
(mebi), Gi (gibi), or Ti (tebi), if indicated.
If the metric prefixes are correct, add the definitions or an
explanation to avoid misunderstanding.

96:Set sizes of all buffers to 10KB, except for buffer 6, which will have the size
100:# dcb buffer set dev eth0 buffer-size all:10K 6:1M
109:buffer-size 0:10Kb 1:10Kb 2:10Kb 3:10Kb 4:10Kb 5:10Kb 6:1Mb 7:10Kb
111:total-size 1222Kb

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
26:.RI DEV

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

61:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the

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

55:priority, and sizes of those buffers. It can be also used to inspect the current
61:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
62:parameter name is to be used as a simple keyword without further arguments. This
63:instructs the tool to show the value of a given parameter. When no parameters
69:buffers. This might be more than a simple sum of individual buffer sizes if
76:for details. Keys are priorities, values are buffer indices. For each priority
83:for details. Keys are buffer indices, values are sizes of that buffer in bytes.

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.


Line 49, length 82

.IR SIZE " := { " INTEGER " | " INTEGER\fBK\fR " | " INTEGER\fBM\fR " | " ... " }"


-.-.

Use the name of units in text; use symbols in tables and
calculations.
The rule is to have a (no-break, \~) space between a number and
its units (see "www.bipm.org/en/publications/si-brochure")

100:# dcb buffer set dev eth0 buffer-size all:10K 6:1M
109:buffer-size 0:10Kb 1:10Kb 2:10Kb 3:10Kb 4:10Kb 5:10Kb 6:1Mb 7:10Kb
111:total-size 1222Kb

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line


--kGtXsRRkLDQgiJ3d--

