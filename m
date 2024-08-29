Return-Path: <netdev+bounces-123085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94070963A13
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288D2B22253
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB21514FB;
	Thu, 29 Aug 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dmpII/D4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3414A614;
	Thu, 29 Aug 2024 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910964; cv=none; b=H/pWdhM0omeHR495Ca7JiH2mYZ/P/BA+HqJSbnX2YVuT9Y1eBLzL203X2FSBlcWR/7yufzIoLL5M769GVhHAfaTkN2vNjKwk6LLCtD9l3KPGy1I0Z7F5uC8Nj2VnbT/9XxR3KgqdM8RNTypbSG6LGlHXAPoRFue/7rSd35NaVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910964; c=relaxed/simple;
	bh=sg6IqIT3QcAqXFdlSqjApvkm1f7yjny/b+aThUtqubI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxX+9drkBrircKbR0CBrlMGG2LXtW/SdOhTV0ers8oyJOs721x5K3TCKX89gqxj39Y/LmdHMxvuZybpLVkMLrk2YCisW4n5XWp6Nvz/8BLFKcNcDtTNJVDUsXibMTzvMQpVKgXe0fo9TVlCcZ6mdV3mmY0CUGmtB0l0El9tHCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dmpII/D4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910963; x=1756446963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sg6IqIT3QcAqXFdlSqjApvkm1f7yjny/b+aThUtqubI=;
  b=dmpII/D4+iUVCdOQP/HFFPILyiQMPIioxhMe6JNk6a2RRr0rcywHp7Ga
   XI9IPmKDos6HC0D7+hXqRh3LVgRaFN7+cG8vIuGsEGUCqCl+RQlFeMjOK
   lpxXDMGpZGtpuu1Y7R1GMc7MiNL8K/3v2KWZuV+k+Whb3ZIMLRyD4Uc4l
   +ZpyD4Io70vGLPkK3FXESP+S/dMZzYopdtvAr5d7fqNVjWR6+nvV1Ekli
   runiseHXlGOmVq6qI9aZ3vqyYTm/0WBkOW8G2dFNP8JWhAdgOFUvgyZgp
   DoKah73fvRFNKg9OfukbzxVNAG6qnwUrKrvqzzBuLfDCXZaPIEgI5OsJw
   A==;
X-CSE-ConnectionGUID: 2MQclz5sT/+LITt4o2qSTg==
X-CSE-MsgGUID: 8ihwvZtzSge1nZwS2spPmw==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="261978660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:56:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:36 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:31 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 3/5] net: lan743x: Create separate Link Speed Duplex state function
Date: Thu, 29 Aug 2024 11:21:30 +0530
Message-ID: <20240829055132.79638-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
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


