Return-Path: <netdev+bounces-272256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCv8LRCgxWkZAQUAu9opvQ
	(envelope-from <netdev+bounces-272256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:07:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B333BAE7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB4FD3036A2A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A722388385;
	Thu, 26 Mar 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DWjr/1zy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gKRjrb9k"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7F3A453E;
	Thu, 26 Mar 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559245; cv=none; b=g4noIONahRIvodBKWnrRRvoMnVC5qFEx+q96Hbi9LLuHjFLVx/ox4Af3Fnx1fKhbcRVCuncJ7ZvVM97QUqfaaioe9nxptHfKvozVNLqXHebHwJH4b3eQZ+18ApInAr0c2tNt7IidfT4CSDBM8qzUplMG+uf/iCK5p7m5oSV8wUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559245; c=relaxed/simple;
	bh=mzEifaggiR7QkeULQQmpXr3u9WdRy4KiACyC2UiEOW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tScFUQwyGqd9ydt2aafW4fVBLemjjEkVj55oDeLREKUrOnRAkPPBMqWlCc+uyBKDid4RlIiZRdjNbWynNGQwUHGCcU3DibKZFvVvf7Zrk6AYe/CzL6B6fJnRCgM/Y7jZOsNp5JflS4mc9LOO9tFXvP2Hix06qysnlGr80LJ9Ewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DWjr/1zy; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gKRjrb9k; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fhbvG0X36z9tyP;
	Thu, 26 Mar 2026 22:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIfAWFSpDQzUN4yS5FNmf/onB8IkyWgXnQcXrwWoKl8=;
	b=DWjr/1zyJtlgUNeYjAE0895YqY2P8+2fn20KrjHIrFqJRl8+av/5f+JcJuMvXIui+CRAwT
	G/dmYHFpJDJDW+MEMUwYiIXChVtRyHiXIn5UDwbIH+zZYs6vbHJbAqL7RmKvbSZBj60P2z
	kLy702dUSRINZBhhcXhYrCFh61xyN3r7cvXkUlYRd6mton11Xj28tLJTTBmDGMBzcynC2w
	kM2KNKwGpCm0BcuDqZ2GH8ujHNiwqKIqkJuKbCilI0f1fq8gBEPrBu9J98BEIy0MzL0sY4
	GUp5RtdvjpmvLb1bVps/IRcoZR2/2A2HWhuRucW7xGPWc7AdUR5K90qDGmFT2A==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIfAWFSpDQzUN4yS5FNmf/onB8IkyWgXnQcXrwWoKl8=;
	b=gKRjrb9kaBU0EglRvG48MZmOYG8ZJBm/Nwj4TiTN8MKGATMxCWDLjA/uySjAe+stSs6KkU
	txlAQqNolI5QVCsMpOlS794aVJ8KhV2ZfLLxxJF3acm0EWNA3ZUMhQkBbFaKdc9MqUExmj
	E8sqJ41g0Uox5MVsTQcqCSdb81CrzqMKwD+7T79Vd7iLn0HWpwY0K29xdpUggtp2Nq0ltU
	XOJxjAcIDDdeK5f2YATNyY/46LQLYQ7lxaHHb4ovqLcWhQfkse1y54E1hU6FbRO/5OcpPi
	BZ3lYfLP3fAbkBPwMgMYyzplG1sachGWYPrbZzOqTFNrTlaC7IDp+WeyMdh2iQ==
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
Subject: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to enable SSC
Date: Thu, 26 Mar 2026 22:06:35 +0100
Message-ID: <20260326210704.58912-3-marek.vasut@mailbox.org>
In-Reply-To: <20260326210704.58912-1-marek.vasut@mailbox.org>
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: owu1h59qsz7szt7kcz4q6xtm77iouneo
X-MBO-RS-ID: 4c9c7a0cd0a8bccda06
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-272256-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F3B333BAE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
V3: Update RTL8211FVD PHYCR2 comment to state this PHY has PHYCR2 register,
    but SSC configuration is not supported due to different layout.
V4: - Perform all SSC configuration before disabling CLKOUT
    - Perform all SSC configuration in the same order as in the SSC appnote
    - Rebase on current next, retest using spectrum analyzer again
V5: s@SCC@SSC@ typo
---
 drivers/net/phy/realtek/realtek_main.c | 131 +++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605bd..0b5d35841fdd4 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -75,10 +75,18 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
 
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
@@ -215,6 +223,9 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_clkout_ssc;
+	bool enable_rxc_ssc;
+	bool enable_sysclk_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -278,6 +289,12 @@ static int rtl821x_probe(struct phy_device *phydev)
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
 
@@ -707,6 +724,108 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
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
+	/* RTL8211FVD has PHYCR2 register, but configuration of CLKOUT SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	/* Unnamed registers from EMI improvement parameters application note 1.2 */
+	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SSC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * Enable CLKOUT SSC using PHYCR2 bit 7 , this step is missing from the
+	 * EMI improvement parameters application note 1.2 section 2.3
+	 */
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2, RTL8211F_CLKOUT_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SSC enable failed: %pe\n", ERR_PTR(ret));
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
+	/* RTL8211FVD has PHYCR2 register, but configuration of RXC SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
+	if (ret < 0) {
+		dev_err(dev, "RXC SSC configuration failed: %pe\n", ERR_PTR(ret));
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
+	/* RTL8211FVD has PHYCR2 register, but configuration of SYSCLK SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_SYSCLK, 0x4f00);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SSC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable SSC */
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2, RTL8211F_SYSCLK_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SSC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -723,6 +842,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = rtl8211f_config_rxc_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_sysclk_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_clkout_ssc(phydev);
+	if (ret)
+		return ret;
+
 	ret = rtl8211f_config_clk_out(phydev);
 	if (ret) {
 		dev_err(dev, "clkout configuration failed: %pe\n",
-- 
2.53.0


