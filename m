Return-Path: <netdev+bounces-191957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BBABE082
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD4B188F8EF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AB27055C;
	Tue, 20 May 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Em0Gzp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EC2701B6
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757966; cv=none; b=txlXlXwlKImoL/uvlDBmK7wTD3wCbjIKvYfZHMGHV/ARVpT1hCV/nxmLuaqtyyjfRrOl7u+Sa8BegJt8J7hbLRkmKxc7r3lOrYrWW5Nf8JEF8PwKRXCczH8yNUzbUkDtbtt8XiTQ9RAMvYXOCizzXAo7nB3mOwTF5m6DZdHDIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757966; c=relaxed/simple;
	bh=cVsXyFbZFH4xTgFSG0KA8C/CyrNmhjtjGcNkjtFj/oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjGa0g/vz40tV6bjDgfzA/ouRSTYF62ybXM8gY9PFYtAqbHvNlO6W6PClJtKM/O0QH2E/0SEZuwUAzg2U2OSww3cbLwiaAfxVrjWLMLlNo6uJcJedp08/GGV2KqkONHfHQaTKpKWTaAh/S+SSun2zug13DJOtZtfG+7X00Voy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Em0Gzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB76C4CEE9;
	Tue, 20 May 2025 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757965;
	bh=cVsXyFbZFH4xTgFSG0KA8C/CyrNmhjtjGcNkjtFj/oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2Em0Gzp6ABjss3HedKTnPWP2qLHWmW1kAuxRy1o8BAQ3Dlsb8ao3DP0Oudlx+l50
	 U/DYU4Tzsmw384iUhUnxmkalpuxfGyVQIhyNb7OVUjlepRYMJYZ5qjbs9tklMJ8NeH
	 eveuMDYV7nsDOSPiDdH2+eW0yH67Tf4vs6p+xEWLmYLazizPtuBO215oEBegALyC5i
	 1308zm+O66kvHRodo0EKjBcCfbLAEYa9apfY33ubHMTDroel7kemr3vougdqgyjqsP
	 LqAJlcsOzP+XPqQrFntwmQqJFFsxrhYjafm76f1HE6cY/e2CfMVqqBPzow+oBth7LW
	 WPXlmYNSapw6g==
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
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/12] netlink: specs: tc: add C naming info
Date: Tue, 20 May 2025 09:19:08 -0700
Message-ID: <20250520161916.413298-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add naming info needed by C code gen.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


