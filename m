Return-Path: <netdev+bounces-21198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82F762C9C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA0281BC2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D094846C;
	Wed, 26 Jul 2023 07:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C55846B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:07:07 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF555BF;
	Wed, 26 Jul 2023 00:06:45 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A02CC6607115;
	Wed, 26 Jul 2023 08:06:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1690355187;
	bh=iz0YvQ3fnQ9vjxmywIwYRGMCuKmZv1tpf33ccDhklTc=;
	h=From:To:Cc:Subject:Date:From;
	b=UZUUdkhhH4JX93a4W1Gq/45Jt2H5arXOhIrMz0YvKRZl45tpQLrhi0UHtRwg+QxAj
	 1I9tNi9nl0jSWJ5Ws9d5RVCPajRg6V+ikrD8OgSGRCM+G7hwdGuCA6Vaz/mzhU7Aoa
	 Yiju2Bs/nmq2pZhA/SBRs5ZuKMnPGcGHd26g2TZnQOwxt007Nly4s2mC39Komd7sEJ
	 45f/rnwKqFo8mvq2eJHhsqOEkvcQThcoIRb0PXloEg3V6feCYhk4iN4hZBYYXYGkzT
	 InHAOlZVLMqB7EC9dHHSf8FdY5PciM2lJ4GUKQpH4s3EwenPqzaAAx/U4SnvJ1ZSdv
	 FF/MIJjZsY0ag==
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
Subject: [PATCH v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema
Date: Wed, 26 Jul 2023 10:06:15 +0300
Message-Id: <20230726070615.673564-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The range and the defaults are specified in the description instead of
being specified in the schema.
Fix it by adding the default value in the `default` field and specifying
the range as `minimum` and `maximum`.

Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
changes in v2:
- also move the range as minimum/maximum in the schema

 .../devicetree/bindings/net/rockchip-dwmac.yaml        | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index bb943c96c196..70bbc4220e2a 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -92,12 +92,18 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   tx_delay:
-    description: Delay value for TXD timing. Range value is 0~0x7F, 0x30 as default.
+    description: Delay value for TXD timing.
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x7F
+    default: 0x30
 
   rx_delay:
-    description: Delay value for RXD timing. Range value is 0~0x7F, 0x10 as default.
+    description: Delay value for RXD timing.
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x7F
+    default: 0x10
 
   phy-supply:
     description: PHY regulator
-- 
2.34.1


