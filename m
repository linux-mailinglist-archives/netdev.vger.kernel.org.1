Return-Path: <netdev+bounces-142097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370139BD7A3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC83E1F2329F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED0216209;
	Tue,  5 Nov 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="iwJJiudN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9F216213
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842159; cv=none; b=VRGPC8a9xDDXs70cbW/mBqrYEIlZPW5//yA29yzRoyn4/dhpzB4lol70xKSkmKMzEeqcDW2EWKUUg7JpqLsBm/bZqMQ5AGhm6hgn2c/bF/2GcZGj8rygoKEPwIXjzpMQdprFKj1DGzFVBndfN8iVLihbYbjME0eu51jZidckqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842159; c=relaxed/simple;
	bh=SS4GWu3FjZi/LDHHA73Ns2xau/GSKqqhwH/ReCgSd2g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KYZnqxtGVZe1EUsIDdlQel6vH3InteMGUT7Qx3F3/c9iZCARaT9tcLwz/AFqPkaMbIia7mG5Wkzu9KPhOHOD9rH/fJEXFIEqnmtX/mgwjlJJ5jsahX2fdvd6yqhcmMGNbYlC4png4NVIbXbqpj/JPeOiz9aJpDIOAoh7Nqrx3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=iwJJiudN; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730842155; x=1762378155;
  h=date:from:to:subject:message-id:mime-version;
  bh=Zsm9hF1pgzoXDov4MVSVszj/9n6sthpb/kAIa+uhIGI=;
  b=iwJJiudN5BNqEbJM1WGVDOmIMMljX6eLBRixydMd4LLT6XSRYl/1TIw0
   9b3jVvS7Yy5DaOUxA/0R7iG0cyFpk2BK632XKGnxXJiWIj1inSWn8qaqj
   jimNbgXh459Qu2N9NMuzfaVuGRGD5qF/RxAEe/zueMcXqFJfrZijkMy2J
   VU+BqOHXm8+k6R3x1R8mGxNFP5k/E6YSZCEMvhxbqQKIQjazZHcSyf8cK
   4bbIVcLafrYkmw+xJC2s7FO4/9VtIJ3ZBbxOWKndQaBcyKYPThde7jEYz
   OoKdTKmswHhlhPD9/hXAyVO+f8HfQ14/W0WcHkSl33yRV3GF4MMyFAobG
   A==;
X-CSE-ConnectionGUID: Ccxc5Ey/TWKC3TEzQwPa4Q==
X-CSE-MsgGUID: sFh0U7KzSge5rYEVfbMD0Q==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2HgEQA1iCpnhVjoacJaHAECDi8BBAQBEAEHAQqBUwKCG?=
 =?us-ascii?q?ih9gWSIJY4CHYMonHYHAQEBDxQCAQIOChMEAQEEhVQBAQ+JVSg3Bg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEOAQEGAQEBAQEBBgcCEAEBAQFADjuFNUYNhSwsgntfg?=
 =?us-ascii?q?wEBgmSvZoE0gQGDHNsXgV0QgUgBhWmCYgGFaYR3PAaCDYEVNYEGbYFAhBuGb?=
 =?us-ascii?q?ASCSHyBegyCDhIlgi+BEIVWiCWPVIFpA1khEQFVExcLBwWBegODUoE5gVGDI?=
 =?us-ascii?q?EqDWYFCRj83ghNpSzoCDQI2giR9gk6DGIIFhHCEaYEjHTYKAwttPTUUG58wA?=
 =?us-ascii?q?UaCNy9DAhUnUYEEQAMwBgQJAh58kk5EE48xgUShXIQkhluDMIILlUMzhASTO?=
 =?us-ascii?q?ww6kkiYd6NuGYUbgX2CACwHGggwO4JnCUkZD44qGYEMAQeHIr8JeDsCBwsBA?=
 =?us-ascii?q?QMJjwWBfgEB?=
IronPort-PHdr: A9a23:9TTKkBHEvPCWJaDtS/FHE51Gfg0Y04WdBeZ0woEil6oLdbm/usy5e
 lfe4PNgkBnIRtaT5/FFjr/QtKbtESwF7I2auX8POJpLS1ceiMoQkgBhSM6IAEH2NrjrOio9G
 skqaQ==
