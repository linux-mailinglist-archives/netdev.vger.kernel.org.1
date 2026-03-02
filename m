Return-Path: <netdev+bounces-262604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNgAKA1opWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:35:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89C1D6A14
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D09130668FC
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F43AEF44;
	Mon,  2 Mar 2026 10:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339423A0E8A;
	Mon,  2 Mar 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447089; cv=none; b=aEwcE2gXo05LgySUuS0vs2h0wvuaz3w7knrK/DCX1rqQiIkv854NPWXyAkQTFuH03Ydyrdm0jq21WwiWbHy2H0g9wzsLF0aWpbdzsK7vUYe4iwD+vtx3Tx0E+6OecojvgOYiAgdAI7hGrNcRhJ4HjkIl43BMeRofbjY4+kUmkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447089; c=relaxed/simple;
	bh=GNBVN9sBooVec+i3k+OhnV9U0vINAXVIEnxZwRMxiok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IdQrYSfj6XzPgbw4Gt7CvlkYMiDVFZNcpV1p6A0xD606aM/e6OfhI/h+8VXKY83voZubml9AQSESTO0YZUbGJLgJYR77y9qymqPhHL+ShdnJ0VWsFUjeCrI9wcHgRBcCH5pPAY2odreXxKIChqji1XRORBKs9dKOM20WY3KjPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:31 +0800
Subject: [PATCH net-next v6 4/5] net: ftgmac100: Support rgmii delay in old
 dts with AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260302-rgmii_delay_2600-v6-4-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=9969;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=GNBVN9sBooVec+i3k+OhnV9U0vINAXVIEnxZwRMxiok=;
 b=/Bemo3MJ8tUHzhfUnL8BRt6fHMNk16GVTHCryga+He7Qx/E3WIeI75NSxIPE1QjxRyJlBQ92c
 Pg1w8WIDO3ICGJ+2i9ebXm3zyVQWtrO2KGY771P9ZVmGgCCNag8otkm
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262604-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF89C1D6A14
X-Rspamd-Action: no action

Strating to this patch, driver will remind the legacy dts to update the
"phy-mode" to "rgmii-id, and if necessary, add small
"rx-internal-delay-ps" and "tx-internal-delay-ps.
If lack the two properties, driver will accord to the original delay
value from bootloader to disable RGMII delay and to change the phy
interface to phy driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 190 +++++++++++++++++++++++++++----
 drivers/net/ethernet/faraday/ftgmac100.h |   5 +
 2 files changed, 174 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 0b2a0bb8a4a9..5f5b9199a9ef 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1871,10 +1871,40 @@ static int ftgmac100_probe_ncsi(struct net_device *netdev,
 	return err;
 }
 
