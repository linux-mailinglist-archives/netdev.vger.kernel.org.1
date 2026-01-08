Return-Path: <netdev+bounces-248122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE0D04487
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 663363366090
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF689342521;
	Thu,  8 Jan 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2JcxrpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9C33291D;
	Thu,  8 Jan 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884738; cv=none; b=a2IxJgQkZJ6QRVF0Hq4Hnk281LNbkD9Fe4l+LzoWxYpXmfcuUHYOj6VN/V3NkqtGxk/s2H4A+YtDZIYMU0+DyZKNmlFGgQrdlrV1CEZCek4jsgI8CsuYzhqiNJrmoyrTjRxjhgZ7Ry5xilRIGJQOAKPfs+xJ1/VLuSA4YvJqCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884738; c=relaxed/simple;
	bh=DGdHkFD+3L5QgZmRMdpdwL9Bm9MC+Wi93ePEIeYNCWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjDvAenMCV95oooWZlzQ4IPdiBKxUPi4/ppCMp3h1ODNLvkic/XWX9WcwIhyYZJYwuY1g9a+0sV9kaLwhJT+lLavT+3oC3fEiwvCvVWdSOBfKy1askTUozQG5JSrN6P8PaohKVfQSGdQsYtWXcPvJVd+9P/v4bQIgs0vj27kjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2JcxrpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107E7C116C6;
	Thu,  8 Jan 2026 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884738;
	bh=DGdHkFD+3L5QgZmRMdpdwL9Bm9MC+Wi93ePEIeYNCWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g2JcxrpUi7AaJtDoYHHgWuhyywj4wX46R1n4CFdMSn60n61tfDxML2xWNe/uaqIy+
	 v+5TC+FJT4WMbPcOITX9hjemBnAWhXcZuGGxnNmGpz6Dg93FHdJKmYE9agm8E94Ybo
	 /whcHcWTofRl2drZLs8KOYE0LtAHCduYAiEr90PApPeLu9DuajqEfQQHaIpZxZTEwO
	 rsajtsZRLsEwmQHnaUrcIr8C23LKt+GjXSD0ueoyf527rbUnvOkv1EWQc/DHWe2LAp
	 pHXHVUH/mVJQKFn6ytYom72q1F6PYT8KoTwACa+thpLXKyT5gNkLvE4U83noI84Y5a
	 eg1qDLGB6p7aQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 08 Jan 2026 16:05:07 +0100
Subject: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-airoha-ba-memory-region-v3-1-bf1814e5dcc4@kernel.org>
References: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
In-Reply-To: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
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
 .../devicetree/bindings/net/airoha,en7581-npu.yaml  | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..19860b41286fd42f2a5ed15d5dc75ee0eb00a639 100644
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
@@ -57,6 +56,8 @@ properties:
       - const: pkt
       - const: tx-pkt
       - const: tx-bufid
+      - const: ba
+    minItems: 1
 
 required:
   - compatible
@@ -93,7 +94,7 @@ examples:
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


