Return-Path: <netdev+bounces-222605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D2B54F66
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76BC7A979C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524131282E;
	Fri, 12 Sep 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP+Pzyzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC93126DD;
	Fri, 12 Sep 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683399; cv=none; b=O9C5TjlO186euvq8bmTzd2ru0G2uydN8aQ7saY1a+qbCo/zPyhcr30dHP2UJffWwM3xZkVvZH5+mO8FecskIl4nB90IN8RaGttLcNWlpLGOYvy7+qvXGqKPSKRjPVvXR0s4U25g6ZZ3c5DDvQ0YL5K0v4t1uJQJsRc08Q/5+62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683399; c=relaxed/simple;
	bh=CQynYlI5Jbr7BRqUpmCrgkbOcNBBYC+jF1PwTtv6dEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkSolS0VGgBWrHdhoDblb68XE/pO3VZFWV2Vu20LuNDj8ijuyyzod72tEmEtkNDIwoZ1rtGh72Pzcr/kcC9Sv4LpqgscURLNEqUWiDGd7465c6/1WjNL7OCIew+GXsARNMZ9B98rwWYb3405316sJ1LXFd47xnG/DJee5J8xTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP+Pzyzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AC3C4CEF9;
	Fri, 12 Sep 2025 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683399;
	bh=CQynYlI5Jbr7BRqUpmCrgkbOcNBBYC+jF1PwTtv6dEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YP+PzyztFHZUItTulaPmGGfxTAv9bxm2/SYbyDXi/HtCINOyKw4cqzft4iUcg/RL8
	 ptOD6Ty7GrKCPmZglUO/W4jdw4/9QKOHnun6w9IMP5IMqFTZj9alSkfOEG0nk1WNgA
	 OhfYumaznzkgRA0gSivxfmarUD8wgTt1SWNwPqSMOyuOrsrmB8+Etb1kvXlp2KhQ3Q
	 ipdP5NTuwkMJjQx7fp5yMBtRQPd2DDR29VXjf8nrhgi1ZUEQg4t9RcARH6m+iBKEjk
	 tgDzVzcx0OtmAyFt3rMnEBrgkDUPl70RdZ/haExzr7croJVWl7Eznc9ZBYQ+OijbJU
	 9uadTlojbxHRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 15:23:01 +0200
Subject: [PATCH net-next v2 3/3] netlink: specs: explicitly declare block
 scalar strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-ynl-attr-doc-rst-v2-3-c44d36a99992@kernel.org>
References: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
In-Reply-To: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9196; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CQynYlI5Jbr7BRqUpmCrgkbOcNBBYC+jF1PwTtv6dEI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOyO2VMZ0QUi0YdX/rkVaOQ7vrrzNOitXa4Plt41tn1
 4oiv+MfO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYivIWR4bqR5FEtEY4fBzeq
 538/8/mqoLBn/dZS3ldvQvbUXSiIbWdkOPtzyQ+eE1vsjb5LRq69nGK4dHbiQoFLqw+4i3ZksRo
 8YwUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In YAML, it is allowed to declare a scalar strings at the next lines
without explicitly declaring them as a block. Yet, they looks weird, and
can cause issues when ':' or '#' are present.

The modified lines didn't have issues with the special characters, but
it seems better to explicitly declare such blocks as scalar strings to
encourage people to "properly" declare future scalar strings.

The right angle bracket is used with a minus sign to indicate that the
folded style should be used without adding extra newlines. By doing
that, the output is not changed compared to what was done before this
patch.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/conntrack.yaml    |  2 +-
 Documentation/netlink/specs/netdev.yaml       | 22 +++++++++++-----------
 Documentation/netlink/specs/nftables.yaml     |  2 +-
 Documentation/netlink/specs/nl80211.yaml      |  2 +-
 Documentation/netlink/specs/ovs_datapath.yaml |  2 +-
 Documentation/netlink/specs/ovs_flow.yaml     |  2 +-
 Documentation/netlink/specs/ovs_vport.yaml    |  2 +-
 Documentation/netlink/specs/rt-addr.yaml      |  2 +-
 Documentation/netlink/specs/rt-link.yaml      |  2 +-
 Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
 Documentation/netlink/specs/rt-route.yaml     |  2 +-
 Documentation/netlink/specs/rt-rule.yaml      |  2 +-
 Documentation/netlink/specs/tc.yaml           |  2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index c6832633ab7bf9517194da3e2227ace0fa03b013..642ac859cb7ade772e5a7674509475ab32ea3319 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -4,7 +4,7 @@ name: conntrack
 protocol: netlink-raw
 protonum: 12
 
-doc:
+doc: >-
   Netfilter connection tracking subsystem over nfnetlink
 
 definitions:
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c035dc0f64fd6245669c9df82a208c7afddcc3cf..e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -2,7 +2,7 @@
 ---
 name: netdev
 