+static struct phy_device *ftgmac100_ast2600_phy_get(struct net_device *dev,
+						    struct device_node *np,
+						    void (*hndlr)(struct net_device *),
+						    phy_interface_t phy_intf)
+{
+	struct device_node *phy_np;
+	struct phy_device *phy;
+	int ret;
+
+	if (of_phy_is_fixed_link(np)) {
+		ret = of_phy_register_fixed_link(np);
+		if (ret < 0) {
+			netdev_err(dev, "broken fixed-link specification\n");
+			return NULL;
+		}
+		phy_np = of_node_get(np);
+	} else {
+		phy_np = of_parse_phandle(np, "phy-handle", 0);
+		if (!phy_np)
+			return NULL;
+	}
+
+	phy = of_phy_connect(dev, phy_np, hndlr, 0, phy_intf);
+
+	of_node_put(phy_np);
+
+	return phy;
+}
+
 static int ftgmac100_probe_dt(struct net_device *netdev,
 			      struct platform_device *pdev,
 			      struct ftgmac100 *priv,
-			      struct device_node *np)
+			      struct device_node *np,
+			      phy_interface_t phy_intf)
 {
 	struct phy_device *phy;
 	int err;
@@ -1890,8 +1920,16 @@ static int ftgmac100_probe_dt(struct net_device *netdev,
 		 * them. 2600 has an independent MDIO controller, not
 		 * part of the MAC.
 		 */
-		phy = of_phy_get_and_connect(priv->netdev, np,
-					     &ftgmac100_adjust_link);
+		if (priv->mac_id == FTGMAC100_AST2600)
+			/* Because AST2600 will use the RGMII delay to determine
+			 * which phy interface to use.
+			 */
+			phy = ftgmac100_ast2600_phy_get(priv->netdev, np,
+							&ftgmac100_adjust_link,
+							phy_intf);
+		else
+			phy = of_phy_get_and_connect(priv->netdev, np,
+						     &ftgmac100_adjust_link);
 		if (!phy) {
 			dev_err(&pdev->dev, "Failed to connect to phy\n");
 			return -EINVAL;
@@ -1923,10 +1961,62 @@ static int ftgmac100_probe_dt(struct net_device *netdev,
 	return 0;
 }
 
+static int ftgmac100_get_ast2600_rgmii_flag(u32 delay)
+{
+	if ((delay > 500 && delay < 1500) ||
+	    (delay > 2500 && delay < 7500))
+		return AST2600_RGMII_KEEP_DELAY;
+
+	return AST2600_RGMII_DIS_DELAY;
+}
+
+static int ftgmac100_check_ast2600_rgmii_delay(struct regmap *scu,
+					       u32 delay_unit,
+					       int mac_id, int dly_reg)
+{
+	u32 delay_value;
+	u32 tx_delay;
+	u32 rx_delay;
+	int tx_flag;
+	int rx_flag;
+
+	regmap_read(scu, dly_reg, &delay_value);
+	if (mac_id == 0 || mac_id == 2) {
+		tx_delay = FIELD_GET(ASPEED_MAC0_2_TX_DLY, delay_value);
+		rx_delay = FIELD_GET(ASPEED_MAC0_2_RX_DLY, delay_value);
+	} else {
+		tx_delay = FIELD_GET(ASPEED_MAC1_3_TX_DLY, delay_value);
+		rx_delay = FIELD_GET(ASPEED_MAC1_3_RX_DLY, delay_value);
+	}
+
+	/* Due to the hardware design reason, for MAC2/3 on AST2600,
+	 * the zero delay ns on RX is configured by setting value 0x1a.
+	 * List as below:
+	 * 0x1a, 0x1b, ... , 0x1f, 0x00, 0x01, ... , 0x19
+	 * Covert for calculation purpose.
+	 * 0x00, 0x01, ... , 0x19, 0x1a, 0x1b, ... , 0x1f
+	 */
+	if (mac_id == 2 || mac_id == 3)
+		rx_delay = (rx_delay + 0x06) & 0x1f;
+
+	tx_delay *= delay_unit;
+	rx_delay *= delay_unit;
+
+	tx_flag = ftgmac100_get_ast2600_rgmii_flag(tx_delay);
+	rx_flag = ftgmac100_get_ast2600_rgmii_flag(rx_delay);
+
+	if (tx_flag == AST2600_RGMII_KEEP_DELAY ||
+	    rx_flag == AST2600_RGMII_KEEP_DELAY) {
+		return AST2600_RGMII_KEEP_DELAY;
+	}
+
+	return AST2600_RGMII_DIS_DELAY;
+}
+
 static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
-					     u32 rgmii_tx_delay,
-					     u32 rgmii_rx_delay,
-					     phy_interface_t phy_intf)
+					     s32 rgmii_tx_delay,
+					     s32 rgmii_rx_delay,
+					     phy_interface_t *phy_intf)
 {
 	struct device *dev = priv->dev;
 	struct device_node *np;
@@ -1975,13 +2065,59 @@ static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
 		return -EINVAL;
 	}
 
-	/* Please refer to ethernet-controller.yaml. */
-	if (phy_intf == PHY_INTERFACE_MODE_RGMII &&
-	    (rgmii_tx_delay == 2000 || rgmii_rx_delay == 2000)) {
-		dev_warn(dev, "RX/TX delay cannot set to 2000 on 'rgmii'\n");
-		return -EINVAL;
+	if (of_phy_is_fixed_link(np)) {
+		if (rgmii_tx_delay < 0 || rgmii_rx_delay < 0) {
+			dev_err(dev,
+				"Add rx/tx-internal-delay-ps for fixed-link\n");
+			/* Keep original RGMII delay value*/
+			return 0;
+		}
+
+		/* Must have both of rx/tx-internal-delay-ps for fixed-link */
+		goto conf_delay;
+	}
+
+	if (*phy_intf == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    *phy_intf == PHY_INTERFACE_MODE_RGMII_TXID)
+		goto out_warn;
+
+	/* Both rx/tx-internal-delay-ps are not existed. */
+	if (rgmii_tx_delay < 0 && rgmii_rx_delay < 0) {
+		int flag;
+
+		flag = ftgmac100_check_ast2600_rgmii_delay(scu,
+							   rgmii_delay_unit,
+							   mac_id,
+							   dly_reg);
+		if (flag == AST2600_RGMII_KEEP_DELAY)
+			goto out_warn;
+
+		if (*phy_intf == PHY_INTERFACE_MODE_RGMII) {
+			dev_err(dev, "Update phy-mode to 'rgmii-id'\n");
+			/* Forced phy interface to RGMII_ID and MAC will disable
+			 * RGMII delay.
+			 */
+			*phy_intf = PHY_INTERFACE_MODE_RGMII_ID;
+		}
+	} else {
+		/* Please refer to ethernet-controller.yaml. */
+		if (*phy_intf == PHY_INTERFACE_MODE_RGMII &&
+		    (rgmii_tx_delay == 2000 || rgmii_rx_delay == 2000)) {
+			dev_warn(dev,
+				 "RX/TX delay cannot set to 2000 on 'rgmii'\n");
+			return -EINVAL;
+		}
 	}
 
+	/* The value is negative, which means the rx/tx-internal-delay-ps
+	 * property is not existed in dts. Therefore, set to default 0.
+	 */
+	if (rgmii_tx_delay < 0)
+		rgmii_tx_delay = 0;
+	if (rgmii_rx_delay < 0)
+		rgmii_rx_delay = 0;
+
+conf_delay:
 	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
 	if (tx_delay_index >= 32) {
 		dev_err(dev, "The %u ps of TX delay is out of range\n",
@@ -2018,15 +2154,21 @@ static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
 
 	regmap_update_bits(scu, dly_reg, dly_mask, tx_delay_index | rx_delay_index);
 
+	return 0;
+
+out_warn:
+	/* Print the warning message. Keep the phy-mode and the RGMII delay value. */
+	dev_warn(dev, "Update phy-mode to 'rgmii-id' and add rx/tx-internal-delay-ps\n");
+
 	return 0;
 }
 
-static int ftgmac100_config_rgmii_delay(struct ftgmac100 *priv)
+static int ftgmac100_config_rgmii_delay(struct ftgmac100 *priv,
+					phy_interface_t *phy_intf)
 {
 	struct device_node *np = priv->dev->of_node;
-	phy_interface_t phy_intf;
-	u32 rgmii_tx_delay;
-	u32 rgmii_rx_delay;
+	s32 rgmii_tx_delay;
+	s32 rgmii_rx_delay;
 	int err = 0;
 
 	/* Because some old dts using NC-SI mode does not include phy-mode
@@ -2036,20 +2178,23 @@ static int ftgmac100_config_rgmii_delay(struct ftgmac100 *priv)
 	if (of_get_property(np, "use-ncsi", NULL))
 		return 0;
 
-	err = of_get_phy_mode(np, &phy_intf);
+	err = of_get_phy_mode(np, phy_intf);
 	if (err) {
 		dev_err(priv->dev, "Failed to get phy mode: %d\n", err);
 		return err;
 	}
 
 	/* RMII does not need to configure RGMII delay */
-	if (!phy_interface_mode_is_rgmii(phy_intf))
+	if (!phy_interface_mode_is_rgmii(*phy_intf))
 		return 0;
 
+	/* AST2600 needs to know if the "tx/rx-internal-delay-ps" properties
+	 * are existed in dts. If not existed, set -1 and delay is equal to 0.
+	 */
 	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay))
-		rgmii_tx_delay = 0;
+		rgmii_tx_delay = -1;
 	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay))
