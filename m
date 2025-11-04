Return-Path: <netdev+bounces-235434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51DC30778
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317403AB9A0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A93112D5;
	Tue,  4 Nov 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="njF5gHm1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4331DC9B3;
	Tue,  4 Nov 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251653; cv=none; b=mklmg2Lz9hvwZswEQHXstce+yZwansUA/a+x/4gwqRj8nDnE1K7hwfJ1VOHvCQFhlWx+6rsBTVzoyCtnPybeeFeZzLUanZ1Ecrpf4yr6/nWeL/LEJQVjM6YMzws80c61VbemexDx4GBCaPDBDgSbp66+776zAKQUhXpeAuVx2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251653; c=relaxed/simple;
	bh=W+oDDAVkBX8+8VjKeG7txAM8ukN+kYV2hV3smQ/JGZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jb6xos/VSS5YxsgeOPQM8XCQmv5nUPPLplonZUvqzMTxFu8gDuvt8VP4xPtnZIzxLH2cMF9b7D3zpBbHzJeCTYN17eV+kszkLUOUeqv1zWEKdLz16TOiMtkI/oiE2WvjUrH4xk/gjgr7939j/6uHK6Of5YRab9Ug/ialW0e0Uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=njF5gHm1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762251650; x=1793787650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+oDDAVkBX8+8VjKeG7txAM8ukN+kYV2hV3smQ/JGZM=;
  b=njF5gHm1ud+xNE9fWzz9A3XWXLbnBCxRNfR00Nz1VBGQXjh9UML0n7po
   5uTOY/WvcVkE8bGp063zHlGQOD5jZK6E5m8t1iCSqKdmrWzkphg8MSQtS
   y2dIYjy9+M0+zCgXW8AAisxyI0TzJ0ZYCOqdLc5lvwxNLOMZvQbh5X9rd
   MMqORP3xfCfRY9eTRCK6LyTVNExuQPUMcgMux7Y9tNqf9bwf7ZO6Q81QF
   FvYVHbSCSDauOMhgmsi6V6xe9LsPOQpLl1dQSVyJLZrE3oidzK1rH82l2
   PyP9f38eTonfBrZT9fg2pR15sZELemAnwuA57k35BGdkJRtgXS2R/qZSW
   A==;
X-CSE-ConnectionGUID: 7WIhWbovRpGVq1y6Z5h2hQ==
X-CSE-MsgGUID: 8J2iBr6HRGCydVsEVa/Rtw==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="215997396"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 03:20:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 03:20:20 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 03:20:16 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 0/2] net: phy: microchip_t1s: Add support for LAN867x Rev.D0 PHY
Date: Tue, 4 Nov 2025 15:50:11 +0530
Message-ID: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds Open Alliance TC14 (OATC14) 10BASE-T1S cable
diagnostic feature support to the Linux kernel PHY subsystem and enable
this feature for Microchip LAN867x Rev.D0 PHYs. These patches provide
standardized cable test functionality for 10BASE-T1S Ethernet PHYs,
allowing users to perform cable diagnostics via ethtool.

Patch Summary:
1. add OATC14 10BASE-T1S PHY cable diagnostic support
	- Implements support for the OATC14 cable diagnostic feature in
	  Clause 45 PHYs.
	- Adds functions to start a cable test and retrieve its status,
	  mapping hardware results to ethtool codes.
	- Exports these functions for use by PHY drivers.
	- Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features.
	  https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
	
2. add cable diagnostic support for LAN867x Rev.D0
	- Integrates the generic OATC14 cable test functions into the
	  Microchip LAN867x Rev.D0 PHY driver.
	- Enables ethtool cable diagnostics for this PHY, improving
	  troubleshooting and maintenance.

Parthiban Veerasooran (2):
  net: phy: phy-c45: add OATC14 10BASE-T1S PHY cable diagnostic support
  net: phy: microchip_t1s:: add cable diagnostic support for LAN867x
    Rev.D0

 drivers/net/phy/mdio-open-alliance.h |  36 ++++++++
 drivers/net/phy/microchip_t1s.c      |   3 +
 drivers/net/phy/phy-c45.c            | 122 +++++++++++++++++++++++++++
 include/linux/phy.h                  |   3 +
 4 files changed, 164 insertions(+)


base-commit: 9e8a443401dfb15574f9cc962783500ca8c2eec2
-- 
2.34.1


