Return-Path: <netdev+bounces-138034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D39ABA22
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170D72848DC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE319CC28;
	Tue, 22 Oct 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="DAUvt0hK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8B1547E9
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640307; cv=none; b=uQUxOh5r8w+6LmdLLEFR7Uwxg0vd+yozuBl9vLrwnJ0D7BKUjnwrCa2zz3/9r+8Z2wJOscLByNsIU/X2rI9QQa/PicR0cnkSs7h6Hsf2Psd5cLdOpFzgxbPgOjEO+BFSYWKHFd6P6g7P4BDUhGC++cH0qRnNtXp5edFkEwCmg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640307; c=relaxed/simple;
	bh=/UThqSFxRVWRBJHRur1zTcNl0hPsR7dO7SGLRvenno4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gbDGfipDs29k8BNv2BnnSzdDE/zn+8AkKaw6Ka0u7iWiClcFd9OhurisI8HGjy+lBjNB1EIrvN/ySSdOszIhpBOM6h5RqO1QkIVkJcKPditGrClIh+zOfQ/xYdsrLAnsVJ4U9+aWlLDgZI+v8vrHcyCTFw01cNnQfg/58qFyFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=DAUvt0hK; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1729640303; x=1761176303;
  h=date:from:to:subject:message-id:mime-version;
  bh=FEDZympErm3tfDiBe5A7tuz85CCeqrsPHc+WoENkZec=;
  b=DAUvt0hKXssHTqDLaSt3HVYNixzRpZOHcwq12yFF4CARnZdURwZ5EDO+
   oQOaVsWQ2T93GAE9Ao0Nfj4SJwoUrepousQav7gS3y56mjUO/jliLE+4E
   Pht+l1RG2o/rwdikLNcjOSrzzP+Ccj5S9aeyFpsnxieQ3CwsjLoGDIA/i
   HwIXzSkjAsMZV/aBTLmZnjktEGQwKD1xWZVskXSp57py574qVgFm8nFX7
   1g/liw7awzO93WVY+RY9tRPFFcBFsNZUDH6J5eX9xWxrMy1vUYUVvP2E4
   adPSSRFWggyntaTo9WG2pQvbE9xKP1OsM5o67IgZkhp+a0MvYa93mJNnJ
   Q==;
X-CSE-ConnectionGUID: KmOWWSPbST6boJqN8YLtQQ==
X-CSE-MsgGUID: +gimybKpR/SwLcodIThWCQ==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2EeAAAHMhhnhVnoacJSCB0BAQEBCQESAQUFAUCBPwgBC?=
 =?us-ascii?q?wGCGyh9gWSIJYROiTQdgyiOI4xMgg0BAQEPMRMEAQEEgg+NGig0CQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEOAQEGAQEBAQEBBgcCEAEBAQFADjuFNUYNhSwsgSsBH?=
 =?us-ascii?q?zN9NSqDAQGCZLB+gTSBAYMc2xeBbIFIAYVpgmIBhWmEdzwGgg2BFTWBBoItg?=
 =?us-ascii?q?30eAYZrBIYMPgoCgRKDbYFDEoFLA4IOHBo7DoIPAQQGAmmBHlcPghRCAoFQg?=
 =?us-ascii?q?jklgTOCHIN9gXGGNoE9ih+BTRwDWSECEQFVExcLCQWJNYMmghSEEIUlgWcJY?=
 =?us-ascii?q?YlOgT6BWYM5SoNogU9HP4JPak43Ag0CN4IkgQCCUYMZgygdQAMLbT01FBusY?=
 =?us-ascii?q?4FaAUaBeS8PJwYGMgwcARsGEws4CTArCAITAxMVChsBAkcBCgIJBpJ4EQEBE?=
 =?us-ascii?q?yWPOoNUgRiIIZYRhCSMFpVDM4QFgVaRZQw6iwWHQZh3oyIvhU+BZ4EDgRMsB?=
 =?us-ascii?q?xoIMDuCZwlJGQ+OLRaBDAECBYcixUd4OwIHCwEBAwmMEAErgVMBAQ?=
IronPort-PHdr: A9a23:QU9rRBxGOUm5xAbXCzPyngc9DxPP2p3vOxINr506l/cWKeK4/pHkM
 VCZ5O4+xFPKXICO7fVChqKWtq37QmUP7N6Ht2xKa51DURIJyI0WkgUsDdTDCBj9K/jnBxE=
IronPort-Data: A9a23:fIOgn6rL/mgzogwNgh8Gn+NStzReBmJnZRIvgKrLsJaIsI4StFCzt
 garIBmOM67fMGX1Kt4gb4m/oUxXvseAz9dlHgtr/Ck0Q39Dp+PIVI+TRqvSF3rJd5WcFiqLz
 Cm/hv3odp1coqr0/0/1WlTZhSAhk/nOHvylULKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazt8B56r8ks14K2q4mlA5TTSWNgS1LPgvyhEZH4gDfnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFU47Nfh7TKyXmc5aKVeS8oiM+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1NCWYJArYg8N1LX2tJ1
 +U+eAEpcim60rfeLLKTEoGAh+w9LdL3eZEev2l6yiHISK59B47CWLmM5MQwMDUY35ESW6+GO
 oxDMmApPEWojx5nYz/7DLo0k8+zh3z5fiEeqUn9Sa8fuTKPk1wsjeOF3Nz9OdOLQNRfvV6i4
 VnZ22/+DjAmNOO08G/Qmp6rrrSTzXKkCd56+KeD3vhnnFGe2EQNBxAME1i2u/+0jgi5Qd03F
 qAP0jQvtrR35k2uVsP6Twz9+CXCoB8HR5xRCIXW9T1h1IL35iGmOVM8RAV9NtYhltYQFQ0Oy
 mawyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVdUizUEiN1i5i8jXupe/LiJYsrdOAqY/
 txnhDY/nKlWn88Oz7+87UGC22nquJnSUkg0/W07v15JDCskNOZJhKTxuDA3CMqsyq7DHjFtW
 1BfwqCjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6ItoBvWojeRw3appZEdMMX
 KM1kV4JjHO0FCbyBZKbn6roUZlCIVXITIi+CKmKBjawSsctLVPvEN5Sib64hDy9wRd9zcnTy
 L+ecMKlRXYUYZmLPxLrL9rxJYQDn3hkrUuKHMyT50r8i9K2OiXKIYrpxXPVNYjVGovf+12Nq
 76y9qKil31ibQEJSnCKr9RCdg1TcSJT6FKfg5U/S9Nv6zFOQAkJY8I9C5t4E2C5t8y5Ttv1w
 0w=
IronPort-HdrOrdr: A9a23:O+9rLaw+Soj5t0tSqnGfKrPwM71zdoMgy1knxilNoDhuA6qlfq
 GV7ZMmPHDP6Qr5NEtBpTniAtjlfZq/z+8R3WB5B97LN2OK1ATHEGgI1/qB/9SPIVycytJg
