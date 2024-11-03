Return-Path: <netdev+bounces-141255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9E9BA374
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15B71C20F48
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127904120B;
	Sun,  3 Nov 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="bBgd1jiq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-06.simnet.is (smtp-out1-06.simnet.is [194.105.231.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C892F3B
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597313; cv=none; b=JxsE6aPnoQ+6Glr5KhZK7nugyTZnmTMt7x4RoUL/rQt5hJngda+qx5jel2WfdQ7SowoRIaKYbafWFx67vA2B5ELky07djyhckgriJtfcB180ql98/tRY16g6aQ+mRYpJgVJBrEYeTdLotir0uxd9DlC8lsIoDlFYHxS1ctxmj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597313; c=relaxed/simple;
	bh=M3iX7ezSbpYeoIKHiuH3K1a/DSw6Gw9hmdAhTG02H/4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FFv0u7ONqJA+ntyu90tXp9NZvqScLjDLTw0qr6UAlpD4Vb6W4p7H90KwO4pfq9hRpC146M1nCDJZtRMdSpm+eFHAAN8C2GO6qnPfSppR/C2hwUKCUfpX7haBl8hR2fCpQcUMagYdJTCEASAzz0sdrwaUkwgvVY4keWmcBZAOtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=bBgd1jiq; arc=none smtp.client-ip=194.105.231.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730597309; x=1762133309;
  h=date:from:to:subject:message-id:mime-version;
  bh=HxQdCmr6RTRkkmtLrSvWxuVZKtSwMMJffu2I2tRjXvU=;
  b=bBgd1jiqVIPZU3pQK0//PVl365kvJdM9K99uB2ZTbl/LX7wlRrk0W/Ji
   Ii70v3fRDQG1cC3ubkjcYztNWeWrtsTo2DojE/wtENKtuNBq5gzMdDjGY
   FPo12keFyFsCE7RMkgEXyjzIMuR5UR7VZeeAZjnGxomYhVPoHiiOrULPT
   gRkjyfwaKe5AkVy0xMVMqrls1114sx77uwGDHxYIaBUrFnrJzc/xvvFKg
   wKOYwCuKaLRRJJUdpi+evQ6zSyYqUHgpcGKgvmCnFvZgqGnVIZ/6JyYyZ
   6jJ1rvvRn2k15FuNJcsoh5ZWCT5v5scH7ntA5Ttb6a7yBtnqYAxObfCpF
   Q==;
X-CSE-ConnectionGUID: MHCpkmWxQbuhB683bV1EUw==
X-CSE-MsgGUID: OMHnM8e8QCOy1D3Q+pyZKQ==
Authentication-Results: smtp-out-06.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2FvAgBYyyZnhVfoacJagQmBU4IcKH2BZIgljh+DKJx9A?=
 =?us-ascii?q?QEBDzETBAEBBI83KDcGDgECBAEBAQEDAgMBAQEBAQEBAQ4BAQYBAQEBAQEGB?=
 =?us-ascii?q?wIQAQEBAUAOO4U1Rg2FLCyBSzR8X4MBAYJkrgCBNIEBgxzbF4FsgUiFaoJiA?=
 =?us-ascii?q?YVphHc8BoINgUqBBoItiwcEgjQVhRASJYkXlz2BTRwDWSERAVUTFwsHBYF5A?=
 =?us-ascii?q?4NSgTmBUYMgSoNZgUVGP4JKaU06Ag0CNoIkfYJQgxiCBYRyhGpAHUADC209N?=
 =?us-ascii?q?RQbnwcBRoIrgTlHChyBK0NBoy+jH4QkjBaVQzOEBJM7DDqSRph3o3yFJYF9g?=
 =?us-ascii?q?gAsBxoIMDuCZwlJGQ+PTwEHhyK/a3g7AgcLAQEDCZB1AQE?=
IronPort-PHdr: A9a23:kbkQhBRGx32YMUHUTYWFUd81f9pso5DLVj580XJGo6lLbrzm+In+e
 RSBo+5siVnEQcPa8KEMh+nXtvXmXmoNqdaEvWsZeZNBHxkClY0NngMmDcLEQU32JfLndWo7S
 cJFUlINwg==
