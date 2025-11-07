Return-Path: <netdev+bounces-236691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB2C3EF72
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD83B3B09A2
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5130FC38;
	Fri,  7 Nov 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0SkXv3R0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9430FC19
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504156; cv=none; b=BOsPpwVcnZT/sAvCMRCZflwI3HeEJRomsfiKtfoCp/W/5iK7DdCdLFEmVSETtzo5+mLtM61ofAVa5jOuJL+3SHAapxf6JpgB8k0yzmvZvRteqYapb5SDpwMDTL7j4B9fY1e7pXPXyrXx7iSwZ521msQzIX1ntYcGu1rYHbRJF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504156; c=relaxed/simple;
	bh=o2k+SDyDNZuwm0/l3mzXDojbsFdwOYhb9C1qnO8TfrU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KxAvnA4mB6w9VZibz/XX7qdIBYK28OGAnJl5QBRgU351o4JfgdObQ7o1PWTqT8nCDpJ56IFdc5bdN87eKSqeu7EGBpuZ1UzU5+6y6OpBP7xrF5IDbm4heN9sRYCctCIA01ZE/SSbvlT8vu1ffVo+In6YNQBIy/gpvjwZWlXh0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0SkXv3R0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w3jBS0tqT/QRg8rL1xz4Merr6UrN32I0S/6JlGlut68=; b=0SkXv3R0vlJHj5NRJb97peBUIk
	RZt2eK40J6dFiPrKFHP43tFZ4UzH8V45A1H8/MB8myPwwBxUchPsaVJOT4KJh0nuCBH5nZ4nJ9BHn
	XfHtXMTh0biTWW4ijGalP/pIimRzSl2Czx1Y1bprvWug4cBEeovUagKpsdzVssk8oEkXcwVCKCb1Z
	Ba99IipfE2tLZ3qimuo5iT174X9CymCw5GeD4QMU+6IO7x7KzGKIqF/Ul4N4yAGtjNALcyognSiAE
	DCnunqKucZUpLgcq/vjuRNXe3+zbGFgi1d6VHNu4IScTzNvLDYs+N8oO8hifUo2k9rHuHoLJ8bk4v
	mdK3VVGg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41494 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vHHqA-000000006A2-3SPM;
	Fri, 07 Nov 2025 08:29:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vHHq8-0000000DjrJ-2NRK;
	Fri, 07 Nov 2025 08:29:00 +0000
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 06/11] net: stmmac: ingenic: use
 stmmac_get_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vHHq8-0000000DjrJ-2NRK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Nov 2025 08:29:00 +0000

Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
phy_intf_sel value, validate the result against the SoC specific
supported phy_intf_sel values, and pass into the SoC specific
set_mode() methods, replacing the local phy_intf_sel variable. This
provides the value for the MACPHYC_PHY_INFT_MASK field.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 55 ++++++++++++-------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 6680f7d3a469..79735a476e86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -64,28 +64,27 @@ struct ingenic_soc_info {
 	enum ingenic_mac_version version;
 	u32 mask;
 
-	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
+	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
+
+	u8 valid_phy_intf_sel;
 };
 
-static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			       u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
 		break;
 
 	case PHY_INTERFACE_MODE_GMII:
-		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -93,7 +92,6 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		phy_intf_sel = PHY_INTF_SEL_RGMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
 		break;
 
@@ -110,7 +108,8 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 
@@ -129,15 +128,14 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
 }
 
-static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -153,16 +151,15 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -178,17 +175,16 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
 			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -197,8 +193,6 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 		val = 0;
-		phy_intf_sel = PHY_INTF_SEL_RGMII;
-
 		if (mac->tx_delay == 0)
 			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
 		else
@@ -229,10 +223,21 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 {
 	struct ingenic_mac *mac = bsp_priv;
-	int ret;
+	phy_interface_t interface;
+	int phy_intf_sel, ret;
 
 	if (mac->soc_info->set_mode) {
-		ret = mac->soc_info->set_mode(mac->plat_dat);
+		interface = mac->plat_dat->phy_interface;
+
+		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
+		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
+		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
+			dev_err(mac->dev, "unsupported interface %s\n",
+				phy_modes(interface));
+			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
+		}
+
+		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
 		if (ret)
 			return ret;
 	}
@@ -309,6 +314,9 @@ static struct ingenic_soc_info jz4775_soc_info = {
 	.mask = MACPHYC_TXCLK_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = jz4775_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_GMII_MII) |
+			      BIT(PHY_INTF_SEL_RGMII) |
+			      BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1000_soc_info = {
@@ -316,6 +324,7 @@ static struct ingenic_soc_info x1000_soc_info = {
 	.mask = MACPHYC_SOFT_RST_MASK,
 
 	.set_mode = x1000_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1600_soc_info = {
@@ -323,6 +332,7 @@ static struct ingenic_soc_info x1600_soc_info = {
 	.mask = MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x1600_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1830_soc_info = {
@@ -330,6 +340,7 @@ static struct ingenic_soc_info x1830_soc_info = {
 	.mask = MACPHYC_MODE_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x1830_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x2000_soc_info = {
@@ -338,6 +349,8 @@ static struct ingenic_soc_info x2000_soc_info = {
 			MACPHYC_RX_DELAY_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x2000_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RGMII) |
+			      BIT(PHY_INTF_SEL_RMII),
 };
 
 static const struct of_device_id ingenic_mac_of_matches[] = {
-- 
2.47.3


