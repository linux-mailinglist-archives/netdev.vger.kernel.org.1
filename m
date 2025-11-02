Return-Path: <netdev+bounces-234901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A54C29120
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB1B188C676
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3B1A9F87;
	Sun,  2 Nov 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="j53wxHnE"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67933EC
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762097611; cv=none; b=obHSlMh/QZvY6biajsOHx3EIbEssUe7l/XybYTtgds8VFx+ZyoBQXMz5gKpBrYSMNthcwx9orJiIcjad0awJ+4NFtIhkisD/W7q+Q3t7x0FjAP/t6Z0DHL/JIhXLvXm5g2IxnwcS8dbDMokN6MWm2P9bE79RylbfDhQln12Ish0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762097611; c=relaxed/simple;
	bh=saBBTj9g2ex9hfdojJb5iTGm2W5ddhv20LFgkhkO4So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyXJmtaw16LTjkzLygGKyYHjaA7fBhcIC1cLqZ43zrzpGCGIQOpkxvhAgqWLfOFwq4+DB9ZBmc9+hWKoxrCBg5S6Oty6yPmGhE1yel7lTyPcoLuqv0zYkO37Ii/m2jgN2ztMpiqv2yXXDrmc3sJ6HB/rPajhPA1spp2qRSUhWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=j53wxHnE; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 41772 invoked from network); 2 Nov 2025 16:26:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1762097206; bh=Ub6hffTn7SrY8SyD9Bcnm2LUqrBBKdR9XtyLwFfdDjw=;
          h=From:To:Cc:Subject;
          b=j53wxHnEswuKtJRux3wr0dEs56XUk9XMviBrOGzggaumLNS5/bYGbd7+gMePvaTYT
           2OFNGlPyW/ktt/x4FjPmDWcb08CF0sgOiXRuiIFHiRA8DN5jiapykO2jGwR3ag5Fh8
           85IFqUcHyuSV3iwLijLyDhm1PmA2gpT4kLku7s/o92j5IiLgg2YtTDP7Uj+9KzY2iu
           Zf1N/R6td9nIHddjBp77FnBj3rET8a0jq13LX680uYC6ti9mbQ/aOqVIsSe/bpMR15
           xOQ07sy9Xdt4JDDZFqK8/hgkK28s8JFAXD0+lpquBNJwb3CmPWVbrwOUjcTWordEV6
           mgG1XH9vM73PQ==
Received: from 83.24.116.118.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.116.118])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 2 Nov 2025 16:26:46 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	olek2@wp.pl,
	daniel.braunwarth@kuka.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: add interrupt support for RTL8221B
Date: Sun,  2 Nov 2025 16:26:37 +0100
Message-ID: <20251102152644.1676482-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: e1cbfab1f7ca1df41dd3cdc76b647bde
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QSPc]                               

From: Jianhui Zhao <zhaojh329@gmail.com>

This commit introduces interrupt support for RTL8221B (C45 mode).
Interrupts are mapped on the VEND2 page. VEND2 registers are only
accessible via C45 reads and cannot be accessed by C45 over C22.

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
[Enable only link state change interrupts]
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 1fd4b6cf5c1e..417f9a88aab6 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -128,6 +128,11 @@
  */
 #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
+#define RTL8221B_VND2_INER			0xa4d2
+#define RTL8221B_VND2_INER_LINK_STATUS		BIT(4)
+
+#define RTL8221B_VND2_INSR			0xa4d4
+
 #define RTL8224_MII_RTCT			0x11
 #define RTL8224_MII_RTCT_ENABLE			BIT(0)
 #define RTL8224_MII_RTCT_PAIR_A			BIT(4)
@@ -1880,6 +1885,53 @@ static irqreturn_t rtl9000a_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtl8221b_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INSR);
+
+	return (err < 0) ? err : 0;
+}
+
+static int rtl8221b_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = rtl8221b_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		err = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INER,
+				    RTL8221B_VND2_INER_LINK_STATUS);
+	} else {
+		err = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    RTL8221B_VND2_INER, 0);
+		if (err)
+			return err;
+
+		err = rtl8221b_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = rtl8221b_ack_interrupt(phydev);
+	if (err) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -2054,6 +2106,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
@@ -2078,6 +2132,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-- 
2.47.3


