Return-Path: <netdev+bounces-156739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE4A07BA8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F9816A92E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510E21D004;
	Thu,  9 Jan 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ummhw3n0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D121E091
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435782; cv=none; b=AI5FUJ/an2Q4zkHOZTl+2BlV8A/x0QGyCULuVpawkGYKNdjUQe6E4/MrK2DXAKby1IK9Y1EUkQ1iFJUGdbkTyjy45IHhOLrupx03Yyv8pfjzq+/gAQ+TCPiwoyJOtUTW24SLbBVYDMw4w5eJwhGFPVQ97/N6yD/bvfO199ugn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435782; c=relaxed/simple;
	bh=DJBqwgnEDopLUdLho90KrKRYlZqWf1riW9pMSMndcQw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KEmkI8CVS0s0nHnm7SkYsz/Jj5XfIP3vpG8T7m3aBO5cy3wBY+rA9P2U8apZOjcG5TKNN0g4PlKNAO7Bn7tqHU2Ybthmn10SYs43MnCQNzW0qeKj1iayoW9I54mW4pOsR3PGl9oL4qAGjJvCQt8zIRnZ4dfKUMUWTwn7dlzwck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ummhw3n0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MpGGZSUI+WeruL3LFk7HIJG+rWlujUTuGWD8czotisw=; b=ummhw3n0l/qAEztCt+kMX0X8Nr
	mU2+7NQHasLGa0OVqTQTA49NLbBqdoFZ6z1LGroU+3jrH+rBTOc0hWqfSchzPxh2iEF07OipZDV6v
	EDDC/+LJsUGIgSWAafjl9CkbUkuATYq47MftoxWD+ygWWjLCtE4/tQSmS2kxXHU8jvpvExnpaONr4
	/Gm3JtiF51MRbM+/EtLT75iq05zXzwkwXeL7OIjBzbO9qrEwgCtBJk1RWI3J6hKasUtYeu/ErmywC
	B1DaJCAAZ4LNW5O1mK/HdnEIyFBNzpayFRRntM7iL/A1bf/hN2qKOgf5F8T6FxB3NoWyt/9mzNrAl
	5Bx/hLUQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37406 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVuGB-0002DT-0k;
	Thu, 09 Jan 2025 15:15:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVuFr-000BXc-Kk; Thu, 09 Jan 2025 15:15:27 +0000
In-Reply-To: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next 3/5] net: phylink: pass neg_mode into c22 state
 decoder
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVuFr-000BXc-Kk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 09 Jan 2025 15:15:27 +0000

Pass the current neg_mode into phylink_mii_c22_pcs_get_state() and
phylink_mii_c22_pcs_decode_state(). Update all users of phylink PCS
that use these functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fman/fman_dtsec.c         | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h    | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c    | 4 ++--
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c        | 2 +-
 drivers/net/pcs/pcs-lynx.c                               | 2 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                          | 3 ++-
 drivers/net/pcs/pcs-xpcs.c                               | 5 +++--
 drivers/net/phy/phylink.c                                | 7 +++++--
 include/linux/phylink.h                                  | 3 ++-
 10 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index c47108c820ea..b3e2a596ad2c 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -760,7 +760,7 @@ static void dtsec_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct fman_mac *dtsec = pcs_to_dtsec(pcs);
 
-	phylink_mii_c22_pcs_get_state(dtsec->tbidev, state);
+	phylink_mii_c22_pcs_get_state(dtsec->tbidev, neg_mode, state);
 }
 
 static int dtsec_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 25cb2f61986f..1efa584e7107 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -443,7 +443,7 @@ int lan966x_stats_init(struct lan966x *lan966x);
 
 void lan966x_port_config_down(struct lan966x_port *port);
 void lan966x_port_config_up(struct lan966x_port *port);
