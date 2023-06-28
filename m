Return-Path: <netdev+bounces-14354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E408740747
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B9828116A
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D59A4E;
	Wed, 28 Jun 2023 00:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6C7E2
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 00:45:02 +0000 (UTC)
Received: from smtp-out1-05.simnet.is (smtp-out1-05.simnet.is [194.105.231.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29B2728
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1687913099; x=1719449099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ee/9/ZZUQ+Rn6p+2OhA86NW317R66sLFxUiZW0gSiWY=;
  b=Q1Rnj5VVPB/lYicbOAlujnJPOEUFFloisUwjSaIE+58196UNPd9mSsnA
   iAGmYtk5rGGLH6UAw5++C/EAEuZdQEFeiXgvx0ZbqUmW134Zzt/bGEVtv
   pqEpfP2Bm6sT+f6pFwAuxsSLv8NelfqHZ/2IH7haw6fMu/yobjp5UaYAZ
   kj4im1+o19zypZidA4BkRuFvUzSy91znthfgvmjF13wRzExPy6uh91rG/
   kswzAEMXd4HMnktxSbHIBe7QjqHJh+afP4MNV8dx0l/60f6QrSpMT3W3O
   GDyF/fG7bkCtJN8ZyQb+3zdzxHSczCsRJvTg1JjsEOUWnTPE/xztGamae
   g==;
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 4.4
X-IPAS-Result: =?us-ascii?q?A2ETAAC7fZtkkFnoacJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIKKHWBXIghhE6GToIlJR4DhXGLQYFQim8UgXkBAQEPMRMEAQEEA?=
 =?us-ascii?q?4FMgzMChhAnNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEGBgIQAQEBA?=
 =?us-ascii?q?QEBIB4QDieFLzkNhF0sCAVZAQEdAQEBAQM6PxALEQMBAgEuED8IBhOCfgGCX?=
 =?us-ascii?q?K9peIE0gQGCYzWwDoFogUIBkWw8BoINglGBbz6ECoZ8BIIThzuBUA4MOYIug?=
 =?us-ascii?q?zSCLwcyCYFaMYl6gShvgR6BIHoCCQIRZ4EICF+Bbj4CDVULC2OBHIJSAgIRJ?=
 =?us-ascii?q?xMUQRJ4HQMHA4EFEC8HBDIfCQYJGBgXJQZRBQItJAkTFUEEg1gKgQ0/FQ4Rg?=
 =?us-ascii?q?loiAgc2PxtRgm0JFw49RwNEHUADez01FB8GJ0iBVzCBSyQkoRqCZBEzAVgsC?=
 =?us-ascii?q?iuBHAVkBEAykjcCAQcKjwOhEYE3hBKLfYMLhAeGe4dXg25MgQqLFoYoDDmRf?=
 =?us-ascii?q?pgfjV2VHQ8DGYUWgUEighYsBxoIMIMiCUkZD49IAQQDh1guijYBdTsCBwsBA?=
 =?us-ascii?q?QMJhkuEH14BAQ?=
IronPort-PHdr: A9a23:e6VioxySx+tqKZDXCzPyngc9DxPP2p3vOxINr506l/cWL+K4/pHkM
 VCZ5O4+xFPKXICO7fVChqKWtq37QmUP7N6Ht2xKa51DURIJyI0WkgUsDdTDCBj9K/jnBxE=
IronPort-Data: A9a23:i9sK2aMnIUDxer/vrR1wl8FynXyQoLVcMsEvi/4bfWQNrUp03zMGz
 WtLXTqBO/qJYWPweYp2Ooi/oR4AvZ7Vn4A2HnM5pCpnJ55ogZOeXIzGdC8cHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E3ratANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtcAbeORXUXV4
 Lsen+WFYAX+g2AubTpPg06+gEoHUMra6WJwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQgMQnSOvVVO3gWAEFIxFPICX+y7+y+zGieSiPt7MxgMRk6bYYe3ekiVAmi9
 dRAQNwMRg6CnP7z0rO+UvNrltVmdJKtIoIEpjdh1lk1D95/EMyFGv2Xo4UDhnFg16iiHt6HD
 yYdQTBuahvBbBxUEkwWDZQzgKGpnRETdhUJ8A7E+/druAA/yiRJ8ua2MpnZWOaSH8JYghaZh
 2/U71zmV0Ry2Nu3kmbVoy392ocjhxjTQ54fDL218NZsjUGMwXYQEBkLUFG2u7++kEHWc9RSN
 0AZ5AIwoqUosk+mVN/wW1u/unHsg/IHc8RRCPF/+gCI0rDT8xfcXjNCUD9adJonr6faWADGy
 HeOko3JKD9K6ITNSF2k+IrMoWO5Pw8aeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMWyoq
 9xthHVl74j/nfLnxI3loA6X2WzESozhC1dlvlqGAQpJ+ysgPNbNWmC+1bTMxdd7RGpzZnCCo
 WIJitKfhAzlJc/VzERhrM0rG6u15/uMKyG0vLKCN4cg7Cjo6X+mZZpX8CA7fBwvLMcfZXnoe
 yc/WD+9BrcPYxNGjoctOupd7vjGK4C7TrwJsdiOP7JzjmBZLlPvwc2XTRf4M5rRuEYti7ojH
 pyQbNyhC30XYYw+kmrpF7ZFj+V7lnxmrY82eXwd50n/uVZ5TCPPIYrpzHPXN4jVEYvd+l6Oo
 ow32zWil0oCOAEBXsUn2dVPfQFVfCRT6WHers1Tf6aDLGJb9JIJVpfsLUcaU9U9xcx9z76Yl
 lnjARUw4ASk2hX6xfCiNiwLhEXHBswk/BrW/EUEYT6V5pTUSdn3tvZHJ8VmItHKNoVLlJZJc
 hXMQO3Yatwnd9gN0211gUXVxGC6SCmWuA==
IronPort-HdrOrdr: A9a23:wQSxjaGd4kwQY0i0pLqE6ceALOsnbusQ8zAXPo5KOH5om+ij5r
 iTdZUgpGbJYVkqOU3I9erhBEDEewKmyXcX2/h2AV7BZniDhILAFugLhuGOr1KPJ8S9zJ876U
 4KSdkaNDSfNykYsfrH
X-Talos-CUID: 9a23:sxu0gWHaLhqq2pvoqmJg+RA0N8MAKkSFzVjpLXLgBTZiTpqaHAo=
X-Talos-MUID: 9a23:vhfsQQqTLWRoytS3o6EezwlAapxqoKiMMlhXlpga68ilOD5gAyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,163,1684800000"; 
   d="scan'208";a="90496543"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 00:44:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 5E72F412AEA5;
	Wed, 28 Jun 2023 00:44:55 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id S0WOO8u70JZq; Wed, 28 Jun 2023 00:44:54 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 1A7E6412AEA7;
	Wed, 28 Jun 2023 00:44:54 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UIzWVgDQw9eQ; Wed, 28 Jun 2023 00:44:54 +0000 (GMT)
Received: from kassi.invalid.is.lan (85-220-7-150.dsl.dynamic.simnet.is [85.220.7.150])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id D4734412AE9B;
	Wed, 28 Jun 2023 00:44:53 +0000 (GMT)
Received: from bg by kassi.invalid.is.lan with local (Exim 4.96)
	(envelope-from <bingigis@simnet.is>)
	id 1qEJIj-00013w-1o;
	Wed, 28 Jun 2023 00:44:53 +0000
Date: Wed, 28 Jun 2023 00:44:53 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: tc.8:  some remarks and a patch for the manual
Message-ID: <ZJuChT7GPgEpORaQ@localhost>
References: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
 <20230627103849.7bce7b54@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627103849.7bce7b54@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 10:38:49AM -0700, Stephen Hemminger wrote:
> On Sat, 24 Jun 2023 21:43:21 +0000
> Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:
> 
> > Package: iproute2
> > Version: 6.3.0
> > Severity: minor
> > Tags: patch
> > 
> > Dear Maintainer,
> > 
> > here are some notes and a patch.
> > 
> > The difference between the formatted outputs can be seen with:
> > 
> >   nroff -man <file1> > <out1>
> >   nroff -man <file2> > <out2>
> >   diff -u <out1> <out2>
> > 
> > and for groff, using
> > 
> > "groff -man -Z" instead of "nroff -man"
> 
> Overall this looks fine but:
> 1. Make the commit message more succinct and clearer, don't need to write a letter.
> 2. Lines with starting with # get ignored by git when committing
> 3. Missing Signed-Off-by which is required for all iproute2 patches.
> 
> Running checkpatch on this patch will show these things.

  Here is a simplified patch based on the latest "iproute2" repository.

  Output from "checkpatch.pl" when run in the "git/iproute2" directory
with the patch:

Must be run from the top-level dir. of a kernel tree

Patch:

From fc0bd90193ff11babb96bf8ae5658177e3465aeb Mon Sep 17 00:00:00 2001
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
Date: Wed, 28 Jun 2023 00:30:51 +0000
Subject: [PATCH] iproute2/man/man8/tc.8: some editorial changes to the man
 page

  Improve the layout of the man page according to the "man-page(7)"
guidelines, the output of "mandoc -lint T", the output of
"groff -ww -z -rSTYLECHECK=3", that of a shell script, and typographical
conventions.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>
---
 man/man8/tc.8 | 86 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d464..e9d5d566 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -18,7 +18,7 @@ tc \- show / manipulate traffic control settings
 \fIBLOCK_INDEX\fR ] qdisc
 [ qdisc specific parameters ]
 .P
-
+.
 .B tc
 .RI "[ " OPTIONS " ]"
 .B class [ add | change | replace | delete | show ] dev
@@ -29,7 +29,7 @@ tc \- show / manipulate traffic control settings
 \fIclass-id\fR ] qdisc
 [ qdisc specific parameters ]
 .P
