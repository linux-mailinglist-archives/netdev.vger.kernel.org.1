Return-Path: <netdev+bounces-210380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98649B12FE1
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C63B6F5E
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538A21A434;
	Sun, 27 Jul 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfuWJ4Ua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE9D528;
	Sun, 27 Jul 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627272; cv=none; b=X6x2G5/gSBCSDVR1fGfxAZK8w1u4Sq/ooHiTFw5o1BwdEV18DaAhn7LeKRdEBznKm80O183ULxRksHiPc8EBiQs5qG8HoPFME54ueU4FIKe++eQyK9AYqCOx9UwPypmNLf+HHnCPZK/5BMcqkOBU4JP8dyhGR0QzD9Cm6/kMHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627272; c=relaxed/simple;
	bh=FoodcQfDi77BL3FsG7MouWgqbNJBM2kuquxlkB2wMdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGr44w+8+hDulAoZN/ghM4xOmeat2oxgSkY+IcLC0Adp1Z0pg0bdMhmTy9EFIdDd1Fb+Ld2b34qfrK0rebHyg6gzi/00kJ30mbDXlxVHXkHjgiWkpJZwtTgbBX8YFNc+aLJwMo0uz6QFSf9IAxsyv7j6Nbmi7DNVU9SO7KT3O34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfuWJ4Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14828C4CEEB;
	Sun, 27 Jul 2025 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627272;
	bh=FoodcQfDi77BL3FsG7MouWgqbNJBM2kuquxlkB2wMdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sfuWJ4UawEKNJrn8fWJrcBzzKeIyatTolnHk+CLozDBUB8eMQpAitYihKtzTHdcIO
	 UTAs6JMtu9VIBSrET2k+3u9nbM3qjw7klBnVhlhaEW1YmZ9AwAROv3bzuYfn9Hv6V6
	 BXOcSPlecoyBW9pZo4m+EXJYR8WlTytY2arfw0BFKAI0G0FNmO/B5dTbG5jgbOLFWP
	 uIoU6bAi0O8VL/Oly7Qnog1OwaYcLv2q1bWqw5BuAhULH4MylvdTyBOVVaDJSL29/x
	 ISNrdmbvUwQUOKW/xAy8bFs3o9JAnJF2buOl0iWiZDhXxYfwKFXExQjWEttFtIlNFI
	 aJ3WAc+ZTaKIg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 27 Jul 2025 16:40:46 +0200
Subject: [PATCH net-next v6 1/7] dt-bindings: net: airoha: npu: Add memory
 regions used for wlan offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-1-6afad96ac176@kernel.org>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Document memory regions used by Airoha EN7581 NPU for wlan traffic
offloading. The brand new added memory regions do not introduce any
backward compatibility issues since they will be used just to offload
traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
if these memory regions are not provide, it will just disable offloading
via the NPU module.

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