-void lan966x_port_status_get(struct lan966x_port *port,
+void lan966x_port_status_get(struct lan966x_port *port, unsigned int neg_mode,
 			     struct phylink_link_state *state);
 int lan966x_port_pcs_set(struct lan966x_port *port,
 			 struct lan966x_port_config *config);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c b/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
index a761777259bf..75188b99e4e7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
@@ -93,7 +93,7 @@ static void lan966x_pcs_get_state(struct phylink_pcs *pcs,
 {
 	struct lan966x_port *port = lan966x_pcs_to_port(pcs);
 
-	lan966x_port_status_get(port, state);
+	lan966x_port_status_get(port, neg_mode, state);
 }
 
 static int lan966x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index fdfa4040d9ee..cf7de0267c32 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -284,7 +284,7 @@ void lan966x_port_config_up(struct lan966x_port *port)
 	lan966x_port_link_up(port);
 }
 
-void lan966x_port_status_get(struct lan966x_port *port,
+void lan966x_port_status_get(struct lan966x_port *port, unsigned int neg_mode,
 			     struct phylink_link_state *state)
 {
 	struct lan966x *lan966x = port->lan966x;
@@ -314,7 +314,7 @@ void lan966x_port_status_get(struct lan966x_port *port,
 		bmsr |= BMSR_ANEGCOMPLETE;
 
 		lp_adv = DEV_PCS1G_ANEG_STATUS_LP_ADV_GET(val);
-		phylink_mii_c22_pcs_decode_state(state, bmsr, lp_adv);
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lp_adv);
 	} else {
 		if (!state->link)
 			return;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f9e695d7cc4a..3531646ef6ab 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2336,7 +2336,7 @@ static void axienet_pcs_get_state(struct phylink_pcs *pcs,
 {
 	struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
 
-	phylink_mii_c22_pcs_get_state(pcs_phy, state);
+	phylink_mii_c22_pcs_get_state(pcs_phy, neg_mode, state);
 }
 
 static void axienet_pcs_an_restart(struct phylink_pcs *pcs)
diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index f359f62f69ad..e46f588cae7d 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -109,7 +109,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
-		phylink_mii_c22_pcs_get_state(lynx->mdio, state);
+		phylink_mii_c22_pcs_get_state(lynx->mdio, neg_mode, state);
 		break;
 	case PHY_INTERFACE_MODE_2500BASEX:
 		lynx_pcs_get_state_2500basex(lynx->mdio, state);
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index e1b6f332c3c2..7d6261dee534 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -115,7 +115,8 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
 	regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv);
 
-	phylink_mii_c22_pcs_decode_state(state, FIELD_GET(SGMII_BMSR, bm),
+	phylink_mii_c22_pcs_decode_state(state, neg_mode,
+					 FIELD_GET(SGMII_BMSR, bm),
 					 FIELD_GET(SGMII_LPA, adv));
 }
 
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4cd0c4fe6496..1aef2afd3c73 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1030,6 +1030,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 }
 
 static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
+					unsigned int neg_mode,
 					struct phylink_link_state *state)
 {
 	int lpa, bmsr;
@@ -1058,7 +1059,7 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 			}
 		}
 
-		phylink_mii_c22_pcs_decode_state(state, bmsr, lpa);
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
 	}
 
 	return 0;
@@ -1114,7 +1115,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_1000BASEX:
-		ret = xpcs_get_state_c37_1000basex(xpcs, state);
+		ret = xpcs_get_state_c37_1000basex(xpcs, neg_mode, state);
 		if (ret)
 			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_1000basex", ERR_PTR(ret));
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6443cf39593c..99737bb6d1c7 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3860,6 +3860,7 @@ static void phylink_decode_usgmii_word(struct phylink_link_state *state,
 /**
  * phylink_mii_c22_pcs_decode_state() - Decode MAC PCS state from MII registers
  * @state: a pointer to a &struct phylink_link_state.
+ * @neg_mode: link negotiation mode (PHYLINK_PCS_NEG_xxx)
  * @bmsr: The value of the %MII_BMSR register
  * @lpa: The value of the %MII_LPA register
  *
@@ -3872,7 +3873,7 @@ static void phylink_decode_usgmii_word(struct phylink_link_state *state,
  * accessing @bmsr and @lpa cannot be done with MDIO directly.
  */
 void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
-				      u16 bmsr, u16 lpa)
+				      unsigned int neg_mode, u16 bmsr, u16 lpa)
 {
 	state->link = !!(bmsr & BMSR_LSTATUS);
 	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
@@ -3910,6 +3911,7 @@ EXPORT_SYMBOL_GPL(phylink_mii_c22_pcs_decode_state);
 /**
  * phylink_mii_c22_pcs_get_state() - read the MAC PCS state
  * @pcs: a pointer to a &struct mdio_device.
+ * @neg_mode: link negotiation mode (PHYLINK_PCS_NEG_xxx)
  * @state: a pointer to a &struct phylink_link_state.
  *
  * Helper for MAC PCS supporting the 802.3 clause 22 register set for
@@ -3922,6 +3924,7 @@ EXPORT_SYMBOL_GPL(phylink_mii_c22_pcs_decode_state);
  * structure.
  */
 void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
+				   unsigned int neg_mode,
 				   struct phylink_link_state *state)
 {
 	int bmsr, lpa;
@@ -3933,7 +3936,7 @@ void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
 		return;
 	}
 
-	phylink_mii_c22_pcs_decode_state(state, bmsr, lpa);
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
 }
 EXPORT_SYMBOL_GPL(phylink_mii_c22_pcs_get_state);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 0bbcb4898e93..f19b7108c840 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -693,8 +693,9 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 }
 
 void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
-				      u16 bmsr, u16 lpa);
+				      unsigned int neg_mode, u16 bmsr, u16 lpa);
 void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
+				   unsigned int neg_mode,
 				   struct phylink_link_state *state);
 int phylink_mii_c22_pcs_encode_advertisement(phy_interface_t interface,
 					     const unsigned long *advertising);
-- 
2.30.2


