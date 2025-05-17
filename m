Return-Path: <netdev+bounces-191241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC3ABA74B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789F91C01CC6
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16101FBF6;
	Sat, 17 May 2025 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGyZWVtM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE9EEAA
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440814; cv=none; b=Z1XA5Kr5veg3n2KWNnel90JL/KmK4Y5XScuHlYtXHdJ9WEmT0BmuX5kk95SCGGR4s+7hmPHFEwfAruJlwNwJOW7MEanihni7+SGxv4ZTvrCCCvdk/FPX/dQB9x0vRtGDJrUDoJ4OoYsOVK9kM0fX2UVPA95JCIvBIQswRVi9MfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440814; c=relaxed/simple;
	bh=d+20CgSrmkzMHqKKKWnrSe6BH0KIHzOd1IS4ImX5vaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCXHOCov6xoAOlkYHFvnaq2M15onbyMA4ZQhrzuuST8QqNIariz//1ZWe9iiPzN/Uump16ETj/5SE58nEBmlcgi0KC/fC4fPitUr3h5URq99m4eIfvk25NU9X5bm2tWeaCNKA83bO6u5hHFksDKVF6hRUJaaubvBmFT+M0wNUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGyZWVtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A7C4CEFE;
	Sat, 17 May 2025 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440813;
	bh=d+20CgSrmkzMHqKKKWnrSe6BH0KIHzOd1IS4ImX5vaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGyZWVtMGJ2dhrgoL2t8dbZGUT7RFeiyMapZQKUzywywYuJmxiY/mhlb6LnB5hagk
	 KOs2r1HUTbXhRPRmU0wfA0W/mCDKApaEOpfveN05BnU+QyyxMRYXjbVraGb9/ygE4R
	 /TwkxmxYd2fw5Pc7hGpZWWvoF/pZsbOyZflg0h3mULXz3rnSD2Etg/KEtKloWBeUB6
	 7pTgKMVuDzp99TbmyXHqY+kGOfAou7fouOe/2pFXazK6lvbumlaeQl6Z/NEp36EwLS
	 87l8fOdH4kuCAHK3tmOY5kww0JHyXmSbSL0WdcIwXAuSv0Smbkwlejcyf/xyW623OY
	 9JtaLryLe7GsQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] netlink: specs: tc: add C naming info
Date: Fri, 16 May 2025 17:13:10 -0700
Message-ID: <20250517001318.285800-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add naming info needed by C code gen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 95 +++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 697fdd1219d5..8d5e5cb439e4 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2,6 +2,7 @@
 
 name: tc
 protocol: netlink-raw
+uapi-header: linux/pkt_cls.h
 protonum: 0
 
 doc:
@@ -12,6 +13,7 @@ protonum: 0
   -
     name: tcmsg
     type: struct
+    header: linux/rtnetlink.h
     members:
       -
         name: family
@@ -34,6 +36,7 @@ protonum: 0
         type: u32
   -
     name: tc-cls-flags
+    enum-name:
     type: flags
     entries:
       - skip-hw
@@ -43,6 +46,8 @@ protonum: 0
       - verbose
   -
     name: tc-flower-key-ctrl-flags
+    name-prefix: tca-flower-key-flags-
+    enum-name:
     type: flags
     entries:
       - frag
@@ -630,6 +635,7 @@ protonum: 0
   -
     name: tc-ratespec
     type: struct
+    header: linux/pkt_sched.h
     members:
       -
         name: cell-log
@@ -1378,6 +1384,7 @@ protonum: 0
 attribute-sets:
   -
     name: tc-attrs
+    name-prefix: tca-
     attributes:
       -
         name: kind
@@ -1437,6 +1444,7 @@ protonum: 0
         type: string
   -
     name: tc-act-attrs
+    name-prefix: tca-act-
     attributes:
       -
         name: kind
@@ -1473,6 +1481,8 @@ protonum: 0
         type: u32
   -
     name: tc-act-bpf-attrs
+    name-prefix: tca-act-bpf-
+    header: linux/tc_act/tc_bpf.h
     attributes:
       -
         name: tm
@@ -1504,6 +1514,8 @@ protonum: 0
         type: binary
   -
     name: tc-act-connmark-attrs
+    name-prefix: tca-connmark-
+    header: linux/tc_act/tc_connmark.h
     attributes:
       -
         name: parms
@@ -1517,6 +1529,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-csum-attrs
+    name-prefix: tca-csum-
+    header: linux/tc_act/tc_csum.h
     attributes:
       -
         name: parms
