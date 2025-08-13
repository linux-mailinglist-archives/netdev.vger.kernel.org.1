Return-Path: <netdev+bounces-213200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CEB241B0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4E33B4BF7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B92D3EC3;
	Wed, 13 Aug 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c0sITMNi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCA2D3220;
	Wed, 13 Aug 2025 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066981; cv=none; b=EuUkPas4qLIkhFeFSsEivnqqJAQ0jehszNPuzTFfhEYsXAlSqcUVP7eUqvE87r0X1blN4oJxMbRXVFtFbOXVhxYHjlh+5xI3LynZfoj8L2L71UOL6E2OgIPvKyUnRLAC1azRdrUCM1KfVPDoxdlzxB9IygpExrRcACKz5y1EmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066981; c=relaxed/simple;
	bh=l1ElTEVwHPZeTTncvyL28cxslhmD1B/6sp2mtHzf13Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tsp0B/9w2X9Kb8P9SSOjGdumXqrYQbSuqyqkniQgQxvKnRY17I/AVg6/C4ka74U/7Pp92NOGRENS+WATilhEdjo5+Y9TNywgWiEnZBQbO0VC+eWg8PjtHXsk5AlEGzGtEO1MCVNmkwT3SGXKX/LQkxSq3lpK9yr7TrOFC16aEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c0sITMNi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755066980; x=1786602980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1ElTEVwHPZeTTncvyL28cxslhmD1B/6sp2mtHzf13Y=;
  b=c0sITMNiZG1Nk+47xFxkB6+QnrYZloZEzL2LfJa3Mc93uCulA6nNO5Vr
   PTaxftTpCOw5z2s6YPsj3bOrS3VWDS7IJwNKtoFOxYD8yAC6h0ENbhH/5
   xh/CqS5eIvQp+3jVDAigIJuhdrbHGV7cyg16e9f6qxAILcJeuh/dWiJRJ
   K8ivc/MI8qeefdLuvG7mvZVBuVO/0hVDmUi4ohuZMFAQQ0kn76gTBpl5Q
   XYZqysofowQWFs1PfNCr0LrUPgYMJWCsZuHwZ0o36lBtTD8/uTXuNI2pi
   71wt/57KGs1xRzxCdLstIak6auB3TQk6OI5N/CaDw5FEzgvKy7kPA9uAh
   Q==;
X-CSE-ConnectionGUID: HLS0dFJYR22/6mpwumLuLw==
X-CSE-MsgGUID: QSpSQje2QUG8nRp7aomYDQ==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276526646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2025 23:36:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 12 Aug 2025 23:35:53 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 12 Aug 2025 23:35:50 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 1/3] net: phy: micrel: Introduce lanphy_modify_page_reg
Date: Wed, 13 Aug 2025 08:30:42 +0200
Message-ID: <20250813063044.421661-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063044.421661-1-horatiu.vultur@microchip.com>
References: <20250813063044.421661-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As the name suggests this function modifies the register in an
extended page. It has the same parameters as phy_modify_mmd.
This function was introduce because there are many places in the
code where the registers was read then the value was modified and
written back. So replace all this code with this function to make
it clear.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 231 ++++++++++++++++++++-------------------
 1 file changed, 116 insertions(+), 115 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c6aacf7feb7b0..6f2448981bb4b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2838,6 +2838,27 @@ static int lanphy_write_page_reg(struct phy_device *phydev, int page, u16 addr,
 	return val;
 }
 
+static int lanphy_modify_page_reg(struct phy_device *phydev, int page, u16 addr,
+				  u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
+	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA, addr);
+	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL,
+		    (page | LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC));
+	ret = __phy_modify_changed(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA,
+				   mask, set);
+	if (ret < 0)
+		phydev_err(phydev, "Error: __phy_modify_changed has returned error %d\n",
+			   ret);
+
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
 static int lan8814_config_ts_intr(struct phy_device *phydev, bool enable)
 {
 	u16 val = 0;
@@ -2926,7 +2947,6 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	struct lan8814_ptp_rx_ts *rx_ts, *tmp;
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
-	int tx_mod;
 
 	ptp_priv->hwts_tx_type = config->tx_type;
 	ptp_priv->rx_filter = config->rx_filter;
@@ -2973,13 +2993,14 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_RX_TIMESTAMP_EN, pkt_ts_enable);
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_TIMESTAMP_EN, pkt_ts_enable);
 
