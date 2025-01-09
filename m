Return-Path: <netdev+bounces-156671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE7A07564
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA425188B07B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81C217641;
	Thu,  9 Jan 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pAjF0Htb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB612144AE;
	Thu,  9 Jan 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424764; cv=none; b=o7COFcyhN5yK+ohTx9Juz395ft6mqC+ey9+pVEY4Idt+hR3HkZUq1/C4iQW/7kzRPH5UiuYJMkZJaynOa5RZy1YI9hwAEAWYhhfUKAXoxWBZqtMTI6tnqDgGvcwh7uW8/JBjNpivvIfHZSXrQ9I45nVHDz23AtAb0QAHw+ErJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424764; c=relaxed/simple;
	bh=zQdmE+RDlBxj33GME/AX3Sc7D3I7se98Ug5E8v5ZsIc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzLPZu6xYV+kFV79R3po1tMLEqTWQ6KZ80lN5J7rh9haRTLI8GzkErJibYldi6L21hAriY73oUFeL9lXjwBqiTqYs2Eqx8ifCyoIjgJET5qo+VEKBTekoauxYTmMQLVhFeXGR5ZA0kVZLpU8y0xD1NzpJ87jRV56GSpZExNP4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pAjF0Htb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736424762; x=1767960762;
  h=from:to:subject:date:message-id:mime-version;
  bh=zQdmE+RDlBxj33GME/AX3Sc7D3I7se98Ug5E8v5ZsIc=;
  b=pAjF0HtbtvtTU9aM7FG9dDvRH6LhRt7wuawjwsKI6vdk5Gr/0tctc2Os
   i4NsdKwc6dx5jvHd7RzPV/T3vi8zFtvsr2gK0o65Ir4sBVMX6y/seO3vJ
   PRyBUWk/TV+dIGB0oPcXc1BKbzgqD6l2DhwSxnYvKIuPg9s7tUqteVcPm
   AKHQOBNNgHIbLqLH5P0o39B/kWwstCVn50V6/l3tmBe5oIBfBnWpupkT3
   tvHg8RtoC6iETAMh7ZYYwKfT/8TGuNFfAKT/37VMs33b/+SI5zWzNc3ao
   qgffuaUrNyup2cjJMgQuxCi8SYSy1v3x+rbFdp5EFB51AG4JHTn2Otxkt
   A==;
X-CSE-ConnectionGUID: Yl/J3QfuTISZsgup3OP0vw==
X-CSE-MsgGUID: 3e2BLj2uSzWQWrRJdxXQrg==
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="203830025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 05:12:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 05:11:57 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 05:11:53 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net] net: phy: Kconfig: Fix error related to undefined reference
Date: Thu, 9 Jan 2025 17:44:32 +0530
Message-ID: <20250109121432.12664-1-divya.koppera@microchip.com>
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


