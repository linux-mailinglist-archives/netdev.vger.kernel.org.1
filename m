Return-Path: <netdev+bounces-232082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9DC00A85
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3DE3A9BF8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AC30DD2E;
	Thu, 23 Oct 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="K34/P8XB"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDC30274F;
	Thu, 23 Oct 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217956; cv=none; b=JiaOHWD/5Qi2//WGwAB/kTKd74zBL/9cLGb9fAIJ65pUu59I/Zz5wnXeZqM39N2RW4uKUstJO78Efdxj5MSAg6yIw4R1Qpoopu8sIniYMsaTIFNLEdpo28m0D9PPH5GSO55JxWTZiQ6UeVtueRZm2B/zeJ2NhdMTiDxjPpnFeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217956; c=relaxed/simple;
	bh=23BLWzb8uGFu1HmOTdAFRqcMSoJYAOOz1WezsS/3qHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJUmp1JOW/rX/jLrZKaRVPGE+mtPgmAr7oKwetVNH+zJYGIfQ1l0syW2ZOi1UDlYxYTHpavvP2kYNS1t5Tvd4hxDLM+KdDzfEuB4rjMOV/2nRxBCb8UbqPcKn1AMyFLllSFzqfD71C2h2NLE9/g6iw4IECol1MsyLI30/RrpemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=K34/P8XB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=85J+VTRelECOWpE/xhtH9j8sQmBAgll/bvYNDxbb9DM=; b=K34/P8XBJvHoPO/jh2ExQ/ASlA
	Zsk9fOK2mRQz96YAmkUw853Rwn4b/OWZ+B5Hfs3M9sVcoWaMDDL7jCHVBA297xG0prwNt2+c9wOPu
	oKUsjIqES87X2OzOxxASYhie7LoAuYRZgF6hZofx8REbAx8REduJwn+36FHs8nnoKIrVi+gvz0Eyc
	oLv6z6AJY6NgETOnUFOIrRpgTycv8Wwu9JK+o4JZ3Cv4AuumQaa089Vmm4WyJYm34FOC6i0l58ARZ
	zgLw5RXOwwRK6NzQJbbTEjaIS1uQos48niYu+ahl9JxvpoJVD0dcIlknXkYgZG+Mi+BHfYqxQDPKZ
	MB2p56gA==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEx-0002w5-2r; Thu, 23 Oct 2025 13:12:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/5] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506
Date: Thu, 23 Oct 2025 13:12:10 +0200
Message-ID: <20251023111213.298860-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251023111213.298860-1-heiko@sntech.de>
References: <20251023111213.298860-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3506 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add compatible string for the RK3506 variant.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 0ac7c4b47d6b..d17112527dab 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -24,6 +24,7 @@ select:
           - rockchip,rk3366-gmac
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
+          - rockchip,rk3506-gmac
           - rockchip,rk3528-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
@@ -50,6 +51,7 @@ properties:
               - rockchip,rv1108-gmac
       - items:
           - enum:
+              - rockchip,rk3506-gmac
               - rockchip,rk3528-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
@@ -148,6 +150,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - rockchip,rk3506-gmac
                 - rockchip,rk3528-gmac
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 1a0d6789a59b..dd3c72e8363e 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -87,6 +87,7 @@ properties:
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
         - rockchip,rk3399-gmac
+        - rockchip,rk3506-gmac
         - rockchip,rk3528-gmac
         - rockchip,rk3568-gmac
         - rockchip,rk3576-gmac
-- 
2.47.2


