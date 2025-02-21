Return-Path: <netdev+bounces-168490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41730A3F20A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2860916FC0A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE3208973;
	Fri, 21 Feb 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgbCUShd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CD1EE7BC;
	Fri, 21 Feb 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133735; cv=none; b=QKbnbU6E7egdzOzDThUCTWOGw5yAE5V4Ljs5kHf0NRWEY/a/TmdKOHzIYuPFtut/Nu5tsVRAV95lKr/S7oKJcBQq/ROhuTwVyrHO6etTdJY8VGXWgdOkKJ5+EO4qdpmhmuAITOFe1IVbwlKph28D3hZWdsqerNb2q+4YbRAv3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133735; c=relaxed/simple;
	bh=JZDiAKKeX0eSnGFkmKTsrRKkLXrlYR1V8xaHJKtSw9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4RuHzDVqdDQjpW8dp242gGTrdKPvVlkXg0KbbW2oS348qGadtfIqjrBKcoPgHuXNC3ecJ2NItorz4D/PB4J26drXLrP/rYvtmqz4QbS0nrW3wTezZQScXQjTpimu7l4KrJF3f/6KwQauuYETXYArAAROZk8z6IbqJDk3hU2yJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgbCUShd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6BAC4CED6;
	Fri, 21 Feb 2025 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133735;
	bh=JZDiAKKeX0eSnGFkmKTsrRKkLXrlYR1V8xaHJKtSw9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YgbCUShdt8jY/kZz93EPc9er2EqD021hkF5x//AiE8CbTYpyW0aCa8ykNgJW4wq5D
	 y3+wvBniGvCKNgW7nJb/uum6Mkbu9jpR0JOtKxfzFhlwQu2zTNFro6ZOL3joKjl1zu
	 ppqM72keTtlZSbojRUXm8NncyhcRl0Hobcd8gXTqOIOE/Dt2gkH59hkJktzT/BX38l
	 6uY2TSk1fzVLdJrfagc7zjNw+sY0SAw3XaAN8J+nXTzdYT5ezIc2zZ5DSuun7CigtA
	 pPq+jCBZkxcThdv+ne8DjtD75hiv50xzSiAC6CQZeJ8K/vJXQqucldKo7pELYfACth
	 Ay5FiX0cM2u8Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 21 Feb 2025 11:28:12 +0100
Subject: [PATCH net-next v6 11/15] dt-bindings: net: airoha: Add airoha,npu
 phandle property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-airoha-en7581-flowtable-offload-v6-11-d593af0e9487@kernel.org>
References: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
In-Reply-To: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
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