-
+.
 .B tc
 .RI "[ " OPTIONS " ]"
 .B filter [ add | change | replace | delete | get ] dev
@@ -121,13 +121,13 @@ tc \- show / manipulate traffic control settings
 .P
 .ti 8
 .IR OPTIONS " := {"
-\fB[ -force ] -b\fR[\fIatch\fR] \fB[ filename ] \fR|
-\fB[ \fB-n\fR[\fIetns\fR] name \fB] \fR|
-\fB[ \fB-N\fR[\fIumeric\fR] \fB] \fR|
-\fB[ \fB-nm \fR| \fB-nam\fR[\fIes\fR] \fB] \fR|
-\fB[ \fR{ \fB-cf \fR| \fB-c\fR[\fIonf\fR] \fR} \fB[ filename ] \fB] \fR
-\fB[ -t\fR[imestamp\fR] \fB\] \fR| \fB[ -t\fR[short\fR] \fR| \fB[
--o\fR[neline\fR] \fB]\fR }
+\fB[ \-force ] \-b\fR[\fIatch\fR] \fB[ filename ] \fR|
+\fB[ \fB\-n\fR[\fIetns\fR] name \fB] \fR|
+\fB[ \fB\-N\fR[\fIumeric\fR] \fB] \fR|
+\fB[ \fB\-nm \fR| \fB\-nam\fR[\fIes\fR] \fB] \fR|
+\fB[ \fR{ \fB\-cf \fR| \fB\-c\fR[\fIonf\fR] \fR} \fB[ filename ] \fB]\fR
+\fB[ \-t\fR[imestamp\fR] \fB] \fR| \fB[ \-t\fR[short\fR] \fR| \fB[
+\-o\fR[neline\fR] \fB]\fR }
 
 .ti 8
 .IR FORMAT " := {"