X-Talos-CUID: =?us-ascii?q?9a23=3AIVmVgmm1ZfkVdMdHPetKhOpw0ALXOV7Y60jvGHe?=
 =?us-ascii?q?yMlo3Qrq3UHnAyYd4qvM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AP5kHvgwM8kFnslgtQfNbVdpWHFuaqOehCUUcm7Y?=
 =?us-ascii?q?egY6/Kgh7PDu8sDSIabZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="22478553"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:37:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 87DC3406C38B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:37:09 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RozE-Op83Nio for <netdev@vger.kernel.org>;
 Tue, 22 Oct 2024 23:37:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id CBF78406C378
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:37:07 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id out6cpZso3Yd for <netdev@vger.kernel.org>;
 Tue, 22 Oct 2024 23:37:07 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id B2B7D4010661
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:37:07 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t3OR2-00000000Dk8-3YA8
	for netdev@vger.kernel.org;
	Tue, 22 Oct 2024 23:37:08 +0000
Date: Tue, 22 Oct 2024 23:37:08 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: bridge.8: some remarks and editorial changes for this manual
Message-ID: <Zxg3JEUMgKid88OY@kassi.invalid.is>
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
"groff -ww -b -z", that of a shell script, and typographical
conventions.

-.-

The difference between the formatted output of the original and the patched
file can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -u <out1> <out2>

and for groff, using

"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - "

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output of 'diff -u' with 'less -R' or similar.

-.-

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>
---

--- bridge.8	2024-10-22 01:29:40.814405900 +0000
+++ bridge.8.new	2024-10-22 02:49:23.114552470 +0000
@@ -7,17 +7,17 @@ bridge \- show / manipulate bridge addre
 .in +8
 .ti -8
 .B bridge
-.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " | "
+.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " |"
 .BR help " }"
 .sp
 
 .ti -8
-.IR OBJECT " := { "
+.IR OBJECT " := {"
 .BR link " | " fdb " | " mdb " | " vlan " | " vni " | " monitor " }"
 .sp
 
 .ti -8
-.IR OPTIONS " := { "
+.IR OPTIONS " := {"
 \fB\-V\fR[\fIersion\fR] |
 \fB\-s\fR[\fItatistics\fR] |
 \fB\-n\fR[\fIetns\fR] name |
@@ -31,156 +31,156 @@ bridge \- show / manipulate bridge addre
 .ti -8
 .B "bridge link set"
 .B dev
-.IR DEV " [ "
+.IR DEV " ["
 .B cost
-.IR COST " ] [ "
+.IR COST " ] ["
 .B priority
-.IR PRIO " ] [ "
+.IR PRIO " ] ["
 .B state
-.IR STATE " ] [ "
-.BR guard " { " on " | " off " } ] [ "
-.BR hairpin " { " on " | " off " } ] [ "
-.BR fastleave " { " on " | " off " } ] [ "
-.BR root_block " { " on " | " off " } ] [ "
-.BR learning " { " on " | " off " } ] [ "
-.BR learning_sync " { " on " | " off " } ] [ "
-.BR flood " { " on " | " off " } ] [ "
-.BR hwmode " { " vepa " | " veb " } ] [ "
-.BR bcast_flood " { " on " | " off " } ] [ "
-.BR mcast_flood " { " on " | " off " } ] [ "
-.BR mcast_max_groups
+.IR STATE " ] ["
+.BR guard " { " on " | " off " } ] ["
+.BR hairpin " { " on " | " off " } ] ["
+.BR fastleave " { " on " | " off " } ] ["
+.BR root_block " { " on " | " off " } ] ["
+.BR learning " { " on " | " off " } ] ["
+.BR learning_sync " { " on " | " off " } ] ["
+.BR flood " { " on " | " off " } ] ["
+.BR hwmode " { " vepa " | " veb " } ] ["
+.BR bcast_flood " { " on " | " off " } ] ["
+.BR mcast_flood " { " on " | " off " } ] ["
+.B  mcast_max_groups
 .IR MAX_GROUPS " ] ["
-.BR mcast_router
+.B  mcast_router
 .IR MULTICAST_ROUTER " ] ["
-.BR mcast_to_unicast " { " on " | " off " } ] [ "
-.BR neigh_suppress " { " on " | " off " } ] [ "
-.BR neigh_vlan_suppress " { " on " | " off " } ] [ "
-.BR vlan_tunnel " { " on " | " off " } ] [ "
-.BR isolated " { " on " | " off " } ] [ "
-.BR locked " { " on " | " off " } ] [ "
-.BR mab " { " on " | " off " } ] [ "
+.BR mcast_to_unicast " { " on " | " off " } ] ["
+.BR neigh_suppress " { " on " | " off " } ] ["
+.BR neigh_vlan_suppress " { " on " | " off " } ] ["
+.BR vlan_tunnel " { " on " | " off " } ] ["
+.BR isolated " { " on " | " off " } ] ["
+.BR locked " { " on " | " off " } ] ["
+.BR mab " { " on " | " off " } ] ["
 .B backup_port
 .IR  DEVICE " ] ["
-.BR nobackup_port " ] [ "
+.BR nobackup_port " ] ["
 .B backup_nhid
 .IR NHID " ] ["
 .BR self " ] [ " master " ]"
 
 .ti -8
-.BR "bridge link" " [ " show " ] [ "
+.BR "bridge link" " [ " show " ] ["
 .B dev
 .IR DEV " ] ["
 .B master
 .IR DEVICE " ]"
 
 .ti -8
-.BR "bridge fdb" " { " add " | " append " | " del " | " replace " } "
+.BR "bridge fdb" " { " add " | " append " | " del " | " replace " }"
 .I LLADDR
 .B dev
-.IR DEV " { "
-.BR local " | " static " | " dynamic " } [ "
-.BR self " ] [ " master " ] [ " router " ] [ " use " ] [ " extern_learn " ] [ " sticky " ] [ "
+.IR DEV " {"
+.BR local " | " static " | " dynamic " } ["
+.BR self " ] [ " master " ] [ " router " ] [ " use " ] [ " extern_learn " ] [ " sticky " ] ["
 .B src_vni
 .IR VNI " ] { ["
 .B dst
-.IR IPADDR " ] [ "
+.IR IPADDR " ] ["
 .B vni
 .IR VNI " ] ["
 .B port
 .IR PORT " ] ["
 .B via
-.IR DEVICE " ] | "
+.IR DEVICE " ] |"
 .B nhid
-.IR NHID " } "
+.IR NHID " }"
 
 .ti -8
-.BR "bridge fdb" " [ [ " show " ] [ "
+.BR "bridge fdb" " [ [ " show " ] ["
 .B br
-.IR BRDEV " ] [ "
+.IR BRDEV " ] ["
 .B brport
-.IR DEV " ] [ "
+.IR DEV " ] ["
 .B vlan
-.IR VID " ] [ "
+.IR VID " ] ["
 .B state
 .IR STATE " ] ["
 .B dynamic
-.IR "] ]"
+] ]
 
 .ti -8
 .BR "bridge fdb get" " ["
 .B to
