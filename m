Return-Path: <netdev+bounces-156962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FEA086B5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC17B188C98F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970952063F0;
	Fri, 10 Jan 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UdkosnMX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6D205E36;
	Fri, 10 Jan 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487690; cv=none; b=E8ukaaQuc3wp9SE3PQEA3FsIo5TA1xcqyf6jFzkqfDiiTRw4Mignjy7ZdkAAi0R0mT1PYFjBIeNWMPXwqyvsN94Ruvnawb+Sf1rq2Fei1yTpc2bF0DUlW3N7K6pNudFZhaxRiaWEOp5BZ+XIVGa+eoTr7UH+jF/ReFKwFHL17yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487690; c=relaxed/simple;
	bh=1Y7sefoQ0YoJuF1C26LElU/gmvm1zRtYCQDDma8W3tY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1oW0lRIq/EFGpKFXp5uGQrnmCpte/r+2pvW3+vtjNZzXSYTn2z7ykPSNJCIPgmM3SDOpQtOiGcBo2K2okKPpeo1aHF9cJoQq2SVvhG18XSATS8WRj71nPXMWy8EHYLkClrzlT0STOur68l6rCwxp8kkBSNCQeAP6fSfSKR8dEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UdkosnMX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736487689; x=1768023689;
  h=from:to:subject:date:message-id:mime-version;
  bh=1Y7sefoQ0YoJuF1C26LElU/gmvm1zRtYCQDDma8W3tY=;
  b=UdkosnMXw1WE9+lbkwFmi6cgT0licDP0cDuBKaLhHCfOkPhnofySal3m
   mXlwfMbNu5I4R9x/Jy4i6yAnzdGOGhJTFjPrch1z07OfE1sT05LKJFCtS
   TN5XULWHmJjgzJJOQNAwA+bZmEeaxMfQvJB4Tpi3GSKjwWMWNciPlgsqf
   t3BNy6+dtNB05s27XM8AcS0HgikwkeFuxJoHsNSt8HDasrmUrD+9MRiaR
   xTSAQ+sGiVHubrtL+b+4oSF8uQjWZLQmvG2el+RfwbZPBpKeakzQVMr8W
   kSnjKx9gL9JdNB/UKq0bN+muK8tX/6TEq9gXkrNake1rSE7P2i7Yw/HH3
   g==;
X-CSE-ConnectionGUID: YaO9AIrEQPOehTjwwOqDvA==
X-CSE-MsgGUID: NyK4883oTW+tK/aaE4Na+g==
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36379889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 22:41:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 22:40:57 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 22:40:53 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2] net: phy: microchip_t1: depend on PTP_1588_CLOCK_OPTIONAL
Date: Fri, 10 Jan 2025 11:14:24 +0530
Message-ID: <20250110054424.16807-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When microchip_t1_phy is built in and phyptp is module
facing undefined reference issue. This get fixed when
microchip_t1_phy made dependent on PTP_1588_CLOCK_OPTIONAL.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202501090604.YEoJXCXi-lkp@intel.com
Fixes: fa51199c5f34 ("net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys")
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
---
v1 -> v2
- Modifed prefix for the patch and subject.
- Changed target to net-next from net.
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index dc625f2b3ae4..9ad3dbfd2f99 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -287,8 +287,8 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
-	select MICROCHIP_PHY_RDS_PTP if NETWORK_PHY_TIMESTAMPING && \
-				  PTP_1588_CLOCK_OPTIONAL
+	select MICROCHIP_PHY_RDS_PTP if NETWORK_PHY_TIMESTAMPING
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Supports the LAN8XXX PHYs.
 
-- 
2.17.1


