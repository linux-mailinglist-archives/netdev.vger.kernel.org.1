Return-Path: <netdev+bounces-255575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJpBManLfmneeQIAu9opvQ
	(envelope-from <netdev+bounces-255575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:42:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CFC4DC7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2703730157DB
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 03:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8834427FB3A;
	Sun,  1 Feb 2026 03:42:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1123A9A8;
	Sun,  1 Feb 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769917328; cv=none; b=jGZk9XgV2YDuQ7rHvlosKR6nvIy3TSRbJES0SvKT+DLTFPa1az3aJHIjLbpw9yu+2TXzdk0B3EdkNpIMLNwy2xMscfZR5PYkHZKU375cwZYzcNySXrfYxM1eAqA53luOiLq86CUvCC5u1rYYUdeI/gslXL2wRZztwPibpqxESJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769917328; c=relaxed/simple;
	bh=q1yqherTZ1VwTP5irNF4KDqWVxAHd1f324KoOIjrlh8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZRsiiIqCgyxpg43jDvhv7s9IMSdmHOw617JhroyoS8D2sw2LdRg9i5d7gWAxShnB1PF1D55fiCdCpHAnVHnSN/MSzU/A5Q50DsxZudmQs3tBdtumw0O5iKdNH9p7sbaMtmX+M6WQA+QAbzGj9lm6g/9LxjQyNf7PSsRXL9tnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmOLb-000000002Wu-1HSD;
	Sun, 01 Feb 2026 03:42:03 +0000
Date: Sun, 1 Feb 2026 03:42:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: dsa: mxl-gsw1xx: configure SerDes port
 polarities
Message-ID: <8bf79b3476e23673fceffbe2bc9d6abc13d132e5.1769916962.git.daniel@makrotopia.org>
References: <cover.1769916962.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769916962.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E9CFC4DC7
X-Rspamd-Action: no action

Configure SerDes (port 4) RX and TX polarities using the newly
introduced generic properties. The polarities are described at the port
level which equals the polarities of the external pins of the chip.

Note that the RX lane is inverted internally and the vendor driver
simply always sets bit GSW1XX_SGMII_PHY_RX0_CFG2_INVERT unconditionally
to end up with the correct (ie. as documented in datasheets) polarity at
the external pins.

In this sense, PHY_POLARITY_NORMAL denotes normal polarity for pins as
documented for the MRQFN 105-pin package (GSW120, GSW125, GSW140, GSW141
and GSW145 all use the same package and have identical pin layouts
except for TP port 2 and 3 being N/C on GSW12x):
pin B18 (TX0_P) positive signal of the differential SGMII data output pair
pin B19 (TX0_M) negative signal of the differential SGMII data output pair
pin B20 (RX0_P) positive signal of the differential SGMII data input pair
pin B21 (RX0_M) negative signal of the differential SGMII data input pair

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: be clear about describing polarity at external pins
v2: use phy_get_manual_rx_polarity and phy_get_manual_tx_polarity
---
 drivers/net/dsa/lantiq/Kconfig      |  1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 39 +++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
index bad13817af25..98efeef2661b 100644
--- a/drivers/net/dsa/lantiq/Kconfig
+++ b/drivers/net/dsa/lantiq/Kconfig
@@ -15,6 +15,7 @@ config NET_DSA_MXL_GSW1XX
 	tristate "MaxLinear GSW1xx Ethernet switch support"
 	select NET_DSA_TAG_MXL_GSW1XX
 	select NET_DSA_LANTIQ_COMMON
+	select PHY_COMMON_PROPS
 	help
 	  This enables support for the Intel/MaxLinear GSW1xx family of 1GE
 	  switches.
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 79cf72cc77be..61220b5fe5af 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
+#include <linux/phy/phy-common-props.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
@@ -229,11 +231,17 @@ static int gsw1xx_pcs_phy_xaui_write(struct gsw1xx_priv *priv, u16 addr,
 					1000, 100000);
 }
 
-static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
+static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv, phy_interface_t interface)
 {
+	struct dsa_port *sgmii_port;
+	unsigned int pol;
 	int ret;
 	u16 val;
 
+	sgmii_port = dsa_to_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
+	if (!sgmii_port)
+		return -EINVAL;
+
 	/* Assert and deassert SGMII shell reset */
 	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
 			      GSW1XX_RST_REQ_SGMII_SHELL);
@@ -260,15 +268,20 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
 	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
 			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
 
+	ret = phy_get_manual_rx_polarity(of_fwnode_handle(sgmii_port->dn),
+					 phy_modes(interface), &pol);
+	if (ret)
+		return ret;
+
 	/* RX lane seems to be inverted internally, so bit
 	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
-	 * (ie. non-inverted) operation.
-	 *
-	 * TODO: Take care of inverted RX pair once generic property is
-	 *       available
+	 * (ie. non-inverted) operation matching the chips external pins as
+	 * described in datasheets dated 2023-11-08, ie. pin B20 (RX0_P) being
+	 * the positive signal and pin B21 (RX0_M) being the negative signal of
+	 * the differential input pair.
 	 */
-
-	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
+	if (pol == PHY_POL_NORMAL)
+		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
 
 	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
 	if (ret < 0)
@@ -277,9 +290,13 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
 	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
 			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
 
-	/* TODO: Take care of inverted TX pair once generic property is
-	 *       available
-	 */
+	ret = phy_get_manual_tx_polarity(of_fwnode_handle(sgmii_port->dn),
+					 phy_modes(interface), &pol);
+	if (ret)
+		return ret;
+
+	if (pol == PHY_POL_INVERT)
+		val |= GSW1XX_SGMII_PHY_TX0_CFG3_INVERT;
 
 	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
 	if (ret < 0)
@@ -336,7 +353,7 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
 
 	if (!reconf)
-		ret = gsw1xx_pcs_reset(priv);
+		ret = gsw1xx_pcs_reset(priv, interface);
 
 	if (ret)
 		return ret;
-- 
2.52.0