@@ -1530,6 +1544,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-ct-attrs
+    name-prefix: tca-ct-
+    header: linux/tc_act/tc_ct.h
     attributes:
       -
         name: parms
@@ -1592,6 +1608,8 @@ protonum: 0
         type: u8
   -
     name: tc-act-ctinfo-attrs
+    name-prefix: tca-ctinfo-
+    header: linux/tc_act/tc_ctinfo.h
     attributes:
       -
         name: pad
@@ -1626,6 +1644,8 @@ protonum: 0
         type: u64
   -
     name: tc-act-gate-attrs
+    name-prefix: tca-gate-
+    header: linux/tc_act/tc_gate.h
     attributes:
       -
         name: tm
@@ -1660,6 +1680,8 @@ protonum: 0
         type: s32
   -
     name: tc-act-ife-attrs
+    name-prefix: tca-ife-
+    header: linux/tc_act/tc_ife.h
     attributes:
       -
         name: parms
@@ -1685,6 +1707,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-mirred-attrs
+    name-prefix: tca-mirred-
+    header: linux/tc_act/tc_mirred.h
     attributes:
       -
         name: tm
@@ -1701,6 +1725,8 @@ protonum: 0
         type: binary
   -
     name: tc-act-mpls-attrs
+    name-prefix: tca-mpls-
+    header: linux/tc_act/tc_mpls.h
     attributes:
       -
         name: tm
@@ -1731,6 +1757,8 @@ protonum: 0
         type: u8
   -
     name: tc-act-nat-attrs
+    name-prefix: tca-nat-
+    header: linux/tc_act/tc_nat.h
     attributes:
       -
         name: parms
@@ -1744,6 +1772,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-pedit-attrs
+    name-prefix: tca-pedit-
+    header: linux/tc_act/tc_pedit.h
     attributes:
       -
         name: tm
@@ -1767,6 +1797,8 @@ protonum: 0
         type: binary
   -
     name: tc-act-simple-attrs
+    name-prefix: tca-def-
+    header: linux/tc_act/tc_defact.h
     attributes:
       -
         name: tm
@@ -1783,6 +1815,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-skbedit-attrs
+    name-prefix: tca-skbedit-
+    header: linux/tc_act/tc_skbedit.h
     attributes:
       -
         name: tm
@@ -1817,6 +1851,8 @@ protonum: 0
         type: u16
   -
     name: tc-act-skbmod-attrs
+    name-prefix: tca-skbmod-
+    header: linux/tc_act/tc_skbmod.h
     attributes:
       -
         name: tm
@@ -1839,6 +1875,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-tunnel-key-attrs
+    name-prefix: tca-tunnel-key-
+    header: linux/tc_act/tc_tunnel_key.h
     attributes:
       -
         name: tm
@@ -1889,6 +1927,8 @@ protonum: 0
         type: flag
   -
     name: tc-act-vlan-attrs
+    name-prefix: tca-vlan-
+    header: linux/tc_act/tc_vlan.h
     attributes:
       -
         name: tm
@@ -1918,6 +1958,7 @@ protonum: 0
         type: binary
   -
     name: tc-basic-attrs
+    name-prefix: tca-basic-
     attributes:
       -
         name: classid
@@ -1944,6 +1985,7 @@ protonum: 0
         type: pad
   -
     name: tc-bpf-attrs
+    name-prefix: tca-bpf-
     attributes:
       -
         name: act
@@ -1983,6 +2025,7 @@ protonum: 0
         type: u32
   -
     name: tc-cake-attrs
+    name-prefix: tca-cake-
     attributes:
       -
         name: pad
@@ -2040,6 +2083,7 @@ protonum: 0
         type: u32
   -
     name: tc-cake-stats-attrs
+    name-prefix: tca-cake-stats-
     attributes:
       -
         name: pad
@@ -2093,6 +2137,7 @@ protonum: 0
         type: s32
   -
     name: tc-cake-tin-stats-attrs
+    name-prefix: tca-cake-tin-stats-
     attributes:
       -
         name: pad
@@ -2171,6 +2216,7 @@ protonum: 0
         type: u32
   -
     name: tc-cbs-attrs
+    name-prefix: tca-cbs-
     attributes:
       -
         name: parms
@@ -2178,6 +2224,7 @@ protonum: 0
         struct: tc-cbs-qopt
   -
     name: tc-cgroup-attrs
+    name-prefix: tca-cgroup-
     attributes:
       -
         name: act
@@ -2193,6 +2240,7 @@ protonum: 0
         type: binary
   -
     name: tc-choke-attrs
