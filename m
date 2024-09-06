Return-Path: <netdev+bounces-125882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93496F1B7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276DA287E2F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E01CB30C;
	Fri,  6 Sep 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nGNLv8GX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E201C9ED5;
	Fri,  6 Sep 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619170; cv=none; b=rlEI9nF6I2i33a6U85hUDy7JWvN1gCLyRWh29BZOBH6swCMa8ylrfeqz1K8eCzOLSRDDoZZ0BWrkUXXIS0gHmI1/CT/V/R/nfejq6PZLL3sKFpJlZLesZA5Yd5tl5IqUKMS0/a5kGNq2kiFGwKO8y8vdUun6vpU/XfBiOCIOlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619170; c=relaxed/simple;
	bh=uv1BaiAsIImW8JB4J/uVRynwlwyWgQEuxAt4sMlJdPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDWtjMBLpQn23mTvOjmExzQ4JZkTvs4wZ60An9O+M0GJV2z5Qy2CPVmQJ9zox0eftuOoM9UoO1l9+zd2ZCbbelJEpjnTeJMdW82blQDbYPehsky+B0eKywa5EDIRYepgq7ho29e4OH52y8cy5PGXhh8qTqnBUUeigzQPLS4tOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nGNLv8GX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725619168; x=1757155168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uv1BaiAsIImW8JB4J/uVRynwlwyWgQEuxAt4sMlJdPQ=;
  b=nGNLv8GXfVNhLx1AEtP2effJpaEHFHCnGecaHR2MBV/yd+pqFEFcHDAW
   bQRPT5/CJn1uMN6F1RpYhvF+eIoJ65stJ+rb4gk+xK+GKl248pO8hDoqC
   BeYIzeuAUeadHoUqhXc1uq8hHtV9LJyD813GyjmdH9V531QHvx3FuK2Fc
   FjBcY8VvRc4alsNr4InfIOlVnfeCx9jZHxU0jXOAMZUeqYNFoYh9NbSRG
   yP6rTRLRoQHKDjiCFe/Au6NrZygId3Ypn4aIHXz3BE9Q1CNGTYNuQIVQn
   i+/SSAyNG2eelyX/NqI/AYmxdXQ2LUBkNJnfUISGAEWKARaBaajbdVomW
   Q==;
X-CSE-ConnectionGUID: ARynwNKwTMmFStNWNTzFxw==
X-CSE-MsgGUID: MpwQ9rrEQS23ahSB+pz/IQ==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34530672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 03:39:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 03:39:19 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 03:39:14 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V6 3/5] net: lan743x: Create separate Link Speed Duplex state function
Date: Fri, 6 Sep 2024 16:05:09 +0530
Message-ID: <20240906103511.28416-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
References: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Create separate Link Speed Duplex (LSD) update state function from
lan743x_sgmii_config () to use as subroutine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
============                                                                    
V5 -> V6:
  - No change
V4 -> V5:
  - No change
V3 -> V4:
  - No change
V2 -> V3:
  - No change
V1 -> V2:                                                                       
  - No change                                                                  
 
 drivers/net/ethernet/microchip/lan743x_main.c | 75 +++++++++++--------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index ce1e104adc20..b4a4c2840a83 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -992,6 +992,42 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
 	return ret;
 }
 
+static int lan743x_get_lsd(int speed, int duplex, u8 mss)
+{
+	int lsd;
+
+	switch (speed) {
+	case SPEED_2500:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_2500_SLAVE;
+		else
+			lsd = LINK_2500_MASTER;
+		break;
+	case SPEED_1000:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_1000_SLAVE;
+		else
+			lsd = LINK_1000_MASTER;
+		break;
+	case SPEED_100:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_100FD;
+		else
+			lsd = LINK_100HD;
+		break;
+	case SPEED_10:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_10FD;
+		else
+			lsd = LINK_10HD;
+		break;
+	default:
+		lsd = -EINVAL;
+	}
+
+	return lsd;
+}
+
 static int lan743x_sgmii_mpll_set(struct lan743x_adapter *adapter,
 				  u16 baud)
 {
@@ -1179,42 +1215,21 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
-	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
 	bool status;
 	int ret;
 
-	switch (phydev->speed) {
-	case SPEED_2500:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_2500_MASTER;
-		else
-			lsd = LINK_2500_SLAVE;
-		break;
-	case SPEED_1000:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_1000_MASTER;
-		else
-			lsd = LINK_1000_SLAVE;
-		break;
-	case SPEED_100:
-		if (phydev->duplex)
-			lsd = LINK_100FD;
-		else
-			lsd = LINK_100HD;
-		break;
-	case SPEED_10:
-		if (phydev->duplex)
-			lsd = LINK_10FD;
-		else
-			lsd = LINK_10HD;
-		break;
-	default:
+	ret = lan743x_get_lsd(phydev->speed, phydev->duplex,
+			      phydev->master_slave_state);
+	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-			  "Invalid speed %d\n", phydev->speed);
-		return -EINVAL;
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
 	}
 
-	adapter->sgmii_lsd = lsd;
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
 	ret = lan743x_sgmii_aneg_update(adapter);
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-- 
2.34.1


