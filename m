Return-Path: <netdev+bounces-184044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A2A92FD4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA4E463B87
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32521267B7B;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4EJWC1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A2267B74
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942639; cv=none; b=I/xWYg4NLJYssljjoT/pBpn+nGW2WY3/V9I9zHPnX3NmRarTCI/gyhxrPH2Btjml9PbJwFp6l92LL4gXrCzOaagBBJOEJKd6YcSgCmL/Bq42cJr3AhF+g0lKMaIyJxF/1xeeZc9rvvHHrVB250fS8mZgfpLDTSy2ZXt6p6d2j7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942639; c=relaxed/simple;
	bh=RWWelw6eOwL7K/jZ3ClhbgxHtYTprdzsRBRzlWahjR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNKMViLgCW8hN1lLZUQldizJF/9EwVBR1K4XKy2PLv285mfMya2aWUV10P0gZrTb401uY48t1Ex3YzcoUtsGn0D9OEYEarCVUg9jmpFrvLIfU8+UNntY4O7+567/VWn5B4gLNMSkkNFB99yEXdOFLbRMhzxlKccyl/lEmMXcPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4EJWC1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89279C4CEF4;
	Fri, 18 Apr 2025 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942638;
	bh=RWWelw6eOwL7K/jZ3ClhbgxHtYTprdzsRBRzlWahjR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4EJWC1UkP3v/ZXASkRrFWDRT/j3GbiAE3SWVCsXEkRaN+NL9fRkn4UHTWbAx6ZRG
	 Zm0pZAV6mrXP2EfH4VlKGaQlZjyAZeGscRSJTxvZRoZm4xWf2lfwuB6kKTHHjHh6Bp
	 L1p1phTc7q7+c5hFt3Sb663XL//PqnmVuikPudRry1zv44F8J+wH9Fz2Zrs4wM4QyA
	 /61F7OUTQIQN8HtgqaHE4DXtvlSmglkzsh1TvK7fTraS448hBeDXVaGZXLb1rHrS7L
	 gXA9dJwYkM3q5ktB90pF5+E0pIRV/jv6XiqxuNVQmZ08mCNBwg7u0Ga1Rmco1gPs/e
	 9bPkfeMnOaslA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/12] netlink: specs: rt-link: add C naming info
Date: Thu, 17 Apr 2025 19:16:59 -0700
Message-ID: <20250418021706.1967583-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties needed for C codegen to match names with uAPI headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 38f439911f94..a331eb5eecb2 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2,6 +2,7 @@
 
 name: rt-link
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -11,6 +12,9 @@ protonum: 0
   -
     name: ifinfo-flags
     type: flags
+    header: linux/if.h
+    enum-name: net-device-flags
+    name-prefix: iff-
     entries:
       -
         name: up
@@ -53,6 +57,7 @@ protonum: 0
   -
     name: vlan-protocols
     type: enum
+    enum-name:
     entries:
       -
         name: 8021q
@@ -754,6 +759,7 @@ protonum: 0
   -
     name: vlan-flags
     type: flags
+    enum-name:
     entries:
       - reorder-hdr
       - gvrp
@@ -840,6 +846,7 @@ protonum: 0
   -
     name: ifla-vf-link-state-enum
     type: enum
+    enum-name:
     entries:
       - auto
       - enable
@@ -906,6 +913,7 @@ protonum: 0
   -
     name: rtext-filter
     type: flags
+    enum-name:
     entries:
       - vf
       - brvlan
@@ -918,6 +926,7 @@ protonum: 0
   -
     name: netkit-policy
     type: enum
+    enum-name:
     entries:
       -
         name: forward
@@ -928,6 +937,7 @@ protonum: 0
   -
     name: netkit-mode
     type: enum
+    enum-name: netkit-mode
     entries:
       - name: l2
       - name: l3
@@ -935,6 +945,7 @@ protonum: 0
   -
     name: netkit-scrub
     type: enum
+    enum-name:
     entries:
       - name: none
       - name: default
@@ -1195,6 +1206,7 @@ protonum: 0
         nested-attributes: mctp-attrs
   -
     name: vfinfo-list-attrs
+    name-prefix: ifla-vf-
     attributes:
       -
         name: info
@@ -1203,6 +1215,7 @@ protonum: 0
         multi-attr: true
   -
     name: vfinfo-attrs
+    name-prefix: ifla-vf-
     attributes:
       -
         name: mac
@@ -1257,6 +1270,7 @@ protonum: 0
         type: binary
   -
     name: vf-stats-attrs
+    name-prefix: ifla-vf-stats-
     attributes:
       -
         name: rx-packets
@@ -1288,6 +1302,8 @@ protonum: 0
         type: u64
   -
     name: vf-vlan-attrs
+    name-prefix: ifla-vf-vlan-
+    attr-max-name: ifla-vf-vlan-info-max
     attributes:
       -
         name: info
@@ -1296,12 +1312,15 @@ protonum: 0
         multi-attr: true
   -
     name: vf-ports-attrs
+    name-prefix: ifla-
     attributes: []
   -
     name: port-self-attrs
+    name-prefix: ifla-
     attributes: []
   -
     name: linkinfo-attrs
+    name-prefix: ifla-info-
     attributes:
       -
         name: kind
@@ -1855,6 +1874,7 @@ protonum: 0
   -
     name: linkinfo-vti-attrs
     name-prefix: ifla-vti-
+    header: linux/if_tunnel.h
     attributes:
       -
         name: link
@@ -2107,7 +2127,7 @@ protonum: 0
         byte-order: big-endian
   -
     name: ifla-vlan-qos
-    name-prefix: ifla-vlan-qos
+    name-prefix: ifla-vlan-qos-
     attributes:
       -
         name: mapping
@@ -2123,6 +2143,7 @@ protonum: 0
         type: u32
   -
     name: xdp-attrs
+    name-prefix: ifla-xdp-
     attributes:
       -
         name: fd
@@ -2150,6 +2171,7 @@ protonum: 0
         type: s32
   -
     name: ifla-attrs
+    name-prefix: ifla-inet-
     attributes:
       -
         name: conf
@@ -2157,6 +2179,7 @@ protonum: 0
         struct: ipv4-devconf
   -
     name: ifla6-attrs
+    name-prefix: ifla-inet6-
     attributes:
       -
         name: flags
@@ -2222,6 +2245,7 @@ protonum: 0
         type: binary
   -
     name: link-offload-xstats
+    name-prefix: ifla-offload-xstats-
     attributes:
       -
         name: cpu-hit
@@ -2236,6 +2260,7 @@ protonum: 0
         type: binary
   -
     name: hw-s-info-one
+    name-prefix: ifla-offload-xstats-hw-s-info-
     attributes:
       -
         name: request
@@ -2245,6 +2270,8 @@ protonum: 0
         type: u8
   -
     name: link-dpll-pin-attrs
+    name-prefix: dpll-a-
+    header: linux/dpll.h
     attributes:
       -
         name: id
@@ -2357,6 +2384,7 @@ protonum: 0
 
 operations:
   enum-model: directional
+  name-prefix: rtm-
   list:
     -
       name: newlink
-- 
2.49.0