IronPort-Data: A9a23:LvhfsatcAiLZBGr0Rqx5zk+FQefnVKFeMUV32f8akzHdYApBs4E2e
 kKraxnVYqTlPzOrZYw0KpPiphgb7NKW0N5T/DEc/ntmF39DoJCfVIqScheuZy3Kc5aaE0k8s
 5oVNNLOcMxuEyOD9k6jPLO/pCMs2/DYG+KhAbadYHF8GF5uGSt/1nqP9wJBbqtA2LBVVCvQ4
 oiryyGmBGKY5tJUDo41w6za8Bk2tf3/tmoV7gBkPf5FsVOCznRMVZwRKa/vdSD1a4QFReTSq
 8TrlergpjyDl/sO5nJJtp6hLyXml5aLZVDmZkJ+AvXk2l4a4HVqjs7XDdJEAW9PkTKFgttt/
 9tEsJ20WG8BM7bF8Agne0Aw/xpWY+sfodcrHVDl6ZbPlhSeLiOwqxlTJBhe0bMwq7cf7V5mr
 ZT0GBhVBjifiuS/xq6MS+UErqzP++GyYevzElk5pd3oJa5OraLrGs0m1vcEtNsEvf2iKN6FD
 yYvhZWDWzybC/FHEg9/5JvTB45EjFGnG9FTgAr9SabafwE/ZeG+uVTgGIO9RzCEeSlatm2Tt
 mmb0nW+Pi45H4ej5Ci87Uql2taayEsXWKpKfFG53uBrm0HW1G0WEAcRRUr++aP/lE+lR5ReM
 CT4+AJ3/PR0rRT2CIOmBVvo8BZovTZFMzZUO+c1wBqMz6zZ/0CYHQDoSxYbNIZ47p9nHFTG0
 HeSsdOxOGNMooaaRC+Hx5qqozmXFXAseDpqiSgsFldVsoay/OnflCnnSNt/HKOrpsP6FCu2w
 D2QqiU6wbIJgqY2O76T41Hcn3e+p53RVAkl90CPBCS77xhlIo++D2C11bTFxd1LPI3EY0jGg
 EcnsJOiwfI3EqmEyBXYFY3hA4qVz/qCNTTdh3tmEJ8g6ymh9hafkWZ4vGEWyKBBbpZsRNP5X
 HI/rz+987dyBxOXgUJffYOqF4E4zK34D9P1R7WMNJxQY4NtMg6clM2PWaJy9z63+KTPufhuU
 Xt+TSpKJS1AYUiA5GHuL9rxKZdxmkgDKZr7HPgXNSiP37uEf2KyQrwYKlaIZe1RxPrb+12Kr
 4sHZpLbkE03vAjCjs//rd57wbcicCBTOHwKg5UNK4Zv3yI/RDp/UqG5LU0JIdw6wMy5adskD
 lnmBh8Jlwuj7ZE2AQCLbnkraL2HYHqMhS9TAMDYBn7xgyJLSd/2sM83KcBtFZF5r7ML8BKBZ
 6JeEyl2Kq8UEmyfk9ncBLGhxLFfmOOD31/RZHH7PmFuIPaNhWXho7fZQ+cmzwFWZgLfiCf0i
 +TIOt/zKXbbezlfMQ==
IronPort-HdrOrdr: A9a23:t5KlUqxZQGZp4B2qVQ4wKrPwM71zdoMgy1knxilNoDhuA6qlfq
 GV7ZMmPHDP6Qr5NEtBpTniAtjlfZq/z+8R3WB5B97LN2OK1ATHEGgI1/qB/9SPIVycytJg
X-Talos-CUID: 9a23:KxdFkW/ovH4THpYTH8GVv2UfCst4X2ya8EjzCBSEJHRQV4WcFWbFrQ==
X-Talos-MUID: 9a23:VUDQ/wkuMumEdPqSUIlqdnp5Gscw3vuNGnsCnMgciuS6OyZVF2+k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="8'?scan'208";a="24262891"
Received: from vist-zimproxy-02.vist.is ([194.105.232.88])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 21:29:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id 58BA8442865A
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:29:06 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bqJJPt50jLO6 for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 21:29:05 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id C48EC442867D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:29:05 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2vfil6ix3491 for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 21:29:05 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTPS id B0CCA442865A
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:29:05 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8R6p-000000001Qx-0CZP
	for netdev@vger.kernel.org;
	Tue, 05 Nov 2024 21:29:07 +0000
Date: Tue, 5 Nov 2024 21:29:07 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-ets.8: some remarks and editorial changes for this manual
Message-ID: <ZyqOI3MK0ROapWU3@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vYJoJmLmrozs8FgY"
Content-Disposition: inline


--vYJoJmLmrozs8FgY
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



diff --git a/dcb-ets.8 b/dcb-ets.8.new
index 9c64b33..b90d2ca 100644
--- a/dcb-ets.8
+++ b/dcb-ets.8.new
@@ -3,20 +3,19 @@
 dcb-ets \- show / manipulate ETS (Enhanced Transmission Selection) settings of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B ets
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb ets show dev
-.RI DEV
+.I DEV
 .RB "[ " willing " ]"
 .RB "[ " ets-cap " ]"
 .RB "[ " cbs " ]"
@@ -30,7 +29,7 @@ the DCB (Data Center Bridging) subsystem
 
 .ti -8
 .B dcb ets set dev
-.RI DEV
+.I DEV
 .RB "[ " willing " { " on " | " off " } ]"
 .RB "[ { " tc-tsa " | " reco-tc-tsa " } " \fITSA-MAP\fB " ]"
 .RB "[ { " pg-bw " | " tc-bw " | " reco-tc-bw " } " \fIBW-MAP\fB " ]"
@@ -40,7 +39,7 @@ the DCB (Data Center Bridging) subsystem
 .IR TSA-MAP " := [ " TSA-MAP " ] " TSA-MAPPING
 
 .ti -8
