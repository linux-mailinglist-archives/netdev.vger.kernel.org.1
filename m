Return-Path: <netdev+bounces-163195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFAA298CA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65FE188AA2F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8E1FE44A;
	Wed,  5 Feb 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLGbUfrj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E601FCFE1;
	Wed,  5 Feb 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779747; cv=none; b=LvStN8tUwdzpQ3OIymJZPiL9M1jf1n3P+P6WMkmVDqNsqWTAC4B0un4MZ1DETMVr7hN8Y/s5xih+x10HUWy/iECSF14xVkdc3d4suDzvalv8AeZAKaLahSBv8f/byGPftyjD/cn8si2Pqq7Tz2XnuT12Cyw352fCCLbv7QnKJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779747; c=relaxed/simple;
	bh=zTdTUW0dwrafTX4itj2ohGtbrJbqJHnQvGtwFC7cl2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sk+XzjO/KzCBzHIhONlXq/LQQEJTd2e3e5ldh/zO/FO1iIc/NUrdMokOQwvlyDi+Nk/c8DHZEnonHJOloBF96DbxtaXHH3WWZYRylbZ0cKFRFQWyaTCLoIuKqvQPQg6PUwPTglM8sb/RZuH89I8jm37KNVdFiZcbOU2ydIlQnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLGbUfrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D5C4CED1;
	Wed,  5 Feb 2025 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779747;
	bh=zTdTUW0dwrafTX4itj2ohGtbrJbqJHnQvGtwFC7cl2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DLGbUfrjnmGg9dZdE579scDaj5f+/erqucRWaAd9TkBgkj7b6EU4T7nslZ5vlL6Hj
	 wQNjU7RWK8v55s4XzTvK+SAx4IQuU0qGHPNayuwibRmmF8HDZZqqRkIrek+mvwtM8n
	 luFYDhKOBCBAAHqxJAVX+WN1ArgSocG5wYkG0aIzv/4LX1bTTbBJHClpJwK1FsVJDk
	 vkYv0Y9VNVySkUN9NFl4Js6A7VLO5GKK47C637yQcYGmEPkQdZM81ihfdiQxIpSkHE
	 ocm0iHXdYWcMlzBUZgNk68ImdLfosItzmUv+4u8MN0Goy3ci2rMclkAyHAi+gOyX2C
	 bnj6SB4kdxK2A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:28 +0100
Subject: [PATCH net-next 09/13] dt-bindings: net: airoha: Add airoha,npu
 phandle property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Introduce the airoha,npu property for the npu syscon node available on
EN7581 SoC. The airoha Network Processor Unit (NPU) is used to offload
network traffic forwarded between Packet Switch Engine (PSE) ports.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a20230b0c4e58534aa61f984da 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -63,6 +63,12 @@ properties:
   "#size-cells":
     const: 0
 
+  airoha,npu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node used to configure the NPU module
+      used for traffic offloading.
+
 patternProperties:
   "^ethernet@[1-4]$":
     type: object
@@ -132,6 +138,8 @@ examples:
                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 
+        airoha,npu = <&npu>;
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.48.1