-		rgmii_rx_delay = 0;
+		rgmii_rx_delay = -1;
 
 	if (priv->mac_id == FTGMAC100_AST2600)
 		err = ftgmac100_set_ast2600_rgmii_delay(priv,
@@ -2068,10 +2213,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
+	phy_interface_t phy_intf;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
 
+	phy_intf = PHY_INTERFACE_MODE_NA;
+
 	np = pdev->dev.of_node;
 	if (np) {
 		match_data = of_device_get_match_data(&pdev->dev);
@@ -2151,7 +2299,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	}
 
 	if (rgmii_delay_conf) {
-		err = ftgmac100_config_rgmii_delay(priv);
+		err = ftgmac100_config_rgmii_delay(priv, &phy_intf);
 		if (err)
 			return err;
 	}
@@ -2165,7 +2313,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	}
 
 	if (np) {
-		err = ftgmac100_probe_dt(netdev, pdev, priv, np);
+		err = ftgmac100_probe_dt(netdev, pdev, priv, np, phy_intf);
 		if (err)
 			goto err;
 	}
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index d19d44d1b8e0..1b2f79a104ea 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -291,4 +291,9 @@ struct ftgmac100_rxdes {
 #define AST2600_MAC2_BASE_ADDR		0x1e670000
 #define AST2600_MAC3_BASE_ADDR		0x1e690000
 
+/* Keep original delay */
+#define AST2600_RGMII_KEEP_DELAY	0x01
+/* Need to disable delay on MAC side */
+#define AST2600_RGMII_DIS_DELAY		0x02
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1


