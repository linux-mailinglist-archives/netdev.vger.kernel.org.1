Return-Path: <netdev+bounces-144096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C13629C5B57
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9400B47ED4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5B15A858;
	Tue, 12 Nov 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jLB5EH2z"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CE15572C;
	Tue, 12 Nov 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418647; cv=none; b=GdMFLz1Vs2zp4HdA+2LIEgQipxffmxOnl0YtZWWC/lv4M8WMA9kUU49ThWTyTkN+WGUYEzJOnvAw+ZsNH8hHBAOQGmOcRgv8XqrIg02JXCpGtG/0gFTiHvuR6TKr4FoXPxtFh3LTvp1Vd4TcuXFu3mftPselUngr/JXWL9O+d0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418647; c=relaxed/simple;
	bh=56D6/xJT03JJuKHiVk8w6cxWRRCdIzSDilYtts9qJ94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2zHDXWlp/U1mZfsyj7U/IoXn7hIEb0MLlmL9r3Hkz+EUY10cI45fzkP3v5o76ZhBWXdnq+wyH/JssIyj8+FV1Bf3WsxzIySU8NMl/AbXkbW2/vfS1l20EzQEucCOlUbblRy49xrzy8B8LJggkKO4DOjUQkSpzqJha/9XmdrVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jLB5EH2z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731418646; x=1762954646;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=56D6/xJT03JJuKHiVk8w6cxWRRCdIzSDilYtts9qJ94=;
  b=jLB5EH2zgInFBCY19enxY4BgeaNh6Bk02gqllcbPJJTeehwWBFKfnt1d
   KdKgEV1iEs95f9A4YCMdbQC641/3AaxoOc5CjYfX7h8hQ49t8flkrznt5
   uX2bhE9cs+EF0nnzB5+QAfnfWtHzBzO9z4WriTUI/Zo8R2K51xxJl3Kfg
   x26uHsh4sSjzWTrBB2/UI6Nehhx67vDWHObLt03b/CW/sKdhyJR2lvucd
   sKkuK7Kna8+nnSFSOwWF3O4OgbVb/7yexO8CVjr5VNRyKmQYKEAPMfQ2f
   o7sNCtxLQjJBr6zxFs2Bka2K0R7S3Twf0wkXG5NKKv5XoHb/WCWi/UKEr
   A==;
X-CSE-ConnectionGUID: MrNChj17QCGoNOgRM4DkTw==
X-CSE-MsgGUID: N0OnZmx1QwKUrksOymCQug==
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="201634990"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 06:37:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 06:37:21 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Nov 2024 06:37:17 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 3/5] net: phy: Kconfig: Add ptp library support and 1588 optional flag in Microchip phys
Date: Tue, 12 Nov 2024 19:07:22 +0530
Message-ID: <20241112133724.16057-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112133724.16057-1-divya.koppera@microchip.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
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

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2 -> v3
- No changes
---
 drivers/net/phy/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ee3ea0b56d48..22c274b42784 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -302,8 +302,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHYPTP
+        tristate "Microchip PHY PTP"
 	help
-	  Supports the LAN87XX PHYs.
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


