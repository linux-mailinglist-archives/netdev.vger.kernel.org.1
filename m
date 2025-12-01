Return-Path: <netdev+bounces-242881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1EC95A41
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 04:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F3DE342056
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2845619258E;
	Mon,  1 Dec 2025 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YLNXUHNH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6463CF;
	Mon,  1 Dec 2025 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559459; cv=none; b=HYRRyQvalSJjSRpYzV7YAr5i998IAY/vmzPeVd74A1/VBPzvMIsei4IfKEjQP54dxOFBKAbza7o6Opx1V0S7GkrF8A6xNZKyDJPHYqnJD4QDTuCosEp4m0vpkPylzFzSpJQBbsONzXRdbC40oSlyjnLdXRFbhTddN0qkRm5d8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559459; c=relaxed/simple;
	bh=L0Va06MhdT78s3CnnqaoAkGMxzlx0FOX+Lm4zGUg+/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlXB+oLdxK1DYIY0vdPGhy6scuD+ecoRWEwoRb3YoD5CFErsLRKwjvBpPMYHKbc/BiZCRoyb6yrZZjC3EM3Ykhi7+EMKwx0PFV0wLlCzqXk9FzelInMp2oZQd7kPxi/jZett2Qgny/pYk0wE4/4LvG4PksbsU8F2NFlXnt4oDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YLNXUHNH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764559457; x=1796095457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L0Va06MhdT78s3CnnqaoAkGMxzlx0FOX+Lm4zGUg+/Y=;
  b=YLNXUHNHaLA9HyIW6yztrAC1w7nERJr0BjIb2bzN9Jw0Fj5o4UfUfP6z
   AmiGBiGW6Q3keZ52Xg6lXICHLjTy4fKN7ABqgyKxO2CC6mlxTzfXN0PdW
   z5px+oHC1lhKW8I++NvUziCBSY6WXNx3DzZgK2ANxOJ5ICerbrOtWwc3L
   6vwKtYwiVjFpdfR2YdVSWxQcuRfnZNtmWm4rpQnAkpQE9S0Bv6foR0uuP
   p0TusQvO+KyjIhX0kI3wPP3sKwxkZyolR1CBAyXAVgDkH2gKXUzHliukl
   0H+dpzmx2rMAj7fN5UQrkNEV4O/vZQi8apBENwHglfRlmsGpxaBQiffS/
   A==;
X-CSE-ConnectionGUID: lRLhGS1/QleSDXijaJpBXQ==
X-CSE-MsgGUID: qsbBkjooTCGMvAGfXF3ZTg==
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="217188627"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 20:24:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 30 Nov 2025 20:23:52 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 30 Nov 2025 20:23:48 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 0/2] Add SQI and SQI+ support for OATC14 10Base-T1S PHYs and Microchip T1S driver
Date: Mon, 1 Dec 2025 08:53:44 +0530
Message-ID: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series adds Signal Quality Indicator (SQI) and enhanced SQI+
support for OATC14 10Base-T1S PHYs, along with integration into the
Microchip T1S PHY driver. This enables ethtool to report the SQI value for
OATC14 10Base-T1S PHYs.

Patch Summary:
1. add SQI and SQI+ support for OATC14 10Base-T1S PHYs
   - Introduces MDIO register definitions for DCQ_SQI and DCQ_SQIPLUS.
   - Adds genphy_c45_oatc14_get_sqi_max() to report the maximum SQI/SQI+
     level.
   - Adds genphy_c45_oatc14_get_sqi() to return the current SQI or SQI+
     value.
   - Updates include/linux/phy.h to expose the new APIs.
   - SQI+ capability is read from the Advanced Diagnostic Features
     Capability register (ADFCAP). If unsupported, the driver falls back
     to basic SQI (0–7 levels).
   - If SQI+ capability is supported, the function returns the extended
     SQI+ value; otherwise, it returns the basic SQI value.
   - Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features.
     https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
	
2. add SQI support for LAN867x Rev.D0 PHYs
   - Registers .get_sqi and .get_sqi_max callbacks in the Microchip T1S
     driver.
   - Enables network drivers and diagnostic tools to query link signal
     quality for LAN867x Rev.D0 PHYs.
   - Existing PHY functionality remains unchanged.

v2:
 - Updated cover letter description for better clarity.
 - Added oatc14_sqiplus_bits variable to cache the SQI+ capability in the
   phy device structure.
 - Fixed function description comment style warnings reported by the
   kernel test robot.

v3:
 - Reworked SQI/SQI+ update sequencing to address the issue,
   oatc14_sqiplus_bits being 0 until after
   genphy_c45_oatc14_get_sqi_max() is called.

v4:
 - Added the missing description for the  member
    to fix the kernel-doc warning.


Parthiban Veerasooran (2):
  net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
  net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs

 drivers/net/phy/mdio-open-alliance.h |  13 +++
 drivers/net/phy/microchip_t1s.c      |   2 +
 drivers/net/phy/phy-c45.c            | 137 +++++++++++++++++++++++++++
 include/linux/phy.h                  |  29 ++++++
 4 files changed, 181 insertions(+)


base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
-- 
2.34.1


