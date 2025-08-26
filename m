Return-Path: <netdev+bounces-216824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BAB3551A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC5A7AC4F2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170A2F6561;
	Tue, 26 Aug 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SnaKPci0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5F2EC55E;
	Tue, 26 Aug 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192539; cv=none; b=k6wK1fnisLK9/I33Ujl5z8SdLz1ShceTR+lkJXmjdRJN6iOrbMrJsYkUkJqsUpNHTDWi+ZvxTPk1kY6IGjhVglP+ELAloL6yvwTV93FvETTxW4ZbNx1DpkgljUaFeYGHQ6v6r9hYXqSj9Yz/rRyfJYxP4wC40XhmZLJSFhSgSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192539; c=relaxed/simple;
	bh=S92BXshMpN8Ceo2qQGLk/WhwdK/P331CSIQlwAw9sz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX2eBC7PaBAdXtCX8KP9bpbqUKCoZU0fMaIQGx/VyoeGh4FyqW6/+fIBWgSVOeCSHugER+TbI9eNkumioTNrrrl/IoEp8lHq9NtO59NkXa59ao8RgbIiFUltTRmtV/g7rHYJfPFT53oNrVC4gkRVMrTGrTcciwRWXJpOz8nN43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SnaKPci0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756192536; x=1787728536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S92BXshMpN8Ceo2qQGLk/WhwdK/P331CSIQlwAw9sz8=;
  b=SnaKPci0uNRQ0EOPo7gha2htbDhwMy1+3O4mafHSSOfDGSRzo/TpnzAk
   DDYe4SJvYZpglzuZVaM9R1C6NX4pQrQv01dIJeGlUcpdUHfBa4hMms+gW
   sdQlyWJOEPaZu8wYFT503R27m71JcrbDPxsdKEv2VL0RXB9GUW63CVGAn
   AOiMh68ubGdlJZXO7jnPXwbg5gMKpfOwHFMFdRwMh1XKDgJ4XMFXmQWhv
   fQJA27Lgm0YVgzh3A2x9TpxdFVcs/rwHiQOMxMyJwLH359ZA0/VfrwM36
   QeRdSQUK/AmhfzpiPQuGhAyQZOW56yBhSjJuyfs/oDNa2mtsqNL4rwZR4
   w==;
