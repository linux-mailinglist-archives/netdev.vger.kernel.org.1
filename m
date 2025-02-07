Return-Path: <netdev+bounces-164085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F20A2C8CD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E7016AC37
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C718DB0B;
	Fri,  7 Feb 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdxQvQ20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD918B47E;
	Fri,  7 Feb 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945636; cv=none; b=EoEogESIuJEwjJfnevI5yPnOfHlDxEWe8rlxnLMdCPqnOWY+IIhFVl4iSUnAyPuiUcQWFnFZFXBi5YQN7udNGGDYtlHvww3vAWoFm/ZogmvazWgxuOOuXYlpsYco0Xk/QUfnQzWxldYjqF/C7WLT56iYXd0HBmgNwgJ9wJPO3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945636; c=relaxed/simple;
	bh=bGoyXY6We520lNEfDX0QPxA2F1231s68QjfLe3Ly2HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGVSxXCtZbHWOxknHOjOFHcwLWUd+YZNlYt+XIZsI6l6pBanKKac+cAd6UjiZDUsJtMBlpQTLE9Jwp1DHbATDHD+JVB+pT8nsCBXOdKxJb+fNSzZen+b/FuQRrCgvgKzzg5gvhReluIh2K6DvFtKFhnwxbe2HeIUvn88VPllkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdxQvQ20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE5C4CED1;
	Fri,  7 Feb 2025 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945635;
	bh=bGoyXY6We520lNEfDX0QPxA2F1231s68QjfLe3Ly2HY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XdxQvQ20Kw9ANVzxvjBOpy7vbWvm9FmIF+97NFRRH/jyGIw7EeQHS+2wTwT5zgWBG
	 OTJV2L+ay43MTPUosaH/O90mVcWkJf5tz4MmSvVTEv+1paFUjS2THb2upLLxqx3Gij
	 eK/AHRE0xfrFwryIGeS1H4ZdeEBCKV0ecpC3Qpny1Ke2NdHIbXoo6yOJeK2tn5sD4O
	 /bdbzSjEes9SrKOP8e1IrVUQsos4he+jsVZC+CF3xQi+IDwpm31s4EBfRlNqLzin06
	 pFm+k/ATShTMw2RGs0o3Z4W1CytijjcwWB2sDJm4Oq9jImSNanjAyUYMbvjno+eZBq
	 4mmStQOW9PRbw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:26 +0100
Subject: [PATCH net-next v2 11/15] dt-bindings: net: airoha: Add airoha,npu
 phandle property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-11-3a2239692a67@kernel.org>
References: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
In-Reply-To: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Introduce the airoha,npu property for the NPU node available on
EN7581 SoC. The airoha Network Processor Unit (NPU) is used to
offload network traffic forwarded between Packet Switch Engine
(PSE) ports.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index c578637c5826db4bf470a4d01ac6f3133976ae1a..0fdd1126541774acacc783d98e4c089b2d2b85e2 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -63,6 +63,14 @@ properties:
   "#size-cells":
     const: 0
 
+  airoha,npu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the node used to configure the NPU module.
+      The Airoha Network Processor Unit (NPU) provides a configuration
+      interface to implement hardware flow offloading programming Packet
+      Processor Engine (PPE) flow table.
+
 patternProperties:
   "^ethernet@[1-4]$":
     type: object
@@ -132,6 +140,8 @@ examples:
                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 
+        airoha,npu = <&npu>;
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.48.1


