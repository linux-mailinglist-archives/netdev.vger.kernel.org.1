Return-Path: <netdev+bounces-246944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F713CF2A27
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC4A304A112
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAB33123E;
	Mon,  5 Jan 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQrsMO31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420232C33E;
	Mon,  5 Jan 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603797; cv=none; b=HJn0FbSWOXk5GnXNkRnqj8HOp/ryTHR2a9nHyNq7wU9xIT8q0jqAOsHq7Q23kdjPTxqDo1ztaV6o/EKVTv5Vfv7/+Vy/lznSXuzi84W11KS9nn+BpVdAjhPtVpdjW97Wx65qULlmTdiWY9pbEaADa+4phLQltE2aZWwYQbgcoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603797; c=relaxed/simple;
	bh=8vXTewXSrHJNcvfU5XxxfBAvi/sv6EPaP/XXsW+cvCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAGtpuSLUMPo2RZAajv5dYHuiMf1pxB2932yFtgsfAh6zVd+l9fPIW7FL1hsj+Kofdqds12lI3gxCf5A2sXxk00C2rWyogjIDCPRNZmpoxp+VRA0AjtpKHGPBNf3/ybM26wp8OZ0gGPT3ANwG/8igZsSWrhBP0UYJOnRtcAT/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQrsMO31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3451C2BCB6;
	Mon,  5 Jan 2026 09:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767603796;
	bh=8vXTewXSrHJNcvfU5XxxfBAvi/sv6EPaP/XXsW+cvCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VQrsMO31f35whw1OvqyzyD/ru/6ixeJrxJqPSihrTCg+MHcXEHSusMQXN/hY4PGjo
	 7KdK1HTSSTcUXldEfr4r85VXwKlKItXgxOrS90enPT9z5nLTl4qRCH9GUPl7CydNsV
	 +tndekfEl2Y/rhVnsJQid2JcGtCFnaqcRXuxQq2RhsljeKVt+t1NbH7ggrgOb/TxYD
	 qN81C9cFNow3uGVreDH+5EF0zCBS57S49qXkXmPt0QgW9RHGZKRhE0DWbsE/ZRrak7
	 78U3qCwPUG6LjsYdvW5TaMjEzN0YMgLFTggPba1Yok42Pz0Ux0tVBLBx2l1ehzF9CL
	 wt/NJnGkuNnGg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 05 Jan 2026 10:02:56 +0100
Subject: [PATCH net-next 1/2] dt-bindings: net: airoha: npu: Add BA memory
 region
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-airoha-ba-memory-region-v1-1-5b07a737c7a7@kernel.org>
References: <20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org>
In-Reply-To: <20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..b3a2b36f6a121f90acf88a07b0f1733fa6da08a8 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -50,6 +50,12 @@ properties:
           - description: NPU wlan offload RX buffers region
           - description: NPU wlan offload TX buffers region
           - description: NPU wlan offload TX packet identifiers region
+      - items:
+          - description: NPU firmware binary region
+          - description: NPU wlan offload RX buffers region
+          - description: NPU wlan offload TX buffers region
+          - description: NPU wlan offload TX packet identifiers region
+          - description: NPU wlan Block Ack buffers region
 
   memory-region-names:
     items:
@@ -57,6 +63,7 @@ properties:
       - const: pkt
       - const: tx-pkt
       - const: tx-bufid
+      - const: ba
 
 required:
   - compatible
@@ -93,7 +100,7 @@ examples:
                      <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
         memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
-                        <&npu_txbufid>;
-        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid";
+                        <&npu_txbufid>, <&npu_ba>;
+        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid", "ba";
       };
     };

-- 
2.52.0


