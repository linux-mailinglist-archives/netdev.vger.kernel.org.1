Return-Path: <netdev+bounces-226847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3DDBA5A12
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6AA2A4268
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F57283FE1;
	Sat, 27 Sep 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="yFhIyI8P"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FD27A928
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758956919; cv=none; b=D5UYlfu+131LlO/xcdcTfuokRGn/lCA75UrfKl4IFIg9Pdj+fI0w8r9p473qEdXawZGaXwxVRwv3Mx3a7XrsV+8HNq8+7Hk6UQ8z1qWs9z+dwpKaCkbjzJx0S+CmWWJnZHEYo0qawJpqRi+dmDx511PzmFsnFScGclhP52CZvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758956919; c=relaxed/simple;
	bh=GwYSL2nkCPuXZjnbJ/Os6l0os5/AtWZPUF/Fmhz9cuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5S0pchjuibDBHHxwHzNPPM29QiQjoNxYa4EkNpOrux441HyK1TiFbomvmWDydndfLTiMh36OauvPu95uLgqC6cjs3Oe/yLIXopsBmnYu/zpsWPS/eYE8qPcevMpmERXgghaHPNSk/DUjTrcfc8eGyVxIplX1ZsVPoGQ6tHSuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=yFhIyI8P; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w8D026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:24 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w8D026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956907; bh=dOJBIXw/tOw/nsGtimWEqRJNXsqsJvPEuj661JVrIY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yFhIyI8PHNftmWt0/2GD1qMLDByMfy1xWsTLirR1epD8ry+0UShs90Ux7q8dRpMPd
	 QhPCoz19fkatui6VlqQHNsq+3YTjd96FDR1yEQjEBP6A9GZxrYOY45kQdr+Fj61toH
	 fwe9GRnLcX8oOEc5cvMLtu2mUBR+Sg5y+5THKV9NGsozdSCAJuhW8AEkoHRlvcQVX5
	 3xXhmnZIFDPHYsZKj0IDCiIkWoo+hNgf2zmyid4f/Xba51FrGn4exRKCmtUAGsVBvD
	 D41+94WplMBKGHULqG4fWg86WiDLC6Ked0tRNifCneicT01leFuCd0qU4lT3PIhs1b
	 r8qTzesXbUSlg==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 5/5] dt-bindings: net: dsa: mv88e6xxx: add mv88e6xxx-avb-mode property
Date: Sat, 27 Sep 2025 17:07:08 +1000
Message-ID: <20250927070724.734933-6-lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927070724.734933-1-lukeh@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the vendor-specific marvell,mv88e6xxx-avb-mode property for adding
stricter handling of frames with non-AVB frame priorities and destination
addresses.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
index 19f15bdd1c976..33d0cf5f21d5b 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -97,6 +97,31 @@ properties:
     required:
       - compatible
 
+  marvell,mv88e6xxx-avb-mode:
+    description: Marvell MV88E6xxx that support Audio Video Bridging/Time
+      Sensitive Networking (AVB/TSN) traffic prioritization can have ports
+      ports configured in one of several modes. These modes control the
+      handling of frames with non-AVB frame priorities and destination
+      addresses.
+    oneOf:
+      - enum:
+          - 0
+          - 1
+          - 2
+      - description: |
+        0: Standard Mode: frames with a priority that is mapped to an AVB
+           traffic class (TC) are considered as AVB frames. Others frames
+           are considered Legacy (non-AVB).
+        1: Enhanced: frames with a priority that is mapped to an AVB TC
+           and for which there is a static FDB or MDB entry are
+           considered as AVB frames. Those with an AVB TC but no FDB or
+	   MDB entry will be dropped. To avoid conflict with other multicast
+           protocols, only AVTP (91:e0:f0) destination addresses are
+           considered to be AVB multicast addresses.
+        2: Secure: as for Enhanced, but also require the FDB or MDB entry
+           to have its source port's bit set to one. In this mode, all
+	   frames with an AVTP destination address must be valid AVB frames.
+
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
 
-- 
2.43.0


