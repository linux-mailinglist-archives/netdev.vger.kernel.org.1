Return-Path: <netdev+bounces-189293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C5AB17BF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B35176641
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F0233128;
	Fri,  9 May 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3g64sBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5E230D14;
	Fri,  9 May 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802314; cv=none; b=t2bMDRpBHXh2qlBL2uhZuM2aGEK3e8ZabTER7AD2z3B7lakX+2Aha11FpfYCCPSR49z7J5kWYkqtjjJ20tXerB7lGVKgfdX7KLG5B+tXY6Wq+b0fIjZP70HQ84k+ukqIu8vN4TKg/WkItsDDpy30n5+hue+0p0yOgocN9aVeVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802314; c=relaxed/simple;
	bh=uR0aozr2O/tJXppiXBBx5w2+BaypfkdKR5QW5BGZkGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/qNwggPxCmVafNAU7C/jCeyQ0xrq+AN4Ew58hw0fPqdHMsodNqiXnYvN+IVTnsdWPWOOTepbps67KUJmgrz6pTTRZQPCLfIuQEPvRQmM+I2+/1aAwReb9Z+4YEII+xCrio0qcnQwsWsSCBhSrjkDWJzLXGFa45OTy8vv60m4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3g64sBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83500C4CEE4;
	Fri,  9 May 2025 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746802313;
	bh=uR0aozr2O/tJXppiXBBx5w2+BaypfkdKR5QW5BGZkGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P3g64sBXm9KrjwiFVFwe4CCEzhuGlCIjMpgxhqfsctDcUNr9Ie900BHmcDQfuaHD+
	 4YA3fkRScotnI7liBZ5swLSSTtPiHgNMf1kJcQmZJ5oRYP/41GNFtVWqtBVdeAnUlf
	 x3YEB5NvKcQYQKn+FmyOx1uGrIjz9DVblxgX02q+fjsPAv6Df8LlRDks0xvTEpmTmy
	 JCbytoKwRv5vApoB5Ar8LrGwNlSwF6IWzh8ZxoqOV/u6KT5w7G00CQ+jgrUu2BCadc
	 4qZqirTt/slR1KgLXVOyqljC3qdq6kQzcg/zXolXzDyK8+yKXaB64W2lawuNlEU/le
	 vLbfyAqrVCBJQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 09 May 2025 16:51:33 +0200
Subject: [PATCH net-next v2 1/2] dt-bindings: net: airoha: Add EN7581
 memory-region property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-airopha-desc-sram-v2-1-9dc3d8076dfb@kernel.org>
References: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
In-Reply-To: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce the memory-region and memory-region-names properties for the
ethernet node available on EN7581 SoC. In order to improve performances,
EN7581 SoC supports allocating buffers for hw forwarding queues in SRAM
instead of DRAM if available on the system.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index 0fdd1126541774acacc783d98e4c089b2d2b85e2..6d22131ac2f9e28390b9e785ce33e8d983eafd0f 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -57,6 +57,16 @@ properties:
       - const: hsi-mac
       - const: xfp-mac
 
+  memory-region:
+    items:
+      - description: QDMA0 buffer memory
+      - description: QDMA1 buffer memory
+
+  memory-region-names:
+    items:
+      - const: qdma0-buf
+      - const: qdma1-buf
+
   "#address-cells":
     const: 1
 
@@ -140,6 +150,9 @@ examples:
                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 
+        memory-region = <&qdma0_buf>, <&qdma1_buf>;
+        memory-region-names = "qdma0-buf", "qdma1-buf";
+
         airoha,npu = <&npu>;
 
         #address-cells = <1>;

-- 
2.49.0


