Return-Path: <netdev+bounces-99724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0168D60AF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09E11F267EF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C315749C;
	Fri, 31 May 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EXs2dttX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB39157468
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154824; cv=none; b=NmUHqzClp3XsLbuL2Mx5uoB9FQD6IL+jzvulFF0+Q4FVRouufpiUWQION34DP9OM7Rp4NSeeLmVhdL5qCzmku2bCRrBaSCDqyQoftJPh5dB0coRo9/W+uD+EdLnc395v/K9C0iH8csVYXOfWO2iqDf6g2LT8egbc+jgJx42ycZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154824; c=relaxed/simple;
	bh=RRjMb3xjDikXAp19FZO1DkfmHsA1Assyrihd4raLC2c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IcQFlaV3KU28pCl6UeHpQjIHMDzRhnEt39iJXhZ1p/s79bpjp/1PNNny4umvhtaJqyAF66VfzDn3Bul/5ZZpwikub2H1J2RQ4OO+0NOLdKgZsE7iT9Xpg7ggieYSwowUvVF8aD5iMiUgGn153Ep0fWXWnyVUVocLVNabkzwJVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EXs2dttX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yz4eTBWoxbuuF2Ohye0DezdsGM6F55QSQ6ouR9V4Ptc=; b=EXs2dttXM8ndBMt8IApzgkEDHA
	ga7xrkejCRdN7lqD2UVBjsJpQEWWoXRv7yLAF9K/jZ3CNcb3JxHjUWL0h61Hv7j2DpFRoeJ1wOm5y
	Gi2JpJxYxsu+6jJ4TcWLQDQTcDtM3zZLVr+yuqdYKngWiBAtbIzfYiVGLrcIStLSSfc4IRmCmah3C
	orNEaZCslTVJvctl6/IqeJMdbHoQLHZ0eQ2jRInDO8ULH2zkpKuGhhIZ1ZsCk1y2EsIMXPpwS+8qx
	NCqDByD6TAo4cdI5fI8e3rhQ8BoQnOTY90lDk/lBFuy0Zx1URcpNxfTKcZl/4iZP+Tg79oH2SOzQN
	iy5nyZKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32886 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0PJ-0008TA-1W;
	Fri, 31 May 2024 12:26:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0PL-00EzCP-1u; Fri, 31 May 2024 12:26:51 +0100
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next v2 8/8] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sD0PL-00EzCP-1u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:51 +0100

From: Serge Semin <fancer.lancer@gmail.com>

The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
into the DW GMAC controller. It's always done if the controller supports
at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
interfaces support was activated during the IP-core synthesize the PCS
block won't be activated either and the HWFEATURE.PCSSEL flag won't be
set. Based on that the RGMII in-band status detection procedure
implemented in the driver hasn't been working for the devices with the
RGMII interface support and with none of the SGMII, TBI, RTBI PHY
interfaces available in the device.

Fix that just by dropping the dma_cap.pcs flag check from the conditional
statement responsible for the In-band/PCS functionality activation. If the
RGMII interface is supported by the device then the in-band link status
detection will be also supported automatically (it's always embedded into
the RGMII RTL code). If the SGMII interface is supported by the device
then the PCS block will be supported too (it's unconditionally synthesized
into the controller). The later is also correct for the TBI/RTBI PHY
interfaces.

Note while at it drop the netdev_dbg() calls since at the moment of the
stmmac_check_pcs_mode() invocation the network device isn't registered. So
the debug prints will be for the unknown/NULL device.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[rmk: fix build errors, only use PCS for SGMII if priv->dma_cap.pcs is set]
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ad19ba42c412..4384d61a3bcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1132,18 +1132,10 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
 	int interface = priv->plat->mac_interface;
 
-	if (priv->dma_cap.pcs) {
-		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
-			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_RGMII;
-		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
-			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_SGMII;
-		}
-	}
+	if (phy_interface_mode_is_rgmii(interface))
+		priv->hw->pcs = STMMAC_PCS_RGMII;
+	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
+		priv->hw->pcs = STMMAC_PCS_SGMII;
 }
 
 /**
-- 
2.30.2


