Return-Path: <netdev+bounces-238325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A52C574A1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA83466CD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7A34D3A9;
	Thu, 13 Nov 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PeKtV/SG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491D34AAF9;
	Thu, 13 Nov 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034767; cv=none; b=E83o2PxcsPBRlxqipViiNFa/wWGEeu13QVKGWcwtNw+mmEk8IkHyQ3r80JifIWdT03ifuxGhqbN6ih7myXuvARtq7skezYe3i9cdlVEXoHsqM/Fi9f8O7ia6ODtti/6hhnEio2ssBgks5UzUXrNIiYTjo0BKvt9EREE14mi+wD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034767; c=relaxed/simple;
	bh=Awiqz2gu0Ah82+m/BLSWEZzsIgqVt80s2wCjgM/rli4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRZOrq2+35lm2XjjMpeIHg/Zg/IITHzafZDCncBAYfPZ0ze7pa+kapl5Awfy3r5NRWeLb+bel+MYu0T7pAfE30mKhlKjTXmB4Q3gphYDiO6coyaWU26r8SVHTD8831O64BsCezZtDG3/6HOmgJk+jqjByyj7ngUTyeAHyvmhkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PeKtV/SG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763034765; x=1794570765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Awiqz2gu0Ah82+m/BLSWEZzsIgqVt80s2wCjgM/rli4=;
  b=PeKtV/SGjSt0ciibY0uG17H3Fn8EiUsslNd6QY0OQkdjFh7RqBAESFem
   uZz3glhfZ2diRQdPCWz9+uEDqo9uukeaCuuJmq6RiYpw3jeBUC0fGEi31
   HyryYZyOlhIxBzZ/YUFrcrB6Jei6tnE4dqrh8rR4inIGfv2lFwB1dixKC
   RA5BvJ+Wt9B6C4mRsb2iM1CrJcVmr9n+PVIoi3Uv/dymj3+nUVL7y3iAO
   S/330USGBzvUx85TQxyfFaKVqQaw4FDdaNsGqwMXiqplgPtjNDNWGmvXU
   u4sAP14KuJAPOXbNhyGbW1Y9Jx1TeN/UD2PbUXXgKYEoDEiCxqJy4myaM
   A==;
X-CSE-ConnectionGUID: 7GjOUujsQVWXY9ciwl/Q0g==
X-CSE-MsgGUID: W71mz7AwQhqmprzJvcvrQQ==
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="55527003"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2025 04:52:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 13 Nov 2025 04:52:14 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 13 Nov 2025 04:52:10 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 0/2] Add SQI and SQI+ support for OATC14 10Base-T1S PHYs and Microchip T1S driver
Date: Thu, 13 Nov 2025 17:22:04 +0530
Message-ID: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
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
Microchip T1S PHY driver. These changes enable higher-layer drivers and
diagnostic tools to assess link quality more accurately.

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
   - Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features.
     https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
	
2. add SQI support for LAN867x Rev.D0 PHYs
   - Registers .get_sqi and .get_sqi_max callbacks in the Microchip T1S
     driver.
   - Enables network drivers and diagnostic tools to query link signal
     quality for LAN867x Rev.D0 PHYs.
   - Existing PHY functionality remains unchanged.

Parthiban Veerasooran (2):
  net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
  net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs

 drivers/net/phy/mdio-open-alliance.h | 14 +++++
 drivers/net/phy/microchip_t1s.c      |  2 +
 drivers/net/phy/phy-c45.c            | 94 ++++++++++++++++++++++++++++
 include/linux/phy.h                  |  2 +
 4 files changed, 112 insertions(+)


base-commit: 68fa5b092efab37a4f08a47b22bb8ca98f7f6223
-- 
2.34.1


