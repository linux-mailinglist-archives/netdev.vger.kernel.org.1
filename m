Return-Path: <netdev+bounces-13443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6073B9F5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2062D280E30
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75454C151;
	Fri, 23 Jun 2023 14:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A39449
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:18:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC771BC6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OeyGZR0QAyNpDnAr7d5s5/mQDpEFjBE477iVgC3zyp0=; b=TSpMWFJIQpDdl+m2eAjPV3E9q4
	OYc/SMwntvgiaois6s4/Ua/rZXkTae6T6rePqldiKYAnaZN36EClhbwr5kfeXCD60FINsDp+LNOYL
	RBIqKRZIYm4YgAUTHs4c29qNxFghX+5/P3Pwtg6B6CRTuTiSGisfxG1NN7jpUZRSCC2ami7RDrZEZ
	fyNtC965rnNKyHvq3WF0SkazPz6V9DgAkQfvNEQwDvcmae45MHL2hA4RUkvIbxZBMj1oupFcQmESo
	+dIztxFkTDA2/Lpj9/cuebLZcs8yy//Si47bJfOy3qf45QAmQVkgFxk5HarZX7T+W1bbYjwoaYjK5
	AuWlOYoQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55230 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qChbo-0005SE-3D; Fri, 23 Jun 2023 15:17:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qChbn-00Fmsg-GG; Fri, 23 Jun 2023 15:17:55 +0100
In-Reply-To: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
References: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
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
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 13/14] net: dsa: remove legacy_pre_march2020 from
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
Message-Id: <E1qChbn-00Fmsg-GG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jun 2023 15:17:55 +0100
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
 drivers/net/dsa/mt7530.c               | 6 ------
 drivers/net/dsa/mv88e6xxx/chip.c       | 4 ----
 drivers/net/dsa/ocelot/felix.c         | 6 ------
 drivers/net/dsa/qca/qca8k-8xxx.c       | 2 --
 drivers/net/dsa/sja1105/sja1105_main.c | 6 ------
 6 files changed, 30 deletions(-)

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
index 80861ac090ae..4b255c0cc2ee 100644
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
index f7d7cfb2fd86..d4e48d900d54 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1394,8 +1394,6 @@ static void qca8k_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000FD;
-
-	config->legacy_pre_march2020 = false;
 }
 
 static void
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index a55a6436fc05..a7be8596b959 100644
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


