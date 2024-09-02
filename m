Return-Path: <netdev+bounces-124219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B49968A09
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC48B22A05
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8C1A263A;
	Mon,  2 Sep 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="URA75C91"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F431A2632;
	Mon,  2 Sep 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287738; cv=none; b=JGtvlWScPFkdtGNP0c6wMgnRSEBAlpd5kVyedGnFyvwwOJyXy3HVJG1A31us8KRrySUWRSKlY+ff4TRyFcUpe066kpmbI0bJrxpu4zZoEAVXkVa6VkI08t3fcf8Oi+3feRLZk3U2aV105uVmudf9woRzd+rFDqEllhy+msBouYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287738; c=relaxed/simple;
	bh=5+yszPpjmoqd5/amSYx24TtTQjGQhpbvSYUCMGZpy0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOHto99n32Z2ogW85n5xDolWRpXlpGzl9IqJFSMXOoF92MXPWoSHCukcRTFrcpfu9zMJcNm3rVVC6n2WbFr9t25Rm2Q4Uz2Cz0mcVb63cZy8k1RItiyqr/qW8uz9XO/gsI+MF0Y8r512OfeUnm5DgHsLrSjwgobzOeg5ocOdNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=URA75C91; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287736; x=1756823736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5+yszPpjmoqd5/amSYx24TtTQjGQhpbvSYUCMGZpy0I=;
  b=URA75C91k37lI/YMcjxv55y066yLLLcmc4nhEZ5xKgbPHLqPFwjb+23D
   og7lAXfIrSfe3qvdd3nfZmIkbLfxA78CSe2WkMdoPbEWR/wZELh93JMjA
   zi8sdrqJ8XySz5l9B/QM4iqJiJzPwaTqLjbT4ScEjOalGvq/WW8loZsjN
   ZatHE9dknTTHRpTAyJAXA26bPoF2Sr4l0tcIPQi1sgpJSNbEig0a84hJr
   8ho1BmYbdGi0u7u1JaY6TSUXCAefvcJKGITgpYMUgpHGubn/WNJ9d8E+Q
   uwlzneR1Yss8L1ABJmFeypDkYqrBRRZ5Ghh28oEFAJIwVqr/49pRgbVIH
   A==;
X-CSE-ConnectionGUID: ocGO3RCOTkuOSmOfjK4K+g==
X-CSE-MsgGUID: x1BTIxwuTba/it2EneXaTA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34270499"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:35:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:06 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:02 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/7] microchip_t1s: Update on Microchip 10BASE-T1S PHY driver
Date: Mon, 2 Sep 2024 20:04:51 +0530
Message-ID: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates,

v1:
- Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
  functions arguments to more generic.
- Updated new/improved initial settings of LAN865X Rev.B0 from latest
  AN1760.
- Added support for LAN865X Rev.B1 from latest AN1760.
- Moved LAN867X reset handling to a new function for flexibility.
- Added support for LAN867X Rev.C1/C2 from latest AN1699.
- Disabled/enabled collision detection based on PLCA setting.

v2:
- Fixed indexing issue in the configuration parameter setup.

Parthiban Veerasooran (7):
  net: phy: microchip_t1s: restructure cfg read/write functions
    arguments
  net: phy: microchip_t1s: update new initial settings for LAN865X
    Rev.B0
  net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
  net: phy: microchip_t1s: move LAN867X reset handling to a new function
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
  net: phy: microchip_t1s: configure collision detection based on PLCA
    mode

 drivers/net/phy/Kconfig         |   4 +-
 drivers/net/phy/microchip_t1s.c | 299 +++++++++++++++++++++++++-------
 2 files changed, 239 insertions(+), 64 deletions(-)


base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
-- 
2.34.1


