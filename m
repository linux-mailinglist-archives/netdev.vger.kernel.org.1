Return-Path: <netdev+bounces-153343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7C09F7B5D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9723418935CF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223E22619B;
	Thu, 19 Dec 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xH4aKQqg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FB224AFC;
	Thu, 19 Dec 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611447; cv=none; b=VTNySAfLdiJqUv2JpuvUiF243eK8BF7NJEUBOe3n3qKsCZ9tguaPPaiyX2Jza5bvo+x+Fmj8rHlrwPUSfNcgr0p+5AL1gjNi4YdT/DU6J6frG+vJDlduAbFWCsAYLKLk3r6qQNVGWeJK+8lV6YDix7yPuQPACLWx/MzRJ4M2BBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611447; c=relaxed/simple;
	bh=QKxhY6Te6a+E9nl1Mz9YCkr841o/iFECzuUa3EqMNwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7ThJDLQbxhRLlAtSdvrY1hWO4LRYLwQu+zfcS+gLHNMTl1fBK4MohONh4M23hhC9fmoeFZWUiDyd/i3zDLvQ4YIJdJhV64L+m9curQNOzFmqj1whbtHE5rAxn52wMDwgBr9oAV3Ex8K4M0lGC3vybZPiLYRvXZRp4as3m+6Huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xH4aKQqg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734611445; x=1766147445;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=QKxhY6Te6a+E9nl1Mz9YCkr841o/iFECzuUa3EqMNwE=;
  b=xH4aKQqgxdOtUnJuLXe3zTNRpTHPwLF6pEM31dV3nxhZcipZlO0skKee
   54kR/EBdKPq1mHl0/iOfT4eCFA99O/StJhWL5wrJ+TPoanfHDNzKGywCO
   Od+Nz4/wYWPBGPlCj6iWZBssOB8BLa+dhsYW8KLGTdf0E4wONkE51OV8h
   yGqfmvpndOCPZZlhLUIQfpkkktvTkkN2g6yfjXNY/eVdyrjHRCbvj6Lm3
   Q/tEIK8Zbqa8mE5Emn7+QQdw0MT2MzLZCFhD+rL1LG0a9XtnXFWhEkfF4
   X9aLKQfi7jap7j2PltVG4LJsKpi4n5wCN+YT9BMwfmDgMWAr36x42vDnZ
   g==;
X-CSE-ConnectionGUID: NB4TeJuwRMyLWuysxUyzIQ==
X-CSE-MsgGUID: vEMN+J8jT8mkLeaq+j5Smg==
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35409655"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2024 05:30:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Dec 2024 05:30:34 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Dec 2024 05:30:30 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v8 4/5] net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
Date: Thu, 19 Dec 2024 18:03:10 +0530
Message-ID: <20241219123311.30213-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241219123311.30213-1-divya.koppera@microchip.com>
References: <20241219123311.30213-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add makefile support for rds ptp library.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v7 -> v8
- Added library in alphabetical order.

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
index e6145153e837..39b72b464287 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
+obj-$(CONFIG_MICROCHIP_PHY_RDS_PTP)	+= microchip_rds_ptp.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
-- 
2.17.1


