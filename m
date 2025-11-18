Return-Path: <netdev+bounces-239381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D94C674DC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88C4E35622B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F342226CFD;
	Tue, 18 Nov 2025 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ogyQce/q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE015A864;
	Tue, 18 Nov 2025 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442020; cv=none; b=Q3JhbwJEz919ojv35FZzcw4n28ei5PTNj9wIlMFwvYOb1p49D11TzxLL7B0U0gajj5yYr7Qe82jurC4IV//MUeDo4LFfpWRe3owVIobQON+oB1l5kXQ+/5iJxX5+9Lchm8JfJl1FoLLRgnAoKb6pENRXQ372p2ePNV1IJtTcop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442020; c=relaxed/simple;
	bh=8UMZBvdRd7B2lFwGCxR/JoxSl4b7dLdPc57BksA6Pyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJPfrubB8RShuaUI8HmBuVJv+qFe4AiXuUc1Ki/BMWffm4dF+oFo1QuCqJaG3xFabAS9xY/Cd2Z2SfEohtqeH1qNjGQ2eTj+wsRK/Axl9UFFB5Iu2ASI1PbGaUWqgs9XDiumfnJJJgzqVNmsuh9cxdklWXkPWxo8dw5FaWGp4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ogyQce/q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763442019; x=1794978019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8UMZBvdRd7B2lFwGCxR/JoxSl4b7dLdPc57BksA6Pyw=;
  b=ogyQce/qOCU9RGDSPd/KiwXfkIj34Zpnku3sDwl+7plSW/BSUWxluQ1S
   zPMDNH7QF7rXF8vCzDTxtLu75k2GccSB2z/3gdyiKWDvo+sgPWVbNI2HU
   cUSgMivZ6sAsMjv6k2dlVXXPZV1hAZKcXOey4kL0glj8v1wBOsRHF6bdM
   9Ga2Qc15SkSRrep5eVnW3D03hZZsTnom1zUz1FP6bHbt4dPv8mUChS4D8
   jZQ4HN4YYv52zIUXTeno24wP53ZkMAnf3COlHi7uHrOAJsG4KtMFG799l
   Equ6l6d+J2GzoJDNkZlgsJJgfX6jubLmPsEMnd9YDFm8w+3pSxpg3BbMX
   A==;
X-CSE-ConnectionGUID: CBAKL5HZSnmlCJaSPFbQ8Q==
X-CSE-MsgGUID: Sgm5BDEfTz2y9YsTzqzJfQ==
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="49294696"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 22:00:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Nov 2025 21:59:53 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Nov 2025 21:59:49 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/2] Add SQI and SQI+ support for OATC14 10Base-T1S PHYs and Microchip T1S driver
Date: Tue, 18 Nov 2025 10:29:44 +0530
Message-ID: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
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


Parthiban Veerasooran (2):
  net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
  net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs

 drivers/net/phy/mdio-open-alliance.h | 13 +++++
 drivers/net/phy/microchip_t1s.c      |  2 +
 drivers/net/phy/phy-c45.c            | 86 ++++++++++++++++++++++++++++
 include/linux/phy.h                  | 12 ++++
 4 files changed, 113 insertions(+)


base-commit: 7c898b71e59c51ba356aab095ea4ee1f867ad595
-- 
2.34.1