-	tx_mod = lanphy_read_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD);
 	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
-		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
-				      tx_mod | PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+		lanphy_modify_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_,
+				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
 	} else if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ON) {
-		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
-				      tx_mod & ~PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+		lanphy_modify_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+				       PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_,
+				       0);
 	}
 
 	if (config->rx_filter != HWTSTAMP_FILTER_NONE)
@@ -3382,73 +3403,66 @@ static void lan8814_ptp_set_reload(struct phy_device *phydev, int event,
 static void lan8814_ptp_enable_event(struct phy_device *phydev, int event,
 				     int pulse_width)
 {
-	u16 val;
-
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG);
-	/* Set the pulse width of the event */
-	val &= ~(LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_MASK(event));
-	/* Make sure that the target clock will be incremented each time when
+	/* Set the pulse width of the event,
+	 * Make sure that the target clock will be incremented each time when
 	 * local time reaches or pass it
+	 * Set the polarity high
 	 */
-	val |= LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, pulse_width);
-	val &= ~(LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event));
-	/* Set the polarity high */
-	val |= LAN8814_PTP_GENERAL_CONFIG_POLARITY_X(event);
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG, val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG,
+			       LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_MASK(event) |
+			       LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, pulse_width) |
+			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event) |
+			       LAN8814_PTP_GENERAL_CONFIG_POLARITY_X(event),
+			       LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, pulse_width) |
+			       LAN8814_PTP_GENERAL_CONFIG_POLARITY_X(event));
 }
 
 static void lan8814_ptp_disable_event(struct phy_device *phydev, int event)
 {
-	u16 val;
-
 	/* Set target to too far in the future, effectively disabling it */
 	lan8814_ptp_set_target(phydev, event, 0xFFFFFFFF, 0);
 
 	/* And then reload once it recheas the target */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG);
-	val |= LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event);
-	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG, val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG,
+			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event),
+			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event));
 }
 
 static void lan8814_ptp_perout_off(struct phy_device *phydev, int pin)
 {
-	u16 val;
-
 	/* Disable gpio alternate function,
 	 * 1: select as gpio,
 	 * 0: select alt func
 	 */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
-	val |= LAN8814_GPIO_EN_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+			       LAN8814_GPIO_EN_BIT(pin),
+			       LAN8814_GPIO_EN_BIT(pin));
 
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
-	val &= ~LAN8814_GPIO_DIR_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+			       LAN8814_GPIO_DIR_BIT(pin),
+			       0);
 
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin));
-	val &= ~LAN8814_GPIO_BUF_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
+			       LAN8814_GPIO_BUF_BIT(pin),
+			       0);
 }
 
 static void lan8814_ptp_perout_on(struct phy_device *phydev, int pin)
 {
-	int val;
-
 	/* Set as gpio output */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
-	val |= LAN8814_GPIO_DIR_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+			       LAN8814_GPIO_DIR_BIT(pin),
+			       LAN8814_GPIO_DIR_BIT(pin));
 
 	/* Enable gpio 0:for alternate function, 1:gpio */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
-	val &= ~LAN8814_GPIO_EN_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+			       LAN8814_GPIO_EN_BIT(pin),
+			       0);
 
 	/* Set buffer type to push pull */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin));
-	val |= LAN8814_GPIO_BUF_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin), val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
+			       LAN8814_GPIO_BUF_BIT(pin),
+			       LAN8814_GPIO_BUF_BIT(pin));
 }
 
 static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
