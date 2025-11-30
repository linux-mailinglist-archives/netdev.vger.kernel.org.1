Return-Path: <netdev+bounces-242757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF01C949E0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEE69347AC6
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C341FF61E;
	Sun, 30 Nov 2025 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IscGDKcu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lr+J7QYu"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180201FBCA7;
	Sun, 30 Nov 2025 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764464350; cv=none; b=PfSxyk6Kv9PM05J3jqoVUqdLDCCw+bWVee1j8aAwdNgQSwfeU3S/UF/HXGJPnv8ftYzzDAXBFt0zbyBjasyA+jdF8p0oqOLscyiurHU5EbdH0VunDj7u5Ho47kQquOQXuhf6XziGqWv190yZ8Js7IhOAADc9mRVxKAlBpPcKuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764464350; c=relaxed/simple;
	bh=HFwcMto0EdYzFC8j1jzp4Vh6mpN4h6tqdB0ORbavm2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeQFjQJYt3VWEW95NFm2ZsbYlWDeQ5kp5w2QEuw/njz4LUMRXOh8uawUGtsvxLFrQw7Nz6fPylR+fzscMUIex5K48A2JrX68PexUszje6adoKsCajGtLCPOqWhM0PG6BckcLUXeGcQy+tG8mPZy4FHrVei7xmtPtnSltqe0zwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IscGDKcu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lr+J7QYu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dJpZT6yWyz9sRn;
	Sun, 30 Nov 2025 01:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJUkaqejA8eJaafZEbdYftkY1miLPNzZPG4a5swltts=;
	b=IscGDKcuIzldryCyARwp/N7bxvUxm8ERGw5auSPyJYlPfclaaSjxG1HOdfYbFfotrR3j5t
	8jmNbTDEhzzS66Nb3JxugUjB2GjscZIxvCQaNAtRsVTEVa2PxCxPdDUIOeH9is+h4n1MpI
	R8brQaHpyYebLohRFUHPjyR/4e1rvbDqgWEXczWU5lI6emU3HfTyJSq+deIYH3chdmLg77
	ra9OyPfbo38W9v41Em9PF/L/UFTvuBzugrh/keBq2LjzPp76JGLfZrh+hQA6DzoPCjftb/
	rSvQ9klxjkpbVreWDmf3LTMGGVwKIblF6ydDTG4Ux4NjadySQ8XmTg1+5OYxWQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lr+J7QYu;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJUkaqejA8eJaafZEbdYftkY1miLPNzZPG4a5swltts=;
	b=lr+J7QYu9RzPiHTV9Y3LBCKB0RfbleLa9kMRdTZNAu6Ed6Fo4Qi2CmUi9u3aQccgiEmBv1
	2Dw2uLmyK1YZkQ44Ip6Eld0wzhSq24ihwHcrRP6scY8N6W+ajTGk5JK9S4AR13KaZaGmux
	/cWVUiu3PIRR3uoCU1zqCjbl1vsMwMDShE/Tf0DLLIpsl2wULhLEzM8h6tfT6diYHsYvvI
	eeEzveQr4+g9W6RlTHyfNLAZPKTXx4x76tiIVie/LYKMl0qqgulnqscMWywhV/vt3ayv69
	UXSTSXerS50THhhebHnAS/WULCRaX76njHleYYZqXYTjMklT9UuJtC+eO3e+Gg==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable SSC
Date: Sun, 30 Nov 2025 01:58:34 +0100
Message-ID: <20251130005843.234656-3-marek.vasut@mailbox.org>
In-Reply-To: <20251130005843.234656-1-marek.vasut@mailbox.org>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a55ed673f69ff13f098
X-MBO-RS-META: 4a7dr94nhchz6jkihn8mhnwitsqtbntx
X-Rspamd-Queue-Id: 4dJpZT6yWyz9sRn

Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
follows EMI improvement application note Rev. 1.2 for these PHYs.

The current implementation enables SSC for both RXC and SYSCLK clock
signals. Introduce new DT property 'realtek,ssc-enable' to enable the
SSC mode.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
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
 drivers/net/phy/realtek/realtek_main.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4af2b1..b1b48936d6422 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -74,11 +74,17 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
 
 #define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
+/* RTL8211F SSC settings */
+#define RTL8211F_SSC_PAGE			0xc44
+#define RTL8211F_SSC_RXC			0x13
+#define RTL8211F_SSC_SYSCLK			0x17
+
 /* RTL8211F LED configuration */
 #define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
@@ -203,6 +209,7 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,6 +273,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
+	priv->enable_ssc = of_property_read_bool(dev->of_node,
+						 "realtek,ssc-enable");
 
 	phydev->priv = priv;
 
@@ -700,6 +709,37 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
 				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 }
 
+static int rtl8211f_config_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_ssc)
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
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_SYSCLK, 0x4f00);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable SSC */
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+				RTL8211F_SYSCLK_SSC_EN, RTL8211F_SYSCLK_SSC_EN);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -723,6 +763,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
+	ret = rtl8211f_config_ssc(phydev);
+	if (ret) {
+		dev_err(dev, "SSC mode configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	return rtl8211f_config_phy_eee(phydev);
 }
 
-- 
2.51.0


