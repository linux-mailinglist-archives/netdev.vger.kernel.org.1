Return-Path: <netdev+bounces-232248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08034C0326B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC16A3B0AAE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81F26F463;
	Thu, 23 Oct 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qjl1lQoR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D21B7F4;
	Thu, 23 Oct 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246937; cv=none; b=KI6iql48ki0mAE8Uf3+kdz5UzYD68xMmoz1gxWiQU+q5JBM6N2N2Dw4UDyDzhxCKW3zch1xn+ak6J9iW3XGh+B7zV4cVfDX/aWm55Uq7eAYK0P+q8sNk3u6wX38DUyOpxf6e2/L8bBI+MA40XQNgVq6Rt+SQ8Zi0OoE0CmHMsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246937; c=relaxed/simple;
	bh=FHmbxa0+C+nXf1NpSWhh9IxDkFqCWgywCG9BFptEL3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=enWiLWKs+XvkCSk1+vHnLxpqJ4WiNxxD0I7JUZQmIXOdDnNwOHEmMKdpL6drNxRf0IiH4HRkUFYzDMlBBgEnp7AYrg2bpYIK3dpGhW6YosreG+k4yfCLwOJYpUKcoKCNqYGx5lNw8sQC2yGixkg/yfgYeYNYx0Eitb/Y6PxN0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qjl1lQoR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761246936; x=1792782936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FHmbxa0+C+nXf1NpSWhh9IxDkFqCWgywCG9BFptEL3Y=;
  b=qjl1lQoR//In22ZsXwc5NgpqC8ZRlI5kQRltkKxFtjum3sJ19ABgNtua
   wwU6aaogO0MVt1qwgI1ZtQYppdIXKtIcB3KfsHp9A14IOmmqJQlw0WRe6
   Tu/Y5RJTFZsIOAps4U8QRuMmbUuZoanzU377UUlfC8usN+hnAXYN98g03
   VfYRcMudoraLjIpH4BvAA5Vph136kXbZpMTsMiRQkPNfdOuTQwsVA67q0
   znjDcxYLg9S0s+D3jx/dDVwcjZoxysyQlUtTTfRLjo48WzOwohUvPuAbx
   x5FUIugs30E5U2ROd5C8w6dp5RiHNtc0FAoKPwZTvUsTQ3cGlRZtgawJq
   w==;
X-CSE-ConnectionGUID: 6jSydriyQCOrs/G/QPbxjg==
X-CSE-MsgGUID: sC29ntFoS3GnEN7ld9Ng/w==
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="48690428"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2025 12:15:29 -0700
Received: from chn-vm-ex2.mchp-main.com (10.10.87.31) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 23 Oct 2025 12:15:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Thu, 23 Oct 2025 12:15:12 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 23 Oct 2025 12:15:09 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <steen.hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 0/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Date: Thu, 23 Oct 2025 21:13:48 +0200
Message-ID: <20251023191350.190940-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The first patch will update the PHYs VSC8584, VSC8582, VSC8575 and VSC856X
to use PHY_ID_MATCH_EXACT because only rev B exists for these PHYs.
But for the PHYs VSC8574 and VSC8572 exists rev A, B, C, D and E.
This is just a preparation for the second patch to allow the VSC8574 and
VSC8572 to use the function vsc8584_probe().

We want to use vsc8584_probe() for VSC8574 and VSC8572 because this
function does the correct PTP initialization. This change is in the second
patch.

v4->v5:
- target net-next
- use PHY_ID_MATCH_EXACT instead of PHY_ID_MATCH_MODEL
v3->v4:
- rebase on net-main
v2->v3:
- split into a series, first patch will update VSC8584, VSC8582, VSC8575
  and VSC856X to use PHY_ID_MATCH_MODEL, second patch will do the actual
  fix
- improve commit message and start use vsc8584_probe()
v1->v2:
- rename vsc8574_probe to vsc8552_probe and introduce a new probe
  function called vsc8574_probe and make sure that vsc8504 and vsc8552
  will use vsc8552_probe.

Horatiu Vultur (2):
  phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575,
    VSC856X
  phy: mscc: Fix PTP for VSC8574 and VSC8572

 drivers/net/phy/mscc/mscc.h      |  8 ++++----
 drivers/net/phy/mscc/mscc_main.c | 29 +++++++----------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.34.1


