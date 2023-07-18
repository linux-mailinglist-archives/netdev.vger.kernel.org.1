Return-Path: <netdev+bounces-18517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC1757769
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEDF281098
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68929C8D8;
	Tue, 18 Jul 2023 09:09:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38DBE55
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:09:36 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B02E4C;
	Tue, 18 Jul 2023 02:09:31 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 02201660702C;
	Tue, 18 Jul 2023 10:09:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1689671370;
	bh=LRgumKXnd6HM84mjqPVewOO4GAbvkbnnAGnSqH3ASMI=;
	h=From:To:Cc:Subject:Date:From;
	b=LA3ZsJ3+9vkedXXQOHUVhKKF9X4DaU/+cqVSkYFPUm3vYxLoFvr2h7SIFCwNPxCs8
	 BslBR6YzrSsk5soWRFYnoozpj49DLm5bY6IolMENAqGg4o5QOgrThCL8XjDVIrZ8HI
	 rC05vfQ55eYePb4uM3gSwhywP8gYY83c9/hGiGFfgp3I1mxWsKEaogCAtVqZSDXhMt
	 WTFhrm3tmVTR2eqvY1gOhlbmfpbMFQ+wFSfrYzst7sM79t6MaD8p2hs7fyOdX+2Kxx
	 2CvqLHepOq43ZHmJlaAJk5sS2pk23bkKSyOi7W7q2zAw3dCNpf0lD6p2kqu4kxuUpc
	 i49kF5T8bgD/g==
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
Subject: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input' for clock_in_out
Date: Tue, 18 Jul 2023 12:09:14 +0300
Message-Id: <20230718090914.282293-1-eugen.hristev@collabora.com>
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

'clock_in_out' property is optional, and it can be one of two enums.
The binding does not specify what is the behavior when the property is
missing altogether.
Hence, add a default value that the driver can use.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 176ea5f90251..bb943c96c196 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -80,6 +80,7 @@ properties:
       "output" means GMAC provides the reference clock.
     $ref: /schemas/types.yaml#/definitions/string
     enum: [input, output]
+    default: input
 
   rockchip,grf:
     description: The phandle of the syscon node for the general register file.
-- 
2.34.1


