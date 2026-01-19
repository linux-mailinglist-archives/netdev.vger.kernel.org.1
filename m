Return-Path: <netdev+bounces-251163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C574D3AF17
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 414D3301784C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3ED38B993;
	Mon, 19 Jan 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHXwHMcT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A3233128;
	Mon, 19 Jan 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836787; cv=none; b=mWWxrluRtjKcMHc0voqc3gFCdxbYnFyyzvUjxcme7AVsZ/IzBKpHfMuzkTrGYjgmyuHoGsc7VvOOFdcZo3Q+aoi+NiiCDwYQ/6hXLCAzEweT8Fx+uzgZnmKaSthh4zfi5JX2wng7omI8inNQMODOe/vWdT9VPPvpfm+np2W3HTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836787; c=relaxed/simple;
	bh=4Gg/dHLVhHdOTxKZNMriKqAYLSqjDn9VOo3z8X3R3Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVZhlIU5ygS4JRUczRWmoWnzKe/GokiUUYbSHlHH4dFiZcpzX473OOLmpmKRZV4DxCboLE1Q8f3rBd/HhsEwBQMllqwQmLoC0QhikmjKNfFEeWheTpB8H9RbVUFMNLDwp6sRMJ3LB9c0iuiVtyyaGxVxJdjAHiJk2uAPD3/5W+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHXwHMcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD7AC116C6;
	Mon, 19 Jan 2026 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836787;
	bh=4Gg/dHLVhHdOTxKZNMriKqAYLSqjDn9VOo3z8X3R3Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHXwHMcTYDPI2LjDP+ASfDjJQS+uHVDpX0gYJaMZRaA6+i2CtjmaobCMO8Cqvwaxs
	 b1zkayhMCxFj2f7YNVaq8335uuvN//Ra32E9XtCxWF7l+2YeVyUGpX0h4CUpCn7QCM
	 aMtvP2U9qC5R5NxB1Lxy5onGXIY410GZk+OeEaRy6ArvdSjSqYMjKOwHc8nvGxkd/a
	 g9fE1zmiqZKmjgzhChFMyY8ADCHo+83/i25pYGQvq51W9gnIWdaHmFsi5Kys2fvCoO
	 bNSqaJu/MZPZdyvkRme5HV7YoubQRNndz9BsIEPmvHKj25/gZGqCtSZ3srByhO5tnN
	 3im7XsDzcGpwA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 19 Jan 2026 16:32:40 +0100
Subject: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add
 firmware-name property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-airoha-npu-firmware-name-v3-1-cba88eed96cc@kernel.org>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
In-Reply-To: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Add firmware-name property in order to introduce the capability to
specify the firmware names used for 'RiscV core' and 'Data section'
binaries. This patch is needed because NPU firmware binaries are board
specific since they depend on the MediaTek WiFi chip used on the board
(e.g. MT7996 or MT7992) and the WiFi chip version info is not available
in the NPU driver. This is a preliminary patch to enable MT76 NPU
offloading if the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 19860b41286fd42f2a5ed15d5dc75ee0eb00a639..aefa19c5b42468dad841892fa5b75a47552762a0 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -59,6 +59,11 @@ properties:
       - const: ba
     minItems: 1
 
+  firmware-name:
+    items:
+      - description: Firmware name of RiscV core
+      - description: Firmware name of Data section
+
 required:
   - compatible
   - reg
@@ -96,5 +101,7 @@ examples:
         memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
                         <&npu_txbufid>, <&npu_ba>;
         memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid", "ba";
+        firmware-name = "airoha/en7581_npu_rv32.bin",
+                        "airoha/en7581_npu_data.bin";
       };
     };

-- 
2.52.0