X-CSE-ConnectionGUID: 2lrYuWnGTjajXVs08DIvmg==
X-CSE-MsgGUID: FJNXh2D2QYu2zyfKyjAK8w==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="45648555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 00:15:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 00:15:06 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 26 Aug 2025 00:15:04 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 2/2] net: phy: micrel: Add PTP support for lan8842
Date: Tue, 26 Aug 2025 09:11:00 +0200
Message-ID: <20250826071100.334375-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826071100.334375-1-horatiu.vultur@microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It has the same PTP IP block as lan8814, only the number of GPIOs is
different, all the other functionality is the same. So reuse the same
functions as lan8814 for lan8842.
There is a revision of lan8842 called lan8832 which doesn't have the PTP
IP block. So make sure in that case the PTP is not initialized.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 42af075894bec..ba4ed064a09e2 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -457,6 +457,9 @@ struct lan8842_phy_stats {
 
 struct lan8842_priv {
 	struct lan8842_phy_stats phy_stats;
+	int rev;
+	struct phy_device *phydev;
+	struct kszphy_ptp_priv ptp_priv;
 };
 
 static const struct kszphy_type lan8814_type = {
@@ -5786,6 +5789,17 @@ static int ksz9131_resume(struct phy_device *phydev)
 	return kszphy_resume(phydev);
 }
 
+#define LAN8842_PTP_GPIO_NUM 16
+
+static int lan8842_ptp_probe_once(struct phy_device *phydev)
+{
+	return __lan8814_ptp_probe_once(phydev, "lan8842_ptp_pin",
+					LAN8842_PTP_GPIO_NUM);
+}
+
+#define LAN8842_STRAP_REG			0 /* 0x0 */
+#define LAN8842_STRAP_REG_PHYADDR_MASK		GENMASK(4, 0)
+#define LAN8842_SKU_REG				11 /* 0x0b */
 #define LAN8842_SELF_TEST			14 /* 0x0e */
 #define LAN8842_SELF_TEST_RX_CNT_ENA		BIT(8)
 #define LAN8842_SELF_TEST_TX_CNT_ENA		BIT(4)
@@ -5793,6 +5807,7 @@ static int ksz9131_resume(struct phy_device *phydev)
 static int lan8842_probe(struct phy_device *phydev)
 {
 	struct lan8842_priv *priv;
+	int addr;
 	int ret;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -5800,6 +5815,7 @@ static int lan8842_probe(struct phy_device *phydev)
 		return -ENOMEM;
 
 	phydev->priv = priv;
+	priv->phydev = phydev;
 
 	/* Similar to lan8814 this PHY has a pin which needs to be pulled down
 	 * to enable to pass any traffic through it. Therefore use the same
@@ -5817,6 +5833,41 @@ static int lan8842_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Revision lan8832 doesn't have support for PTP, therefore don't add
+	 * any PTP clocks
+	 */
+	priv->rev = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+					 LAN8842_SKU_REG);
+	if (priv->rev < 0)
+		return priv->rev;
+	if (priv->rev == 0x8832)
+		return 0;
+
+	/* As the lan8814 and lan8842 has the same IP for the PTP block, the
+	 * only difference is the number of the GPIOs, then make sure that the
+	 * lan8842 initialized also the shared data pointer as this is used in
+	 * all the PTP functions for lan8814. The lan8842 doesn't have multiple
+	 * PHYs in the same package.
+	 */
+	addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				    LAN8842_STRAP_REG);
+	addr &= LAN8842_STRAP_REG_PHYADDR_MASK;
+	if (addr < 0)
+		return addr;
+
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, addr,
+				    sizeof(struct lan8814_shared_priv));
+	if (ret)
+		return ret;
+
+	if (phy_package_init_once(phydev)) {
+		ret = lan8842_ptp_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	lan8814_ptp_init(phydev);
+
 	return 0;
 }
 
@@ -5896,8 +5947,34 @@ static int lan8842_config_inband(struct phy_device *phydev, unsigned int modes)
 				      enable ? LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA : 0);
 }
 
+static void lan8842_handle_ptp_interrupt(struct phy_device *phydev, u16 status)
+{
+	struct kszphy_ptp_priv *ptp_priv;
+	struct lan8842_priv *priv;
+
+	priv = phydev->priv;
+	ptp_priv = &priv->ptp_priv;
+
+	if (status & PTP_TSU_INT_STS_PTP_TX_TS_EN_)
+		lan8814_get_tx_ts(ptp_priv);
+
+	if (status & PTP_TSU_INT_STS_PTP_RX_TS_EN_)
+		lan8814_get_rx_ts(ptp_priv);
+
+	if (status & PTP_TSU_INT_STS_PTP_TX_TS_OVRFL_INT_) {
+		lan8814_flush_fifo(phydev, true);
+		skb_queue_purge(&ptp_priv->tx_queue);
+	}
+
+	if (status & PTP_TSU_INT_STS_PTP_RX_TS_OVRFL_INT_) {
+		lan8814_flush_fifo(phydev, false);
+		skb_queue_purge(&ptp_priv->rx_queue);
+	}
+}
+
 static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
 {
+	struct lan8842_priv *priv = phydev->priv;
 	int ret = IRQ_NONE;
 	int irq_status;
 
@@ -5912,6 +5989,26 @@ static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	/* Phy revision lan8832 doesn't have support for PTP threrefore there is
+	 * not need to check the PTP and GPIO interrupts
+	 */
+	if (priv->rev == 0x8832)
+		goto out;
+
+	while (true) {
+		irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+						  PTP_TSU_INT_STS);
+		if (!irq_status)
+			break;
+
+		lan8842_handle_ptp_interrupt(phydev, irq_status);
+		ret = IRQ_HANDLED;
+	}
+
+	if (!lan8814_handle_gpio_interrupt(phydev, irq_status))
+		ret = IRQ_HANDLED;
+
+out:
 	return ret;
 }
 
-- 
2.34.1