-.IR "]"
-.I LLADDR "[ "
+.I ]
+.I LLADDR "["
 .B br
 .IR BRDEV " ]"
 .B { brport | dev }
-.IR DEV " [ "
+.IR DEV " ["
 .B vlan
-.IR VID  " ] [ "
+.IR VID  " ] ["
 .B vni
 .IR VNI " ] ["
 .BR self " ] [ " master " ] [ " dynamic " ]"
 
 .ti -8
-.BR "bridge fdb flush"
+.B "bridge fdb flush"
 .B dev
-.IR DEV " [ "
+.IR DEV " ["
 .B brport
-.IR DEV " ] [ "
+.IR DEV " ] ["
 .B vlan
-.IR VID " ] [ "
+.IR VID " ] ["
 .B src_vni
-.IR VNI " ] [ "
+.IR VNI " ] ["
 .B nhid
 .IR NHID " ] ["
 .B vni
-.IR VNI " ] [ "
+.IR VNI " ] ["
 .B port
 .IR PORT " ] ["
 .B dst
-.IR IPADDR " ] [ "
-.BR self " ] [ " master " ] [ "
-.BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
-.BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
+.IR IPADDR " ] ["
+.BR self " ] [ " master " ] ["
+.BR [no]permanent " | " [no]static " | " [no]dynamic " ] ["
+.BR [no]added_by_user " ] [ " [no]extern_learn " ] ["
 .BR [no]sticky " ] [ " [no]offloaded " ] [ " [no]router " ]"
 
 .ti -8
-.BR "bridge mdb" " { " add " | " del " | " replace " } "
+.BR "bridge mdb" " { " add " | " del " | " replace " }"
 .B dev
 .I DEV
 .B port
 .I PORT
 .B grp
-.IR GROUP " [ "
+.IR GROUP " ["
 .B src
-.IR SOURCE " ] [ "
-.BR permanent " | " temp " ] [ "
+.IR SOURCE " ] ["
+.BR permanent " | " temp " ] ["
 .B vid
-.IR VID " ] [ "
-.BR filter_mode " { " include " | " exclude " } ] [ "
+.IR VID " ] ["
+.BR filter_mode " { " include " | " exclude " } ] ["
 .B source_list
-.IR SOURCE_LIST " ] [ "
+.IR SOURCE_LIST " ] ["
 .B proto
-.IR PROTO " ] [ "
+.IR PROTO " ] ["
 .B dst
-.IR IPADDR " ] [ "
+.IR IPADDR " ] ["
 .B dst_port
-.IR DST_PORT " ] [ "
+.IR DST_PORT " ] ["
 .B vni
-.IR VNI " ] [ "
+.IR VNI " ] ["
 .B src_vni
-.IR SRC_VNI " ] [ "
+.IR SRC_VNI " ] ["
 .B via
 .IR DEV " ]
 
 .ti -8
-.BR "bridge mdb show" " [ "
+.BR "bridge mdb show" " ["
 .B dev
 .IR DEV " ]"
 
 .ti -8
 .B "bridge mdb get"
-.BI dev " DEV " grp " GROUP "
+.BI dev " DEV " grp " GROUP"
 .RB "[ " src
 .IR SOURCE " ]"
 .RB "[ " vid
@@ -190,7 +190,7 @@ bridge \- show / manipulate bridge addre
 
 .ti -8
 .B "bridge mdb flush"
-.BI dev " DEV "
+.BI dev " DEV"
 .RB "[ " port
 .IR PORT " ]"
 .RB "[ " vid
@@ -209,99 +209,99 @@ bridge \- show / manipulate bridge addre
 
 .ti -8
 .B "bridge mst set"
-.IR dev " DEV " msti " MSTI " state " STP_STATE "
+.IR dev " DEV " msti " MSTI " state " STP_STATE"
 
 .ti -8
-.BR "bridge mst" " [ [ " show " ] [ "
+.BR "bridge mst" " [ [ " show " ] ["
 .B dev
 .IR DEV " ] ]"
 
 .ti -8
-.BR "bridge vlan" " { " add " | " del " } "
+.BR "bridge vlan" " { " add " | " del " }"
 .B dev
 .I DEV
 .B vid
-.IR VID " [ "
+.IR VID " ["
 .B tunnel_info
-.IR TUNNEL_ID " ] [ "
-.BR pvid " ] [ " untagged " ] [ "
-.BR self " ] [ " master " ] "
+.IR TUNNEL_ID " ] ["
+.BR pvid " ] [ " untagged " ] ["
+.BR self " ] [ " master " ]"
 
 .ti -8
-.BR "bridge vlan set"
+.B "bridge vlan set"
 .B dev
 .I DEV
 .B vid
-.IR VID " [ "
+.IR VID " ["
 .B state
-.IR STP_STATE " ] [ "
+.IR STP_STATE " ] ["
 .B mcast_max_groups
-.IR MAX_GROUPS " ] [ "
+.IR MAX_GROUPS " ] ["
 .B mcast_router
-.IR MULTICAST_ROUTER " ] [ "
+.IR MULTICAST_ROUTER " ] ["
 .BR neigh_suppress " { " on " | " off " } ]"
 
 .ti -8
-.BR "bridge vlan" " [ " show " | " tunnelshow " ] [ "
+.BR "bridge vlan" " [ " show " | " tunnelshow " ] ["
 .B dev
 .IR DEV " ]"
 
 .ti -8
-.BR "bridge vlan global set"
+.B "bridge vlan global set"
 .B dev
 .I DEV
 .B vid
-.IR VID " [ "
+.IR VID " ["
 .B mcast_snooping
-.IR MULTICAST_SNOOPING " ] [ "
+.IR MULTICAST_SNOOPING " ] ["
 .B mcast_querier
-.IR MULTICAST_QUERIER " ] [ "
+.IR MULTICAST_QUERIER " ] ["
 .B mcast_igmp_version
-.IR IGMP_VERSION " ] [ "
+.IR IGMP_VERSION " ] ["
 .B mcast_mld_version
-.IR MLD_VERSION " ] [ "
+.IR MLD_VERSION " ] ["
 .B mcast_last_member_count
-.IR LAST_MEMBER_COUNT " ] [ "
+.IR LAST_MEMBER_COUNT " ] ["
 .B mcast_last_member_interval
-.IR LAST_MEMBER_INTERVAL " ] [ "
+.IR LAST_MEMBER_INTERVAL " ] ["
 .B mcast_startup_query_count
-.IR STARTUP_QUERY_COUNT " ] [ "
+.IR STARTUP_QUERY_COUNT " ] ["
 .B mcast_startup_query_interval
-.IR STARTUP_QUERY_INTERVAL " ] [ "
+.IR STARTUP_QUERY_INTERVAL " ] ["
 .B mcast_membership_interval
-.IR MEMBERSHIP_INTERVAL " ] [ "
+.IR MEMBERSHIP_INTERVAL " ] ["
 .B mcast_querier_interval
-.IR QUERIER_INTERVAL " ] [ "
+.IR QUERIER_INTERVAL " ] ["
 .B mcast_query_interval
