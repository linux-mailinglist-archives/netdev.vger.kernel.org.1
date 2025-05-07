Return-Path: <netdev+bounces-188761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F96AAE82A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3871B694E9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024D28DB61;
	Wed,  7 May 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxNfAM85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9528DB57;
	Wed,  7 May 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640148; cv=none; b=iG9WOkfbQ0hRSKY1wJIOAQm8A9GKL1OO9HFqzrsnZyiVJeCWFbtDfyDQ0gxRY9aryKfAaRKQd8yNpTj+ySVANdJttqsHGlTd6X/OmEecFokqfg5I3qayvvEj05BomyLz6COE8OOUi2Iallp15Z3P5gc7bS9qeJAInFci19OfMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640148; c=relaxed/simple;
	bh=uR0aozr2O/tJXppiXBBx5w2+BaypfkdKR5QW5BGZkGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYHY2XW6uZ5K6NTGhMKIBPZI0Mkie3giGa5yS7SHC808N8x9iASwGhu2ZPRyO6ZHY8NUK4/dpizxPFmYnvlaaPwnqoUwFFjt48yPkGrYrxnoD5ll9tUDWfTPpemF3rd6pCh3W+c28xs18f0W9fuidyoLwXYbIDUVoTEFayKo6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxNfAM85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1685DC4CEE2;
	Wed,  7 May 2025 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746640147;
	bh=uR0aozr2O/tJXppiXBBx5w2+BaypfkdKR5QW5BGZkGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CxNfAM85W5HvgSZnqjlmTl1LycieW3MBV4Y4866cnVPIN6mLCgmHBq/BkADebZRRr
	 2xQuh/AkK6YyVIo0gCXrSV16iuix174HJTEjERlzaym/Aj4caFmdWmgXqlFu+AYiHo
	 ctjQzPy/93C3RoYOR7eDI2tck8LUSUvMooTkWp96Lh/qQP9ALjVGHsReyi7JP4umO5
	 hoX4zMhcDa3l8LRpZ9XB7IjUYqCbFJTJ9G5KZVDoqwXhlwBJNlvxq5Ax2s4Mh9jq7U
	 k1LCFhmgArDckWOY8FdYKHFCcMEBAvyg8utyyHEU5q5vQ4t6AUE8sZjWVvydZ9oBK6
	 HgFi1INKIGlZg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 07 May 2025 19:48:45 +0200
Subject: [PATCH net-next 1/2] dt-bindings: net: airoha: Add EN7581
 memory-region property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-airopha-desc-sram-v1-1-d42037431bfa@kernel.org>
References: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
In-Reply-To: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
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


