Return-Path: <netdev+bounces-141311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB19BA73A
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9271C20F1D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D017B4E9;
	Sun,  3 Nov 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="B8fPycFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4014D718
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730654091; cv=none; b=VawTosXpU0y/6VQWB5Tzt97ytYni4m2woFQ6LXUfTCIewm5zZyoA72mwY7uG7KAi6S/A2ritrqP1s/Xd2WORKPj52Rxx2sTsIC3RVBHxizgld9T9/AuN7K1VMgqxZhF8nrGGbVvHN+EE4GU20l1YPCHNrcZfB7tfFMJTN71YLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730654091; c=relaxed/simple;
	bh=zcRHdb8amWzYx53GjvOThueDuT7taEZfFXOQUNMc2zs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KSg23EhNlIOk5GVy948Oxa1YiIyHq1HvnkaaCEyTIJfyeSL1vPbk6awbYFvPwHqoPUvNdFbY1rbWwEKgWc/SPCOE13EQGabitJ1/Pzwba0b1B0I8m5xbNmwDuom4yHb/bWWVVXXTtoQ+DlQ1eAQc9lAX4gNQLdfbTwLjlcH7uBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=B8fPycFS; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730654087; x=1762190087;
  h=date:from:to:subject:message-id:mime-version;
  bh=0T9ZkDU4XMlI+G/JgAoznSaPZb33dQmZ1f5nzq30XYw=;
  b=B8fPycFS2DBjYIn8YoomaQ3+ev0V65MHGOWOXVyjhngO3MkCFe4hXAEJ
   6Iqze6IJYwHZaDhtvtIr8qBdWdfDd054KHzGNwUwnq7G6g+pOuZ03LZ/p
   ALzehq/atJL/XAFp6/7NmgBMoWqleHGo+rLDBT4r1mxtAIujA2nEanoNg
   hoCyf7aMyjsnYITbEQtRQNIZuI0/8gQ8mbvYbJwyQitjSHkW/ohKWRYMw
   7+Cc64eIRP6UWsPRN5ew0iMQNG1BVLFgR9ekKy/vuwdGE3VHLdVojLJ33
   7Ak6FG+7Myp+2IOvEHACvxVES54OSl0VmLu0NWNms8Rpi+l4PwpjJGLeq
   A==;
X-CSE-ConnectionGUID: JwVi+vivT+qQ9xPSrj/huA==
X-CSE-MsgGUID: VDeWsIn0Tx6ICqUSFHCyPA==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2FMAgAtrCdnhVjoacJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCHCh9gWSIJY4fgRaCEpx2BwEBAQ8xEwQBAQSPNyg4EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQ4BAQYBAQEBAQEGBwIQAQEBAUAOO4U1Rg2FLCyCe1+DAQGCZK4ng?=
 =?us-ascii?q?TSBAYMc2xeBXBCBSIVqgmIBhWmEdzwGgg2BFTWBBm1KdosHBIIyFXw6gT0Mg?=
 =?us-ascii?q?g4SJYIvgRCFVoglgleBTopxgWkDWSERAVUTFwsHBYF5A4NRgTmBUYMgSoNZg?=
 =?us-ascii?q?UJGPzeCE2lNOgINAjaCJH2CToMYggeEcIRqQB02CgMLbT01FBufAwFGgjUvQ?=
 =?us-ascii?q?wEBBTcyHwt5LRMDMAYECx0BIS+SeUSPQ4FEjEyTUYE+hCSGW4MwgguVQzOEB?=
 =?us-ascii?q?JM7DDqSRph3o20ZhRuBfoF/LAcaCDA7gmcJSRkPjioZgQwBAwSHIr9oeDsCB?=
 =?us-ascii?q?wsBAQMJkGsBAQ?=
IronPort-PHdr: A9a23:yYMkaRYbuOiumusNVWaEl3D/LTAChN3EVzX9i7I8jq5WN6O+49G6Z
 wrE5PBrgUOPXJ6Io/5Hiu+DtafmVCRA5Juaq3kNfdRKUANNksQZmQEsQYaFBET3IeSsbnk8G
 8JPPGI=
