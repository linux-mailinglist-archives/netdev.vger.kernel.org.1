Return-Path: <netdev+bounces-17882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29777753628
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1526E1C21618
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6CD524;
	Fri, 14 Jul 2023 09:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D467DDA9
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:12:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077501BD
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eZRavDpoR/oM9p9VsXBgHmxsS4/tc0SOYu5cR266RZU=; b=Jo1S0yIPPyXZ1kdhe3vrz6OTSR
	VW6Rc4rTjM/a1PnOjYh8JdnR/mL91ZoC5jQZgXh7ThN04lKtorpMl+eZBf4lqCQ4hgiZsrjGyT7EJ
	MGuEqwmKo6CLr7JjLHA9vz+7H20w+RatQNm8M8OxaW1F5rtSqgQFydLSOEtlmNuAQBuIG545qS49x
	1USWMsFUBSDroT7jdMtlgfmzDiDmQVIfOmLk1wef0NkLwgCiKid43/cuZJm0BF3MXDQ8ub2sJsIOA
	DlbgXx4cJfVTb71XFNG3GFieRz7KPfzJqIyTnKFQBRarVMvrlqSEGZ6NY3SnMwSKxsAZVgwx+bafI
	kxSXkjwQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43778 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qKEqS-0000O7-2O;
	Fri, 14 Jul 2023 10:12:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qKEqS-00H0xb-G1; Fri, 14 Jul 2023 10:12:12 +0100
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
Subject: [PATCH net-next 2/3] net: dsa: remove legacy_pre_march2020 from
 drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qKEqS-00H0xb-G1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Jul 2023 10:12:12 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since DSA no longer marks anything as phylink-legacy, there is now no
need for DSA drivers to set this member to false. Remove all instances
of this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/b53/b53_common.c       | 6 ------
 drivers/net/dsa/lan9303-core.c         | 6 ------
 drivers/net/dsa/microchip/ksz_common.c | 2 --
 drivers/net/dsa/mt7530.c               | 6 ------
 drivers/net/dsa/mv88e6xxx/chip.c       | 4 ----
 drivers/net/dsa/ocelot/felix.c         | 6 ------
 drivers/net/dsa/qca/qca8k-8xxx.c       | 2 --
 drivers/net/dsa/sja1105/sja1105_main.c | 6 ------
 8 files changed, 38 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3464ce5e7470..4e27dc913cf7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1393,12 +1393,6 @@ static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 	/* Get the implementation specific capabilities */
 	if (dev->ops->phylink_get_caps)
 		dev->ops->phylink_get_caps(dev, port, config);
-
-	/* This driver does not make use of the speed, duplex, pause or the
-	 * advertisement in its mac_config, so it is safe to mark this driver
-	 * as non-legacy.
-	 */
-	config->legacy_pre_march2020 = false;
 }
 
 static struct phylink_pcs *b53_phylink_mac_select_pcs(struct dsa_switch *ds,
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ff76444057d2..b0da1e4de63c 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1290,12 +1290,6 @@ static void lan9303_phylink_get_caps(struct dsa_switch *ds, int port,
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 	}
-
-	/* This driver does not make use of the speed, duplex, pause or the
-	 * advertisement in its mac_config, so it is safe to mark this driver
-	 * as non-legacy.
-	 */
-	config->legacy_pre_march2020 = false;
 }
 
 static void lan9303_phylink_mac_link_up(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 813b91a816bb..07ba2b54ab99 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1624,8 +1624,6 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 {
 	struct ksz_device *dev = ds->priv;
 
-	config->legacy_pre_march2020 = false;
-
 	if (dev->info->supports_mii[port])
 		__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 38b3c6dda386..8fbda739c1b3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2949,12 +2949,6 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
 
-	/* This driver does not make use of the speed, duplex, pause or the
-	 * advertisement in its mac_config, so it is safe to mark this driver
-	 * as non-legacy.
-	 */
-	config->legacy_pre_march2020 = false;
-
 	priv->info->mac_port_get_caps(ds, port, config);
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6174855188d9..8dd82fd87fc6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -769,10 +769,6 @@ static void mv88e6xxx_get_caps(struct dsa_switch *ds, int port,
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 	}
-
-	/* If we have a .pcs_init, we are not legacy. */
-	if (chip->info->ops->pcs_ops)
-		config->legacy_pre_march2020 = false;
 }
 
 static struct phylink_pcs *mv88e6xxx_mac_select_pcs(struct dsa_switch *ds,
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 8da46d284e35..fd7eb4a52918 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1042,12 +1042,6 @@ static void felix_phylink_get_caps(struct dsa_switch *ds, int port,
 {
 	struct ocelot *ocelot = ds->priv;
 
-	/* This driver does not make use of the speed, duplex, pause or the
-	 * advertisement in its mac_config, so it is safe to mark this driver
-	 * as non-legacy.
-	 */
-	config->legacy_pre_march2020 = false;
-
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD |
 				   MAC_2500FD;
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 09b80644c11b..27bf58e40be6 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1397,8 +1397,6 @@ static void qca8k_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000FD;
-
-	config->legacy_pre_march2020 = false;
 }
 
 static void
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 3529a565b4aa..52dd52d6c43d 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1396,12 +1396,6 @@ static void sja1105_phylink_get_caps(struct dsa_switch *ds, int port,
 	struct sja1105_xmii_params_entry *mii;
 	phy_interface_t phy_mode;
 
-	/* This driver does not make use of the speed, duplex, pause or the
-	 * advertisement in its mac_config, so it is safe to mark this driver
-	 * as non-legacy.
-	 */
-	config->legacy_pre_march2020 = false;
-
 	phy_mode = priv->phy_mode[port];
 	if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
 	    phy_mode == PHY_INTERFACE_MODE_2500BASEX) {
-- 
2.30.2


