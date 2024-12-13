Return-Path: <netdev+bounces-151738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AD9F0C05
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116AA28247D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530F1DFE30;
	Fri, 13 Dec 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wDx2oI0d"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAE1DFE15;
	Fri, 13 Dec 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092115; cv=none; b=Qh34Gjm1z2D4SCEToUmLyLzq/3cVfYNcbsMH2g53UuhoT3IV1w1LcR90Ev1ZWnwds/rJAeMUDnp5otFxwvjQc884IObY+bmr7l6T7PTxgxdoQNULtZVSsxPj9YZCvlhWBNFAsgjSfXIZ0c5ALgdNfEvJ9gg1/TLLQ4XxOCURie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092115; c=relaxed/simple;
	bh=OMYUg5ITKHOrkfYI5nC7u5/p63upXtRWyz8K6uiTXpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB9QEMBGtRwxqYeIF3jIq9UaeadDXECwqxrlXhkJ1bDEqLlHLFAA6cX7csCOBfvrnXtKvfYZC18XosTTXiaoLy1xcgVIo2+hL8dnYJ7xHz9wsue+v/GpRSl9et1Ly+xGtlWO7mXTdwFpgYCPu+bRmUYSH64S10SmTMNNvKnJ71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wDx2oI0d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734092115; x=1765628115;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=OMYUg5ITKHOrkfYI5nC7u5/p63upXtRWyz8K6uiTXpM=;
  b=wDx2oI0dlrDBwipFTTMeLVZmeZ60HUWw/9mFoPs51ItfwxTMkn4xS3KG
   0klIc/ao0C9thJA3w/Qcso77ULGE40etu3FnWlHElnlDk5nHK7B/JLkTK
   NJkGAPYxlZmN7no8KjALYuGSb+ZAXKcHWn2oQ+w966dZenVi9PXiXVklb
   QAxCZ6XYC1eTnMLOeJ1707gYSJK2xeccI3cm2sbi7zCtgYZYUzG+/5AhP
   mgzsGS0VdpuhXqDWU0kmSndF4r60bQHqARejTFb/V0akSom0L9ldG0Hx+
   r6NJxxMA6NB6VUTzrj91iN8j9k1Mw6KnZ707GtIUCes2YkaguXehn5Cjr
   A==;
X-CSE-ConnectionGUID: KencwqX2Qrmpc2f85spCRg==
X-CSE-MsgGUID: s5MM/9xHRoujI5IzeEb6GQ==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35501687"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:15:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:14:31 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:14:27 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v7 4/5] net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
Date: Fri, 13 Dec 2024 17:44:02 +0530
Message-ID: <20241213121403.29687-5-divya.koppera@microchip.com>
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

Add makefile support for rds ptp library.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v6 -> v7
- No changes

v5 -> v6
- Renamed config name and object file name to reflect ptp hardware code name.

v1 -> v5
- No changes
---
 drivers/net/phy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e6145153e837..e32600f3e4f1 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
+obj-$(CONFIG_MICROCHIP_PHY_RDS_PTP)	+= microchip_rds_ptp.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
-- 
2.17.1