IronPort-Data: A9a23:IXlojKy3Mk3bPbdU1wF6t+fAxirEfRIJ4+MujC+fZmQN5Y4CYwd3n
 TpENjTXZOHfICDrL4okddz2tVQOiSLmvoRnQAM+rSEyQ3wR95efXITGcU2uMimccsCdQBg94
 ptAY4GQdcloE3PQrUfzO7aw/HRyiKiEF7D1Ur7ONnsuGAUMpEvN8f5Gs7dRbtlA3oXmXmthw
 O/PnvAzGGNJ+hYqPGxM4v2P8Uhi5Kur4WMT4gRha65A5wXUyyVMXJlOL4i8fiDyKmV2NrfhH
 r6cltlV3Y94EzMFUI7NfmPTKxVSKlLqFVHTzCIQA+772kQqShUais4TLOAbZVpclwKHltVwz
 MQlnZGrQG/FBIWV8Agme0ceSngW0ZFuouedfSHm6ZfLlSUqTlO1qxlQJBBnVWEn0r4f7VFmr
 ZQwND0LZxafsOO6qJrTpj5E35lLwGHDZevzi1k4pd3rJa9OraPrH80m0eRlMAIY3aiiKxpxi
 /0xMlKDZDyYC/FG18x+5JgWxI9EjVGnG9FURc78SQPaLAE/wSQouIUBPuY5dfSoWvtU3ViZu
 F6F5l2oEikhLt7YySespyfEau/nxUsXWaoMFaaks+xrhUWJwXwCTUVME0W6uuX/i1XWt9B3c
 h1IvHN28O5orxbtHomVsx6Q+RZoujYWVPJLEug85R3Ly7G8DwOxXDNVEWIcMYZOWMkeexAn6
 USomYvVFWJOm6Socly93aashGbnUcQSBTReNX5bHFdtD8PYiIc+kh7CUP59H6OvyN74Azf9x
 3aNtidWulkIpdAKzLn+71HCmyirtomMFlRz+ATMQiSk9WuVebJJeaSK9mbaruhBMrraV2DQr
 EA/gcrZ7P0nWMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yL4FWy3yG0uTHqFIvo5lSnVj
 Fj7mDg52XO+FGWrdrMycYO0E94t3bmlTY6jSPHPcpxPefCdlTNrHgkwPiZ8PEi0wSDAdJ3T3
 7/BKq5A6l5BUcxaIMKeHbt17FPS7nlWKZnvbZ761Q+79rGVeWSYT7wIWHPXMbthsfze/F2Pq
 IwAXydv9/m5eLGhCsUw2dNLRW3m0VBiX82eRzF/L7LYfFM4cI3fI6OAn+NJl3NZc1R9zbuYr
 y7sBie0OXL6hHnOYQWEAk2Pm5uyNauTWUkTZHR2VX7xgiRLSdj0ts83KcBoFYTLAcQ4lpaYu
 dFeIJ3YWpyii13vp1wgUHUKhNU7JE/221vXYXTNjfpWV8cIejElM+TMJmPHnBTixALu3Sfii
 9VMDj/mfKc=
IronPort-HdrOrdr: A9a23:HGmzbKoGOFP0DcNq1Q45gYkaV5oReYIsimQD101hICG9E/b1qy
 nKpp8mPHDP5wr5NEtPpTnjAsm9qALnlKKdiLN5Vd3OYOCBghrLEGgI1/qA/9SPIVyYysdtkY
 tmbqhiGJnRIDFB/KDHCdCDYrMdKQ+8gcSVuds=
X-Talos-CUID: 9a23:q3ZLwmAVAU102BD6Ewt4yk9XBME7Tj7E9SbAG3SiCyFpVZTAHA==
X-Talos-MUID: 9a23:7iqy6QRR8NPFcWZ7RXTSqDxdL+Zuu5i+VmEmiKg9lemvJBRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="8'?scan'208";a="23974512"
Received: from vist-zimproxy-02.vist.is ([194.105.232.88])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:13:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id 33EAE442866F
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 17:13:35 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id rIgwSYj0qdhW for <netdev@vger.kernel.org>;
 Sun,  3 Nov 2024 17:13:34 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id 535DF442887C
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 17:13:34 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lZYiagp_q_kp for <netdev@vger.kernel.org>;
 Sun,  3 Nov 2024 17:13:34 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTPS id 3EDD2442866F
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 17:13:34 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t7eAR-000000006Bc-0rmJ
	for netdev@vger.kernel.org;
	Sun, 03 Nov 2024 17:13:35 +0000