@@ -3563,61 +3577,59 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
 
 static void lan8814_ptp_extts_on(struct phy_device *phydev, int pin, u32 flags)
 {
-	u16 tmp;
-
 	/* Set as gpio input */
-	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
-	tmp &= ~LAN8814_GPIO_DIR_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+			       LAN8814_GPIO_DIR_BIT(pin),
+			       0);
 
 	/* Map the pin to ltc pin 0 of the capture map registers */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
-	tmp |= pin;
-	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO,
+			       pin,
+			       pin);
 
 	/* Enable capture on the edges of the ltc pin */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
 	if (flags & PTP_RISING_EDGE)
-		tmp |= PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0);
+		lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+				       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0),
+				       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0));
 	if (flags & PTP_FALLING_EDGE)
-		tmp |= PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0);
-	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
+		lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+				       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0),
+				       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0));
 
 	/* Enable interrupt top interrupt */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
-	tmp |= PTP_COMMON_INT_ENA_GPIO_CAP_EN;
-	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_COMMON_INT_ENA,
+			       PTP_COMMON_INT_ENA_GPIO_CAP_EN,
+			       PTP_COMMON_INT_ENA_GPIO_CAP_EN);
 }
 
 static void lan8814_ptp_extts_off(struct phy_device *phydev, int pin)
 {
-	u16 tmp;
-
 	/* Set as gpio out */
-	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
-	tmp |= LAN8814_GPIO_DIR_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
+			       LAN8814_GPIO_DIR_BIT(pin),
+			       LAN8814_GPIO_DIR_BIT(pin));
 
 	/* Enable alternate, 0:for alternate function, 1:gpio */
-	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
-	tmp &= ~LAN8814_GPIO_EN_BIT(pin);
-	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), tmp);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
+			       LAN8814_GPIO_EN_BIT(pin),
+			       0);
 
 	/* Clear the mapping of pin to registers 0 of the capture registers */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
-	tmp &= ~GENMASK(3, 0);
-	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO,
+			       GENMASK(3, 0),
+			       0);
 
 	/* Disable capture on both of the edges */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
-	tmp &= ~PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(pin);
-	tmp &= ~PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(pin);
-	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_CAP_EN,
+			       PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(pin) |
+			       PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(pin),
+			       0);
 
 	/* Disable interrupt top interrupt */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
-	tmp &= ~PTP_COMMON_INT_ENA_GPIO_CAP_EN;
-	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_COMMON_INT_ENA,
+			       PTP_COMMON_INT_ENA_GPIO_CAP_EN,
+			       0);
 }
 
 static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
@@ -3857,9 +3869,9 @@ static int lan8814_gpio_process_cap(struct lan8814_shared_priv *shared)
 	/* This is 0 because whatever was the input pin it was mapped it to
 	 * ltc gpio pin 0
 	 */
