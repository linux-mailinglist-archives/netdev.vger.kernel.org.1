Return-Path: <netdev+bounces-243462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7484CA1A13
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D46302A978
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D442D3EE5;
	Wed,  3 Dec 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FJqlX9es";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BhLbtJKy"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698322D190C;
	Wed,  3 Dec 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796156; cv=none; b=DSfXekMusr7T/81qKpfBmJ/HLdR+WS3WI+Da0gOMvwYz3xqlgKYMg8kFqfTwIb1vfsE+4DB0yq8T1SPl5fKk2nktWGuzIUORaLcx5NIfd+U5S8U1uxRHc/CMXMGpOM7gu9n7N9cU1/I5i4AS5/ul4BTeSyFxFSzREb3I6D32NbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796156; c=relaxed/simple;
	bh=cHT6RTEBO5sXEurDk/gl6mvx2DgwJV5WjP5regct73k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBaEgNWAOp4dS9HxvGbAbTH1RQcpIWK7yWiowtMkk29C2yM88Tv0X4zd0fzH4fauw/LSpKZNUyms3qwM1XKlocVaAYUoDYA/sNz+wFSh8leRwAFAX+g/6xbqm49HywXr8WOBU4kTI7fjqcx91RDcCgQvrT4t9ZiVYmITo63GvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FJqlX9es; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BhLbtJKy; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dM9HX4f3Gz9tKq;
	Wed,  3 Dec 2025 22:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKLLEyUCa1M/5zRwIJjRbz/UBMTbUidINBB9hmj/IK8=;
	b=FJqlX9esyl/BeBW+OyZnfrwbQTU9NcSQsYZkpk8lzYBLGjykO9mx7APhkgBrbWNUXbFveg
	pn9VS8/5iu2BUCsDFyayjRTKHdGOI2oFpjNOtq7fLnHwTu+UtJoTu1tdXpH/q1npJ//Rdz
	UGilNI6O0ebS6wNlvRkWy1LuTGXDItEWrrj7W+se20SHkHZnpnyMw7WHofiXoWUUsexfWE
	MU4j/xr/TB3UbmF6dVdjc3cEaG4e17qmcYuO59P+xIdyiPmUiZIlaHPO1YdxabY8qx/xcB
	Gmeo6X0aUvZ5CWSA55VHjFfQft+6RAjBYtPLjJkbvM5+CTj6Q0ZstDFwJUW9Vw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BhLbtJKy;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKLLEyUCa1M/5zRwIJjRbz/UBMTbUidINBB9hmj/IK8=;
	b=BhLbtJKyEdyGyG9eoUXGlEntGPS63k+lsMkfQ2mCwScocg7+/p84Qh8TXRCIqWFq23p36J
	VbFNGq6Y9eql9qrYoBQ4yz+FtGlx+EWdysFy20tq5NDxLYhDh9A4pTLNHBfhlDFqYlgmgX
	oPmIjWFZl6AyJY//vQMHZ3kHsvRXiqqOL868rLt5vJZutWNmuAm0KZ9dhB25hWMEerLUuk
	utdMFKB5ZUbBBYqIYxPgXx67PhaPMc7vlokQdFfGkGIskiB+sX9pvAtwQWoQuJj0bO1xjG
	CyFTDBgv/hRbBpqbiOAFyTL9NaJj9egYr390Z8BEoo4A07g7enetp80yw7vxRQ==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to enable SSC
Date: Wed,  3 Dec 2025 22:08:06 +0100
Message-ID: <20251203210857.113328-3-marek.vasut@mailbox.org>
In-Reply-To: <20251203210857.113328-1-marek.vasut@mailbox.org>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d82f0e1cebd25e7e4fb
X-MBO-RS-META: qp9c1ydh4sh7err115rzwtak1m4nq56w
X-Rspamd-Queue-Id: 4dM9HX4f3Gz9tKq

Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
follows EMI improvement application note Rev. 1.2 for these PHYs.

The current implementation enables SSC for both RXC and SYSCLK clock
signals. Introduce DT properties 'realtek,clkout-ssc-enable',
'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
signals.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
---
 drivers/net/phy/realtek/realtek_main.c | 124 +++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4af2b1..ac80653cdbe28 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -74,11 +74,19 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
 
 #define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
+/* RTL8211F SSC settings */
+#define RTL8211F_SSC_PAGE			0xc44
+#define RTL8211F_SSC_RXC			0x13
+#define RTL8211F_SSC_SYSCLK			0x17
+#define RTL8211F_SSC_CLKOUT			0x19
+
 /* RTL8211F LED configuration */
 #define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
@@ -203,6 +211,9 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_clkout_ssc;
+	bool enable_rxc_ssc;
+	bool enable_sysclk_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,6 +277,12 @@ static int rtl821x_probe(struct phy_device *phydev)
 						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
+	priv->enable_clkout_ssc = of_property_read_bool(dev->of_node,
+							"realtek,clkout-ssc-enable");
+	priv->enable_rxc_ssc = of_property_read_bool(dev->of_node,
+						     "realtek,rxc-ssc-enable");
+	priv->enable_sysclk_ssc = of_property_read_bool(dev->of_node,
+							"realtek,sysclk-ssc-enable");
 
 	phydev->priv = priv;
 
@@ -700,6 +717,101 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
 				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 }
 
+static int rtl8211f_config_clkout_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_clkout_ssc)
+		return 0;
+
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	/* Unnamed registers from EMI improvement parameters application note 1.2 */
+	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC initialization failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_CLKOUT, 0x38c3);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * Enable CLKOUT SSC using PHYCR2 bit 7 , this step is missing from the
+	 * EMI improvement parameters application note 1.2 section 2.3
+	 */
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+			       RTL8211F_CLKOUT_SSC_EN, RTL8211F_CLKOUT_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8211f_config_rxc_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_rxc_ssc)
+		return 0;
+
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
+	if (ret < 0) {
+		dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8211f_config_sysclk_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_sysclk_ssc)
+		return 0;
+
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_SYSCLK, 0x4f00);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable SSC */
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+			       RTL8211F_SYSCLK_SSC_EN, RTL8211F_SYSCLK_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SCC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -723,6 +835,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
+	ret = rtl8211f_config_clkout_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_rxc_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_sysclk_ssc(phydev);
+	if (ret)
+		return ret;
+
 	return rtl8211f_config_phy_eee(phydev);
 }
 
-- 
2.51.0