Date: Sun, 3 Nov 2024 17:13:35 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-app.8: some remarks and editorial changes for this manual
Message-ID: <ZyevP76CiK57k_CZ@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="duav7VVD32ow5N1B"
Content-Disposition: inline


--duav7VVD32ow5N1B
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

  Output from a script "chk_manual" should be in an attachment.

-.-

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

diff --git a/dcb-app.8 b/dcb-app.8.new
index be505a0..dde3d28 100644
--- a/dcb-app.8
+++ b/dcb-app.8.new
@@ -3,20 +3,19 @@
 dcb-app \- show / manipulate application priority table of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B app
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb app " { " show " | " flush " } " dev
-.RI DEV
+.I DEV
 .RB "[ " default-prio " ]"
 .RB "[ " ethtype-prio " ]"
 .RB "[ " stream-port-prio " ]"
@@ -27,7 +26,7 @@ the DCB (Data Center Bridging) subsystem
 
 .ti -8
 .B dcb app " { " add " | " del " | " replace " } " dev
-.RI DEV
+.I DEV
 .RB "[ " default-prio " " \fIPRIO-LIST\fB " ]"
 .RB "[ " ethtype-prio " " \fIET-MAP\fB " ]"
 .RB "[ " stream-port-prio " " \fIPORT-MAP\fB " ]"
@@ -90,7 +89,7 @@ other prioritization rule applies.
 DCB APP entries are 3-tuples of selector, protocol ID, and priority. Selector is
 an enumeration that picks one of the prioritization namespaces. Currently it
 mostly corresponds to configurable parameters described below. Protocol ID is a
-value in the selector namespace. E.g. for EtherType selector, protocol IDs are
+value in the selector namespace. E.g., for EtherType selector, protocol IDs are
 the individual EtherTypes, for DSCP they are individual code points. The
 priority is the priority that should be assigned to traffic that matches the
 selector and protocol ID.
@@ -108,7 +107,7 @@ and
 .B del
 commands. On the other hand, the command
 .B replace
-does what one would typically want in this situation--first adds the new
+does what one would typically want in this situation\(emfirst adds the new
 configuration, and then removes the obsolete one, so that only one
 prioritization is in effect for a given selector and protocol ID.
 
@@ -190,7 +189,7 @@ will only use the higher six bits).
 .B dcb app show
 will similarly format DSCP values as symbolic names if possible. The
 command line option
-.B -N
+.B \-N
 turns the show translation off.
 
 .TP
@@ -199,8 +198,8 @@ turns the show translation off.
 .BR dcb (8)
 for details. Keys are PCP/DEI. Values are priorities assigned to traffic with
 matching PCP/DEI. PCP/DEI values are written as a combination of numeric- and
-symbolic values, to accommodate for both. PCP always in numerical form e.g
-0 .. 7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the
+symbolic values, to accommodate for both. PCP always in numerical form e.g.,
+0 .. 7 and DEI in symbolic form, e.g., 'de' (drop-eligible), indicating that the
 DEI bit is 1 or 'nd' (not-drop-eligible), indicating that the DEI bit is 0.
 In combination 2de:1 translates to a mapping of PCP=2 and DEI=1 to priority 1.
 
@@ -220,7 +219,7 @@ Add another rule to configure DSCP 24 to priority 2 and show the result:
 .br
 dscp-prio 0:0 CS3:2 CS3:3 CS6:6
 .br
-# dcb -N app show dev eth0 dscp-prio
+# dcb \-N app show dev eth0 dscp-prio
 .br
 dscp-prio 0:0 24:2 24:3 48:6
 
@@ -230,7 +229,7 @@ priority 4:
 .P
 # dcb app replace dev eth0 dscp-prio 24:4
 .br
-# dcb app -N show dev eth0 dscp-prio
+# dcb app \-N show dev eth0 dscp-prio
 .br
 dscp-prio 0:0 24:4 48:6
 

--duav7VVD32ow5N1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-app.8"

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

