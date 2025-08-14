Return-Path: <netdev+bounces-213628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0CB25EE3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C647BC3B4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41740254873;
	Thu, 14 Aug 2025 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cywjB4fp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8B1FDE01;
	Thu, 14 Aug 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160294; cv=none; b=BqvyKK2nh9ld846AEuvj6ozK1lq+f971JYOpXVLHRGYX9GbeKLt+3wwiJSx02H+IqyJntSTD3elMoor/tKa5jLo/V8p/ALM5G3lARrJlw/a96eCrOgVBkb45iDlxKdJ7P7FSf/6Jc9n/4NikORti2ua4KLtECMew+nTnYb0mOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160294; c=relaxed/simple;
	bh=JetMEFAfY4oO5jtm61uNtrm/1VUC8x8YVTQesqMMMEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rk89r02L0igw8I1Zv1zelRasl5ttV9WL/xN8W6dO5QECRY3he2uEB0Uwp7u++CjsVNloDHRNB9Z5mi6a0k53tr8TFqeqV63OwGjoJAmszKQvw1ypEEc3BST+pmBzQ+96ndbJeDqB2mQc1R5iHui/lfs1Gr0wvXIffo8WLL6mQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cywjB4fp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755160292; x=1786696292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JetMEFAfY4oO5jtm61uNtrm/1VUC8x8YVTQesqMMMEw=;
  b=cywjB4fp+qz+jM5yYiUk+euoIENxJ23AuXYi0CCgXl44XFydU1scbQRN
   s5vRoUaCkQbvXheZNrndpNZpvnt3YuPZoiudqbrXPFqDrWD/7auQ7a4KK
   tK+FdzKx4UdC9Agsz5nHBs9JgP6bXMW86/oEvZpn9dWQRBvbCbhYw8oNZ
   jmSADVzY2idyqBpy3+ptMKxxwC7iDaoe9VocnswhJJa0yd8VeQwDsUHTv
   q//Uk7qUmUiRtcQ6+DCCoW8onqoUDP7whpS6BFtTbf06og24k0yN3OlfK
   AalrV8RiGWsTt+HfBH+MVC1Pojrwab5eHHkktvw/aq8xq+PtMC2x1i5xG
   Q==;
X-CSE-ConnectionGUID: sG1idv10QAqjPnfZxhk11w==
X-CSE-MsgGUID: wHpDMKkgSOOE+JSOIkqK5Q==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45178587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 01:31:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 01:31:09 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 14 Aug 2025 01:31:07 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 0/4] net: phy: micrel: Add support for lan8842
Date: Thu, 14 Aug 2025 10:26:20 +0200
Message-ID: <20250814082624.696952-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8842 which supports industry-standard SGMII.
While add this the first 3 patches in the series cleans more the
driver, they should not introduce any functional changes.

v3->v4:
- add missing patch, the first patch was drop by mistake in previous
  version
- update lanphy_modify_page_reg to print err in readable form and outside
  of lock

v2->v3:
- add better defines for page numbers
- fix the statis->tx_errors, it was reading the rx_errors by mistake
- update lanphy_modify_page_reg to keep lock over all transactions

v1->v2:
- add the first 3 patches to clean the driver
- drop fast link failure support
- implement reading the statistics in the new way

Horatiu Vultur (4):
  net: phy: micrel: Start using PHY_ID_MATCH_MODEL
  net: phy: micrel: Introduce lanphy_modify_page_reg
  net: phy: micrel: Replace hardcoded pages with defines
  net: phy: micrel: Add support for lan8842

 drivers/net/phy/micrel.c   | 780 ++++++++++++++++++++++++++-----------
 include/linux/micrel_phy.h |   1 +
 2 files changed, 549 insertions(+), 232 deletions(-)

-- 
2.34.1