+    name-prefix: tca-choke-
     attributes:
       -
         name: parms
@@ -2209,6 +2257,7 @@ protonum: 0
         type: u32
   -
     name: tc-codel-attrs
+    name-prefix: tca-codel-
     attributes:
       -
         name: target
@@ -2227,12 +2276,15 @@ protonum: 0
         type: u32
   -
     name: tc-drr-attrs
+    name-prefix: tca-drr-
     attributes:
       -
         name: quantum
         type: u32
   -
     name: tc-ematch-attrs
+    name-prefix: tca-ematch-
+    attr-max-name: tca-ematch-tree-max
     attributes:
       -
         name: tree-hdr
@@ -2243,6 +2295,7 @@ protonum: 0
         type: binary
   -
     name: tc-flow-attrs
+    name-prefix: tca-flow-
     attributes:
       -
         name: keys
@@ -2283,6 +2336,7 @@ protonum: 0
         type: u32
   -
     name: tc-flower-attrs
+    name-prefix: tca-flower-
     attributes:
       -
         name: classid
@@ -2709,6 +2763,7 @@ protonum: 0
         enum-as-flags: true
   -
     name: tc-flower-key-enc-opts-attrs
+    name-prefix: tca-flower-key-enc-opts-
     attributes:
       -
         name: geneve
@@ -2728,6 +2783,7 @@ protonum: 0
         nested-attributes: tc-flower-key-enc-opt-gtp-attrs
   -
     name: tc-flower-key-enc-opt-geneve-attrs
+    name-prefix: tca-flower-key-enc-opt-geneve-
     attributes:
       -
         name: class
@@ -2740,12 +2796,14 @@ protonum: 0
         type: binary
   -
     name: tc-flower-key-enc-opt-vxlan-attrs
+    name-prefix: tca-flower-key-enc-opt-vxlan-
     attributes:
       -
         name: gbp
         type: u32
   -
     name: tc-flower-key-enc-opt-erspan-attrs
+    name-prefix: tca-flower-key-enc-opt-erspan-
     attributes:
       -
         name: ver
@@ -2761,6 +2819,7 @@ protonum: 0
         type: u8
   -
     name: tc-flower-key-enc-opt-gtp-attrs
+    name-prefix: tca-flower-key-enc-opt-gtp-
     attributes:
       -
         name: pdu-type
@@ -2770,6 +2829,8 @@ protonum: 0
         type: u8
   -
     name: tc-flower-key-mpls-opt-attrs
+    name-prefix: tca-flower-key-mpls-opt-
+    attr-max-name: tca-flower-key-mpls-opt-lse-max
     attributes:
       -
         name: lse-depth
@@ -2788,6 +2849,7 @@ protonum: 0
         type: u32
   -
     name: tc-flower-key-cfm-attrs
+    name-prefix: tca-flower-key-cfm-
     attributes:
       -
         name: md-level
@@ -2797,6 +2859,7 @@ protonum: 0
         type: u8
   -
     name: tc-fw-attrs
+    name-prefix: tca-fw-
     attributes:
       -
         name: classid
@@ -2818,6 +2881,7 @@ protonum: 0
         type: u32
   -
     name: tc-gred-attrs
+    name-prefix: tca-gred-
     attributes:
       -
         name: parms
@@ -2843,6 +2907,7 @@ protonum: 0
         nested-attributes: tca-gred-vq-list-attrs
   -
     name: tca-gred-vq-list-attrs
+    name-prefix: tca-gred-vq-
     attributes:
       -
         name: entry
@@ -2851,6 +2916,7 @@ protonum: 0
         multi-attr: true
   -
     name: tca-gred-vq-entry-attrs
+    name-prefix: tca-gred-vq-
     attributes:
       -
         name: pad
@@ -2902,6 +2968,7 @@ protonum: 0
         type: binary
   -
     name: tc-hhf-attrs
+    name-prefix: tca-hhf-
     attributes:
       -
         name: backlog-limit
@@ -2926,6 +2993,7 @@ protonum: 0
         type: u32
   -
     name: tc-htb-attrs
+    name-prefix: tca-htb-
     attributes:
       -
         name: parms
@@ -2958,6 +3026,7 @@ protonum: 0
         type: flag
   -
     name: tc-matchall-attrs
+    name-prefix: tca-matchall-
     attributes:
       -
         name: classid
@@ -2979,6 +3048,7 @@ protonum: 0
         type: pad
   -
     name: tc-etf-attrs
+    name-prefix: tca-etf-
     attributes:
       -
         name: parms
