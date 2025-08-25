Return-Path: <netdev+bounces-216402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66398B33692
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E323B8CEC
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2EB285C83;
	Mon, 25 Aug 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CdkYg3xW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA5283FDF;
	Mon, 25 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103928; cv=none; b=tfE1VO6og4XYkQDzcpsS9zIqQfTtiwhaOc/SfPljs0zFVaI6u/0GmnwemK2LoCi/rXW8uCIufT1FSuesVYWupf3yOBZk35hD+o9uf0ZmsXvYX8VbnccqMX0+fxKgS+4kA0hpz4UC1UMzAvrTeQ5tCAE8R8GQMJCK60IjdZZ/N2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103928; c=relaxed/simple;
	bh=GDqmgHytA/OIUmAi3a+R2kiC3Oc9IvjzIFeK2FU1iLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHHlZyqmiJCfQrDQ2/HtkniEwuD+4iY7ZsXDJ6AVLSjHSm/jV0C99lYL6WenzihtIe26tih83pUiI/72afAg3yZj2l7R1ns/C671oabHpw3roRBzAMziELx09WbMgWdeRwz0CaMaM+Kto14WZ6b/k/fcaRU4H8lUD7jX+yKI+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CdkYg3xW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756103927; x=1787639927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDqmgHytA/OIUmAi3a+R2kiC3Oc9IvjzIFeK2FU1iLs=;
  b=CdkYg3xWZTC/DprUHbqpwP+nNT10kFUdCbJUIoHTaJpTAp9KytEAbcej
   PgwSyzRKgCpZ8+uyPtMSOTLT6/Kn/NUQYQtVyoMpw7+m9J1YojXjq/rE8
   q6EN+vqmG3HsAK+bUBaw0YlSttQJGWwddLfryC8Wc1vh4fwzn99/gawxU
   TOOuxg/kUMBBx1hwPPXbpwy/92J2v7gnGrxP8ceUqb7M4eN3L8mES4XHJ
   62K7LplPjZgQAgZHahfPnagGFeSKCnCe1bPCTS1f/HGh9ZVqvB2FLHozM
   vrmjOQO5wcFB63Iue3bkbc55yhAhmEVNH7s2HBMkH8EyHjcd8lyCRKLVT
   w==;
X-CSE-ConnectionGUID: S3yVFIolTS6rQW1/Z9824Q==
X-CSE-MsgGUID: gGtsIIg6TemuRw2+YgQZWw==
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="276991585"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2025 23:38:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 24 Aug 2025 23:38:19 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 24 Aug 2025 23:38:16 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: micrel: Introduce function __lan8814_ptp_probe_once
Date: Mon, 25 Aug 2025 08:31:35 +0200
Message-ID: <20250825063136.2884640-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825063136.2884640-1-horatiu.vultur@microchip.com>
References: <20250825063136.2884640-1-horatiu.vultur@microchip.com>
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
index 04bd744920b0d..42af075894bec 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4242,7 +4242,8 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	phydev->default_timestamp = true;
 }
 
-static int lan8814_ptp_probe_once(struct phy_device *phydev)
+static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
+				    size_t gpios)
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