-.IR QUERY_INTERVAL " ] [ "
+.IR QUERY_INTERVAL " ] ["
 .B mcast_query_response_interval
-.IR QUERY_RESPONSE_INTERVAL " ] [ "
+.IR QUERY_RESPONSE_INTERVAL " ] ["
 .B msti
 .IR MSTI " ]"
 
 .ti -8
-.BR "bridge vlan global" " [ " show " ] [ "
+.BR "bridge vlan global" " [ " show " ] ["
 .B dev
-.IR DEV " ] [ "
+.IR DEV " ] ["
 .B vid
 .IR VID " ]"
 
 .ti -8
-.BR "bridge vlan" " show " [ "
+.BR "bridge vlan" " show " [
 .B dev
 .IR DEV " ]"
 
 .ti -8
-.BR "bridge vni" " { " add " | " del " } "
+.BR "bridge vni" " { " add " | " del " }"
 .B dev
 .I DEV
 .B vni
-.IR VNI " [ { "
-.B group | remote "} "
-.IR IPADDR " ] "
+.IR VNI " [ {"
+.B group | remote "}"
+.IR IPADDR " ]"
 
 .ti -8
-.BR "bridge vni" " show " [ "
+.BR "bridge vni" " show " [
 .B dev
 .IR DEV " ]"
 
@@ -311,7 +311,7 @@ bridge \- show / manipulate bridge addre
 .SH OPTIONS
 
 .TP
-.BR "\-V" , " -Version"
+.BR "\-V" , " \-Version"
 print the version of the
 .B bridge
 utility and exit.
@@ -337,13 +337,13 @@ Actually it just simplifies executing of
 .B ip netns exec
 .I NETNS
 .B bridge
-.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " | "
+.RI "[ " OPTIONS " ] " OBJECT " { " COMMAND " |"
 .BR help " }"
 
 to
 
 .B bridge
-.RI "-n[etns] " NETNS " [ " OPTIONS " ] " OBJECT " { " COMMAND " | "
+.RI "\-n[etns] " NETNS " [ " OPTIONS " ] " OBJECT " { " COMMAND " |"
 .BR help " }"
 
 .TP
@@ -381,7 +381,7 @@ Output results in JavaScript Object Nota
 
 .TP
 .BR "\-p", " \-pretty"
-When combined with -j generate a pretty JSON output.
+When combined with \-j generate a pretty JSON output.
 
 .TP
 .BR "\-o", " \-oneline"
@@ -396,30 +396,30 @@ or to
 the output.
 
 
-.SH BRIDGE - COMMAND SYNTAX
+.SH BRIDGE \(en COMMAND SYNTAX
 
 .SS
 .I OBJECT
 
 .TP
 .B link
-- Bridge port.
+\(en Bridge port.
 
 .TP
 .B fdb
-- Forwarding Database entry.
+\(en Forwarding Database entry.
 
 .TP
 .B mdb
-- Multicast group database entry.
+\(en Multicast group database entry.
 
 .TP
 .B vlan
-- VLAN filter list.
+\(en VLAN filter list.
 
 .TP
 .B vni
-- VNI filter list.
+\(en VNI filter list.
 
 .SS
 .I COMMAND
@@ -444,7 +444,8 @@ Usually it is
 or, if the objects of this class cannot be listed,
 .BR "help" .
 
-.SH bridge link - bridge port
+.\".SH bridge link \(en bridge port
+.SH bridge link \(en bridge port
 
 .B link
 objects correspond to the port devices of the bridge.
@@ -453,24 +454,24 @@ objects correspond to the port devices o
 The corresponding commands set and display port status and bridge specific
 attributes.
 
-.SS bridge link set - set bridge specific attributes on a port
+.SS bridge link set \(en set bridge specific attributes on a port
 
 .TP
-.BI dev " NAME "
+.BI dev " NAME"
 interface name of the bridge port
 
 .TP
-.BI cost " COST "
+.BI cost " COST"
 the STP path cost of the specified port.
 
 .TP
-.BI priority " PRIO "
+.BI priority " PRIO"
 the STP port priority. The priority value is an unsigned 8-bit quantity
 (number between 0 and 255). This metric is used in the designated port an
 droot port selection algorithms.
 
 .TP
-.BI state " STATE "
+.BI state " STATE"
 the operation state of the port. Except state 0 (disable STP or BPDU filter feature),
 this is primarily used by user space STP/RSTP
 implementation. One may enter port state name (case insensitive), or one of the
@@ -478,7 +479,7 @@ numbers below. Negative inputs are ignor
 error.
 
 .B 0
-- port is in STP
+\(en port is in STP
 .B DISABLED
 state. Make this port completely inactive for STP. This is also called
 BPDU filter and could be used to disable STP on an untrusted port, like
@@ -486,14 +487,14 @@ a leaf virtual devices.
 .sp
 
 .B 1
-- port is in STP
+\(en port is in STP
 .B LISTENING
 state. Only valid if STP is enabled on the bridge. In this
 state the port listens for STP BPDUs and drops all other traffic frames.
 .sp
 
 .B 2
-- port is in STP
+\(en port is in STP
 .B LEARNING
 state. Only valid if STP is enabled on the bridge. In this
 state the port will accept traffic only for the purpose of updating MAC
@@ -501,13 +502,13 @@ address tables.
 .sp
 
 .B 3
-- port is in STP
+\(en port is in STP
 .B FORWARDING
 state. Port is fully active.
 .sp
 
 .B 4
-- port is in STP
+\(en port is in STP
 .B BLOCKING
 state. Only valid if STP is enabled on the bridge. This state
 is used during the STP election process. In this state, port will only process
@@ -515,7 +516,7 @@ STP BPDUs.
 .sp
 
 .TP
-.BR "guard on " or " guard off "
+.BR "guard on " or " guard off"
 Controls whether STP BPDUs will be processed by the bridge port. By default,
 the flag is turned off allowed BPDU processing. Turning this flag on will
 disables
@@ -532,7 +533,7 @@ eth0:
 .B ip link set dev eth0 down; ip link set dev eth0 up
 
 .TP
-.BR "hairpin on " or " hairpin off "
+.BR "hairpin on " or " hairpin off"
 Controls whether traffic may be send back out of the port on which it was
 received. This option is also called reflective relay mode, and is used to support
 basic VEPA (Virtual Ethernet Port Aggregator) capabilities.
@@ -540,13 +541,13 @@ By default, this flag is turned off and
 traffic back out of the receiving port.
 
 .TP
-.BR "fastleave on " or " fastleave off "
+.BR "fastleave on " or " fastleave off"
 This flag allows the bridge to immediately stop multicast traffic on a port
 that receives IGMP Leave message. It is only used with IGMP snooping is
 enabled on the bridge. By default the flag is off.
 
 .TP
-.BR "root_block on " or " root_block off "
+.BR "root_block on " or " root_block off"
 Controls whether a given port is allowed to become root port or not. Only used
 when STP is enabled on the bridge. By default the flag is off.
 
@@ -556,18 +557,18 @@ be elected as root port. This could be u
 trusted; this prevents a hostile guest from rerouting traffic.
 
 .TP
-.BR "learning on " or " learning off "
+.BR "learning on " or " learning off"
 Controls whether a given port will learn MAC addresses from received traffic or
 not. If learning if off, the bridge will end up flooding any traffic for which
 it has no FDB entry. By default this flag is on.
 
 .TP
-.BR "learning_sync on " or " learning_sync off "
+.BR "learning_sync on " or " learning_sync off"
 Controls whether a given port will sync MAC addresses learned on device port to
 bridge FDB.
 
 .TP
-.BR "flood on " or " flood off "
+.BR "flood on " or " flood off"
 Controls whether unicast traffic for which there is no FDB entry will be
 flooded towards this given port. By default this flag is on.
 
@@ -577,46 +578,46 @@ Some network interface cards support HW
 configured in different modes. Currently support modes are:
 
 .B vepa
-- Data sent between HW ports is sent on the wire to the external
+\(en Data sent between HW ports is sent on the wire to the external
 switch.
 
 .B veb
-- bridging happens in hardware.
+\(en bridging happens in hardware.
 
 .TP
-.BR "bcast_flood on " or " bcast_flood off "
+.BR "bcast_flood on " or " bcast_flood off"
 Controls flooding of broadcast traffic on the given port.
 By default this flag is on.
 
 .TP
-.BR "mcast_flood on " or " mcast_flood off "
+.BR "mcast_flood on " or " mcast_flood off"
 Controls whether multicast traffic for which there is no MDB entry will be
 flooded towards this given port. By default this flag is on.
 
 .TP
-.BI mcast_max_groups " MAX_GROUPS "
+.BI mcast_max_groups " MAX_GROUPS"
 Sets the maximum number of MDB entries that can be registered for a given
 port. Attempts to register more MDB entries at the port than this limit
-allows will be rejected, whether they are done through netlink (e.g. the
+allows will be rejected, whether they are done through netlink (e.g., the
 \fBbridge\fR tool), or IGMP or MLD membership reports. Setting a limit to 0
 has the effect of disabling the limit. The default value is 0. See also the
 \fBip link\fR option \fBmcast_hash_max\fR.
 
 .TP
-.BI mcast_router " MULTICAST_ROUTER "
+.BI mcast_router " MULTICAST_ROUTER"
 This flag is almost the same as the per-VLAN flag, see below, except its
-value can only be set in the range 0-2.  The default is
+value can only be set in the range 0\(en2.  The default is
 .B 1
 where the bridge figures out automatically where an IGMP/MLD querier,
 MRDISC capable device, or PIM router, is located.  Setting this flag to
 .B 2
 is useful in cases where the multicast router does not indicate its
-presence in any meaningful way (e.g. older versions of SMCRoute, or
+presence in any meaningful way (e.g., older versions of SMCRoute, or
 mrouted), or when there is a need for forwarding both known and unknown
 IP multicast to a secondary/backup router.
 
 .TP
-.BR "mcast_to_unicast on " or " mcast_to_unicast off "
+.BR "mcast_to_unicast on " or " mcast_to_unicast off"
 Controls whether a given port will replicate packets using unicast
 instead of multicast. By default this flag is off.
 
@@ -631,7 +632,7 @@ previously.
 
 This feature is intended for interface types which have a more reliable
 and/or efficient way to deliver unicast packets than broadcast ones
-(e.g. WiFi).
+(e.g., WiFi).
 
 However, it should only be enabled on interfaces where no IGMPv2/MLDv1
 report suppression takes place. IGMP/MLD report suppression issue is usually
@@ -647,30 +648,30 @@ Hairpin mode is performed after multicas
 only deliver reports to STAs running a multicast router.
 
 .TP
-.BR "neigh_suppress on " or " neigh_suppress off "
+.BR "neigh_suppress on " or " neigh_suppress off"
 Controls whether neigh discovery (arp and nd) proxy and suppression is
 enabled on the port. By default this flag is off.
 
 .TP
-.BR "neigh_vlan_suppress on " or " neigh_vlan_suppress off "
+.BR "neigh_vlan_suppress on " or " neigh_vlan_suppress off"
 Controls whether per-VLAN neigh discovery (arp and nd) proxy and suppression is
 enabled on the port. When on, the \fBbridge link\fR option \fBneigh_suppress\fR
 has no effect and the per-VLAN state is set using the \fBbridge vlan\fR option
 \fBneigh_suppress\fR. By default this flag is off.
 
 .TP
-.BR "vlan_tunnel on " or " vlan_tunnel off "
+.BR "vlan_tunnel on " or " vlan_tunnel off"
 Controls whether vlan to tunnel mapping is enabled on the port. By
 default this flag is off.
 
 .TP
-.BR "isolated on " or " isolated off "
+.BR "isolated on " or " isolated off"
 Controls whether a given port will be isolated, which means it will be
 able to communicate with non-isolated ports only.  By default this
 flag is off.
 
 .TP
-.BR "locked on " or " locked off "
+.BR "locked on " or " locked off"
 Controls whether a port is locked or not. When locked, non-link-local frames
 received through the port are dropped unless an FDB entry with the MAC source
 address points to the port. The common use case is IEEE 802.1X where hosts can
@@ -683,7 +684,7 @@ bridge option needs to be on to prevent
 EAPOL frames. By default this flag is off.
 
 .TP
-.BR "mab on " or " mab off "
+.BR "mab on " or " mab off"
 Controls whether MAC Authentication Bypass (MAB) is enabled on the port or not.
 MAB can only be enabled on a locked port that has learning enabled. When
 enabled, FDB entries are learned from received traffic and have the "locked"
@@ -726,7 +727,7 @@ link setting is configured on the softwa
 .BR "\-t" , " \-timestamp"
 display current time when using monitor option.
 
-.SS bridge link show - list ports configuration for all bridges.
+.SS bridge link show \(en list ports configuration for all bridges.
 
 This command displays ports configuration and flags for all bridges by default.
 
@@ -739,7 +740,7 @@ only display the specific bridge port na
 only display ports of the bridge named DEVICE. This is similar to
 "ip link show master <bridge_device>" command.
 
-.SH bridge fdb - forwarding database management
+.SH bridge fdb \(en forwarding database management
 
 .B fdb
 objects contain known Ethernet addresses on a link.
@@ -749,7 +750,7 @@ The corresponding commands display fdb e
 append entries,
 and delete old ones.
 
-.SS bridge fdb add - add a new fdb entry
+.SS bridge fdb add \(en add a new fdb entry
 
 This command creates a new fdb entry.
 
@@ -762,26 +763,26 @@ the Ethernet MAC address.
 the interface to which this address is associated.
 
 .B local
-- is a local permanent fdb entry, which means that the bridge will not forward
+\(en is a local permanent fdb entry, which means that the bridge will not forward
 frames with this destination MAC address and VLAN ID, but terminate them
 locally. This flag is default unless "static" or "dynamic" are explicitly
 specified.
 .sp
 
 .B permanent
-- this is a synonym for "local"
+\(en this is a synonym for "local"
 .sp
 
 .B static
-- is a static (no arp) fdb entry
+\(en is a static (no arp) fdb entry
 .sp
 
 .B dynamic
-- is a dynamic reachable age-able fdb entry
+\(en is a dynamic reachable age-able fdb entry
 .sp
 
 .B self
-- the operation is fulfilled directly by the driver for the specified network
+\(en the operation is fulfilled directly by the driver for the specified network
 device. If the network device belongs to a master like a bridge, then the
 bridge is bypassed and not notified of this operation (and if the device does
 notify the bridge, it is driver-specific behavior and not mandated by this
@@ -792,34 +793,34 @@ is mandatory. The flag is set by default
 .sp
 
 .B master
-- if the specified network device is a port that belongs to a master device
+\(en if the specified network device is a port that belongs to a master device
 such as a bridge, the operation is fulfilled by the master device's driver,
 which may in turn notify the port driver too of the address. If the specified
 device is a master itself, such as a bridge, this flag is invalid.
 .sp
 
 .B router
-- the destination address is associated with a router.
+\(en the destination address is associated with a router.
 Valid if the referenced device is a VXLAN type device and has
 route short circuit enabled.
 .sp
 
 .B use
-- the address is in use. User space can use this option to
+\(en the address is in use. User space can use this option to
 indicate to the kernel that the fdb entry is in use.
 .sp
 
 .B extern_learn
-- this entry was learned externally. This option can be used to
+\(en this entry was learned externally. This option can be used to
 indicate to the kernel that an entry was hardware or user-space
 controller learnt dynamic entry. Kernel will not age such an entry.
 .sp
 
 .B sticky
-- this entry will not change its port due to learning.
+\(en this entry will not change its port due to learning.
 .sp
 
-.in -8
+.\".in -8
 The next command line parameters apply only
 when the specified device
 .I DEV
@@ -856,11 +857,11 @@ VXLAN device driver to reach the
 remote VXLAN tunnel endpoint.
 
 .TP
-.BI nhid " NHID "
+.BI nhid " NHID"
 ecmp nexthop group for the VXLAN device driver
 to reach remote VXLAN tunnel endpoints.
 
-.SS bridge fdb append - append a forwarding database entry
+.SS bridge fdb append \(en append a forwarding database entry
 This command adds a new fdb entry with an already known
 .IR LLADDR .
 Valid only for multicast link layer addresses.
@@ -874,31 +875,31 @@ sends a copy of the data packet to each
 The arguments are the same as with
 .BR "bridge fdb add" .
 
-.SS bridge fdb delete - delete a forwarding database entry
+.SS bridge fdb delete \(en delete a forwarding database entry
 This command removes an existing fdb entry.
 
 .PP
 The arguments are the same as with
 .BR "bridge fdb add" .
 
-.SS bridge fdb replace - replace a forwarding database entry
+.SS bridge fdb replace \(en replace a forwarding database entry
 If no matching entry is found, a new one will be created instead.
 
 .PP
 The arguments are the same as with
 .BR "bridge fdb add" .
 
-.SS bridge fdb show - list forwarding entries.
+.SS bridge fdb show \(en list forwarding entries.
 
 This command displays the current forwarding table.
 
 .PP
 With the
-.B -statistics
+.B \-statistics
 option, the command becomes verbose. It prints out the last updated
 and last used time for each entry.
 
-.SS bridge fdb get - get bridge forwarding entry.
+.SS bridge fdb get \(en get bridge forwarding entry.
 
 lookup a bridge forwarding table entry.
 
@@ -920,16 +921,16 @@ the bridge to which this address is asso
 
 .TP
 .B self
-- the address is associated with the port drivers fdb. Usually hardware.
+\(en the address is associated with the port drivers fdb. Usually hardware.
 
 .TP
 .B master
-- the address is associated with master devices fdb. Usually software (default).
+\(en the address is associated with master devices fdb. Usually software (default).
 
-.SS bridge fdb flush - flush bridge forwarding table entries.
+.SS bridge fdb flush \(en flush bridge forwarding table entries.
 
 flush the matching bridge forwarding table entries. Some options below have a negated
-form when "no" is prepended to them (e.g. permanent and nopermanent).
+form when "no" is prepended to them (e.g., permanent and nopermanent).
 
 .TP
 .BI dev " DEV"
@@ -992,7 +993,7 @@ such as a bridge, the operation is fulfi
 Flush with both 'master' and 'self' is not recommended with attributes that are
 not supported by all devices (e.g., vlan, vni). Such command will be handled by
 bridge or VXLAN driver, but will return an error from the driver that does not
-support the attribute. Instead, run flush twice - once with 'self' and once
+support the attribute. Instead, run flush twice \(en once with 'self' and once
 with 'master', and each one with the supported attributes.
 
 .TP
@@ -1038,7 +1039,7 @@ if "no" is prepended then only entries w
 if the referenced device is a VXLAN type device.
 .sp
 
-.SH bridge mdb - multicast group database management
+.SH bridge mdb \(en multicast group database management
 
 .B mdb
 objects contain known IP or L2 multicast group addresses on a link.
@@ -1047,7 +1048,7 @@ objects contain known IP or L2 multicast
 The corresponding commands display mdb entries, add new entries, replace
 entries and delete old ones.
 
-.SS bridge mdb add - add a new multicast group database entry
+.SS bridge mdb add \(en add a new multicast group database entry
 
 This command creates a new mdb entry.
 
@@ -1065,11 +1066,11 @@ the multicast group address (IPv4, IPv6
 on the link connected to the port.
 
 .B permanent
-- the mdb entry is permanent. Optional for IPv4 and IPv6, mandatory for L2.
+\(en the mdb entry is permanent. Optional for IPv4 and IPv6, mandatory for L2.
 .sp
 
 .B temp
-- the mdb entry is temporary (default)
+\(en the mdb entry is temporary (default)
 .sp
 
 .TP
@@ -1083,7 +1084,7 @@ forwarding multicast traffic.
 the VLAN ID which is known to have members of this multicast group.
 
 .TP
-.BR "filter_mode include " or " filter_mode exclude "
+.BR "filter_mode include " or " filter_mode exclude"
 controls whether the sources in the entry's source list are in INCLUDE or
 EXCLUDE mode. Can only be set for (*, G) entries.
 
@@ -1102,7 +1103,7 @@ then
 .B static
 is assumed.
 
-.in -8
+.\".in -8
 The next command line parameters apply only
 when the specified device
 .I DEV
@@ -1136,28 +1137,28 @@ device creation will be used.
 device name of the outgoing interface for the VXLAN device to reach the remote
 VXLAN tunnel endpoint.
 
-.in -8
+.\".in -8
 The 0.0.0.0 and :: MDB entries are special catchall entries used to flood IPv4
 and IPv6 unregistered multicast packets, respectively. Therefore, when these
 entries are programmed, the catchall 00:00:00:00:00:00 FDB entry will only
 flood broadcast, unknown unicast and link-local multicast.
 
-.in -8
-.SS bridge mdb delete - delete a multicast group database entry
+.\".in -8
+.SS bridge mdb delete \(en delete a multicast group database entry
 This command removes an existing mdb entry.
 
 .PP
 The arguments are the same as with
 .BR "bridge mdb add" .
 
-.SS bridge mdb replace - replace a multicast group database entry
+.SS bridge mdb replace \(en replace a multicast group database entry
 If no matching entry is found, a new one will be created instead.
 
 .PP
 The arguments are the same as with
 .BR "bridge mdb add" .
 
-.SS bridge mdb show - list multicast group database entries
+.SS bridge mdb show \(en list multicast group database entries
 
 This command displays the current multicast group membership table. The table
 is populated by IGMP and MLD snooping in the bridge driver automatically. It
@@ -1174,16 +1175,16 @@ bridge interfaces.
 
 .PP
 With the
-.B -details
+.B \-details
 option, the command becomes verbose. It prints out the ports known to have
 a connected router.
 
 .PP
 With the
-.B -statistics
+.B \-statistics
 option, the command displays timer values for mdb and router port entries.
 
-.SS bridge mdb get - get multicast group database entry.
+.SS bridge mdb get \(en get multicast group database entry.
 
 This command retrieves a multicast group database entry based on its key.
 
@@ -1208,7 +1209,7 @@ the VLAN ID. Only relevant when the brid
 the source VNI Network Identifier. Only relevant when the VXLAN device is in
 external mode.
 
-.SS bridge mdb flush - flush multicast group database entries.
+.SS bridge mdb flush \(en flush multicast group database entries.
 
 This command flushes the matching multicast group database entries.
 
@@ -1256,7 +1257,7 @@ endpoint. Match entries only with the sp
 the VXLAN VNI Network Identifier to use to connect to the remote VXLAN tunnel
 endpoint. Match entries only with the specified destination VNI.
 
-.SH bridge mst - multiple spanning tree port states
+.SH bridge mst \(en multiple spanning tree port states
 
 In the multiple spanning tree (MST) model, the active paths through a
 network can be different for different VLANs.  In other words, a
@@ -1270,7 +1271,7 @@ same spanning tree by associating them w
 using
 .BR "bridge vlan global set" .
 
-.SS bridge mst set - set multiple spanning tree state
+.SS bridge mst set \(en set multiple spanning tree state
 
 Set the spanning tree state for
 .IR DEV ,
@@ -1295,7 +1296,7 @@ option of
 .B "bridge link set"
 for supported states.
 
-.SS bridge mst show - list MST states
+.SS bridge mst show \(en list MST states
 
 List current MST port states in every MSTI.
 
@@ -1304,7 +1305,7 @@ List current MST port states in every MS
 If specified, only display states of the bridge port with this
 interface name.
 
-.SH bridge vlan - VLAN filter list
+.SH bridge vlan \(en VLAN filter list
 
 .B vlan
 objects contain known VLAN IDs for a link.
@@ -1313,7 +1314,7 @@ objects contain known VLAN IDs for a lin
 The corresponding commands display vlan filter entries, add new entries,
 and delete old ones.
 
-.SS bridge vlan add - add a new vlan filter entry
+.SS bridge vlan add \(en add a new vlan filter entry
 
 This command creates a new vlan filter entry.
 
@@ -1349,17 +1350,17 @@ device is the bridge device.
 .B master
 the vlan is configured on the software bridge (default).
 
-.SS bridge vlan delete - delete a vlan filter entry
+.SS bridge vlan delete \(en delete a vlan filter entry
 This command removes an existing vlan filter entry.
 
 .PP
 The arguments are the same as with
-.BR "bridge vlan add".
+.BR "bridge vlan add" .
 The
 .BR "pvid " and " untagged"
 flags are ignored.
 
-.SS bridge vlan set - change vlan filter entry's options
+.SS bridge vlan set \(en change vlan filter entry's options
 
 This command changes vlan filter entry's options.
 
@@ -1372,28 +1373,28 @@ the interface with which this vlan is as
 the VLAN ID that identifies the vlan.
 
 .TP
-.BI state " STP_STATE "
+.BI state " STP_STATE"
 the operation state of the vlan. One may enter STP state name (case insensitive), or one of the
 numbers below. Negative inputs are ignored, and unrecognized names return an
-error. Note that the state is set only for the vlan of the specified device, e.g. if it is
+error. Note that the state is set only for the vlan of the specified device, e.g., if it is
 a bridge port then the state will be set only for the vlan of the port.
 
 .B 0
-- vlan is in STP
+\(en vlan is in STP
 .B DISABLED
 state. Make this vlan completely inactive for STP. This is also called
 BPDU filter and could be used to disable STP on an untrusted vlan.
 .sp
 
 .B 1
-- vlan is in STP
+\(en vlan is in STP
 .B LISTENING
 state. Only valid if STP is enabled on the bridge. In this
 state the vlan listens for STP BPDUs and drops all other traffic frames.
 .sp
 
 .B 2
-- vlan is in STP
+\(en vlan is in STP
 .B LEARNING
 state. Only valid if STP is enabled on the bridge. In this
 state the vlan will accept traffic only for the purpose of updating MAC
@@ -1401,13 +1402,13 @@ address tables.
 .sp
 
 .B 3
-- vlan is in STP
+\(en vlan is in STP
 .B FORWARDING
 state. This is the default vlan state.
 .sp
 
 .B 4
-- vlan is in STP
+\(en vlan is in STP
 .B BLOCKING
 state. Only valid if STP is enabled on the bridge. This state
 is used during the STP election process. In this state, the vlan will only process
@@ -1415,7 +1416,7 @@ STP BPDUs.
 .sp
 
 .TP
-.BI mcast_max_groups " MAX_GROUPS "
+.BI mcast_max_groups " MAX_GROUPS"
 Sets the maximum number of MDB entries that can be registered for a given
 VLAN on a given port. A VLAN-specific equivalent of the per-port option of
 the same name, see above for details.
@@ -1424,57 +1425,57 @@ Note that this option is only available
 \fBmcast_vlan_snooping\fR is enabled.
 
 .TP
-.BI mcast_router " MULTICAST_ROUTER "
+.BI mcast_router " MULTICAST_ROUTER"
 configure this vlan and interface's multicast router mode, note that only modes
-0 - 2 are available for bridge devices.
+0 to 2 are available for bridge devices.
 A vlan and interface with a multicast router will receive all multicast traffic.
 .I MULTICAST_ROUTER
 may be either
 .sp
 .B 0
-- to disable multicast router.
+\(en to disable multicast router.
 .sp
 
 .B 1
-- to let the system detect the presence of routers (default).
+\(en to let the system detect the presence of routers (default).
 .sp
 
 .B 2
-- to permanently enable multicast traffic forwarding on this vlan and interface.
+\(en to permanently enable multicast traffic forwarding on this vlan and interface.
 .sp
 
 .B 3
-- to temporarily mark this vlan and port as having a multicast router, i.e.
+\(en to temporarily mark this vlan and port as having a multicast router, i.e.,
 enable multicast traffic forwarding. This mode is available only for ports.
 .sp
 
 .TP
-.BR "neigh_suppress on " or " neigh_suppress off "
+.BR "neigh_suppress on " or " neigh_suppress off"
 Controls whether neigh discovery (arp and nd) proxy and suppression is enabled
 for a given VLAN on a given port. By default this flag is off.
 
 Note that this option only takes effect when \fBbridge link\fR option
 \fBneigh_vlan_suppress\fR is enabled for a given port.
 
-.SS bridge vlan show - list vlan configuration.
+.SS bridge vlan show \(en list vlan configuration.
 
 This command displays the current VLAN filter table.
 
 .PP
 With the
-.B -details
+.B \-details
 option, the command becomes verbose. It displays the per-vlan options.
 
 .PP
 With the
-.B -statistics
+.B \-statistics
 option, the command displays per-vlan traffic statistics.
 
-.SS bridge vlan tunnelshow - list vlan tunnel mapping.
+.SS bridge vlan tunnelshow \(en list vlan tunnel mapping.
 
 This command displays the current vlan tunnel info mapping.
 
-.SS bridge vlan global set - change vlan filter entry's global options
+.SS bridge vlan global set \(en change vlan filter entry's global options
 
 This command changes vlan filter entry's global options.
 
@@ -1488,54 +1489,54 @@ supported for global options.
 the VLAN ID that identifies the vlan.
 
 .TP
-.BI mcast_snooping " MULTICAST_SNOOPING "
+.BI mcast_snooping " MULTICAST_SNOOPING"
 turn multicast snooping for VLAN entry with VLAN ID on
-.RI ( MULTICAST_SNOOPING " > 0) "
+.RI ( MULTICAST_SNOOPING " > 0)"
 or off
-.RI ( MULTICAST_SNOOPING " == 0). Default is on. "
+.RI ( MULTICAST_SNOOPING " == 0). Default is on."
 
 .TP
-.BI mcast_querier " MULTICAST_QUERIER "
+.BI mcast_querier " MULTICAST_QUERIER"
 enable
-.RI ( MULTICAST_QUERIER " > 0) "
+.RI ( MULTICAST_QUERIER " > 0)"
 or disable
-.RI ( MULTICAST_QUERIER " == 0) "
+.RI ( MULTICAST_QUERIER " == 0)"
 IGMP/MLD querier, ie sending of multicast queries by the bridge. Default is disabled.
 
 .TP
-.BI mcast_igmp_version " IGMP_VERSION "
+.BI mcast_igmp_version " IGMP_VERSION"
 set the IGMP version. Default is 2.
 
 .TP
-.BI mcast_mld_version " MLD_VERSION "
+.BI mcast_mld_version " MLD_VERSION"
 set the MLD version. Default is 1.
 
 .TP
-.BI mcast_last_member_count " LAST_MEMBER_COUNT "
+.BI mcast_last_member_count " LAST_MEMBER_COUNT"
 set multicast last member count, ie the number of queries the bridge
 will send before stopping forwarding a multicast group after a "leave"
 message has been received. Default is 2.
 
 .TP
-.BI mcast_last_member_interval " LAST_MEMBER_INTERVAL "
+.BI mcast_last_member_interval " LAST_MEMBER_INTERVAL"
 interval between queries to find remaining members of a group,
 after a "leave" message is received.
 
 .TP
-.BI mcast_startup_query_count " STARTUP_QUERY_COUNT "
+.BI mcast_startup_query_count " STARTUP_QUERY_COUNT"
 set the number of queries to send during startup phase. Default is 2.
 
 .TP
-.BI mcast_startup_query_interval " STARTUP_QUERY_INTERVAL "
+.BI mcast_startup_query_interval " STARTUP_QUERY_INTERVAL"
 interval between queries in the startup phase.
 
 .TP
-.BI mcast_membership_interval " MEMBERSHIP_INTERVAL "
+.BI mcast_membership_interval " MEMBERSHIP_INTERVAL"
 delay after which the bridge will leave a group,
 if no membership reports for this group are received.
 
 .TP
-.BI mcast_querier_interval " QUERIER_INTERVAL "
+.BI mcast_querier_interval " QUERIER_INTERVAL"
 interval between queries sent by other routers. If no queries are seen
 after this delay has passed, the bridge will start to send its own queries
 (as if
@@ -1543,21 +1544,21 @@ after this delay has passed, the bridge
 was enabled).
 
 .TP
-.BI mcast_query_interval " QUERY_INTERVAL "
+.BI mcast_query_interval " QUERY_INTERVAL"
 interval between queries sent by the bridge after the end of the
 startup phase.
 
 .TP
-.BI mcast_query_response_interval " QUERY_RESPONSE_INTERVAL "
+.BI mcast_query_response_interval " QUERY_RESPONSE_INTERVAL"
 set the Max Response Time/Maximum Response Delay for IGMP/MLD
 queries sent by the bridge.
 
 .TP
-.BI msti " MSTI "
+.BI msti " MSTI"
 associate the VLAN with the specified multiple spanning tree instance
 (MSTI).
 
-.SS bridge vlan global show - list global vlan options.
+.SS bridge vlan global show \(en list global vlan options.
 
 This command displays the global VLAN options for each VLAN entry.
 
@@ -1571,7 +1572,7 @@ all bridge interfaces.
 the VLAN ID only whose global options should be listed. Default is to list
 all vlans.
 
-.SH bridge vni - VNI filter list
+.SH bridge vni \(en VNI filter list
 
 .B vni
 objects contain known VNI IDs for a dst metadata vxlan link.
@@ -1580,7 +1581,7 @@ objects contain known VNI IDs for a dst
 The corresponding commands display vni filter entries, add new entries,
 and delete old ones.
 
-.SS bridge vni add - add a new vni filter entry
+.SS bridge vni add \(en add a new vni filter entry
 
 This command creates a new vni filter entry.
 
@@ -1602,7 +1603,7 @@ forwarding database. This parameter cann
 .BI group " IPADDR"
 specifies the multicast IP address to join for this VNI
 
-.SS bridge vni del - delete a new vni filter entry
+.SS bridge vni del \(en delete a new vni filter entry
 
 This command removes an existing vni filter entry.
 
@@ -1610,20 +1611,20 @@ This command removes an existing vni fil
 The arguments are the same as with
 .BR "bridge vni add".
 
-.SS bridge vni show - list vni filtering configuration.
+.SS bridge vni show \(en list vni filtering configuration.
 
 This command displays the current vni filter table.
 
 .PP
 With the
-.B -statistics
+.B \-statistics
 option, the command displays per-vni traffic statistics.
 
 .TP
 .BI dev " NAME"
 shows vni filtering table associated with the vxlan device
 
-.SH bridge monitor - state monitoring
+.SH bridge monitor \(en state monitoring
 
 The
 .B bridge

