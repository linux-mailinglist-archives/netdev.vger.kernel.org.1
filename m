Return-Path: <netdev+bounces-232081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAAC00A6D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0C359D80
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22F30CDBA;
	Thu, 23 Oct 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wXM4vnBw"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5972633;
	Thu, 23 Oct 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217955; cv=none; b=liSkh1pvN06TkoF+/C9/LeBqbQ9+vdiQdf/qw5q2WNC7IJrTu69AgfWokApKVpwfo5PThbz5RodCdHIj2K+YPKSAO5SkE9ko+w5Gr4CAq50BCd7m1mRgZCq+8WSaifSVAUSi3dZN4WpbVHu6a78TGFa76CLMPhdN5uU86QsY3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217955; c=relaxed/simple;
	bh=9vz8r6R9Zk0Q2qt+8qDpJZCmHaUx6UDRIUBz8ZUMWZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+tYiNB4Z3cVp0ZMItCV8ETot/HLGixa+4xM6KpWxyGpnqiLskOEo+RkWWLRsG+Ir3wGtFe67r+AEuuCxo5/Kq35qsQA84PRVsFsm6H+ilyh4LqEAGe2NbSW5mw3f338nYB8sDZifnzc1v6Y0mH7Yd4a0c503EJDG1xWBBVVM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wXM4vnBw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=45TdvTvnxchfwZTtTdEPmnINUEynfZ8HbfQ3+TVTz5Q=; b=wXM4vnBwwt+gLUjI0hZrt03Lfl
	WZR+fRQaxsv1BIPt01SUirBvOZg8oAHKn7n/FgN2GXFwLRIdXsouh6DQbjb7eMUSNHz6ZtWvz5Hzy
	xArYMkhTa1JXpuAYNJVcx75yKmpmzdKEUa+nuL3QuF4KJdRkDZxBTZsvLZ25f5LkfwhFcBmBI1Nv+
	gmXnd6WZF54VAq0TS1ADT8+zdPLXCyVur07QukxxVNd4nZjsVTgK8OnimLQDlcmKViF3U8U6pqLeD
	/g1+nAb7m2HKUEXZoIMEB7Wtr0EWz90yB/rtUIZT+1drmwIJmwkdfNSzGV/a+jbRdoj/HS5iV7D00
	AERiSoqg==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEv-0002w5-V2; Thu, 23 Oct 2025 13:12:18 +0200
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
Subject: [PATCH v2 2/5] dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
Date: Thu, 23 Oct 2025 13:12:09 +0200
Message-ID: <20251023111213.298860-3-heiko@sntech.de>
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

A number of dwmac variants from Rockchip SoCs have turned up in the
Rockchip-specific binding, but not in the main list in snps,dwmac.yaml
which as the comment indicates is needed for accurate matching.

So add the missing rk3528, rk3568 and rv1126 to the main list.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 28113ac5e11a..1a0d6789a59b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -87,9 +87,12 @@ properties:
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
         - rockchip,rk3399-gmac
+        - rockchip,rk3528-gmac
+        - rockchip,rk3568-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
         - rockchip,rv1108-gmac
+        - rockchip,rv1126-gmac
         - snps,dwmac
         - snps,dwmac-3.40a
         - snps,dwmac-3.50a
-- 
2.47.2