IronPort-Data: A9a23:0bsSNq2jhNHBochmEvbD5axxkn2cJEfYwER7XKvMYLTBsI5bp2MHm
 zQbWmuDaPfbMDemKY1/PI20oU1V7ZTXxtBkHFA63Hw8FHgiRejtXI/AdhiqV8+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYTdJ5xYuajhIsvvb80s21BjPkGpwUmIWNKEjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52jmWGPvxsp+NUsrPadGqr19Pzhjy
 ONNfVjhbjjb7w636Ky6UfUplMUmNNPsLJJa4igm0zDCEbAnWvgvQY2TtIMehW9twJoVR7COO
 KL1ahI2BPjESxdAEkwWDZQzgKGpnRETdhUC9A7J9fRnvQA/yiRW9ZjrFYrYKuWhYtQMsh2h5
 XrXzUfAV0Ry2Nu3kmbVoy392ocjhxjTXo8OGLCm3uBljUfVxWEJDhASE1yhrpGEZlWWRdNEN
 wkG+y82t68i5QnzF5/jXgak5n+f1vIBZzZOO8gawxmOz5XE2gyEBkJaHmVLVoULidBjEFTGy
 WS1t9/uADVutpicRnSc6qqYoFuO1c49cTRqicgsEVtt3jXznLzfmC4jWf5CK8aIYjDdBzDr3
 3WYrS0mnbIDnItTjuOl/EvbxTO3znQocuLXzluMNo5GxlooDGJAW2BOwQKEhRqnBN3AJmRtR
 FBex6CjABkmVPlhbhClTuQXB62O7P2YKjDailMHN8B+rGzwpCT/JdoLum4WyKJV3iAsJWCBj
 Kj75Fs52XOvFCLwMMebnqroV590lPaI+SrNCqGKPrKinaSdhCfcoHE/Oh/Mt4wcuE0tlah3O
 ZnzTCpfJStyNEiT9xLvH711+eZymkgWmziJLbillEvP7FZrTCXOIVvzGADVNrhhhE5FyS2Jm
 +ti2zyikE8OCLShOnSIreb+7zkidBAGOHw/kOQPHsbrH+asMDhJ5yP5qV/5R7FYog==
IronPort-HdrOrdr: A9a23:5ViszKj5ieGCcqtHh8cwZEFCAHBQXsUji2hC6mlwRA09TyW9rb
 HJoB17726StN9/YhAdcLy7WJVoIkmskaKdg7NhWItKNTOO0ADDQe0Mg7cKqAeQeREWmNQttp
 tdTw==
X-Talos-CUID: =?us-ascii?q?9a23=3A9xMMP2pf9OfaO89Y4dhp25nmUeUFWWXeyUjAGkW?=
 =?us-ascii?q?lCUw3GOafdwa9xbwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AEpkklAwwYt5tsCJ1iahjQ1OlvwCaqIOLKEYowZh?=
 =?us-ascii?q?WguKjJHVcYA7elCWFYbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,254,1725321600"; 
   d="scan'208";a="24448686"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-06.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 01:27:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 7EF4341A169F
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:27:16 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id fzvSpNN0-TEj for <netdev@vger.kernel.org>;
 Sun,  3 Nov 2024 01:27:15 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id D6BD841A1693
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:27:15 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id u_tX6Ofhch8D for <netdev@vger.kernel.org>;
 Sun,  3 Nov 2024 01:27:15 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id C382E419903E
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:27:15 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t7POe-0000000045j-2jeb
	for netdev@vger.kernel.org;
	Sun, 03 Nov 2024 01:27:16 +0000
Date: Sun, 3 Nov 2024 01:27:16 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb.8: some remarks and editorial changes for this manual
Message-ID: <ZybRdNeIHWohpWYN@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

diff --git a/dcb.8 b/dcb.8.new
index a1d6505..2202224 100644
--- a/dcb.8
+++ b/dcb.8.new
@@ -2,74 +2,74 @@
 .SH NAME
 dcb \- show / manipulate DCB (Data Center Bridging) settings
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .RB "{ " app " | " buffer " | " ets " | " maxrate " | " pfc " }"
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb
-.RB "[ " -force " ] "
-.BI "-batch " filename
+.RB "[ " \-force " ]"
+.BI "\-batch " filename
 .sp
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B help
 .sp
 
 .SH OPTIONS
 
 .TP
-.BR "\-n" , " \--netns " <NETNS>
+.BR "\-n" , " \-\-netns " <NETNS>
 switches
 .B dcb
 to the specified network namespace
 .IR NETNS .
 
 .TP
-.BR "\-V" , " --Version"
+.BR "\-V" , " \-\-Version"
 Print the version of the
 .B dcb
 utility and exit.
 
 .TP
-.BR "\-b", " --batch " <FILENAME>
-Read commands from provided file or standard input and invoke them. First
-failure will cause termination of dcb.
+.BR "\-b", " \-\-batch " <FILENAME>
+Read commands from provided file or standard input and invoke them.
+First failure will cause termination of dcb.
 
 .TP
-.BR "\-f", " --force"
-Don't terminate dcb on errors in batch mode. If there were any errors during
-execution of the commands, the application return code will be non zero.
+.BR "\-f", " \-\-force"
+Don't terminate dcb on errors in batch mode.
+If there were any errors during execution of the commands,
+the application return code will be non zero.
 
 .TP
