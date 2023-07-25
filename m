Return-Path: <netdev+bounces-20903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E959761DAE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FAA281839
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8743623BF5;
	Tue, 25 Jul 2023 15:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32821D5D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:53:06 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3075691;
	Tue, 25 Jul 2023 08:53:05 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DD2386606F9F;
	Tue, 25 Jul 2023 16:53:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1690300383;
	bh=oTwjKmbIzP/ICl+gGyGP/1DH20byUoeqWEtx/veTs3o=;
	h=From:To:Cc:Subject:Date:From;
	b=JbyBladbKjcskcYcNNABx1wJ/caoCgyx6Ixz11oqpXplKT3bjW0LG8kuPflsO/Zif
	 renQs/CYIAVyKv7FcLymQrorKZxhcfIkkfx0njUNVb7la5dGVo5aPfPufXc2yHMnfx
	 EXFgdsmcXTtePOR1ckYdS4t7Yhx8rKW99t/WYqbKmfVnhIKCvIhk1O1aCZ9kwnZlpZ
	 rk8O5CW2Cspxzdr7jaEh1AfhMmA+UnY+6J3x+m2EZjvL14jcXV/sNyt+qeP4RFAWlt
	 AEZ8UVITATGZDICbwaB/RkA4wvFERFsogJ1ew6WGVnnP1s8jtfAeOrfqFAmgZ1+Vnb
	 1fTcUIui7rA+w==
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: david.wu@rock-chips.com,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	kernel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults in schema
Date: Tue, 25 Jul 2023 18:52:54 +0300
Message-Id: <20230725155254.664361-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The defaults are specified in the description instead of being specified
in the schema.
Fix it by adding the default value in the `default` field.

Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index bb943c96c196..6d08260ad828 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -92,12 +92,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   tx_delay:
-    description: Delay value for TXD timing. Range value is 0~0x7F, 0x30 as default.
+    description: Delay value for TXD timing. Range value is 0~0x7F.
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x30
 
   rx_delay:
-    description: Delay value for RXD timing. Range value is 0~0x7F, 0x10 as default.
+    description: Delay value for RXD timing. Range value is 0~0x7F.
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x10
 
   phy-supply:
     description: PHY regulator
-- 
2.34.1


