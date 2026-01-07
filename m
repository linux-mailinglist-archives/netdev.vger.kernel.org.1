Return-Path: <netdev+bounces-247632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21761CFCA10
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B964530C9E50
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C428642D;
	Wed,  7 Jan 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoP9HRdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168027877F;
	Wed,  7 Jan 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774595; cv=none; b=JrIa4GDm2ah1Qwy1YI9NrDtkFXam7C1jtiIqMuaNUFp6aIH4A2yc8bcEeL1VMOlXwYRRmoxe73AaVt10du+2lKYj568bFuNnlh5NEijk25qyAMMLtxAEbAjqUPVDX33XRpdTIKBCrcd1McQmZKnOWjcdJ3rwlLbaZPTkCQEja1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774595; c=relaxed/simple;
	bh=n+LKP/wqSqSKvHYOmUR2ubNx5hlSjKfruKRqomCUXjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unRUFL5Fsix7cVPsvR+YjOH2Aft08cp3foioKwkNGDeUnVPsaxWd5JZI8OpQx/9l0eyLt7bFTssOsMZzsKtMi7ry7mIiL/+6N/yxDCC28h0jndStfmvDIkOD47u2Lgp+uHpiW2tErDIAtG1I/V84rMcnc/OwU4/dcLbmA7jtsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoP9HRdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3DFC4CEF7;
	Wed,  7 Jan 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774594;
	bh=n+LKP/wqSqSKvHYOmUR2ubNx5hlSjKfruKRqomCUXjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QoP9HRdQ9CHAVwXWQA8q6+TPNmmOoxhwGHkeD542cJc5aI8abziiVHfUpFOsekw0i
	 zDANXDZkQ1XAkXgDzZqMtcL1zmlRfKWZIMJIYJ3wnYYeaOS5bCngWlEMRs3Sg3loWM
	 J6HiNptjY8m1r68dRcozDN1JtOn20zUnX/kk8xpCm9k2ojUeAAaRKWZngMNAtVNHDk
	 o9fvkFB64LalALfoleC+/xohpNR1g+JWau37dbTRx3nlCOkJMgpM4wTHcb7/59u+48
	 MxLm931iI3wlvMgIL3bFNJs6aynle027n7SEBzASV0gh9/uXihhwOt6rPyaq0gz9qu
	 +spqJfXZa/orw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 07 Jan 2026 09:29:34 +0100
Subject: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-airoha-ba-memory-region-v2-1-d8195fc66731@kernel.org>
References: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
In-Reply-To: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
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
 .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..42bc0f2a42a91236c858241ca76aa0b0ddac8d54 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -42,14 +42,13 @@ properties:
       - description: wlan irq line5
 
   memory-region:
-    oneOf:
-      - items:
-          - description: NPU firmware binary region
-      - items:
-          - description: NPU firmware binary region
-          - description: NPU wlan offload RX buffers region
-          - description: NPU wlan offload TX buffers region
-          - description: NPU wlan offload TX packet identifiers region
+    items:
+      - description: NPU firmware binary region
+      - description: NPU wlan offload RX buffers region
+      - description: NPU wlan offload TX buffers region
+      - description: NPU wlan offload TX packet identifiers region
+      - description: NPU wlan Block Ack buffers region
+    minItems: 1
 
   memory-region-names:
     items:
@@ -57,6 +56,7 @@ properties:
       - const: pkt
       - const: tx-pkt
       - const: tx-bufid
+      - const: ba
 
 required:
   - compatible
@@ -93,7 +93,7 @@ examples:
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