-	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_SEL);
-	tmp |= PTP_GPIO_SEL_GPIO_SEL(0);
-	lanphy_write_page_reg(phydev, 4, PTP_GPIO_SEL, tmp);
+	lanphy_modify_page_reg(phydev, 4, PTP_GPIO_SEL,
+			       PTP_GPIO_SEL_GPIO_SEL(0),
+			       PTP_GPIO_SEL_GPIO_SEL(0));
 
 	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_STS);
 	if (!(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(0)) &&
@@ -3906,13 +3918,10 @@ static int lan8814_handle_gpio_interrupt(struct phy_device *phydev, u16 status)
 
 static int lan8804_config_init(struct phy_device *phydev)
 {
-	int val;
-
 	/* MDI-X setting for swap A,B transmit */
-	val = lanphy_read_page_reg(phydev, 2, LAN8804_ALIGN_SWAP);
-	val &= ~LAN8804_ALIGN_TX_A_B_SWAP_MASK;
-	val |= LAN8804_ALIGN_TX_A_B_SWAP;
-	lanphy_write_page_reg(phydev, 2, LAN8804_ALIGN_SWAP, val);
+	lanphy_modify_page_reg(phydev, 2, LAN8804_ALIGN_SWAP,
+			       LAN8804_ALIGN_TX_A_B_SWAP_MASK,
+			       LAN8804_ALIGN_TX_A_B_SWAP);
 
 	/* Make sure that the PHY will not stop generating the clock when the
 	 * link partner goes down
@@ -4054,7 +4063,6 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
-	u32 temp;
 
 	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK) ||
 	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
@@ -4062,13 +4070,13 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 
 	lanphy_write_page_reg(phydev, 5, TSU_HARD_RESET, TSU_HARD_RESET_);
 
-	temp = lanphy_read_page_reg(phydev, 5, PTP_TX_MOD);
-	temp |= PTP_TX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_;
-	lanphy_write_page_reg(phydev, 5, PTP_TX_MOD, temp);
+	lanphy_modify_page_reg(phydev, 5, PTP_TX_MOD,
+			       PTP_TX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_,
+			       PTP_TX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_);
 
-	temp = lanphy_read_page_reg(phydev, 5, PTP_RX_MOD);
-	temp |= PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_;
-	lanphy_write_page_reg(phydev, 5, PTP_RX_MOD, temp);
+	lanphy_modify_page_reg(phydev, 5, PTP_RX_MOD,
+			       PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_,
+			       PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_);
 
 	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_CONFIG, 0);
 	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_CONFIG, 0);
@@ -4194,23 +4202,21 @@ static void lan8814_setup_led(struct phy_device *phydev, int val)
 static int lan8814_config_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *lan8814 = phydev->priv;
-	int val;
 
 	/* Reset the PHY */
-	val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
-	val |= LAN8814_QSGMII_SOFT_RESET_BIT;
-	lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET,
+			       LAN8814_QSGMII_SOFT_RESET_BIT,
+			       LAN8814_QSGMII_SOFT_RESET_BIT);
 
 	/* Disable ANEG with QSGMII PCS Host side */
-	val = lanphy_read_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG);
-	val &= ~LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA;
-	lanphy_write_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG, val);
+	lanphy_modify_page_reg(phydev, 4, LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
+			       0);
 
 	/* MDI-X setting for swap A,B transmit */
-	val = lanphy_read_page_reg(phydev, 2, LAN8814_ALIGN_SWAP);
-	val &= ~LAN8814_ALIGN_TX_A_B_SWAP_MASK;
-	val |= LAN8814_ALIGN_TX_A_B_SWAP;
-	lanphy_write_page_reg(phydev, 2, LAN8814_ALIGN_SWAP, val);
+	lanphy_modify_page_reg(phydev, 2, LAN8814_ALIGN_SWAP,
+			       LAN8814_ALIGN_TX_A_B_SWAP_MASK,
+			       LAN8814_ALIGN_TX_A_B_SWAP);
 
 	if (lan8814->led_mode >= 0)
 		lan8814_setup_led(phydev, lan8814->led_mode);
@@ -4241,29 +4247,24 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
 
 static void lan8814_clear_2psp_bit(struct phy_device *phydev)
 {
-	u16 val;
-
 	/* It was noticed that when traffic is passing through the PHY and the
 	 * cable is removed then the LED was still one even though there is no
 	 * link
 	 */
-	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
-	val &= ~LAN8814_EEE_STATE_MASK2P5P;
-	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
+	lanphy_modify_page_reg(phydev, 2, LAN8814_EEE_STATE,
+			       LAN8814_EEE_STATE_MASK2P5P,
+			       0);
 }
 
 static void lan8814_update_meas_time(struct phy_device *phydev)
 {
-	u16 val;
-
 	/* By setting the measure time to a value of 0xb this will allow cables
 	 * longer than 100m to be used. This configuration can be used
 	 * regardless of the mode of operation of the PHY
 	 */
-	val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
-	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK;
-	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL;
-	lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);
+	lanphy_modify_page_reg(phydev, 1, LAN8814_PD_CONTROLS,
+			       LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK,
+			       LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL);
 }
 
 static int lan8814_probe(struct phy_device *phydev)
-- 
2.34.1