-.BR "\-i" , " --iec"
-When showing rates, use ISO/IEC 1024-based prefixes (Ki, Mi, Bi) instead of
-the 1000-based ones (K, M, B).
+.BR "\-i" , " \-\-iec"
+When showing rates, use ISO/IEC 1024-based prefixes (Ki, Mi, Gi) instead of
+the 1000-based ones (K, M, G).
 
 .TP
-.BR "\-j" , " --json"
+.BR "\-j" , " \-\-json"
 Generate JSON output.
 
 .TP
-.BR "\-N" , " --Numeric"
+.BR "\-N" , " \-\-Numeric"
 If the subtool in question translates numbers to symbolic names in some way,
 suppress this translation.
 
 .TP
-.BR "\-p" , " --pretty"
-When combined with -j generate a pretty JSON output.
+.BR "\-p" , " \-\-pretty"
+When combined with \-j generate a pretty JSON output.
 
 .TP
-.BR "\-s" , " --statistics"
+.BR "\-s" , " \-\-statistics"
 If the object in question contains any statistical counters, shown them as
 part of the "show" output.
 
@@ -77,59 +77,66 @@ part of the "show" output.
 
 .TP
 .B app
-- Configuration of application priority table
+\(en Configuration of application priority table
 
 .TP
 .B buffer
-- Configuration of port buffers
+\(en Configuration of port buffers
 
 .TP
 .B ets
-- Configuration of ETS (Enhanced Transmission Selection)
+\(en Configuration of ETS (Enhanced Transmission Selection)
 
 .TP
 .B maxrate
-- Configuration of per-TC maximum transmit rate
+\(en Configuration of per-TC maximum transmit rate
 
 .TP
 .B pfc
-- Configuration of PFC (Priority-based Flow Control)
+\(en Configuration of PFC (Priority-based Flow Control)
 
 .SH COMMANDS
 
-A \fICOMMAND\fR specifies the action to perform on the object. The set of
-possible actions depends on the object type. As a rule, it is possible to
+A \fICOMMAND\fR specifies the action to perform on the object.
+The set of possible actions depends on the object type.
+As a rule, it is possible to
 .B show
 objects and to invoke topical
-.B help,
+.BR help ,
 which prints a list of available commands and argument syntax conventions.
 
 .SH ARRAY PARAMETERS
 
 Like commands, specification of parameters is in the domain of individual
-objects (and their commands) as well. However, much of the DCB interface
-revolves around arrays of fixed size that specify one value per some key, such
-as per traffic class or per priority. There is therefore a single syntax for
-adjusting elements of these arrays. It consists of a series of
-\fIKEY\fB:\fIVALUE\fR pairs, where the meaning of the individual keys and values
-depends on the parameter.
+objects (and their commands) as well.
+However, much of the DCB interface
+revolves around arrays of fixed size that specify one value per some key,
+such as per traffic class or per priority.
+There is therefore a single syntax for adjusting elements of these arrays.
+It consists of a series of \fIKEY\fB:\fIVALUE\fR pairs,
+where the meaning of the individual keys and values depends on the parameter.
 
 The elements are evaluated in order from left to right, and the latter ones
-override the earlier ones. The elements that are not specified on the command
+override the earlier ones.
+The elements that are not specified on the command
 line are queried from the kernel and their current value is retained.
 
 As an example, take a made-up parameter tc-juju, which can be set to charm
-traffic in a given TC with either good luck or bad luck. \fIKEY\fR can therefore
-be 0..7 (as is usual for TC numbers in DCB), and \fIVALUE\fR either of
-\fBnone\fR, \fBgood\fR, and \fBbad\fR. An example of changing a juju value of
-TCs 0 and 7, while leaving all other intact, would then be:
+traffic in a given TC with either good luck or bad luck.
+\fIKEY\fR can therefore be 0..7
+(as is usual for TC numbers in DCB),
+and \fIVALUE\fR either of \fBnone\fR, \fBgood\fR, and \fBbad\fR.
+An example of changing a juju value of TCs 0 and 7,
+while leaving all other intact, would then be:
 
 .P
 # dcb foo set dev eth0 tc-juju 0:good 7:bad
 
 A special key, \fBall\fR, is recognized which sets the same value to all array
-elements. This can be combined with the usual single-element syntax. E.g. in the
-following, the juju of all keys is set to \fBnone\fR, except 0 and 7, which have
+elements.
+This can be combined with the usual single-element syntax.
+E.g., in the following,
+the juju of all keys is set to \fBnone\fR, except 0 and 7, which have
 other values:
 
 .P
@@ -146,7 +153,6 @@ Exit status is 0 if command was successful or a positive integer upon failure.
 .BR dcb-maxrate (8),
 .BR dcb-pfc (8),
 .BR dcb-rewr (8)
-.br
 
 .SH REPORTING BUGS
 Report any bugs to the Network Developers mailing list

