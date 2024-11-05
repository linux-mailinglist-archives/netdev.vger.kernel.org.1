Return-Path: <netdev+bounces-142081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E709BD5FF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81982B21C01
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889AE20E023;
	Tue,  5 Nov 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="FFw+Aywb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-05.simnet.is (smtp-out1-05.simnet.is [194.105.231.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34C20D50E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835478; cv=none; b=BQSDaC7aRFkzd5qnm65LuLJ9oa2wKCCZGZYibLjUuK5Lm9haqfJrPZaVFrmy1HCtnfJpBvMynQdKgVA2UiLob/lwxFJSW/cy12T0IXNiu9kfL+5grP3PI47m3AXWLgI4dPFAb+JbPvBTrIlq5vncODnzdum3NcjenU3KJr7sFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835478; c=relaxed/simple;
	bh=+wE9wSwJT947OiSoILkJZ0RNhoCB8NKZ93/C/n0T9qY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BaUgpdp+zUxHpnCcD5aVL/2IONT74X2EaP3sTxTOC9jlTxyZj0HRz8P8+xhO+cTI6/ZalmJydNL9DdqMbSVV3F9Ux2ZAa6q/0cEYjxNuEYTpARcdj/XgwHicmM9n7963W0iJlSqxUY/Hxl9P6JpECe9zd2L6TJpPKH009TN1gtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=FFw+Aywb; arc=none smtp.client-ip=194.105.231.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730835475; x=1762371475;
  h=date:from:to:subject:message-id:mime-version;
  bh=XnG2Tvq+2LNEOhQ1U53XUgF5l0bCysZwrCSBSGDtDl0=;
  b=FFw+AywbI+CqA6ykgoMc3NN1vJVLaYeE8Oy+jR/a2MD8zDU5uOWsOa4n
   egVS9/O3B1KwSBJvj0Lm05l0X9BVpXSKkn7iBlFJ61reLEARkhZu7vr52
   1XC+inDZuwUC4qp3j5YffZQoka3eSNDYD0CLSSUf3Y1FrLVDcyhv0IMe8
   ZKxAiPaV3BQJQ6D8hI7u0DnMpQiGGilgHJ19vonzVcHLDEJj/WA8ZAGzP
   rq0UxXszn4kZuHIEwVty0DqqT0vGJe2jUDxDviTG1LVRe8eOjIm029udj
   OezqhC2n5raMfE0cREvfAWzUZgyrZpEvcOWRXvmw3k/1DoyqTf1eSqjXZ
   Q==;
X-CSE-ConnectionGUID: LSVUFTztRUC/aLZdJsgeAQ==
X-CSE-MsgGUID: bjkQ9khmTmC3W4bL1DdwTQ==
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2HcEQA9cypnhVfoacJaHAECDi8BBAQBEAEHAQqBUwKCQ?=
 =?us-ascii?q?n2BZIgljgIdgyicdgcBAQEPFAIBAg4KEwQBAQSFVAEBD4lVKDcGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQ4BAQYBAQEBAQEGBwIQAQEBAUAOO4U1Rg2FLCyCe1+DA?=
 =?us-ascii?q?QGCZK9TgTSBAYMc2xeBXRCBSAGFaYJiAYVphHc8BoINgRU1gXOBQIsHBIJIf?=
 =?us-ascii?q?IIGgg4SJYIvgRCFVoglj1CBaQNZIREBVRMXCwcFgXoDg1KBOYFRgyBKg1mBQ?=
 =?us-ascii?q?kY/N4ITaUs6Ag0CNoIkfYJOgxiCBYRwhGmBIB02CgMLbT01FBufLgFGgjcvQ?=
 =?us-ascii?q?wJZNIEEQAMwBg8ek1oBM49EgUShXIQkhluDMIILlUMzhASTOww6kkiYd6MiT?=
 =?us-ascii?q?BmFG4F9ggAsBxoIMDuCZwlJGQ+OKhmINr8xeDsCBwsBAQMJkQMBAQ?=
IronPort-PHdr: A9a23:2xFM3x2are00YzAKsmDPhFBlVkEcU9TcJQsJ8t8glq4LKvnl5JXnO
 kHDo/R23xfFXoTevvRDjeee86XtQncJ7pvJtnceOIdNWBkIhYRenwEpDMOfT0yuKvnsYkQH
