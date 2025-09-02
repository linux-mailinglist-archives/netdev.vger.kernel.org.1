Return-Path: <netdev+bounces-219136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B641B4010D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CB17BBA00
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D2299AAF;
	Tue,  2 Sep 2025 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HkwvRV+9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3F28DF0B;
	Tue,  2 Sep 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816897; cv=none; b=PkTtstD+IyRteAjxviuKQU+XJNsGTXwYN9lAEDIj8cuBfjNOdv8DjVqvH9qLwz7nvh0obUpASfAtHmjya/4qyN9/2HDtwxEYZKu0dHleXq8fdFCi/fxAtYq3O5nbLKG5dKgu+SeHZg6Z+ppNAWMYniWgsBIKjcxmpShBllyyIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816897; c=relaxed/simple;
	bh=sSJfDeCErHLMizbHbg7+od45H5c6ZYzDEqhMLgOvb6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlaWgcY87zjh4susLavNDJS0AvAMfXIm3fzaYKJbHJ4tDCbKMm3hDvvBDChKRKNUpSdoYFeBqovXp9hxSDVNiBD2yivqo3Vw1aAKdPOpoPhnSJN6y9JZxZM2bXB6yfaDCrYeXF/7p59EmEqicexI/bDs48NbyaQiHuiovfHNQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HkwvRV+9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756816895; x=1788352895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSJfDeCErHLMizbHbg7+od45H5c6ZYzDEqhMLgOvb6U=;
  b=HkwvRV+9CuLBJGCiozZUk4rmmx78j+oDQPyT6k0d5Y3fe5aD0Mh1W03c
   cGfK0Ov242EzDY/q9M3aVwD0awX0kzb036XMcT2T5YszeZPi4GwkPL9RM
   ri7AWaPbS1ri2tCUjD1Aj0+Euyi3RjAP+T1W0LA2ba/bZUjWijtIkR3Bx
   7pDAPiX2OBv2STrQepOq73NL1IJ+UBcS+QLaPA79kn4HFSmbqYqXyrK62
   n4DxiyQFAZ488X+AZV4Cl13UfTOG8QL/891ldxbr7q5UdNVyKJJPYi3mb
   /Uytfsw5OK1H7Z89zJlJNgi6rWUMJP+xo7TdEq1Q6zYn576FcYSKfzosW
   w==;
X-CSE-ConnectionGUID: uSbTBh14QEunAdjSx76qwQ==
X-CSE-MsgGUID: iEtAVDooQd+SHnYaeuKS1Q==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="213345454"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 05:41:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 05:41:31 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 05:41:29 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>, <kory.maincent@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v7 1/2] net: phy: micrel: Introduce function __lan8814_ptp_probe_once
Date: Tue, 2 Sep 2025 14:18:31 +0200
Message-ID: <20250902121832.3258544-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902121832.3258544-1-horatiu.vultur@microchip.com>
References: <20250902121832.3258544-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce the function __lan8814_ptp_probe_once as this function will be
used also by lan8842 driver which has a different number of GPIOs
compared to lan8814. This change doesn't have any functional
changes.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
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


