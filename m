Return-Path: <netdev+bounces-235713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F8C33F85
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 06:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430151898232
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 05:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6C23ABA9;
	Wed,  5 Nov 2025 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="teCX3krK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093301AE877;
	Wed,  5 Nov 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762319563; cv=none; b=DHTbv656yZylr5A0zTmg2+k/UPkCR9J372E0oJh81LanjuT6f6LPQWp6tSPJlTtUdnDqusO4sWM8JHZ0d1Kz6G0INOdPvEDjwIPCWSN07lWHxKH0tmIf07Dtr6OSQsbMuzmsItPSQFuoyzfY7uSuyxdulvSOnMtR2Gwt0wJ3CCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762319563; c=relaxed/simple;
	bh=IiyJ1aWJbnWehHNFgtNwEj4p0ZW1Wo+y5P3TKQa3wXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5sdAZ84uaTamkmhDmfiL4QNDb/tIS3DpU6qSCVw4ZCaoLCm2qgyDM0dKQn4HlYU7I5N1EqYUpowYXJuWBgeeoLWncHFw7w+f2XsV7phDYobnE40m66oZpX82TCOmo9U2Wqe6bdLT3nTpRJ3fZr2luN89M6Y8flQLVjTiTt6QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=teCX3krK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762319561; x=1793855561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IiyJ1aWJbnWehHNFgtNwEj4p0ZW1Wo+y5P3TKQa3wXs=;
  b=teCX3krKxCZPOnlAJlmeddfWrj6A1nhOlN9IgCJoscFVevur0HvKqeFQ
   hdWWpLjfSrpTihAcpNnNLj4OBRhTNfSI9oatpv+VZvORqIBP2ZxXm+GwX
   mnjsh2LoxEA9eIEmiUdnz8u3z3wOgN6N4hv53TdXNulePpACQxAbjO6it
   r4mtVzLGhJGE9+/U7h0R5kLF7l+7KjfJem1+2Wkbh5UoBkbHlI6ljEWiU
   heaDdv4BUufaXMsbA5ppFTW3O2sWbvT7C59VvYogtG47YfUqe/BuN8lkM
   dIC9BuxMNK+iMBL9NDm7UyYKZjfoSvcQB3x5lGzRbkkaZtqhyf6jT8SSr
   A==;
X-CSE-ConnectionGUID: +AayMLSZQS2zD6+HaLSxFw==
X-CSE-MsgGUID: U4AraaxhQdWGRyCXGH/D9Q==
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="48063543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:12:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 22:12:20 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 22:12:16 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 0/2] net: phy: Add Open Alliance TC14 10Base-T1S PHY cable diagnostic support
Date: Wed, 5 Nov 2025 10:42:11 +0530
Message-ID: <20251105051213.50443-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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

v3:
- Explicitly initialized the first enumeration value
  OATC14_HDD_STATUS_CABLE_OK to 0, ensuring that the enumeration starts
  from 0.
- Code style update — aligned .cable_test_get_status assignment to a
  single line for improved readability.


Parthiban Veerasooran (2):
  net: phy: phy-c45: add OATC14 10BASE-T1S PHY cable diagnostic support
  net: phy: microchip_t1s:: add cable diagnostic support for LAN867x
    Rev.D0

 drivers/net/phy/mdio-open-alliance.h |  36 ++++++++
 drivers/net/phy/microchip_t1s.c      |   2 +
 drivers/net/phy/phy-c45.c            | 122 +++++++++++++++++++++++++++
 include/linux/phy.h                  |   3 +
 4 files changed, 163 insertions(+)


base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
-- 
2.34.1