Output from "mandoc -T lint dcb-app.8": (possibly shortened list)

mandoc: dcb-app.8:6:2: WARNING: skipping paragraph macro: sp after SH

-.-.

Change two HYPHEN-MINUSES (code 0x2D) to an em-dash (\(em),
if one is intended.
  " \(em " creates a too big gap in the text (in "troff").

An en-dash is usually surrounded by a space,
while an em-dash is used without spaces.
"man" (1 byte characters in input) transforms an en-dash (\(en) to one
HYPHEN-MINUS,
and an em-dash to two HYPHEN-MINUSES without considering the space
around it.
If "--" are two single "-" (end of options) then use "\-\-".

dcb-app.8:111:does what one would typically want in this situation--first adds the new

-.-.

Change -- in x--y to \(em (em-dash), or, if an
option, to \-\-

111:does what one would typically want in this situation--first adds the new

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
30:.RI DEV

-.-.

Use a macro to change to the italic font, instead of \fI, if
possible (see man-pages(7)).
The macros have the italic corrections, but "\c" removes the "\/" part,
which is in the macro.
So "\/" must be added between the italic argument and the "\c" string.

  Or

add the italic corrections.

154:rules are configured as triplets (\fBEtherType\fR, \fB0\fR, \fIPRIO\fR).
162:\fIET-MAP\fR uses the array parameter syntax, see
173:\fIPORT-MAP\fR uses the array parameter syntax, see
181:\fIDSCP-MAP\fR uses the array parameter syntax, see
198:\fIPCP-MAP\fR uses the array parameter syntax, see

-.-.

Change a HYPHEN-MINUS (code 0x2D) to a minus(-dash) (\-),
if it
is in front of a name for an option,
is a symbol for standard input,
is a single character used to indicate an option,
or is in the NAME section (man-pages(7)).
N.B. - (0x2D), processed as a UTF-8 file, is changed to a hyphen
(0x2010, groff \[u2010] or \[hy]) in the output.

193:.B -N
223:# dcb -N app show dev eth0 dscp-prio
233:# dcb app -N show dev eth0 dscp-prio

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

93:value in the selector namespace. E.g. for EtherType selector, protocol IDs are

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

85:Center Bridging) subsystem. The APP table is used to assign priority to traffic
87:DSCP. It also allows configuration of port-default priority that is chosen if no
90:DCB APP entries are 3-tuples of selector, protocol ID, and priority. Selector is
91:an enumeration that picks one of the prioritization namespaces. Currently it
92:mostly corresponds to configurable parameters described below. Protocol ID is a
93:value in the selector namespace. E.g. for EtherType selector, protocol IDs are
94:the individual EtherTypes, for DSCP they are individual code points. The
98:The APP table is a set of DCB APP entries. The only requirement is that
99:duplicate entries are not added. Notably, it is valid to have conflicting
100:priority assignment for the same selector and protocol ID. For example, the set
102:10 should get priority of both 1 and 2, form a well-defined APP table. The
109:commands. On the other hand, the command
119:Display all entries with a given selector. When no selector is given, shows all
124:Remove all entries with a given selector. When no selector is given, removes all
137:present in the APP table yet. Then remove those entries, whose selector and
139:priority. This has the effect of, for the given selector and protocol ID,
146:\fBadd\fR, \fBdel\fR and \fBreplace\fR commands. For \fBshow\fR and \fBflush\fR,
152:unspecified. The argument is a list of individual priorities. Note that
164:for details. Keys are EtherType values. Values are priorities to be assigned to
175:for details. Keys are L4 destination port numbers that match on, respectively,
176:TCP and SCTP traffic, UDP and DCCP traffic, and either of those. Values are
183:for details. Keys are DSCP points, values are priorities assigned to
184:traffic with matching DSCP. DSCP points can be written either directly as
191:will similarly format DSCP values as symbolic names if possible. The
200:for details. Keys are PCP/DEI. Values are priorities assigned to traffic with
201:matching PCP/DEI. PCP/DEI values are written as a combination of numeric- and
202:symbolic values, to accommodate for both. PCP always in numerical form e.g
203:0 .. 7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line

Output from "test-nroff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line

-.-.

--duav7VVD32ow5N1B--