@@ -2986,6 +3056,7 @@ protonum: 0
         struct: tc-etf-qopt
   -
     name: tc-ets-attrs
+    name-prefix: tca-ets-
     attributes:
       -
         name: nbands
@@ -3011,6 +3082,7 @@ protonum: 0
         multi-attr: true
   -
     name: tc-fq-attrs
+    name-prefix: tca-fq-
     attributes:
       -
         name: plimit
@@ -3082,6 +3154,7 @@ protonum: 0
         doc: Weights for each band
   -
     name: tc-fq-codel-attrs
+    name-prefix: tca-fq-codel-
     attributes:
       -
         name: target
@@ -3118,6 +3191,7 @@ protonum: 0
         type: u8
   -
     name: tc-fq-pie-attrs
+    name-prefix: tca-fq-pie-
     attributes:
       -
         name: limit
@@ -3157,6 +3231,7 @@ protonum: 0
         type: u32
   -
     name: tc-netem-attrs
+    name-prefix: tca-netem-
     attributes:
       -
         name: corr
@@ -3210,6 +3285,7 @@ protonum: 0
         type: u64
   -
     name: tc-netem-loss-attrs
+    name-prefix: netem-loss-
     attributes:
       -
         name: gi
@@ -3223,6 +3299,7 @@ protonum: 0
         struct: tc-netem-gemodel
   -
     name: tc-pie-attrs
+    name-prefix: tca-pie-
     attributes:
       -
         name: target
@@ -3250,6 +3327,7 @@ protonum: 0
         type: u32
   -
     name: tc-police-attrs
+    name-prefix: tca-police-
     attributes:
       -
         name: tbf
@@ -3288,6 +3366,7 @@ protonum: 0
         type: u64
   -
     name: tc-qfq-attrs
+    name-prefix: tca-qfq-
     attributes:
       -
         name: weight
@@ -3297,6 +3376,7 @@ protonum: 0
         type: u32
   -
     name: tc-red-attrs
+    name-prefix: tca-red-
     attributes:
       -
         name: parms
@@ -3319,6 +3399,7 @@ protonum: 0
         type: u32
   -
     name: tc-route-attrs
+    name-prefix: tca-route4-
     attributes:
       -
         name: classid
@@ -3343,6 +3424,7 @@ protonum: 0
         nested-attributes: tc-act-attrs
   -
     name: tc-taprio-attrs
+    name-prefix: tca-taprio-attr-
     attributes:
       -
         name: priomap
@@ -3386,6 +3468,7 @@ protonum: 0
         nested-attributes: tc-taprio-tc-entry-attrs
   -
     name: tc-taprio-sched-entry-list
+    name-prefix: tca-taprio-sched-
     attributes:
       -
         name: entry
@@ -3394,6 +3477,7 @@ protonum: 0
         multi-attr: true
   -
     name: tc-taprio-sched-entry
+    name-prefix: tca-taprio-sched-entry-
     attributes:
       -
         name: index
@@ -3409,6 +3493,7 @@ protonum: 0
         type: u32
   -
     name: tc-taprio-tc-entry-attrs
+    name-prefix: tca-taprio-tc-entry-
     attributes:
       -
         name: index
@@ -3421,6 +3506,7 @@ protonum: 0
         type: u32
   -
     name: tc-tbf-attrs
+    name-prefix: tca-tbf-
     attributes:
       -
         name: parms
@@ -3449,6 +3535,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-sample-attrs
+    name-prefix: tca-sample-
+    header: linux/tc_act/tc_sample.h
     attributes:
       -
         name: tm
@@ -3472,6 +3560,8 @@ protonum: 0
         type: pad
   -
     name: tc-act-gact-attrs
+    name-prefix: tca-gact-
+    header: linux/tc_act/tc_gact.h
     attributes:
       -
         name: tm
@@ -3490,6 +3580,7 @@ protonum: 0
         type: pad
   -
     name: tca-stab-attrs
+    name-prefix: tca-stab-
     attributes:
       -
         name: base
@@ -3500,6 +3591,8 @@ protonum: 0
         type: binary
   -
     name: tca-stats-attrs
+    name-prefix: tca-stats-
+    header: linux/gen_stats.h
     attributes:
       -
         name: basic
@@ -3534,6 +3627,7 @@ protonum: 0
         type: u64
   -
     name: tc-u32-attrs
+    name-prefix: tca-u32-
     attributes:
       -
         name: classid
@@ -3805,6 +3899,7 @@ protonum: 0
 
 operations:
   enum-model: directional
+  name-prefix: rtm-
   list:
     -
       name: newqdisc
-- 
2.49.0


