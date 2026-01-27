Return-Path: <netdev+bounces-253866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KtyN3+7eGm0sgEAu9opvQ
	(envelope-from <netdev+bounces-253866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:19:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E994CD3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BE0304115A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DD3559D1;
	Tue, 27 Jan 2026 13:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B781EA7CC;
	Tue, 27 Jan 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519933; cv=none; b=cu3ufLJiX9DI0D7USKrBV0aC19hPrtzQykOCVZ0erUry8eorF6KOPLz3AXCEtpQEFzJHYrgJm6ZKGZ98eO70bscbYSn9ZoYbIfsSaulDgozds5zq/h7QouhLbP58BTp7V7eaqT4rTCThd+igsMUQxUkX6AvYJyf26CaY9AWIM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519933; c=relaxed/simple;
	bh=D42JR7u13Ao0gUEQVTk0Kz9ZYGv29KYP29e+BV8Iv+k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBAjWlgznzW9g6OyD0DpjvYKpnvmjqtDiP6K6BuBfQ71hvQNq29mEEQ5HeziIEmoKIw5KlceCkSgnuCpqAyw1dYyxz3GEf0Wgbza6cIMhLpC3ilUy7vMdXAZ09Tvvf3kMwEBE2qL+WoQYIJy6gN1E0F12+Ikmqz4hR/HJ5gbYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkiy0-000000000Sn-2NvO;
	Tue, 27 Jan 2026 13:18:48 +0000
Date: Tue, 27 Jan 2026 13:18:45 +0000
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
Subject: [PATCH net-next 2/3] net: dsa: mxl-gsw1xx: configure PCS polarities
Message-ID: <db296e8f477f34498979cd580898170f8ae537e5.1769519758.git.daniel@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769519758.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253866-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 658E994CD3
X-Rspamd-Action: no action

Configure SerDes PCS RX and TX polarities using the newly
introduced generic properties.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/Kconfig      |  1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 38 +++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 10 deletions(-)

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
index 79cf72cc77be..6284b9afdbbb 100644
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
+	struct dsa_port *pcs_port;
+	unsigned int pol;
 	int ret;
 	u16 val;
 
+	pcs_port = dsa_to_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
+	if (!pcs_port)
+		return -EINVAL;
+
 	/* Assert and deassert SGMII shell reset */
 	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
 			      GSW1XX_RST_REQ_SGMII_SHELL);
@@ -260,15 +268,19 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
 	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
 			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
 
+	ret = phy_get_rx_polarity(of_fwnode_handle(pcs_port->dn),
+				  phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  PHY_POL_NORMAL, &pol);
+	if (ret)
+		return ret;
+
 	/* RX lane seems to be inverted internally, so bit
 	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
 	 * (ie. non-inverted) operation.
-	 *
-	 * TODO: Take care of inverted RX pair once generic property is
-	 *       available
 	 */
-
-	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
+	if (pol == PHY_POL_NORMAL)
+		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
 
 	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
 	if (ret < 0)
@@ -277,9 +289,15 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
 	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
 			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
 
-	/* TODO: Take care of inverted TX pair once generic property is
-	 *       available
-	 */
+	ret = phy_get_tx_polarity(of_fwnode_handle(pcs_port->dn),
+				  phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  PHY_POL_NORMAL, &pol);
+	if (ret)
+		return ret;
+
+	if (pol == PHY_POL_INVERT)
+		val |= GSW1XX_SGMII_PHY_TX0_CFG3_INVERT;
 
 	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
 	if (ret < 0)
@@ -336,7 +354,7 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
 
 	if (!reconf)
-		ret = gsw1xx_pcs_reset(priv);
+		ret = gsw1xx_pcs_reset(priv, interface);
 
 	if (ret)
 		return ret;
-- 
2.52.0

