Return-Path: <netdev+bounces-150260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F639E9A3C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664611887978
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBE1C5CD7;
	Mon,  9 Dec 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EY3zq0/f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E71BEF9F;
	Mon,  9 Dec 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757502; cv=none; b=K6oZSFdJjj7BoOUQBuhcvaUm/lW37CRiog+l/uk9tAPA5HaoiMt2hovkA/JTtDyFeZVTPD+5bUlkUw4k0ISjTTzCn74EMeb80f1grZBT9R+2jNZz2PBkVuNW/KUAj13uQzlmDzs/hkcZ+9ujtnIruBKkcnJ4dffHWNyCiDfoqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757502; c=relaxed/simple;
	bh=TaaoUJlwFZIyPi3oJlLOERwTajsuwKUCCV07uM4pMJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpHFe28WOPXWq10qMXHjbnlm6Mz1e8qzrCpokZZp6SDb9+zyvxbp62ShNUrmY+g1VoUtLfLs2vHA5EkSm05Xl9tgi2wkFASmcAOJuMGdtmveRaNE7tgi+RNlOWJT4JH4LNK2RPNwq2W+Z/fURTc74Ht+XgMvUFRLPPkpE96xznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EY3zq0/f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733757500; x=1765293500;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=TaaoUJlwFZIyPi3oJlLOERwTajsuwKUCCV07uM4pMJg=;
  b=EY3zq0/f1B1zBGa3d0cVdceaaCu5ZqdUCiS9ToD3VWFWOUBNtOmhWzRb
   7jLiyq20hrdGuLSqQlxEuoaGsaR5ExvWfC9+OT2RI98uQuSd8a51IVUxk
   ZJyt/AroFHZUJ/HYkNXNdeniLxglw1rEJWG8ZbZ9MJCcT0JX+SaLEMirU
   hrlftzKpdI9wBbApys4UI2dv4x3wvKAgtrDdSG2KpzmYy3txUTLUJzh+C
   vuRSyrj4ND6eVcVrFCL16oqjFW0wjXSMyPhPhnyr7v31+VHwbCzx7SYqx
   XMlusjcw4jJ+3nmDgkM7Xb97bVcosHGRuHgsATy+O3o9OkBR1rq5GgCBo
   w==;
X-CSE-ConnectionGUID: yJIa2BtxQkuJT04wZ40P6A==
X-CSE-MsgGUID: zpgMCeI+SAuE1pqvxKQsyQ==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35775870"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 08:18:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 08:17:53 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 08:17:49 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v6 4/5] net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
Date: Mon, 9 Dec 2024 20:47:41 +0530
Message-ID: <20241209151742.9128-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209151742.9128-1-divya.koppera@microchip.com>
References: <20241209151742.9128-1-divya.koppera@microchip.com>
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


