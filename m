Return-Path: <netdev+bounces-188462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5DAACE32
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033E03B8FCD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D120C023;
	Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZJedD7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19420AF9C
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560481; cv=none; b=E5vUH/AD7RX6REC4kK3L/qSk0HzM1fgPk2JtvtG6Qe0hYTWRNGPUUjm1cSMDbqEA94lcplrNWm5LqNGVYiIKxIQWatE2guFxEHuvIqH1O1PnR2Dmhe9bAdZu9Sl/IdL6uGHHWTVLfUHzwyjArjRUFrQD0gYeb79Iuzw/+6FkxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560481; c=relaxed/simple;
	bh=rbdSyqgZ9M76ebYHogEmaOjwD+K+nQbF6OPIT76pl/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE7qC/rGFHrYvrUT6YmAyius7Hj2rcEbeCQ/7xNi8/pP79Pc+C+27k+z1R4dcCwd7+tYzuZTdkFoQ9z8kq9olnDzyTe+qa6W9VKZA376LLEtxC3r3j95K+dfZsdLnmS1nweF+x2Fi9kjnoBTHmn8Iec1gciFEqtpx20XBLvJ2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZJedD7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01FDC4CEE4;
	Tue,  6 May 2025 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746560481;
	bh=rbdSyqgZ9M76ebYHogEmaOjwD+K+nQbF6OPIT76pl/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZJedD7BaDPxT32v95jiw1soL0z92erXotOvt8nJdXwTz/SqloHjY+/X7reZnFlBw
	 bBjRjAkADH3qIG0enCzyov0iYp4AAWb7cz86QcscgZk5Ev46h89v+6vJfsvrUEv/5y
	 JiT9qxYPQTqY0UakLIP621wE5Nj1jw9H6ARRnidjNfyjU4Z3KyWhPHkSnIJUwayJ8Z
	 PL8ccGU/vuTp+A47rNpRwy7y/2CL1afstYy8ZburgsritQdd6S3sd73SCABS11qCQN
	 pLdpTUsq2s9/jgB5JY5C7AvQkJHlGa0LoJOTn+N9+8NLLo7YAb7WFaOonSP+BwLiqo
	 YGXIRomlkpzXQ==
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
Subject: [PATCH net-next v2 2/4] netlink: specs: ovs: correct struct names
Date: Tue,  6 May 2025 12:40:58 -0700
Message-ID: <20250506194101.696272-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506194101.696272-1-kuba@kernel.org>
References: <20250506194101.696272-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen will soon support using struct types for binary attrs.
Correct the struct names in OvS specs.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


