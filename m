Return-Path: <netdev+bounces-13746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123D73CCD3
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 23:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C082810D2
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB9D533;
	Sat, 24 Jun 2023 21:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BAA953
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 21:44:39 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 14:44:33 PDT
Received: from smtp-out1-05.simnet.is (smtp-out1-05.simnet.is [194.105.231.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6762E1
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1687643074; x=1719179074;
  h=date:from:to:subject:message-id:mime-version;
  bh=BKiGqNRTcFWl7O1NHwl8Njh9j2Ffqnh53rz55pZ2gWM=;
  b=fWAsO0p26xAKWAFPvUHB/un84B87/oBMbNJNV4uCWj8pcHecpaA4vQM3
   7PqrgYUr8SV3KjcSYUpp0qVfoJd9k1+CXQ9d46iTUlUsySuWYy8sjuHip
   Q6nH9fApUgnseJyavp9G1O02X9B5fF2OgfFJJzpeGKCQWndIGDTRUlYra
   UbmtFPF1ttajQZhE0+6yW68lx3Vf/454BtGisMtmmiBvZXdMFGYLITOMq
   3q4ai/ZlK84Dfw6I6v5fliGPVnB/grJQSdSSPUFttVd10DFQW8Ux2d0Eb
   OQzkj2YunvgXyM5ZCQ6O8Sy9E45ed8de5qfNkqcdRZPfvBWvDpv7K/Dg3
   w==;
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 4.4
X-IPAS-Result: =?us-ascii?q?A2EaAADVXZdkkFnoacJQCh0BAQEBCQESAQUFAUCBOwgBC?=
 =?us-ascii?q?wGCCih1gVyIIYROhk6CaIEWkB6MPxSBeQEBAQ8xEwQBAQQDiwcnNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQYBAQEBAQEGBgIQAQEBAQEBIB4OECeFLzkNhF0sD?=
 =?us-ascii?q?YEZAQwTOIEuIQmCJlgBglyuEYEBM4EBgmI1sA6BaIFCAZFqPAaCDRKBAzOBC?=
 =?us-ascii?q?W1KdoQKDQSGawSCE4dFgU8BDQELATmCLoFvS3mCLwcyCYFCiiCBKG+BHjlne?=
 =?us-ascii?q?gIJAhFngQgIYIFxQAINVAsLY4EcglICAhE6FEESXxkbAwcDgQUQLwcEMigGC?=
 =?us-ascii?q?RgvJQZRBQIXFiQJExVBBINYCoEMPxUOEYJYIgIHNj8bUYJsCRcOOQMJAwcFL?=
 =?us-ascii?q?B1AAwsYDUsRLDUUH0yBBxdjgXYKSKBzgiw3ARAUHwEBIRsNDgIqCitQAQcBC?=
 =?us-ascii?q?BsKFgUjCAIHAQsNEAcEKQEIDgaSUxACARGPAqEQgTeEEot8gwuEB4Z7hxEzI?=
 =?us-ascii?q?oNfTIEKixaGKAw5kX6YH41ciGyMMRIKDwo0hFiBQSKCFiwHGggwgyIJSRkPj?=
 =?us-ascii?q?ikZgQYBAwECAYciNopkAXU7AgcLAQEDCYZLgiOBfF4BAQ?=
IronPort-PHdr: A9a23:LcsUfBLtKFg+A9Lne9mcuUoyDhhOgF2VFhUQ9oJijK9SN/z+uY/jO
 UrS+bNslwyBUYba7qdCjOzb++DlVHcb6JmM+HYFbNRXVhADhMlX1wwtCcKIEwv6efjtaSFSI
 Q==
IronPort-Data: A9a23:cXtk3K0XrDp4qxO0QvbD5eNxkn2cJEfYwER7XKvMYLTBsI5bpzBSy
 2ZLUDiPO6mNYDb1e493a4+/8EICvcXRn98yGVM63Hw8FHgiRejtXI/AdhiqV8+xwmwvaGo9s
 q3yv/GZdJhcokf0/0vraP65xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2LBVOCvT/
 4uryyHjEAX9gWUsbDhIs/nrRC5H5ZwehhtJ7zTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8Qi0vtYx/yxWZMV7FLH7zXeXvdHI40ffbyfX0a8xLXsJIKQj4L9ZKDQbn
 RAYAGhlghGrmeOt3PepS+x0nMMzPYyzZ8UBu2p8izDCZRokacmSH+OTvYIehmxqwJAfdRrdT
 5NxhT5HZhXGbBxAO0w/E5M7muq0wHjkG9FdgAPN/PdmujKNpOB3+KXVLtmSWvmFftVcg3/bt
 3vd72ihEyhPYbRzzhLeriL92b6T9c/hY6oUGaG0++BCnlKe3CoQBQcQWF/9puO24nNSQPpBK
 lcIvzgvqLAo81y6C4GmGQO5u2LCvwV0t8ds//MS5BzW5qDN/1qiFDJbbwR+dfUdrpYYbGl/v
 rOWpO/BCTtqubyTbHuS8LaIsD+/URT5y0dfPUfoqiNYuLHeTJEPYgHnEIs9QPTr5jHhMXSpk
 2jV/XdWa6A715ZTv5hX62wrlBqNnfAlpCYc5RjNU3O/72uVj6b7P9TABbTzy/FaMIaUR0Kd1
 EXoduCA7fsSSIOMkTSXR/UcWenyoeiEKyGagEUH83gdG9aFpyHLkWN4umgWyKJV3iAsI2GBj
 Kj741I52XOrFCH2BZKbmqroYyjQ8YDuFM7+StffZcdUb556eWevpX8+OhPMgji2wRR3zsnT3
 Kt3l+7wXB727ow6llKLqxs1iOZDKt0WnDmIHsGhp/hZ+efEOBZ5tovpwHPVMrBos/LYyOkk2
 9NeM8LCyxs3bQENSnS/zGLnFnhTdSJTLcmv96R/KLXZSiI4Qz5JNhMk6e99E2CTt/8PzbagE
 7DUchMw9WcTclWcdFvUNSE4OOm/NXu9xFpiVRER0Z+T8yBLSe6SAG03LvPboZFPGDRf8MNJ
IronPort-HdrOrdr: A9a23:fzIlm6kaUdI7bYEar5naefShr7DpDfI53DAbv31ZSRFFG/Fws/
 re+sjztCWE7wr5N0tApTntAsm9qBDnhPpICOsqTNKftWDd0QPCRuwPguXfKlbbak/DH4BmpM
 RdmtBFeaTNMWQ=
X-Talos-CUID: 9a23:58NQCmOLpMYDH+5DVDQ82EQNBpweYCeC7U3vPmaDEz9HYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AS7S72Q/QPXs/wCDSpV8UyQuQf9pQ/afpKGUCqoU?=
 =?us-ascii?q?PpvDHJDVrKzvFnQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,156,1684800000"; 
   d="scan'208";a="90159126"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 21:43:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id C5DBF41230F4
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 21:43:25 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id sieEkbtTdCC5 for <netdev@vger.kernel.org>;
	Sat, 24 Jun 2023 21:43:23 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id D930041263C0
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 21:43:23 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gbdyBXMm-BGm for <netdev@vger.kernel.org>;
	Sat, 24 Jun 2023 21:43:23 +0000 (GMT)
Received: from kassi.invalid.is.lan (85-220-7-150.dsl.dynamic.simnet.is [85.220.7.150])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id BB04D4115E8A
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 21:43:23 +0000 (GMT)
Received: from bg by kassi.invalid.is.lan with local (Exim 4.96)
	(envelope-from <bingigis@simnet.is>)
	id 1qDB2P-0000lP-1a
	for netdev@vger.kernel.org;
	Sat, 24 Jun 2023 21:43:21 +0000
Date: Sat, 24 Jun 2023 21:43:21 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: tc.8:  some remarks and a patch for the manual
Message-ID: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: reportbug 12.0.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Package: iproute2
Version: 6.3.0
Severity: minor
Tags: patch

Dear Maintainer,

here are some notes and a patch.

The difference between the formatted outputs can be seen with:

  nroff -man <file1> > <out1>
  nroff -man <file2> > <out2>
  diff -u <out1> <out2>

and for groff, using

"groff -man -Z" instead of "nroff -man"

#####

Output from "mandoc -T lint tc.8":

mandoc: tc.8:21:1: WARNING: skipping paragraph macro: sp after PP
mandoc: tc.8:32:1: WARNING: skipping paragraph macro: sp after PP
mandoc: tc.8:129:28: WARNING: undefined escape, printing literally: \]
mandoc: tc.8:145:82: STYLE: input text line longer than 80 bytes: is used to configure...
mandoc: tc.8:156:81: STYLE: input text line longer than 80 bytes: By scheduling the tr...
mandoc: tc.8:157:90: STYLE: input text line longer than 80 bytes: for traffic that nee...
mandoc: tc.8:185:83: STYLE: input text line longer than 80 bytes: First In, First Out ...
mandoc: tc.8:230:98: STYLE: input text line longer than 80 bytes: Flow-based classifie...
mandoc: tc.8:252:97: STYLE: input text line longer than 80 bytes: Generic filtering on...
mandoc: tc.8:329:118: STYLE: input text line longer than 80 bytes: This is a special qd...
mandoc: tc.8:346:82: STYLE: input text line longer than 80 bytes: allow one to add del...
mandoc: tc.8:430:244: STYLE: input text line longer than 80 bytes: Hierarchical Fair Se...
mandoc: tc.8:482:81: STYLE: input text line longer than 80 bytes: Userspace programs c...
mandoc: tc.8:513:82: STYLE: input text line longer than 80 bytes: It is customary to e...
mandoc: tc.8:649:90: STYLE: input text line longer than 80 bytes: must be passed, eith...
mandoc: tc.8:658:111: STYLE: input text line longer than 80 bytes: A qdisc can be delet...
mandoc: tc.8:663:88: STYLE: input text line longer than 80 bytes: Some entities can be...
mandoc: tc.8:671:90: STYLE: input text line longer than 80 bytes: Performs a nearly at...
mandoc: tc.8:681:87: STYLE: input text line longer than 80 bytes: Displays all filters...
mandoc: tc.8:695:85: STYLE: input text line longer than 80 bytes: If the file option i...
mandoc: tc.8:709:104: STYLE: input text line longer than 80 bytes: If there were any er...
mandoc: tc.8:750:94: STYLE: input text line longer than 80 bytes: specifies path to th...
mandoc: tc.8:755:81: STYLE: input text line longer than 80 bytes: When\fB\ tc monitor\...
mandoc: tc.8:760:88: STYLE: input text line longer than 80 bytes: When\fB\ tc monitor\...
mandoc: tc.8:780:92: STYLE: input text line longer than 80 bytes: for u32 filter, deco...
mandoc: tc.8:860:2: WARNING: skipping paragraph macro: PP after SH

#######

Mark a full stop (.) with "\&",
if it does not mean an end of a sentence.
This is a preventive action,
the paragraph could be reshaped, e.g., after changes.

When typing, one does not always notice when the line wraps after the
period.
There are too many examples of input lines in manual pages,
that end with an abbreviation point.

This marking is robust, and independent of the position on the line.

It corresponds to "\ " in TeX, and to "@:" in Texinfo.


367:non-responsive flows (i.e. flows that do not react to congestion marking
415:useful e.g. for using RED qdiscs with different settings for particular
540:(e.g. 5%, 99.5%). Warning: specifying the rate as a percentage means a fraction
785:print rates in IEC units (ie. 1K = 1024).
856:cookie, etc.) and stats. This option is currently only supported by

#####

Use the correct macro for the font change of a single argument or
split the argument into two.

707:.BR "\-force"
732:.IR NETNS
784:.BR "\-iec"
790:.BR "-s"
792:.BR "dev"

#####

Change a HYPHEN-MINUS (code 0x55, 2D) to a minus (\-), if in front of a
name for an option.

124:\fB[ -force ] -b\fR[\fIatch\fR] \fB[ filename ] \fR|
125:\fB[ \fB-n\fR[\fIetns\fR] name \fB] \fR|
126:\fB[ \fB-N\fR[\fIumeric\fR] \fB] \fR|
127:\fB[ \fB-nm \fR| \fB-nam\fR[\fIes\fR] \fB] \fR|
128:\fB[ \fR{ \fB-cf \fR| \fB-c\fR[\fIonf\fR] \fR} \fB[ filename ] \fB] \fR
129:\fB[ -t\fR[imestamp\fR] \fB\] \fR| \fB[ -t\fR[short\fR] \fR| \fB[
740:.RI "-n[etns] " NETNS " [ " OPTIONS " ] " OBJECT " { " COMMAND " | "
751:.BR -nm ")."
790:.BR "-s"
817:.B -cf
841:.B -nm
843:.B -cf
847:.B -nm
861:tc -g class show dev eth0
866:tc -g -s class show dev eth0

#####

Add a comma after "e.g." and "i.e.", or use English words
(man-pages(7).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

367:non-responsive flows (i.e. flows that do not react to congestion marking
415:useful e.g. for using RED qdiscs with different settings for particular
540:(e.g. 5%, 99.5%). Warning: specifying the rate as a percentage means a fraction
750:specifies path to the config file. This option is used in conjunction with other options (e.g.

#####

Wrong distance between sentences.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

N.B

  The number of lines affected is too large to be in the patch.


145:is used to configure Traffic Control in the Linux kernel. Traffic Control consists
150:When traffic is shaped, its rate of transmission is under control. Shaping may
152:bursts in traffic for better network behaviour. Shaping occurs on egress.
157:for traffic that needs it while still guaranteeing bandwidth to bulk transfers. Reordering
163:arriving. Policing thus occurs on ingress.
177:understanding traffic control. Whenever the kernel needs to send a
180:to the qdisc configured for that interface. Immediately afterwards, the kernel
185:First In, First Out queue. It does however store traffic when the network interface
194:it can come from any of the classes. A qdisc may for example prioritize
202:be enqueued. Whenever traffic arrives at a class with subclasses, it needs
203:to be classified. Various methods may be employed to do so, one of these
204:are the filters. All filters attached to the class are called, until one of
205:them returns with a verdict. If no verdict was made, other criteria may be
206:available. This differs per qdisc.
215:Filter packets based on an ematch expression. See
225:Filter packets based on the control group of their process. See
230:Flow-based classifiers, filtering packets based on their flow (identified by selectable keys). See
236:Filter based on fwmark. Directly maps fwmark value to traffic class. See
240:Filter packets based on routing table. See
248:Filter packets based on traffic control index. See
252:Generic filtering on arbitrary packet data, assisted by syntax to abstract common operations. See
257:Traffic control filter that matches every packet. See
263:take place in the qdisc. Each qevent can either be unused, or can have a
264:block attached to it. To this block are then attached filters using the "tc
265:block BLOCK_IDX" syntax. The block is executed when the qevent associated
266:with the attachment point takes place. For example, packet could be
286:monopolize the queue. CHOKe is a variation of RED, and the configuration is
295:Simplest usable qdisc, pure First In, First Out behaviour. Limited in
304:Queuing with the CoDel AQM scheme. FQ_Codel uses a stochastic model to classify
306:bandwidth to all the flows using the queue. Each such flow is managed by the
307:CoDel queuing discipline. Reordering within a flow is avoided since Codel
312:queuing discipline that combines Flow Queuing with the PIE AQM scheme. FQ-PIE
315:qdisc. Each such flow is managed by the PIE algorithm.
319:achieve multiple drop priorities. This is required to realize Assured
324:heavy-hitters. The goal is to catch the heavy-hitters and move them to a
334:configurable priority to traffic class mapping. A traffic class in this context
339:Multiqueue is a qdisc optimized for devices with multiple Tx queues. It has
350:Standard qdisc for 'Advanced Router' enabled kernels. Consists of a three-band
356:queue management scheme. It is based on the proportional integral controller but
361:packets when nearing configured bandwidth allocation. Well suited to very
367:non-responsive flows (i.e. flows that do not react to congestion marking
378:configured rate. Scales well to large bandwidths.
381:the root of a device. Full syntax:
407:It contains shaping elements as well as prioritizing capabilities. Shaping is
409:underlying link bandwidth. The latter may be ill-defined for some interfaces.
413:Fairness Queuing. Unlike SFQ, there are no built-in queues \-\- you need to add
415:useful e.g. for using RED qdiscs with different settings for particular
416:traffic. There is no default class \-\- if a packet cannot be classified, it is
425:qdiscs in one scheduler. ETS makes it easy to configure a set of strict and
430:Hierarchical Fair Service Curve guarantees precise bandwidth and delay allocation for leaf classes and allocates excess bandwidth fairly. Unlike HTB, it makes use of packet dropping to achieve low delays which interactive sessions benefit from.
434:classes with an emphasis on conforming to existing practices. HTB facilitates
436:limits to inter-class sharing. It contains shaping elements, based on TBF and
441:classes which are dequeued in order. This allows for easy prioritization
443:no packets available. To facilitate configuration, Type Of Service bits are
449:the number of groups and the packet length. The QFQ algorithm has no loops, and
454:A class may have multiple children. Some qdiscs allow for runtime addition
465:behaviour, although another qdisc can be attached in place. This qdisc may again
470:to one of the classes within. Three criteria are available, although not all
475:for relevant instructions. Filters can match on all fields of a packet header,
489:attached to that class. Check qdisc specific manpages for details, however.
501:are hexadecimal numbers and are limited to 16 bits. There are two special
512:number namespace available for classes. The handle is expressed as '10:'.
522:parent classes, only to their parent qdisc. The same naming custom as for
531:The following parameters are widely used in TC. For other parameters,
540:(e.g. 5%, 99.5%). Warning: specifying the rate as a percentage means a fraction
585:Length of time. Can be specified as a floating point number
606:Amounts of data. Can be specified as a floating point number
647:Add a qdisc, class or filter to a node. For all entities, a
652:parameter. A class is named with the
658:A qdisc can be deleted by specifying its handle, which may also be 'root'. All subclasses and their leaf qdiscs
663:Some entities can be modified 'in place'. Shares the syntax of 'add', with the exception
664:that the handle cannot be changed and neither can the parent. In other words,
671:Performs a nearly atomic remove/add on an existing node id. If the node does not exist yet
681:Displays all filters attached to the given interface. A valid parent ID must be passed.
696:the given file and dumps its contents. The file has to be in binary
716:character. This is convenient when you want to count records
750:specifies path to the config file. This option is used in conjunction with other options (e.g.
785:print rates in IEC units (ie. 1K = 1024).
789:shows classes as ASCII graph. Prints generic stats info under each class if
791:option was specified. Classes can be filtered only by
797:Configure color output. If parameter is omitted or
799:color output is enabled regardless of stdout state. If parameter is
801:stdout is checked to be a terminal before enabling color output. If parameter is
803:color output is disabled. If specified multiple times, the last one takes
804:precedence. This flag is ignored if
818:option. This file is just a mapping of
856:cookie, etc.) and stats. This option is currently only supported by
873:was written by Alexey N. Kuznetsov and added in Linux 2.2.

#####

Split lines longer than 100 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.

tc.8: line 329	length 118
This is a special qdisc as it applies to incoming traffic on an interface, allowing for it to be filtered and policed.

tc.8: line 430	length 244
Hierarchical Fair Service Curve guarantees precise bandwidth and delay allocation for leaf classes and allocates excess bandwidth fairly. Unlike HTB, it makes use of packet dropping to achieve low delays which interactive sessions benefit from.

tc.8: line 658	length 111
A qdisc can be deleted by specifying its handle, which may also be 'root'. All subclasses and their leaf qdiscs

tc.8: line 709	length 104
If there were any errors during execution of the commands, the application return code will be non zero.

tc.8: line 908	length 121
.RB "User documentation at " http://lartc.org/ ", but please direct bugreports and patches to: " <netdev@vger.kernel.org>


#####

Use \(en for a dash (en-dash) between space characters, not a minus
(\-) or a hyphen (-), except in the NAME section.

tc.8:151:be more than lowering the available bandwidth - it is also used to smooth out
tc.8:189:Some qdiscs can contain classes, which contain further qdiscs - traffic may
tc.8:210:qdiscs - they are not masters of what happens.

#####

Protect a period (.) or a apostrophe (') with '\&' from becoming a
control character, if it could end up at the start of a line (by
splitting the line into more lines).

176:is short for 'queueing discipline' and it is elementary to
184:A simple QDISC is the 'pfifo' one, which does no processing at all and is a pure
350:Standard qdisc for 'Advanced Router' enabled kernels. Consists of a three-band
373:Stochastic Fairness Queueing reorders queued traffic so each 'session'
482:Userspace programs can encode a \fIclass-id\fR in the 'skb->priority' field using
510:number, called a 'handle', leaving the
512:number namespace available for classes. The handle is expressed as '10:'.
521:number called a 'classid' that has no relation to their
538:either a unit (both SI and IEC units supported), or a float followed by a '%'
640:indicate TC to interpret them as octal and hexadecimal by adding a '0'
641:or '0x' prefix respectively.
658:A qdisc can be deleted by specifying its handle, which may also be 'root'. All subclasses and their leaf qdiscs
663:Some entities can be modified 'in place'. Shares the syntax of 'add', with the exception

#####

Output from "test-nroff -man -b -ww -z":


[ "test-groff" is a developmental version of "groff" ]

Input file is ./tc.8

Output from test-groff -b -mandoc -dAD=l -rF0 -rHY=0 -t -w w -z :
troff: backtrace: file '/tmp/chk_manuals.temp.nlIzmz':128
troff:/tmp/chk_manuals.temp.nlIzmz:128: warning: trailing space in the line
troff: backtrace: file '/tmp/chk_manuals.temp.nlIzmz':129
troff:/tmp/chk_manuals.temp.nlIzmz:129: warning: escape character ignored before ']'
an.tmac:/tmp/chk_manuals.temp.nlIzmz:274: style: 3 leading space(s) on input line
an.tmac:/tmp/chk_manuals.temp.nlIzmz:707: style: .BR expects at least 2 arguments, got 1
an.tmac:/tmp/chk_manuals.temp.nlIzmz:732: style: .IR expects at least 2 arguments, got 1
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':673: macro 'RI'
troff: backtrace: file '/tmp/chk_manuals.temp.nlIzmz':734
troff:/tmp/chk_manuals.temp.nlIzmz:734: warning: trailing space in the line
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':673: macro 'RI'
troff: backtrace: file '/tmp/chk_manuals.temp.nlIzmz':740
troff:/tmp/chk_manuals.temp.nlIzmz:740: warning: trailing space in the line
an.tmac:/tmp/chk_manuals.temp.nlIzmz:756: style: 3 leading space(s) on input line
an.tmac:/tmp/chk_manuals.temp.nlIzmz:761: style: 3 leading space(s) on input line
an.tmac:/tmp/chk_manuals.temp.nlIzmz:784: style: .BR expects at least 2 arguments, got 1
an.tmac:/tmp/chk_manuals.temp.nlIzmz:790: style: .BR expects at least 2 arguments, got 1
an.tmac:/tmp/chk_manuals.temp.nlIzmz:792: style: .BR expects at least 2 arguments, got 1

####

--- tc.8	2023-06-24 14:42:36.000000000 +0000
+++ tc.8.new	2023-06-24 21:24:14.000000000 +0000
@@ -18,7 +18,7 @@ tc \- show / manipulate traffic control
 \fIBLOCK_INDEX\fR ] qdisc
 [ qdisc specific parameters ]
 .P
-
+.
 .B tc
 .RI "[ " OPTIONS " ]"
 .B class [ add | change | replace | delete | show ] dev
@@ -29,7 +29,7 @@ tc \- show / manipulate traffic control
 \fIclass-id\fR ] qdisc
 [ qdisc specific parameters ]
 .P
-
+.
 .B tc
 .RI "[ " OPTIONS " ]"
 .B filter [ add | change | replace | delete | get ] dev
@@ -121,13 +121,13 @@ tc \- show / manipulate traffic control
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
@@ -142,25 +142,30 @@ tc \- show / manipulate traffic control
 
 .SH DESCRIPTION
 .B Tc
-is used to configure Traffic Control in the Linux kernel. Traffic Control consists
-of the following:
+is used to configure Traffic Control in the Linux kernel.
+Traffic Control consists of the following:
 
 .TP
 SHAPING
-When traffic is shaped, its rate of transmission is under control. Shaping may
-be more than lowering the available bandwidth - it is also used to smooth out
-bursts in traffic for better network behaviour. Shaping occurs on egress.
+When traffic is shaped, its rate of transmission is under control.
+Shaping may be more than lowering the available bandwidth \(en
+it is also used to smooth out
+bursts in traffic for better network behaviour.
+Shaping occurs on egress.
 
 .TP
 SCHEDULING
-By scheduling the transmission of packets it is possible to improve interactivity
-for traffic that needs it while still guaranteeing bandwidth to bulk transfers. Reordering
-is also called prioritizing, and happens only on egress.
+By scheduling the transmission of packets
+it is possible to improve interactivity
+for traffic that needs it while still guaranteeing bandwidth to bulk transfers.
+Reordering is also called prioritizing,
+and happens only on egress.
 
 .TP
 POLICING
 Whereas shaping deals with transmission of traffic, policing pertains to traffic
-arriving. Policing thus occurs on ingress.
+arriving.
+Policing thus occurs on ingress.
 
 .TP
 DROPPING
@@ -173,7 +178,7 @@ classes and filters.
 
 .SH QDISCS
 .B qdisc
-is short for 'queueing discipline' and it is elementary to
+is short for \&'queueing discipline' and it is elementary to
 understanding traffic control. Whenever the kernel needs to send a
 packet to an interface, it is
 .B enqueued
@@ -181,12 +186,13 @@ to the qdisc configured for that interfa
 tries to get as many packets as possible from the qdisc, for giving them
 to the network adaptor driver.
 
-A simple QDISC is the 'pfifo' one, which does no processing at all and is a pure
-First In, First Out queue. It does however store traffic when the network interface
+A simple QDISC is the \&'pfifo' one, which does no processing at all and is a pure
+First In, First Out queue.
+It does however store traffic when the network interface
 can't handle it momentarily.
 
 .SH CLASSES
-Some qdiscs can contain classes, which contain further qdiscs - traffic may
+Some qdiscs can contain classes, which contain further qdiscs \(en traffic may
 then be enqueued in any of the inner qdiscs, which are within the
 .B classes.
 When the kernel tries to dequeue a packet from such a
@@ -207,7 +213,7 @@ available. This differs per qdisc.
 
 It is important to notice that filters reside
 .B within
-qdiscs - they are not masters of what happens.
+qdiscs \(en they are not masters of what happens.
 
 The available filters are:
 .TP
@@ -227,7 +233,9 @@ Filter packets based on the control grou
 for details.
 .TP
 flow, flower
-Flow-based classifiers, filtering packets based on their flow (identified by selectable keys). See
+Flow-based classifiers,
+filtering packets based on their flow (identified by selectable keys).
+See
 .BR tc-flow "(8) and"
 .BR tc-flower (8)
 for details.
@@ -249,7 +257,9 @@ Filter packets based on traffic control
 .BR tc-tcindex (8).
 .TP
 u32
-Generic filtering on arbitrary packet data, assisted by syntax to abstract common operations. See
+Generic filtering on arbitrary packet data,
+assisted by syntax to abstract common operations.
+See
 .BR tc-u32 (8)
 for details.
 .TP
@@ -326,7 +336,8 @@ separate queue with less priority so tha
 latency of critical traffic.
 .TP
 ingress
-This is a special qdisc as it applies to incoming traffic on an interface, allowing for it to be filtered and policed.
+This is a special qdisc as it applies to incoming traffic on an interface,
+allowing for it to be filtered and policed.
 .TP
 mqprio
 The Multiqueue Priority Qdisc is a simple queuing discipline that allows
@@ -343,11 +354,12 @@ band is not stopped prior to dequeuing a
 .TP
 netem
 Network Emulator is an enhancement of the Linux traffic control facilities that
-allow one to add delay, packet loss, duplication and more other characteristics to
+allow one to add delay, packet loss,
+duplication and more other characteristics to
 packets outgoing from a selected network interface.
 .TP
 pfifo_fast
-Standard qdisc for 'Advanced Router' enabled kernels. Consists of a three-band
+Standard qdisc for \&'Advanced Router' enabled kernels. Consists of a three-band
 queue which honors Type of Service flags, as well as the priority that may be
 assigned to a packet.
 .TP
@@ -364,13 +376,13 @@ large bandwidth applications.
 sfb
 Stochastic Fair Blue is a classless qdisc to manage congestion based on
 packet loss and link utilization history while trying to prevent
-non-responsive flows (i.e. flows that do not react to congestion marking
+non-responsive flows (i.e.\& flows that do not react to congestion marking
 or dropped packets) from impacting performance of responsive flows.
 Unlike RED, where the marking probability has to be configured, BLUE
 tries to determine the ideal marking probability automatically.
 .TP
 sfq
-Stochastic Fairness Queueing reorders queued traffic so each 'session'
+Stochastic Fairness Queueing reorders queued traffic so each \&'session'
 gets to send a packet in turn.
 .TP
 tbf
@@ -412,7 +424,7 @@ DRR
 The Deficit Round Robin Scheduler is a more flexible replacement for Stochastic
 Fairness Queuing. Unlike SFQ, there are no built-in queues \-\- you need to add
 classes and then set up filters to classify packets accordingly.  This can be
-useful e.g. for using RED qdiscs with different settings for particular
+useful e.g.\& for using RED qdiscs with different settings for particular
 traffic. There is no default class \-\- if a packet cannot be classified, it is
 dropped.
 .TP
@@ -427,7 +439,11 @@ bandwidth-sharing bands to implement the
 802.1Qaz.
 .TP
 HFSC
-Hierarchical Fair Service Curve guarantees precise bandwidth and delay allocation for leaf classes and allocates excess bandwidth fairly. Unlike HTB, it makes use of packet dropping to achieve low delays which interactive sessions benefit from.
+Hierarchical Fair Service Curve guarantees precise bandwidth
+and delay allocation for leaf classes and allocates excess bandwidth fairly.
+Unlike HTB,
+it makes use of packet dropping to achieve low delays
+which interactive sessions benefit from.
 .TP
 HTB
 The Hierarchy Token Bucket implements a rich linksharing hierarchy of
@@ -479,8 +495,8 @@ Type of Service
 Some qdiscs have built in rules for classifying packets based on the TOS field.
 .TP
 skb->priority
-Userspace programs can encode a \fIclass-id\fR in the 'skb->priority' field using
-the SO_PRIORITY option.
+Userspace programs can encode a \fIclass-id\fR in the \&'skb->priority' field
+using the SO_PRIORITY option.
 .P
 Each node within the tree can have its own filters but higher level filters
 may also point directly to lower classes.
@@ -507,10 +523,11 @@ of all ones, and unspecified is all zero
 QDISCS
 A qdisc, which potentially can have children, gets assigned a
 .B major
-number, called a 'handle', leaving the
+number, called a \&'handle', leaving the
 .B minor
-number namespace available for classes. The handle is expressed as '10:'.
-It is customary to explicitly assign a handle to qdiscs expected to have children.
+number namespace available for classes. The handle is expressed as \&'10:'.
+It is customary to explicitly assign a handle to qdiscs
+expected to have children.
 
 .TP
 CLASSES
@@ -518,7 +535,7 @@ Classes residing under a qdisc share the
 .B major
 number, but each have a separate
 .B minor
-number called a 'classid' that has no relation to their
+number called a \&'classid' that has no relation to their
 parent classes, only to their parent qdisc. The same naming custom as for
 qdiscs applies.
 
@@ -535,9 +552,9 @@ see the man pages for individual qdiscs.
 RATES
 Bandwidths or rates.
 These parameters accept a floating point number, possibly followed by
-either a unit (both SI and IEC units supported), or a float followed by a '%'
+either a unit (both SI and IEC units supported), or a float followed by a \&'%'
 character to specify the rate as a percentage of the device's speed
-(e.g. 5%, 99.5%). Warning: specifying the rate as a percentage means a fraction
+(e.g.\& 5%, 99.5%). Warning: specifying the rate as a percentage means a fraction
 of the current speed; if the speed changes, the value will not be recalculated.
 .RS
 .TP
@@ -637,8 +654,8 @@ so we can specify a max size of 42949672
 VALUES
 Other values without a unit.
 These parameters are interpreted as decimal by default, but you can
-indicate TC to interpret them as octal and hexadecimal by adding a '0'
-or '0x' prefix respectively.
+indicate TC to interpret them as octal and hexadecimal by adding a \&'0'
+or \&'0x' prefix respectively.
 
 .SH TC COMMANDS
 The following commands are available for qdiscs, classes and filter:
@@ -646,7 +663,8 @@ The following commands are available for
 add
 Add a qdisc, class or filter to a node. For all entities, a
 .B parent
-must be passed, either by passing its ID or by attaching directly to the root of a device.
+must be passed,
+either by passing its ID or by attaching directly to the root of a device.
 When creating a qdisc or a filter, it can be named with the
 .B handle
 parameter. A class is named with the
@@ -655,21 +673,23 @@ parameter.
 
 .TP
 delete
-A qdisc can be deleted by specifying its handle, which may also be 'root'. All subclasses and their leaf qdiscs
+A qdisc can be deleted by specifying its handle, which may also be \&'root'.
+All subclasses and their leaf qdiscs
 are automatically deleted, as well as any filters attached to them.
 
 .TP
 change
-Some entities can be modified 'in place'. Shares the syntax of 'add', with the exception
-that the handle cannot be changed and neither can the parent. In other words,
-.B
-change
+Some entities can be modified \&'in place'.
+Shares the syntax of \&'add', with the exception
+that the handle cannot be changed and neither can the parent.
+In other words,
+.B change
 cannot move a node.
 
 .TP
 replace
-Performs a nearly atomic remove/add on an existing node id. If the node does not exist yet
-it is created.
+Performs a nearly atomic remove/add on an existing node id.
+If the node does not exist yet, it is created.
 
 .TP
 get
@@ -678,7 +698,8 @@ Displays a single filter given the inter
 
 .TP
 show
-Displays all filters attached to the given interface. A valid parent ID must be passed.
+Displays all filters attached to the given interface.
+A valid parent ID must be passed.
 
 .TP
 link
@@ -692,8 +713,10 @@ adding/deleting qdiscs, filters or actio
 The following command is available for\fB\ monitor\fR\ :
 .TP
 \fBfile\fR
-If the file option is given, the \fBtc\fR does not listen to kernel events, but opens
-the given file and dumps its contents. The file has to be in binary
+If the file option is given,
+the \fBtc\fR does not listen to kernel events,
+but opens the given file and dumps its contents.
+The file has to be in binary
 format and contain netlink messages.
 
 .SH OPTIONS
@@ -704,9 +727,10 @@ read commands from provided file or stan
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
@@ -729,15 +753,15 @@ to the specified network namespace
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
@@ -747,17 +771,20 @@ converting it to human readable name.
 
 .TP
 .BR "\-cf" , " \-conf " <FILENAME>
-specifies path to the config file. This option is used in conjunction with other options (e.g.
-.BR -nm ")."
+specifies path to the config file.
+This option is used in conjunction with other options (e.g.\&
+.BR \-nm ")."
 
 .TP
 .BR "\-t", " \-timestamp"
-When\fB\ tc monitor\fR\ runs, print timestamp before the event message in format:
+When\fB\ tc monitor\fR\ runs,
+print timestamp before the event message in format:
    Timestamp: <Day> <Month> <DD> <hh:mm:ss> <YYYY> <usecs> usec
 
 .TP
 .BR "\-ts", " \-tshort"
-When\fB\ tc monitor\fR\ runs, prints short timestamp before the event message in format:
+When\fB\ tc monitor\fR\ runs,
+prints short timestamp before the event message in format:
    [<YYYY>-<MM>-<DD>T<hh:mm:ss>.<ms>]
 
 .SH FORMAT
@@ -777,19 +804,20 @@ output raw hex values for handles.
 
 .TP
 .BR "\-p", " \-pretty"
-for u32 filter, decode offset and mask values to equivalent filter commands based on TCP/IP.
+for u32 filter,
+decode offset and mask values to equivalent filter commands based on TCP/IP.
 In JSON output, add whitespace to improve readability.
 
 .TP
-.BR "\-iec"
-print rates in IEC units (ie. 1K = 1024).
+.B \-iec
+print rates in IEC units (i.e.\& 1K = 1024).
 
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
@@ -814,7 +842,7 @@ Display results in JSON format.
 resolve class name from
 .B /etc/iproute2/tc_cls
 file or from file specified by
-.B -cf
+.B \-cf
 option. This file is just a mapping of
 .B classid
 to class name:
@@ -838,13 +866,13 @@ to class name:
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
@@ -853,17 +881,16 @@ alias.
 .TP
 .BR "\-br" , " \-brief"
 Print only essential data needed to identify the filter and action (handle,
-cookie, etc.) and stats. This option is currently only supported by
+cookie, etc.\&) and stats. This option is currently only supported by
 .BR "tc filter show " and " tc actions ls " commands.
 
 .SH "EXAMPLES"
-.PP
-tc -g class show dev eth0
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
@@ -905,7 +932,8 @@ was written by Alexey N. Kuznetsov and a
 .BR tc-tcindex (8),
 .BR tc-u32 (8),
 .br
-.RB "User documentation at " http://lartc.org/ ", but please direct bugreports and patches to: " <netdev@vger.kernel.org>
+.RB "User documentation at " http://lartc.org/ ", \
+but please direct bugreports and patches to: " <netdev@vger.kernel.org>
 
 .SH AUTHOR
 Manpage maintained by bert hubert (ahu@ds9a.nl)

