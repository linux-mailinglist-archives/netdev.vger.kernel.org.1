Return-Path: <netdev+bounces-182669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0BA89998
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F33D3B8675
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3C1DE3A8;
	Tue, 15 Apr 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mYr8sPWd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C075A79B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712085; cv=none; b=EDK1U0vQDLB4RTwnfmCOzpuup2CsHOnZ1FqTiJjZ5oUNZG2wwi/arWM/37fOLzkLaXv6N5TteoysmMacTUaM5lvEbgaCiQiGu3AXMJSCQOrcluGljej8J90LcKsPk56lWV2y+oiOOBJKhG9BLqT0gcjWcWH7GwbZb+iwes32dGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712085; c=relaxed/simple;
	bh=J3acCIifcGX4YC+8d5ABz85CKWBx5u/DUa79Gww+XcI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tSQxLVNJBcHg5HGJvuSJbB9nuuzSrz6J+MvkZsB0t2J3bZ0R23C0NIlcLFKwyITOsngnzoE/8ngXQ3mscqxK7C1+y2SOO++uxwx6qr2mdd4DWFAFebXRFbwnKjw9Q5pf4UYwpJ+9RQNO58AbL7Wf25OtjiO6t1aeFM0q1QRQwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mYr8sPWd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DE0kZ2PlT28YVD5BgsTUQV/7iIYJrvjrqwOjFbEQYUY=; b=mYr8sPWdJ38nHrmU3YJI+k3oso
	toLNm2Tm0fHLBOdogwSzcQq9iFiqobLSu/QZ/AdQ9z6+i97dYRJ0ifE4AYmTyCnUkO2ZWwv1TPDcU
	qB88XoFDKEzdL3refZKO1en4zT0EcDcfo7NfGl4OfaK7sIt3T8I8D+nFqVqC8rZATQsQIF6L5Iv5I
	8VYI80C4+DifX/r564Wje2PjPA7lkSJ4Rfb2JOhJ09NaiQ2F7GK7suL0OwLntZgJ3M9EVC/sTv9uY
	AkXr7Se+mwr8uh1V9HP+fZ9mDLbAnpR5qZub43beHXL7s+3yD+gSidl3fuSnfERrmsQDjM3uYAYRT
	gujkv0FA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36202 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4dJI-0007vd-2x;
	Tue, 15 Apr 2025 11:14:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4dIh-000dT5-Kt; Tue, 15 Apr 2025 11:13:55 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: intel: remove unnecessary setting
 max_speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4dIh-000dT5-Kt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 11:13:55 +0100

Phylink will already limit the MAC speed according to the interface,
so if 2500BASE-X is selected, the maximum speed will be 2.5G.
Similarly, if SGMII is selected, the maximum speed will be 1G.
It is, therefore, not necessary to set a speed limit. Remove setting
plat_dat->max_speed from this glue driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 54db5b778304..96c893dd262f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -300,11 +300,8 @@ static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
 	if (((data & SERDES_LINK_MODE_MASK) >> SERDES_LINK_MODE_SHIFT) ==
 	    SERDES_LINK_MODE_2G5) {
 		dev_info(priv->device, "Link Speed Mode: 2.5Gbps\n");
-		priv->plat->max_speed = 2500;
 		priv->plat->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
 		priv->plat->mdio_bus_data->default_an_inband = false;
-	} else {
-		priv->plat->max_speed = 1000;
 	}
 }
 
-- 
2.30.2


