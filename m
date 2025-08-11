Return-Path: <netdev+bounces-212489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D10B2107B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F6686432
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271441A9FB6;
	Mon, 11 Aug 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgFn+kyE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A51A9FB3;
	Mon, 11 Aug 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926330; cv=none; b=t5tjBubNWkIBMVvmMd49bQNlU47yp300wDqULVNoHwpcankpop5EEBqygIn5nht5U7cHW2a7/Jm+ZsfBraip0lZY9r0uGLCqI1mQkxbGicviVmsggBUmQJoseKzynFvndQkB71KI4RvVoujKWuInwI1wQLsdMjEIDz4VAP/AzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926330; c=relaxed/simple;
	bh=Xm87dAvHgr64si5BCruI649fUNe+2Ev1eMQ1d5E6VVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJ8X3QV7Kc0eQXKUQY7LZhG9o/MsFRDfa72UwJfDz/IUbj9yU/zO9t3h9rFGzhMFqycvZBA1GCkKOG5tt3+nRPApZm6tMvP7Wvpe0vwBBlX+w90K6TOsW8k1m3yG7+VcpR7kJR/X+6TxtcbQOx0aJb+hjnzRpC19TAo6il0gQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgFn+kyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D3BC4CEF4;
	Mon, 11 Aug 2025 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926329;
	bh=Xm87dAvHgr64si5BCruI649fUNe+2Ev1eMQ1d5E6VVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HgFn+kyED/UcHzrW8hAmrKVvxJwo+QGtPd5TdszPD18pFoaRKDCVyiV2rDfzSKkZz
	 sjsWQ7KW98MoLPKxOqse3G4Bhhbr/qnhI98XSEfEIMIBr62dQ01rLXccgaYcHrrTK7
	 Z1d3Q8zvQQ0foKt84TXDQAD18h1ccm1QaHnvAFDN0y2YXjmiQ/pYX4DXwCNNOEtHXM
	 QlHZyAiR6hU4HvGwm1WHzY8SN1zXAqCIXrNAnucaEZd3qIb6g+VvX/G1DuoyxcNksY
	 D7GFGAUrt6fJJzkTl7IeIIp1bLI+csnXpNApx+nsw5z+CLw85eViaApJfDgBb3nzuh
	 WkCqB/BjV2rMQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 Aug 2025 17:31:36 +0200
Subject: [PATCH net-next v7 1/7] dt-bindings: net: airoha: npu: Add memory
 regions used for wlan offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-1-58823603bb4e@kernel.org>
References: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
In-Reply-To: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Document memory regions used by Airoha EN7581 NPU for wlan traffic
offloading. The brand new added memory regions do not introduce any
backward compatibility issues since they will be used just to offload
traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
if these memory regions are not provide, it will just disable offloading
via the NPU module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-npu.yaml | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..c7644e6586d329d8ec2f0a0d8d8e4f4490429dcc 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -41,9 +41,21 @@ properties:
       - description: wlan irq line5
 
   memory-region:
-    maxItems: 1
-    description:
-      Memory used to store NPU firmware binary.
+    oneOf:
+      - items:
+          - description: NPU firmware binary region
+      - items:
+          - description: NPU firmware binary region
+          - description: NPU wlan offload RX buffers region
+          - description: NPU wlan offload TX buffers region
+          - description: NPU wlan offload TX packet identifiers region
+
+  memory-region-names:
+    items:
+      - const: firmware
+      - const: pkt
+      - const: tx-pkt
+      - const: tx-bufid
 
 required:
   - compatible
@@ -79,6 +91,8 @@ examples:
                      <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-        memory-region = <&npu_binary>;
+        memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
+                        <&npu_txbufid>;
+        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid";
       };
     };

-- 
2.50.1


