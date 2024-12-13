Return-Path: <netdev+bounces-151737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169229F0C03
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB329281FBD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5921DFD83;
	Fri, 13 Dec 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gdpqR+8t"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035E1DF974;
	Fri, 13 Dec 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092109; cv=none; b=dtlNRCGAZRW+jvj8JHINPyEh6fFL9dvTIoQgTraEldjv2//2wlgVmX3meSIjZVSlC1LTY+ZkfFpzhnNxI4j9BPIlja74I+hEypTol1HulkVzjqvwlSG2oA1OzxYUam5D0Ee1W9BXjvcGrStyuETqX30xShroxogOI+DPKLV16oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092109; c=relaxed/simple;
	bh=2OFKd1e7ueZe1GZhr3tmwCZz6osySUD85fAKxSoQMzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5UywLqL897vSiWKRW0WN4LLIZDBLSt7OQdxmu3HZh5IKGrj9XOt9RqCImdVK/Z2Zvad8dRJFF7Gx5hzKDCzrPqBxyAw+KJTZD6Ha/kIgZrDpByUuAW5U7nSCUfZRUZ6AwtJNZUwtfJqi765HMJomvn9RCQ48/eQqArS8M+YduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gdpqR+8t; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734092108; x=1765628108;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=2OFKd1e7ueZe1GZhr3tmwCZz6osySUD85fAKxSoQMzw=;
  b=gdpqR+8t0GUI63gvEuBP6xaKUsL9Yj3pQvfiZaU0s01fC2Fe7EPd2OPL
   7A4encJDndr7q523cWsr5u3OQqntlD6llfaFUNHWlqJCtplol3m84VOjT
   D4OE4CIR8iSU8tE0ib1d7R64i6f0ycmfKaoJLYG01mI3LBnYQ/K4qvyms
   7RReiRH1A5nPBAqTGy15L84uvS7Aln/ZjjBEbmEKJyPe6pFJa+uQyhqnf
   8jdPMDXtnQwHggT8I6gR7ncB2w/D53MxzycT3GE3vm9lnE1WDRE7rF4r/
   GDu9I41p07419SVJG1aZp/wYRm+cgZhCsd7z0w8dw0jkgQxgKbxdGV3EW
   A==;
X-CSE-ConnectionGUID: v/CBeaYFQeCpZ9cXifXPYA==
X-CSE-MsgGUID: w3YMBSMHTLaGPiCkiHENFw==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="202962266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:15:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:14:26 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:14:22 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v7 3/5] net: phy: Kconfig: Add rds ptp library support and 1588 optional flag in Microchip phys
Date: Fri, 13 Dec 2024 17:44:01 +0530
Message-ID: <20241213121403.29687-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241213121403.29687-1-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add ptp library support in Kconfig
As some of Microchip T1 phys support ptp, add dependency
of 1588 optional flag in Kconfig

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v6 -> v7
- No changes

v5 -> v6
- Renamed the config name to reflect ptp hardware used.

v4 -> v5
Addressed below review comments.
- Indentation fix
- Changed dependency check to if check for PTP_1588_CLOCK_OPTIONAL

v1 -> v2 -> v3 -> v4
- No changes
---
 drivers/net/phy/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 15828f4710a9..4ff6f5474397 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -287,8 +287,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHY_RDS_PTP if NETWORK_PHY_TIMESTAMPING && \
+				  PTP_1588_CLOCK_OPTIONAL
 	help
-	  Supports the LAN87XX PHYs.
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHY_RDS_PTP
+	tristate "Microchip PHY RDS PTP"
+	help
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


