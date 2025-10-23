Return-Path: <netdev+bounces-232025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C2C0031F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A069F3AAD0A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC02FFDE2;
	Thu, 23 Oct 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hZY4b8+s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA952FB09E;
	Thu, 23 Oct 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211016; cv=none; b=c4RuPuI5CO7nSyCCYV0w56QgQqrYxvtYC5vifzPk7Jogox/iVarVjRZ27WQLevM/TT/c2BUBdXX35Oo457YZbcumMEPeG1JZT0ERLbDxN7StXa4aBh5Z5Trodw8nt9KjL843utxyKKnoZe5kz2az2rZowocSwOoy2zs+TOtXTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211016; c=relaxed/simple;
	bh=vKeSSPYWdvT9KOQUGElb7412nBurrpoWwANzeApqeSc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hWD8bqdmAs5oNiMFCPSA+8a720oJQFU7swmsE4ClQgvs2Yn3p4TFfVsbMjk+J5WxgDY7iEj2+TyIsijZzALOvWngNRUnOp3ryFqDmx6YEWCJvcHSPZIJn8zlNelKsXPP8AwhEkIir32OtemtWkn8u/DnD2vj1al7J5TJhUhFDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hZY4b8+s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=61fUCnPjR/ABE1wFOydhMi2E+9470AJphBO8jqHbD04=; b=hZY4b8+sxU9NLCanLbj6aaP1le
	ibQZFjSMwCgiuQ94RFk+4Bz9O0cyvDArev0xsxdBCRWc66rGeY5EgxCZb+SyomB2FJhIcIkB5lCV6
	gaS7CbGfaufP8WvIhBxzLfGO/oAD/PiQQMNOYnN2WlMTZLysZcRMiY/VH8NG8a5jnA+2bsmdvOlbD
	k8mOg12WsF5I4rVDjbKP1cN/o4ZpzCN5XDbiy38erLRVsyDt1chblS8PSZ1FcC6Sj5U2wpd9x8fAx
	0RomoOz86S50uP3Nvvw1O/y0twHO0u+OBSDDKIxSXH/LGxenN3KFqWbc8aQYwftcu8Dkr4EQvyB65
	PndrYpPQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38306 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrR8-0000000061Y-2am2;
	Thu, 23 Oct 2025 10:16:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrR7-0000000BLza-2PjK;
	Thu, 23 Oct 2025 10:16:45 +0100
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH net-next v2 4/6] net: phylink: add phylink managed wake-on-lan
 PHY speed control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrR7-0000000BLza-2PjK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:16:45 +0100

Some drivers, e.g. stmmac, use the speed_up()/speed_down() APIs to
gain additional power saving during Wake-on-LAN where the PHY is
managing the state.

Add support to phylink for this, which can be enabled by the MAC
driver. Only change the PHY speed if the PHY is configured for
wake-up, but without any wake-up on the MAC side, as MAC side
means changing the configuration once the negotiation has
completed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: use phylink_speed_up/down()
---
 drivers/net/phy/phylink.c | 12 ++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index bec44ebdf80b..6e1243bf68aa 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2576,6 +2576,12 @@ static bool phylink_phy_supports_wol(struct phylink *pl,
 	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
 }
 
+static bool phylink_phy_pm_speed_ctrl(struct phylink *pl)
+{
+	return pl->config->wol_phy_speed_ctrl && !pl->wolopts_mac &&
+	       pl->phydev && phy_may_wakeup(pl->phydev);
+}
+
 /**
  * phylink_suspend() - handle a network device suspend event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2625,6 +2631,9 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 	} else {
 		phylink_stop(pl);
 	}
+
+	if (phylink_phy_pm_speed_ctrl(pl))
+		phylink_speed_down(pl, false);
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2664,6 +2673,9 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	if (phylink_phy_pm_speed_ctrl(pl))
+		phylink_speed_up(pl);
+
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 59cb58b29d1d..38363e566ac3 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -157,6 +157,7 @@ enum phylink_op_type {
  * @lpi_timer_default: Default EEE LPI timer setting.
  * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
  * @wol_phy_legacy: Use Wake-on-Lan with PHY even if phy_can_wakeup() is false
+ * @wol_phy_speed_ctrl: Use phy speed control on suspend/resume
  * @wol_mac_support: Bitmask of MAC supported %WAKE_* options
  */
 struct phylink_config {
@@ -178,6 +179,7 @@ struct phylink_config {
 
 	/* Wake-on-Lan support */
 	bool wol_phy_legacy;
+	bool wol_phy_speed_ctrl;
 	u32 wol_mac_support;
 };
 
-- 
2.47.3