IronPort-Data: A9a23:nMbuP6nJGxZU2SPbAGtvA5fo5gx3JkRdPkR7XQ2eYbSJt16W5oEne
 lBvCjHdVaLbPHygOZtoPN7k6B5V697LxubXe3JoqnthFS9Eo5GcD9qVIh+sZXPCc5SbHEw2s
 8wVZ4WedMo+QHTV90v9beTt/HQsjP+GS+v3BrebYHwtGVU7FHZ84f4Pd5bVp6Yx6TTuK1jT5
 IuaT7TjBWKYNx5I3kM8u6jT8ko056X4s2JF4lAyOqwX5A7TnilMXcNPfq/rcSTRT9gPFIZWZ
 c6al+jhoTmxEzTBqz+BuuymGqHfaueKZWBislIPBu76xEAE/3RuukoCHKJ0QV9NjDmUlMxGx
 txItJihIS8kJaSkdN41CnG0KAkge/QfkFP7CSLn65DKlhWbKyeEL8hGVSnaA6VJq46bPkkWn
 RAoAGhlRgyOgeuw3IW6RoFE7ij0BJC2VG+3kigIIQDxVZ7Kc7iaK0n5zYMwMAMLuyx7Na22i
 /z1xtZYRE+ojxVnYj/7AX+l9QuiriGXnzZw8Dp5qUerioR6IcMYPLXFabLoltK2qcp9un2mm
 0z67XjDPzpdPfitxRie/X+Fv7qa9c/7cNp6+LyQ6P9xnBiBx2kLEhoGRB7j+L+ni1WiHdNEQ
 6AW0nN/8e5rrBHtFIKnGU3nyJKHlkd0t954GeIS8wCIzKfIpQeCboQBZmQaM4x47pVmLdAs/
 lWLnOq4BjxqjLi+Ek3B/JPNgT+tBRFAeAfuYgdfEVtUvIi/yG0ptTrJQ8pvHbCdkNL4A3fzz
 iqMoSx4gK8c5fPnzI2l/EvbxiCto4DTSR4ko12OGHyk9R8/ZZXNi5GUBUbzyc1+EailXEW7g
 VNDkuys4MIVApykrXnYKAkSJ42B6/GAOTzapFdgGZg96jigk0JPm6gMsFmSw281Yq45lS/VX
 aPFhe9GzL5oVEZGgIdpYpmtTtYryLD6EsT0E6iNKMRPeYQ3dRTvEMBSiay4gTqFfKsEyPBX1
 XKnnSCEVi1y5UNPl2Peegvl+eV3rh3SPEuKLXwB8zyp0KCFeFmeQqofPV2FY4gRtfzf+FqJr
 o4ObprRk32ztdEShAGLoeb/ynhXdRAG6Wze8pYKHgJ+ClM6Qz94VZc9P5t7K9M690iqqgs41
 irhCh4HmQaXaYzvLASOYzhjZtvSsWVX8BoG0dgXFQ/wgRALON/zhI9BLMFfVed8q4ReIQtcF
 KJtlzOoWa8XEmyvFvV0RcWVkbGOgzzy2FnWZXL5MWdgF3OiLiSQkuLZksLU3HFmJkKKWQEW/
 9VMCiuzrUI/ejlf
IronPort-HdrOrdr: A9a23:Ih/BAa3QV6Tie6M61/ggHgqjBIYkLtp133Aq2lEZdPU1SK2lfq
 WV954mPHDP+VUssR0b9OxoQZPwJ080rKQFmLX5Xo3NYOCFggeVxehZhOPfK1eJIVyHygc378
 hdmsZFaOEZATBB/KTHCATRKadG/DGMmJrY4Ns3wB9WPGVXV50=
X-Talos-CUID: 9a23:Cd68tm7BQIXxQ4hpldss0HUqJ+4ZYGHn8VyXKmuKBURyR7C8cArF
X-Talos-MUID: 9a23:THZ6cwgtBX93Pm4gGx41ssMpPsVr2vWtCEUxlL5dhJWOEXVcNyihtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="8'?scan'208";a="23386228"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 19:37:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 9EDE94196798
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:37:51 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WUB7r3yLvS6z for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 19:37:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 0D7AD41A16AD
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:37:51 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NMqDUBmTFrQx for <netdev@vger.kernel.org>;
 Tue,  5 Nov 2024 19:37:50 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id EAF0741A1693
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:37:50 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8PNA-000000000p6-09nb
	for netdev@vger.kernel.org;
	Tue, 05 Nov 2024 19:37:52 +0000
Date: Tue, 5 Nov 2024 19:37:51 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-dcbx.8: some remarks and editorial changes for this manual
Message-ID: <Zyp0DxgipVa8KZSN@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="B2J/ivnPufGe0hG1"
Content-Disposition: inline


--B2J/ivnPufGe0hG1
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

