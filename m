Return-Path: <netdev+bounces-187783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BEAA9A03
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357C018946E7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8A26C3BF;
	Mon,  5 May 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+trLWG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3D26D4C2
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464548; cv=none; b=Tz6/c0941chw+UYQ3zEWbQBbBBvn1SgIri21y88G8OjtVvjRwqeZX+d9adCFqDPBnPHgHkkkD367V/8G5D+J+/odm/GuVZYdb9JpGvpzagX7SiP55bI6qUFQTHHon/UgDUFvVsx9rk8od8BxpvSR9G+Gg+KXk2IzbeelGuxI36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464548; c=relaxed/simple;
	bh=HRxpEKYAl+YITMCgOc9M7gZaErAmaRkfrV+DGWONcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3MKJoeMBbsowQYlA8dYjyjEqGVk031Hlr9q+eRXnv53DHMCL3buiz8I0iYipAFdX00pZt7iEaEExLoNtkznPHQ1TF6u7D0BU+UHxQ31AlMBHOMAUAD3SKtUI+8l+BFBuguRO/r3O1EQju8CSgadQwiunsbxsgYAvjEj40zNhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+trLWG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB788C4CEF2;
	Mon,  5 May 2025 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746464548;
	bh=HRxpEKYAl+YITMCgOc9M7gZaErAmaRkfrV+DGWONcdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+trLWG7/xREy7VgnN4BBiVC6V9t43WDwuPtjRNzvcQRzHQfxOxGj8AQE/MXiLc8e
	 kzCFQT6CL+Msmzib50gF7KdOHWDxb6AYPf44nHss6XGDLxg/rVO/LkTN5mpWXcxwBx
	 Yb6/PwPieB8maHiGMKVgShSy2TP4vuvhrDt4h83O3A3FwnSDvd9oRX50DA5N+FpG93
	 ccv1YvEWjz8ydOqkQu3mpjeqLGX6g0lzqFBSVG/iObVHURgCFKS3FrHAqv7/dUNa1L
	 XS6DpY6XjvzWkVX0AMo8tphzHyKlGnhEMoKQPVUEPUMntCee46/g87R3EF4gxyBHGC
	 /M6nXi8kKaVyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] netlink: specs: ovs: correct struct names
Date: Mon,  5 May 2025 10:02:13 -0700
Message-ID: <20250505170215.253672-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170215.253672-1-kuba@kernel.org>
References: <20250505170215.253672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen will soon support using struct types for binary attrs.
Correct the struct names in OvS specs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 10 ++++------
 Documentation/netlink/specs/ovs_vport.yaml    |  5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index edc8c95ca6f5..df6a8f94975e 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -35,8 +35,7 @@ uapi-header: linux/openvswitch.h
         name: dispatch-upcall-per-cpu
         doc: Allow per-cpu dispatch of upcalls
   -
-    name: datapath-stats
-    enum-name: ovs-dp-stats
+    name: ovs-dp-stats
     type: struct
     members:
       -
@@ -52,8 +51,7 @@ uapi-header: linux/openvswitch.h
         name: n-flows
         type: u64
   -
-    name: megaflow-stats
-    enum-name: ovs-dp-megaflow-stats
+    name: ovs-dp-megaflow-stats
     type: struct
     members:
       -
@@ -88,11 +86,11 @@ uapi-header: linux/openvswitch.h
       -
         name: stats
         type: binary
-        struct: datapath-stats
+        struct: ovs-dp-stats
       -
         name: megaflow-stats
         type: binary
-        struct: megaflow-stats
+        struct: ovs-dp-megaflow-stats
       -
         name: user-features
         type: u32
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index b538bb99ee9b..306da6bb842d 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -23,9 +23,8 @@ uapi-header: linux/openvswitch.h
     name-prefix: ovs-vport-type-
     entries: [ unspec, netdev, internal, gre, vxlan, geneve ]
   -
-    name: vport-stats
+    name: ovs-vport-stats
     type: struct
-    enum-name: ovs-vport-stats
     members:
       -
         name: rx-packets
@@ -106,7 +105,7 @@ uapi-header: linux/openvswitch.h
       -
         name: stats
         type: binary
-        struct: vport-stats
+        struct: ovs-vport-stats
       -
         name: pad
         type: unused
-- 
2.49.0


