Return-Path: <netdev+bounces-143743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD09C3F0C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B881C226B2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1231A0BCA;
	Mon, 11 Nov 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YAEBIoVz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BED19E7ED;
	Mon, 11 Nov 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329957; cv=none; b=TziShVpAIEh6fOhljyhT+R0+7xdKSRz53IHsTsbMbEQg6MzF2HPfhlOAr6JKiG1CxjOtz5R0uII1UMi6rNtMEciTMVuA1cCsPwxbTeaholL2Yh6XXh8CmyfmeWfyInbLvEFD+C7UxjXkytu3DYZY/8bWc0x0hg6jVLSFhbdgigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329957; c=relaxed/simple;
	bh=Hxh2GHfuFeGzFoaS+XPXJrBxA/m6xXcggl/oWkpkaIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUdloUN49vjwNfPE/qAAe9IDIw0A0X2ZFfkwLgWdi2Ds6s2OlOjJBHMubVrtABxgXWv1Za2FFy0gEe/qGXbV5tLyMDPxJC0hDmnkSdTygiDZrWzxs18I0Y1in8cNFl7UchLHURs2MVpvhEKuzgDCigSprYg+u0XcsARN6VpWZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YAEBIoVz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731329956; x=1762865956;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=Hxh2GHfuFeGzFoaS+XPXJrBxA/m6xXcggl/oWkpkaIA=;
  b=YAEBIoVzRt0Y8W9KakTv95b0G8FqCefVyYnI/2DjceLW9ad/Y7d/S8Jh
   qQYe8GoKy/gltuSkJe0bqy8c63CPb3sA7O5AsbcgA5UR1P9bbDrSZuh8Q
   WNcpvwgATIuYLz+aXskYC/BuaNmr6OuSSJ/nz262kmrvtLiEtUMlleAc3
   XssZtEp0lXhDIxsjKP9bb07r1HmjSK+WyC009yaOo0Qrt+CIoaZ43Va4S
   ni7uBh9Bj/ZCag6PbWpvqezGTpWT8dDlabDretV7O4RlkVoKypoNOgFdB
   VXfdvaGzsaV7i4AVTExAiliLxCb+P5HJQOrAG6byCaTFCOX69oR5cL1rv
   g==;
X-CSE-ConnectionGUID: dZFC6vp0Q/6hLNqL+TdxVg==
X-CSE-MsgGUID: 2ohdBcE+Tr6hpuQPPegPoA==
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="37646825"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2024 05:59:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Nov 2024 05:58:58 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Nov 2024 05:58:54 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next v2 3/5] net: phy: Kconfig: Add ptp library support and 1588 optional flag in Microchip phys
Date: Mon, 11 Nov 2024 18:28:31 +0530
Message-ID: <20241111125833.13143-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111125833.13143-1-divya.koppera@microchip.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
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
v1 -> v2
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