-.IR TSA-MAPPING " := { " TC " | " \fBall " }" \fB: "{ " \fBstrict\fR " | "
+.IR TSA-MAPPING " := { " TC " | " \fBall " }" \fB: "{ " \fBstrict\fR " |"
 .IR \fBcbs\fR " | " \fBets\fR " | " \fBvendor\fR " }"
 
 .ti -8
@@ -71,13 +70,13 @@ class, bandwidth allocation, etc.
 
 Two DCB TLVs are related to the ETS feature: a configuration and recommendation
 values. Recommendation values are named with a prefix
-.B reco-,
+.BR reco- ,
 while the configuration ones have plain names.
 
 .SH PARAMETERS
 
 For read-write parameters, the following describes only the write direction,
-i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
+i.e., as used with the \fBset\fR command. For the \fBshow\fR command, the
 parameter name is to be used as a simple keyword without further arguments. This
 instructs the tool to show the value of a given parameter. When no parameters
 are given, the tool shows the complete ETS configuration.
@@ -115,23 +114,23 @@ keywords described below. For each TC sets an algorithm used for deciding how
 traffic queued up at this TC is scheduled for transmission. Supported TSAs are:
 
 .B strict
-- for strict priority, where traffic in higher-numbered TCs always takes
+\(en for strict priority, where traffic in higher-numbered TCs always takes
 precedence over traffic in lower-numbered TCs.
-.br
+.sp 1v
 .B ets
-- for Enhanced Traffic Selection, where available bandwidth is distributed among
+\(en for Enhanced Traffic Selection, where available bandwidth is distributed among
 the ETS-enabled TCs according to the weights set by
 .B tc-bw
 and
-.B reco-tc-bw\fR,
+.BR reco-tc-bw ,
 respectively.
-.br
+.sp 1v
 .B cbs
-- for Credit Based Shaper, where traffic is scheduled in a strict manner up to
+\(en for Credit Based Shaper, where traffic is scheduled in a strict manner up to
 the limit set by a shaper.
-.br
+.sp 1v
 .B vendor
-- for vendor-specific traffic selection algorithm.
+\(en for vendor-specific traffic selection algorithm.
 
 .TP
 .B tc-bw \fIBW-MAP
@@ -144,7 +143,6 @@ bandwidth given to the traffic class in question. The value should be 0 for TCs
 whose TSA is not \fBets\fR, and the sum of all values shall be 100. As an
 exception to the standard wording, a configuration with no \fBets\fR TCs is
 permitted to sum up to 0 instead.
-.br
 
 .TP
 .B pg-bw \fIBW-MAP
@@ -164,7 +162,6 @@ Set TSA and transmit bandwidth configuration:
 
 .P
 # dcb ets set dev eth0 tc-tsa all:strict 0:ets 1:ets 2:ets \\
-.br
                        tc-bw all:0 0:33 1:33 2:34
 
 Show what was set:

--vYJoJmLmrozs8FgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-ets.8"

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

Output from "mandoc -T lint dcb-ets.8": (possibly shortened list)

mandoc: dcb-ets.8:6:2: WARNING: skipping paragraph macro: sp after SH
mandoc: dcb-ets.8:147:2: WARNING: skipping paragraph macro: br before sp
mandoc: dcb-ets.8:167:2: WARNING: skipping paragraph macro: br before text line with leading blank

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
33:.RI DEV

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

80:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the

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

68:DCB (Data Center Bridging) interface. ETS permits configuration of mapping of
73:values. Recommendation values are named with a prefix
80:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
81:parameter name is to be used as a simple keyword without further arguments. This
82:instructs the tool to show the value of a given parameter. When no parameters
104:for details. Keys are priorities, values are traffic classes. For each priority
113:for details. Keys are TCs, values are Transmission Selection Algorithm (TSA)
114:keywords described below. For each TC sets an algorithm used for deciding how
115:traffic queued up at this TC is scheduled for transmission. Supported TSAs are:
142:for details. Keys are TCs, values are integers representing percent of available
143:bandwidth given to the traffic class in question. The value should be 0 for TCs
144:whose TSA is not \fBets\fR, and the sum of all values shall be 100. As an

-.-.

Use \(en (en-dash) for a dash between space characters,
not a minus (\-) or a hyphen (-), except in the NAME section.

dcb-ets.8:118:- for strict priority, where traffic in higher-numbered TCs always takes
dcb-ets.8:122:- for Enhanced Traffic Selection, where available bandwidth is distributed among
dcb-ets.8:130:- for Credit Based Shaper, where traffic is scheduled in a strict manner up to
dcb-ets.8:134:- for vendor-specific traffic selection algorithm.

-.-.

Split a punctuation from a single argument, if a two-font macro is meant

74:.B reco-,
126:.B reco-tc-bw\fR,

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "
43:.IR TSA-MAPPING " := { " TC " | " \fBall " }" \fB: "{ " \fBstrict\fR " | "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':679: macro 'IR'
troff: backtrace: file '<stdin>':43
troff:<stdin>:43: warning: trailing space in the line

-.-

Additional changes:

Add empty lines between "TSA-MAP" cases.

--vYJoJmLmrozs8FgY--