diff --git a/dcb-dcbx.8 b/dcb-dcbx.8.new
index bafc18f..790c56c 100644
--- a/dcb-dcbx.8
+++ b/dcb-dcbx.8.new
@@ -2,24 +2,23 @@
 .SH NAME
 dcb-dcbx \- show / manipulate port DCBX (Data Center Bridging eXchange)
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B dcbx
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb dcbx show dev
-.RI DEV
+.I DEV
 
 .ti -8
 .B dcb dcbx set dev
-.RI DEV
+.I DEV
 .RB "[ " host " ]"
 .RB "[ " lld-managed " ]"
 .RB "[ " cee " ]"
@@ -29,16 +28,20 @@ dcb-dcbx \- show / manipulate port DCBX (Data Center Bridging eXchange)
 .SH DESCRIPTION
 
 Data Center Bridging eXchange (DCBX) is a protocol used by DCB devices to
-exchange configuration information with directly connected peers. The Linux DCBX
-object is a 1-byte bitfield of flags that configure whether DCBX is implemented
-in the device or in the host, and which version of the protocol should be used.
+exchange configuration information with directly connected peers.
+The Linux DCBX object is a 1-byte bitfield of flags that configure whether
+DCBX is implemented in the device or in the host,
+and which version of the protocol should be used.
 .B dcb dcbx
 is used to access the per-port Linux DCBX object.
 
 There are two principal modes of operation: in
 .B host
-mode, DCBX protocol is implemented by the host LLDP agent, and the DCB
-interfaces are used to propagate the negotiate parameters to capable devices. In
+mode,
+DCBX protocol is implemented by the host LLDP agent,
+and the DCB interfaces are used to propagate the negotiate parameters to
+capable devices.
+In
 .B lld-managed
 mode, the configuration is handled by the device, and DCB interfaces are used
 for inspection of negotiated parameters, and can also be used to set initial
@@ -47,19 +50,21 @@ parameters.
 .SH PARAMETERS
 
 When used with
-.B dcb dcbx set,
-the following keywords enable the corresponding configuration. The keywords that
-are not mentioned on the command line are considered disabled. When used with
-.B show,
+.BR "dcb dcbx set" ,
+the following keywords enable the corresponding configuration.
+The keywords that are not mentioned on the command line are considered
+disabled.
+When used with
+.BR show ,
 each enabled feature is shown by its corresponding keyword.
 
 .TP
 .B host
 .TQ
 .B lld-managed
-The device is in the host mode of operation and, respectively, the lld-managed
-mode of operation, as described above. In principle these two keywords are
-mutually exclusive, but
+The device is in the host mode of operation and, respectively,
+the lld-managed mode of operation, as described above.
+In principle these two keywords are mutually exclusive, but
 .B dcb dcbx
 allows setting both and lets the driver handle it as appropriate.
 
@@ -67,15 +72,17 @@ allows setting both and lets the driver handle it as appropriate.
 .B cee
 .TQ
 .B ieee
-The device supports CEE (Converged Enhanced Ethernet) and, respectively, IEEE
-version of the DCB specification. Typically only one of these will be set, but
+The device supports CEE (Converged Enhanced Ethernet) and, respectively,
+IEEE version of the DCB specification.
+Typically only one of these will be set, but
 .B dcb dcbx
 does not mandate this.
 
 .TP
 .B static
-indicates the engine supports static configuration. No actual negotiation is
-performed, negotiated parameters are always the initial configuration.
+indicates the engine supports static configuration.
+No actual negotiation is performed,
+negotiated parameters are always the initial configuration.
 
 .SH EXAMPLE & USAGE
 

--B2J/ivnPufGe0hG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-dcbx.8"

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

Output from "mandoc -T lint dcb-dcbx.8": (possibly shortened list)

mandoc: dcb-dcbx.8:5:2: WARNING: skipping paragraph macro: sp after SH

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

18:.RI DEV
22:.RI DEV

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

32:exchange configuration information with directly connected peers. The Linux DCBX
41:interfaces are used to propagate the negotiate parameters to capable devices. In
51:the following keywords enable the corresponding configuration. The keywords that
52:are not mentioned on the command line are considered disabled. When used with
61:mode of operation, as described above. In principle these two keywords are
71:version of the DCB specification. Typically only one of these will be set, but
77:indicates the engine supports static configuration. No actual negotiation is

-.-.

Split a punctuation from a single argument, if a two-font macro is meant

53:.B show,

-.-.

No space is needed before a quote (") at the end of a line

11:.RI "[ " OPTIONS " ] "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':11
troff:<stdin>:11: warning: trailing space in the line


--B2J/ivnPufGe0hG1--

