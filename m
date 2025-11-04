Return-Path: <netdev+bounces-235437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5DC30859
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7833A3B7F4B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02584315D57;
	Tue,  4 Nov 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vkAhxXav"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62335314B71;
	Tue,  4 Nov 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252167; cv=none; b=A55UuS7dpzDGGkqTtxYPQ1uQKKJIcEGdSBpqNiHjw7jDQT6yNelzk+k+K2XTe4D5Y8GLzq9txyBUq9zWSTwxWrs9uL9p6Kt4shCQtQKPOSoh7RcI1JTmLNIuk2sCJrUdinLytzM+lrdQE1/hmQ9aQ6HMzXhgfDasDfa4p4levbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252167; c=relaxed/simple;
	bh=Qs+tTl9/eb+ofRw5rhNs62siJj5H8EJHt++vAeQzByQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFNHLgXvVe3tbladRjI8wMx4lIEcfS848+4N8TMShuwJdG8t9upka2+O8ZofktTdOmEbLY+Z5xMP3odXkUEpY1CaiyWjUAr4W8hh/Z4upqSICYXStsXfUPtajKfb2Dt2rEiIdWrOiW/y/nb13hkaYkGl1Dyu0zMUQGaOrJL7Cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vkAhxXav; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762252166; x=1793788166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qs+tTl9/eb+ofRw5rhNs62siJj5H8EJHt++vAeQzByQ=;
  b=vkAhxXavYkpnOSzAT1ONeRC7MiojdC3I8+NzoJItjAl6zvlWuAwyhQeP
   /uZW7wfbnz1FU/6BaRW3cceZyT5G7gaPgH9ve9xj4YxovIqHWru8pkfBf
   0bMbhnPqYf9X02Qrz9E+GEjCYLqeIOPiJIm5TSrNLHGshuVU9VkkVHvc2
   z13g3GZ7Z5iydMyPlA83D0q6wlisWErf+SI3ewUNLh3G7oSvjQ1YSLmLT
   QwICPaMmj32hYQpKx7HvDuuhs9F6ojW1pvv6WC72vaXxzUUPTfWvzx/rJ
   VN6zFzYj3fXRtOEnAwXrX7SHeQPmS0bvJM1/9EMSmPdtbj4AjEW+nwj55
   Q==;
X-CSE-ConnectionGUID: 54f3n6OUQHWzRkAOn9QkBA==
X-CSE-MsgGUID: uFqlk8YtQvmW7OgZa6tLXQ==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="49163543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 03:29:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 03:28:54 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 03:28:50 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/2] net: phy: Add Open Alliance TC14 10Base-T1S PHY cable diagnostic support
Date: Tue, 4 Nov 2025 15:58:40 +0530
Message-ID: <20251104102842.64519-1-parthiban.veerasooran@microchip.com>
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

v2:
- Updated the cover letter subject line for clarity.


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


