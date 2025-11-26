Return-Path: <netdev+bounces-241852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE801C89648
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CC3B3A8D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6282FB990;
	Wed, 26 Nov 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lNrHdVBu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830002EC0B4;
	Wed, 26 Nov 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154236; cv=none; b=Q9ufC+8FNQElGdH/rZGp0sU807/TeoBgZknUBvbChwyQrSP5+gRuQ6gJvvuSP6lo8kulq8p+YOWlf0DWhjMFFI0ynXTUxHHsJNRn0jIxM3CLYoouCUGQstRNoxm8q+HvuOi6UqucUshT6IBVZ7uo0FBldTmusJv1QLyhBwT5OPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154236; c=relaxed/simple;
	bh=0/1y/L8pz+iEuUbsDoZxVzLm38EVGsFic9hBlnwPFLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQzdCAvaWjGcTVLgcRB0EkqrdOF4Jy6P3AnoXgnQWL2aJvgQrgFjv5/lpaaeyq2qc9+1d7ZkCZW1hvwTVj8bfUAfv1bY5qdO1+6GYSiOTAGTTI82EvNcK/SJU74whFuPPLLwtF/3r1pZrpuL+oAdaXJqvOpXkV2M83xQCkXdTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lNrHdVBu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764154234; x=1795690234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0/1y/L8pz+iEuUbsDoZxVzLm38EVGsFic9hBlnwPFLE=;
  b=lNrHdVBupdn5h64IGDxzvEj16YGTIpvsKko7XHYK5EHpLZTE+2dpK75S
   fGV1iEFRDQM1mtz678th+CSGpm1a6xueZqiZv8htdELDFgFLqlEOq0gVU
   GODD1F/8XuJxgQ3VLw8b03gAu9UwjycP2WI2B3ZiWddmN1XUuW4cBQjLL
   rAZwdRe+DHM5+b3/Ha/1Q7SPuScadgo4qr9BLkrqmYHjZhWlT+xWGXgq/
   SE8XhakfS3wX96G7WgqY4+xqXF9MX4BHcJh8b6mSoT4B6LWzvuHNL+zBE
   0TeSAyfsHjvM7VUqOiHzXlTDdSoRGmReGu8w2SqkMTDc0lg4rAbv0KW0w
   g==;
X-CSE-ConnectionGUID: tMjMCUkbTjK0Gq0hYCWfYA==
X-CSE-MsgGUID: qLMtXWzvToiOABUMYwAOhw==
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="50191393"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Nov 2025 03:50:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 26 Nov 2025 03:50:03 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 26 Nov 2025 03:50:00 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 0/2] Add SQI and SQI+ support for OATC14 10Base-T1S PHYs and Microchip T1S driver
Date: Wed, 26 Nov 2025 16:19:53 +0530
Message-ID: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
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


Parthiban Veerasooran (2):
  net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
  net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs

 drivers/net/phy/mdio-open-alliance.h |  13 +++
 drivers/net/phy/microchip_t1s.c      |   2 +
 drivers/net/phy/phy-c45.c            | 137 +++++++++++++++++++++++++++
 include/linux/phy.h                  |  28 ++++++
 4 files changed, 180 insertions(+)


base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
-- 
2.34.1


