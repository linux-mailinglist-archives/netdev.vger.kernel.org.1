Return-Path: <netdev+bounces-218294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF852B3BCDA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A44FA4527E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4931A041;
	Fri, 29 Aug 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FrYKDMLt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002E1EE7DD;
	Fri, 29 Aug 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475555; cv=none; b=YomKtXlWTpVzOiu6qLQVktpWdzGI9PFkftk72WVCL16iatUSqHwzmSBWZBAv7cQtWgctW0s26TKb1iaqbam+4Vk4Zsf28A+td/caVZJ6f/T7p/GaS2pedcYc7Ogn3HZ4K/F4rp4wmaM3Z1//nWCkaFXyZPKUkFmDMyFrIO1xREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475555; c=relaxed/simple;
	bh=EqgH5I3zjwnAJWWJN8/p/ltYY9bIFWSlIx4TncVSGu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKUUDf5u+k7u1Rr55TKEq1DU5ipc45B4o0hgQcpkWvTBZVExQxXELMlyk+UGcvniTVJkdQSNuTh99lBqFvQ/vx3uTLvImhRNyAlRmqMZ8NcGkJ+pQSvhl6qK5M9KFfut96heRk9pzQO1nnPf40TMR18HEAbgWtujYPQ12su/vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FrYKDMLt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756475555; x=1788011555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqgH5I3zjwnAJWWJN8/p/ltYY9bIFWSlIx4TncVSGu8=;
  b=FrYKDMLtWclDrG5pdMKwr6guCLvVzalrg5M6jxdzhdKQzQ8QukLDRVin
   Kfb696H29RJ76QgrQBezcl6EzV8wnQYutttbw8jTmcbgujbQ3m/oy/6ap
   UokMg1zg4Mrmam7AtzeyIVDLGnCFinpUlDm+8ru4gr0bp4MWa+H2myN/f
   WN47atHHHfpjguzQ/kHQ/3ZqvOBtNlrpAr9ubfjDSkFQKt5208L0QRPHT
   qHEq3RnfhwZCPPCnu0Las5XH4G+FMEoSNncAcJWnr2todJKNrlNsviJbr
   WwDOYamYft6TAZ5g9G57svt7+fP710sbvhIhOY7bbclz6frBDutMiS7eP
   w==;
X-CSE-ConnectionGUID: Ukm2saoeQeulINh9ZfYFRw==
X-CSE-MsgGUID: MYXhX0t6RYKmvHXOHtpeRA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="277201925"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 06:52:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 06:52:32 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 06:52:30 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 1/2] net: phy: micrel: Introduce function __lan8814_ptp_probe_once
Date: Fri, 29 Aug 2025 15:48:35 +0200
Message-ID: <20250829134836.1024588-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce the function __lan8814_ptp_probe_once as this function will be
used also by lan8842 driver. This change doesn't have any functional
changes.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 04bd744920b0d..9a90818481320 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4242,7 +4242,8 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	phydev->default_timestamp = true;
 }
 
-static int lan8814_ptp_probe_once(struct phy_device *phydev)
+static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
+				    int gpios)
 {
 	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
 
@@ -4250,18 +4251,18 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	mutex_init(&shared->shared_lock);
 
 	shared->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
-						LAN8814_PTP_GPIO_NUM,
+						gpios,
 						sizeof(*shared->pin_config),
 						GFP_KERNEL);
 	if (!shared->pin_config)
 		return -ENOMEM;
 
-	for (int i = 0; i < LAN8814_PTP_GPIO_NUM; i++) {
+	for (int i = 0; i < gpios; i++) {
 		struct ptp_pin_desc *ptp_pin = &shared->pin_config[i];
 
 		memset(ptp_pin, 0, sizeof(*ptp_pin));
 		snprintf(ptp_pin->name,
-			 sizeof(ptp_pin->name), "lan8814_ptp_pin_%02d", i);
+			 sizeof(ptp_pin->name), "%s_%02d", pin_name, i);
 		ptp_pin->index = i;
 		ptp_pin->func =  PTP_PF_NONE;
 	}
@@ -4271,7 +4272,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	shared->ptp_clock_info.max_adj = 31249999;
 	shared->ptp_clock_info.n_alarm = 0;
 	shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
-	shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
+	shared->ptp_clock_info.n_pins = gpios;
 	shared->ptp_clock_info.pps = 0;
 	shared->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
 						       PTP_FALLING_EDGE |
@@ -4318,6 +4319,12 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8814_ptp_probe_once(struct phy_device *phydev)
+{
+	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
+					LAN8814_PTP_GPIO_NUM);
+}
+
 static void lan8814_setup_led(struct phy_device *phydev, int val)
 {
 	int temp;
-- 
2.34.1


