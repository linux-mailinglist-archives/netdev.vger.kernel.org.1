Return-Path: <netdev+bounces-192187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FCABECEA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A03D189AE6B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51623536B;
	Wed, 21 May 2025 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXd7DP3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363F22D9E0;
	Wed, 21 May 2025 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811818; cv=none; b=TfcREgxQtFLF6ITlUU06B89NPqsN4nZlhiZ93XPyF+P3uJ+osYi1nJZglqTCjRMKwgdk2AA3FUk9JIS3RJ9wUAoeKcrh7qYoAOQIJjLM5r3Uek753f2x4rEB8teYtuf9nU4zRwYERF7iJXGt5fAGLpaYURXa9V2rhQt8lkG1rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811818; c=relaxed/simple;
	bh=1ZMsp0g7S2M+T7SYrXpIJJ6HweNwGxCIZp/f5LQgZuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOWQGksZTSDGquFAepXFufRil8ve/QM07Oh1blrkUnAkDPZTVUCvmKevb6dDo42VETJoWVTwMQ+qP9JABIa2FK5KHB0QpWrvjYUD93LNxyJ+F+CmlHrEjJzQ60yjdf5HlEFaZoVKiYggIbXD14we38PILn35MtbHM9N//tFCPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXd7DP3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D61AC4CEED;
	Wed, 21 May 2025 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811818;
	bh=1ZMsp0g7S2M+T7SYrXpIJJ6HweNwGxCIZp/f5LQgZuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NXd7DP3kAmXhDfzZ0H3SbMK9IqTQoNX/AEQ0mXGiSGPSC5mH5w1IXIudLdnbcBcVS
	 UWIwk7dAiML6Rwv5xuGzNiEW4GFX0JwK1/II8Ynydq8ZqgIusyZnuo5UIQvpmgC1GY
	 cYWCNfSCykosDTo470HzgsjEGDqz/ZZL16lqV1t8OgxfD5y1MybAi+lU7fPj4AhLzb
	 KJywyCAbr74WewJT2bCYU7XtkOE4pMKmMAQFvWXcLLB5JlCFuppdKfeC3Y82pG47ML
	 Wej28yLcDIqYxYV95WG8SFksP0iqxZXVUVE2DUGgnb5B+JbiUGX8L4AWuaaBN/F5Ud
	 TAy/58w+jHX8g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 21 May 2025 09:16:36 +0200
Subject: [PATCH net-next v3 1/4] dt-bindings: net: airoha: Add EN7581
 memory-region property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-airopha-desc-sram-v3-1-a6e9b085b4f0@kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
In-Reply-To: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce memory-region and memory-region-names properties for the
ethernet node available on EN7581 SoC in order to reserve system memory
for hw forwarding buffers queue used by the QDMA modules.

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