@@ -147,9 +147,10 @@ of the following:
 
 .TP
 SHAPING
-When traffic is shaped, its rate of transmission is under control. Shaping may
-be more than lowering the available bandwidth - it is also used to smooth out
-bursts in traffic for better network behaviour. Shaping occurs on egress.
+When traffic is shaped, its rate of transmission is under control.
+Shaping may be more than lowering the available bandwidth \(en
+it is also used to smooth out bursts in traffic for better network
+behaviour. Shaping occurs on egress.
 
 .TP
 SCHEDULING
@@ -186,9 +187,9 @@ First In, First Out queue. It does however store traffic when the network interf
 can't handle it momentarily.
 
 .SH CLASSES
-Some qdiscs can contain classes, which contain further qdiscs - traffic may
+Some qdiscs can contain classes, which contain further qdiscs \(en traffic may
 then be enqueued in any of the inner qdiscs, which are within the
-.B classes.
+.BR classes .
 When the kernel tries to dequeue a packet from such a
 .B classful qdisc
 it can come from any of the classes. A qdisc may for example prioritize
@@ -207,7 +208,7 @@ available. This differs per qdisc.
 
 It is important to notice that filters reside
 .B within
-qdiscs - they are not masters of what happens.
+qdiscs \(en they are not masters of what happens.
 
 The available filters are:
 .TP
@@ -326,7 +327,8 @@ separate queue with less priority so that bulk traffic does not affect the
 latency of critical traffic.
 .TP
 ingress
-This is a special qdisc as it applies to incoming traffic on an interface, allowing for it to be filtered and policed.
+This is a special qdisc as it applies to incoming traffic on an
+interface, allowing for it to be filtered and policed.
 .TP
 mqprio
 The Multiqueue Priority Qdisc is a simple queuing discipline that allows
@@ -427,7 +429,12 @@ bandwidth-sharing bands to implement the transmission selection described in
 802.1Qaz.
 .TP
 HFSC
-Hierarchical Fair Service Curve guarantees precise bandwidth and delay allocation for leaf classes and allocates excess bandwidth fairly. Unlike HTB, it makes use of packet dropping to achieve low delays which interactive sessions benefit from.
+Hierarchical Fair Service Curve guarantees precise bandwidth
+and delay allocation for leaf classes and allocates excess bandwidth
+fairly.
+Unlike HTB,
+it makes use of packet dropping to achieve low delays
+which interactive sessions benefit from.
 .TP
 HTB
 The Hierarchy Token Bucket implements a rich linksharing hierarchy of
@@ -655,8 +662,9 @@ parameter.
 
 .TP
 delete
-A qdisc can be deleted by specifying its handle, which may also be 'root'. All subclasses and their leaf qdiscs
-are automatically deleted, as well as any filters attached to them.
+A qdisc can be deleted by specifying its handle, which may also be 'root'.
+All subclasses and their leaf qdiscs are automatically deleted,
+as well as any filters attached to them.
 
 .TP
 change
@@ -704,9 +712,10 @@ read commands from provided file or standard input and invoke them.
 First failure will cause termination of tc.
 
 .TP
-.BR "\-force"
+.B \-force
 don't terminate tc on errors in batch mode.
-If there were any errors during execution of the commands, the application return code will be non zero.
+If there were any errors during execution of the commands,
+the application return code will be non zero.
 
 .TP
 .BR "\-o" , " \-oneline"
@@ -729,15 +738,15 @@ to the specified network namespace
 Actually it just simplifies executing of:
 
 .B ip netns exec
-.IR NETNS
+.I NETNS
 .B tc
-.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " | "
+.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " |"
 .BR help " }"
 
 to
 
 .B tc
-.RI "-n[etns] " NETNS " [ " OPTIONS " ] " OBJECT " { " COMMAND " | "
+.RI "\-n[etns] " NETNS " [ " OPTIONS " ] " OBJECT " { " COMMAND " |"
 .BR help " }"
 
 .TP
@@ -748,7 +757,7 @@ converting it to human readable name.
 .TP
 .BR "\-cf" , " \-conf " <FILENAME>
 specifies path to the config file. This option is used in conjunction with other options (e.g.
-.BR -nm ")."
+.BR \-nm ")."
 
 .TP
 .BR "\-t", " \-timestamp"
@@ -781,15 +790,15 @@ for u32 filter, decode offset and mask values to equivalent filter commands base
 In JSON output, add whitespace to improve readability.
 
 .TP
-.BR "\-iec"
-print rates in IEC units (ie. 1K = 1024).
+.B \-iec
+print rates in IEC units (i.e. 1\~K = 1024).
 
 .TP
 .BR "\-g", " \-graph"
 shows classes as ASCII graph. Prints generic stats info under each class if
-.BR "-s"
+.B \-s
 option was specified. Classes can be filtered only by
-.BR "dev"
+.B dev
 option.
 
 .TP
@@ -806,7 +815,7 @@ precedence. This flag is ignored if
 is also given.
 
 .TP
-.BR "\-j", " \-json"
+.BR \-j ", " \-json
 Display results in JSON format.
 
 .TP
@@ -814,7 +823,7 @@ Display results in JSON format.
 resolve class name from
 .B /etc/iproute2/tc_cls
 file or from file specified by
-.B -cf
+.B \-cf
 option. This file is just a mapping of
 .B classid
 to class name:
@@ -838,13 +847,13 @@ to class name:
 .RS
 .B tc
 will not fail if
-.B -nm
+.B \-nm
 was specified without
-.B -cf
+.B \-cf
 option but
 .B /etc/iproute2/tc_cls
 file does not exist, which makes it possible to pass
-.B -nm
+.B \-nm
 option for creating
 .B tc
 alias.
@@ -857,13 +866,13 @@ cookie, etc.) and stats. This option is currently only supported by
 .BR "tc filter show " and " tc actions ls " commands.
 
 .SH "EXAMPLES"
-.PP
-tc -g class show dev eth0
+.
+tc \-g class show dev eth0
 .RS 4
 Shows classes as ASCII graph on eth0 interface.
 .RE
 .PP
-tc -g -s class show dev eth0
+tc \-g \-s class show dev eth0
 .RS 4
 Shows classes as ASCII graph with stats info under each class.
 .RE
@@ -905,7 +914,8 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-tcindex (8),
 .BR tc-u32 (8),
 .br
-.RB "User documentation at " http://lartc.org/ ", but please direct bugreports and patches to: " <netdev@vger.kernel.org>
+.RB "User documentation at " http://lartc.org/ ", \
+but please direct bugreports and patches to: " <netdev@vger.kernel.org>
 
 .SH AUTHOR
 Manpage maintained by bert hubert (ahu@ds9a.nl)
-- 
2.40.1



