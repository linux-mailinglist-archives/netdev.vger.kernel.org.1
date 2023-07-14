Return-Path: <netdev+bounces-17884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA675362A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9A7282241
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DFFDF4C;
	Fri, 14 Jul 2023 09:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23DE574
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:12:26 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCC2D43
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q3stLgcr7QsIYyVtL85+ZPaeP8VcD2MUC2oVyEj57SI=; b=AtXv4LwapPrEY3GpDXKUSyyYs2
	flL2SvW1FtnIW6meAk1KoAjCjWcyKC0cwPsTB4OhLgNWwg3RWvSdJaKr0lZzAjE1jT6egyksA1woF
	O9VJmVBvODm7LMFUX5l3E26wjQ7sGWS+OxlPykBefUIHNEpQcEAUQEZoFDcl0jOXYNFiL/eMhYs5S
	/bkhEVHaU4bA2cHSBafewt5HXdzrZnI2l7uIHdtKotRr99q0VbTsRfC/Opt9q7ksEl0AApZX2OUBL
	OwhgR8O+5hYmmaIzX81DtswZY2xprwSdgwsvFYbIrAj0tU5WMKPc5yIbIynNtslbfzkrIfLREwxvo
	uHKcxPrA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33260 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qKEqX-0000OT-2p;
	Fri, 14 Jul 2023 10:12:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qKEqX-00H0xi-M5; Fri, 14 Jul 2023 10:12:17 +0100
In-Reply-To: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
References: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 3/3] net: phylink: remove legacy mac_an_restart()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qKEqX-00H0xi-M5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Jul 2023 10:12:17 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mac_an_restart() method is now completely unused, and has been
superseded by phylink_pcs support. Remove this method.

Since phylink_pcs_mac_an_restart() now only deals with the PCS, rename
the function to remove the _mac infix.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 22 +++++++++-------------
 include/linux/phylink.h   | 12 ------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 71b1012ef3be..f07e496319b4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1079,17 +1079,13 @@ static void phylink_mac_config(struct phylink *pl,
 	pl->mac_ops->mac_config(pl->config, pl->cur_link_an_mode, state);
 }
 
-static void phylink_mac_pcs_an_restart(struct phylink *pl)
+static void phylink_pcs_an_restart(struct phylink *pl)
 {
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-			      pl->link_config.advertising) &&
+	if (pl->pcs && linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					 pl->link_config.advertising) &&
 	    phy_interface_mode_is_8023z(pl->link_config.interface) &&
-	    phylink_autoneg_inband(pl->cur_link_an_mode)) {
-		if (pl->pcs)
-			pl->pcs->ops->pcs_an_restart(pl->pcs);
-		else if (pl->config->legacy_pre_march2020)
-			pl->mac_ops->mac_an_restart(pl->config);
-	}
+	    phylink_autoneg_inband(pl->cur_link_an_mode))
+		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
 static void phylink_major_config(struct phylink *pl, bool restart,
@@ -1169,7 +1165,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		restart = true;
 
 	if (restart)
-		phylink_mac_pcs_an_restart(pl);
+		phylink_pcs_an_restart(pl);
 
 	if (pl->mac_ops->mac_finish) {
 		err = pl->mac_ops->mac_finish(pl->config, pl->cur_link_an_mode,
@@ -1205,7 +1201,7 @@ static int phylink_change_inband_advert(struct phylink *pl)
 	if (!pl->pcs && pl->config->legacy_pre_march2020) {
 		/* Legacy method */
 		phylink_mac_config(pl, &pl->link_config);
-		phylink_mac_pcs_an_restart(pl);
+		phylink_pcs_an_restart(pl);
 		return 0;
 	}
 
@@ -1234,7 +1230,7 @@ static int phylink_change_inband_advert(struct phylink *pl)
 		return ret;
 
 	if (ret > 0)
-		phylink_mac_pcs_an_restart(pl);
+		phylink_pcs_an_restart(pl);
 
 	return 0;
 }
@@ -2533,7 +2529,7 @@ int phylink_ethtool_nway_reset(struct phylink *pl)
 
 	if (pl->phydev)
 		ret = phy_restart_aneg(pl->phydev);
-	phylink_mac_pcs_an_restart(pl);
+	phylink_pcs_an_restart(pl);
 
 	return ret;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index b28aa3eef7d5..9e861c8316d0 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -234,7 +234,6 @@ struct phylink_config {
  * @mac_prepare: prepare for a major reconfiguration of the interface.
  * @mac_config: configure the MAC for the selected mode and state.
  * @mac_finish: finish a major reconfiguration of the interface.
- * @mac_an_restart: restart 802.3z BaseX autonegotiation.
  * @mac_link_down: take the link down.
  * @mac_link_up: allow the link to come up.
  *
@@ -254,7 +253,6 @@ struct phylink_mac_ops {
 			   const struct phylink_link_state *state);
 	int (*mac_finish)(struct phylink_config *config, unsigned int mode,
 			  phy_interface_t iface);
-	void (*mac_an_restart)(struct phylink_config *config);
 	void (*mac_link_down)(struct phylink_config *config, unsigned int mode,
 			      phy_interface_t interface);
 	void (*mac_link_up)(struct phylink_config *config,
@@ -459,16 +457,6 @@ void mac_config(struct phylink_config *config, unsigned int mode,
 int mac_finish(struct phylink_config *config, unsigned int mode,
 		phy_interface_t iface);
 
-/**
- * mac_an_restart() - restart 802.3z BaseX autonegotiation
- * @config: a pointer to a &struct phylink_config.
- *
- * Note: This is a legacy method. This function will not be called unless
- * legacy_pre_march2020 is set in &struct phylink_config and there is no
- * PCS attached.
- */
-void mac_an_restart(struct phylink_config *config);
-
 /**
  * mac_link_down() - take the link down
  * @config: a pointer to a &struct phylink_config.
-- 
2.30.2


