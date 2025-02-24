Return-Path: <netdev+bounces-168985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F8A41DAC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB06417FBA9
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFC263F40;
	Mon, 24 Feb 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B03oomYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E225C6F4;
	Mon, 24 Feb 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396377; cv=none; b=pkEBaczM6Yylu4w1q3/lDcxV3N4sDyFzPiN0nC2ueMEgFljEb0pCWPUgAx1Uhzua+MSYznzjOEeUHR0BxrDS7dkkHKjh1TXOOYsUGdOaWreq0opY2Xvr3dei7u5L8+1n8QRMTBX5QrGeEYXjML/8t4dCVw4UQnAjMA03x7MKGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396377; c=relaxed/simple;
	bh=JZDiAKKeX0eSnGFkmKTsrRKkLXrlYR1V8xaHJKtSw9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N79Bg4bW7KkRwOt1PDCxIohhaqd+vCtEJahKn4iNxHsRbkQVNk2Yb1cqm9r2fDfjREMEgVUFIYXyYrDIgiAJ3jimIyNIZ69HWlhFDKyy6WDF5ddbOpfNpik8Hk2sgv15oMFQhom9bQUp15yAIMu2gT0eQX7I3BnfRrTC4XmkqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B03oomYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC01CC4CEE6;
	Mon, 24 Feb 2025 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396377;
	bh=JZDiAKKeX0eSnGFkmKTsrRKkLXrlYR1V8xaHJKtSw9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B03oomYO1xl657P13bzbYPxi72IiirFYZZCJjZuAzwi2kTDKtGSXO7A46cHNdimG2
	 Gdas75atKawyNb+W4NoT/Dy9MxaTeA5I9CsCAbSavy6wJRoqKL6mS/MHeBuxgAgzlq
	 Uv4uHYjc4zvDGbTp+HZZtLJi6RTWsN452Nj4frd/hb+AwpckCnXxXERaU4VUX7EPfN
	 hIEQ0oRnpB8k6xxFR42me1ol31mi3EW5wOXiHMhgSZqDZpXo3zJqj3kgzAwO2XwigJ
	 SbKSiQaibomsECTyj27/teXMdqXGHartQ522TX97xUMDV2CXcHgpaIt547cDHSpSqg
	 2gldkH81MfXng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 24 Feb 2025 12:25:31 +0100
Subject: [PATCH net-next v7 11/15] dt-bindings: net: airoha: Add airoha,npu
 phandle property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-airoha-en7581-flowtable-offload-v7-11-b4a22ad8364e@kernel.org>
References: <20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org>
In-Reply-To: <20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org>
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
 upstream@airoha.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Introduce the airoha,npu property for the NPU node available on
EN7581 SoC. The airoha Network Processor Unit (NPU) is used to
offload network traffic forwarded between Packet Switch Engine
(PSE) ports.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