-doc:
+doc: >-
   netdev configuration over generic netlink.
 
 definitions:
@@ -13,33 +13,33 @@ definitions:
     entries:
       -
         name: basic
-        doc:
+        doc: >-
           XDP features set supported by all drivers
           (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
       -
         name: redirect
-        doc:
+        doc: >-
           The netdev supports XDP_REDIRECT
       -
         name: ndo-xmit
-        doc:
+        doc: >-
           This feature informs if netdev implements ndo_xdp_xmit callback.
       -
         name: xsk-zerocopy
-        doc:
+        doc: >-
           This feature informs if netdev supports AF_XDP in zero copy mode.
       -
         name: hw-offload
-        doc:
+        doc: >-
           This feature informs if netdev supports XDP hw offloading.
       -
         name: rx-sg
-        doc:
+        doc: >-
           This feature informs if netdev implements non-linear XDP buffer
           support in the driver napi callback.
       -
         name: ndo-xmit-sg
-        doc:
+        doc: >-
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
   -
@@ -67,15 +67,15 @@ definitions:
     entries:
       -
         name: tx-timestamp
-        doc:
+        doc: >-
           HW timestamping egress packets is supported by the driver.
       -
         name: tx-checksum
-        doc:
+        doc: >-
           L3 checksum HW offload is supported by the driver.
       -
         name: tx-launch-time-fifo
-        doc:
+        doc: >-
           Launch time HW offload is supported by the driver.
   -
     name: queue-type
diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index 2ee10d92d644a6e25e746f4981457e0dc28181ad..cce88819ba71650cbdcf1f04a728d799d7aaa196 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -4,7 +4,7 @@ name: nftables
 protocol: netlink-raw
 protonum: 12
 
-doc:
+doc: >-
   Netfilter nftables configuration over netlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 610fdd5e000ebfdfbc882a0b7929ed9cf1b206ae..802097128bdaede58d67a862298ccd752261761d 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -3,7 +3,7 @@
 name: nl80211
 protocol: genetlink-legacy
 
-doc:
+doc: >-
   Netlink API for 802.11 wireless devices
 
 definitions:
diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index 0c0abf3f9f050f37ac3905dedb2270af1a6594ca..f7b3671991e6cb5d0e868977b83cad43327cb98b 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -5,7 +5,7 @@ version: 2
 protocol: genetlink-legacy
 uapi-header: linux/openvswitch.h
 
-doc:
+doc: >-
   OVS datapath configuration over generic netlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 2dac9c8add57bb87a707b4c62d8e4794dc970a43..951837b72e1d280468272a85747a08db2d16170f 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -5,7 +5,7 @@ version: 1
 protocol: genetlink-legacy
 uapi-header: linux/openvswitch.h
 
-doc:
+doc: >-
   OVS flow configuration over generic netlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index da47e65fd574203f5ead79d6d470923e0440a1be..fa975f8821b6c9283a9c4a8a2dc51452b14c89e5 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -5,7 +5,7 @@ version: 2
 protocol: genetlink-legacy
 uapi-header: linux/openvswitch.h
 
-doc:
+doc: >-
   OVS vport configuration over generic netlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index bafe3bfeabfb572167a746279edb1a2cac52cbb2..3a582eac1629ee50bd6257dcdfc54ca27a03c03a 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
 protonum: 0
 
-doc:
+doc: >-
   Address configuration over rtnetlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 210394c188a3bc0ed2e248717cce414a20a19089..6ab31f86854db3894ba7c05b398ad6f087facd19 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
 protonum: 0
 
-doc:
+doc: >-
   Link configuration over rtnetlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 30a9ee16f128eac9b9f2f0cf1b8aea1940f1e62d..2f568a6231c9309aa8aec00907ea10a4e3359c1a 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
 protonum: 0
 
-doc:
+doc: >-
   IP neighbour management over rtnetlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 5b514ddeff1db01784e4398a0092490616ca51a2..1ecb3fadc0679fb577d73717ddda4e9c5d61d624 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
 protonum: 0
 
-doc:
+doc: >-
   Route configuration over rtnetlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index 46b1d426e7e863a3ee90199b0c3adeb1e34c1465..bebee452a95073332e7b0681ddd97560ce873f20 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/fib_rules.h
 protonum: 0
 
-doc:
+doc: >-
   FIB rule management over rtnetlink.
 
 definitions:
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b1afc7ab353951d5eeab20323db9dd91966789a2..b398f7a46dae19ba82669404e85665e56139c22e 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -5,7 +5,7 @@ protocol: netlink-raw
 uapi-header: linux/pkt_cls.h
 protonum: 0
 
-doc:
+doc: >-
   Netlink raw family for tc qdisc, chain, class and filter configuration
   over rtnetlink.
 

-- 
2.51.0


