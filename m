Return-Path: <netdev+bounces-150259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610619E9A3A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB987163451
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CC1C5CBC;
	Mon,  9 Dec 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aNEt/IsR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC761B423B;
	Mon,  9 Dec 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757501; cv=none; b=mmOa1/UG4E94cnCcaIQwyDx68wG6ct+BwL/v6oxwdhGHLw6zkLVHMLa68ha+imozJ9EICGVfkbP/DZ3vpm07EVFFSg3oU5q2/jn/bsSIfGAbSSoCTruFcnLTNh+H2GBULy7EZ19lF0dbHW5sLEHgfM4dU7I2fOusMnlxvwa9srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757501; c=relaxed/simple;
	bh=34Kvhd9rXAxxfCnK//kvZ21jMyc9BazOQaCB2lv9p6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jApVaYgt2DnkfNLyl0y5fBqnp3fO7rUeJM+1DrEwJfqO6o8uqevm1CzbkDQEyr0/xG6tmJ+h3Dk3SyPg6CopJ+MwdFePyoD6pJJIZ899RMafKzqLAPYM+Ibqq/wBeoe9W5vKEOU/UM13OzuqIT5IivZ5RV4JujZ+BMqG4dfbEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aNEt/IsR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733757500; x=1765293500;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=34Kvhd9rXAxxfCnK//kvZ21jMyc9BazOQaCB2lv9p6k=;
  b=aNEt/IsRVkALWae/ACyVnVVYT4k1F+G/LgSalm638YQqZLgOqPE2Egbp
   Igi49RqvmJCkf5ej82oTxYthWJGbqQ/c7ZpgkiBp95WUD9Izl+F9taHqr
   ZA2rdRxMJ8hul6R07X4Pk9EpZsdx3NzyG/Uw5Xy+uDz2efQkGUY0NcU9j
   58Mog9v+3B6ibzQG306aa2jIWIFOubYcTXEzS9i6Wjf8jAok5piWY51T9
   T/cPiFO4DfRBPgKyZIlpYB0AL43R46P2x21v16/CePZsl7cHZOZNgJQiz
   EL98nkjh90ij0L+Q/sTX8kvtf9Ymn8d5TvIyWGdxcv7lj+JOyP5JhQEu1
   g==;
X-CSE-ConnectionGUID: yJIa2BtxQkuJT04wZ40P6A==
X-CSE-MsgGUID: tWARgQsjTA2f1+q38CqAwA==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35775868"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 08:18:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 08:17:49 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 08:17:45 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v6 3/5] net: phy: Kconfig: Add rds ptp library support and 1588 optional flag in Microchip phys
Date: Mon, 9 Dec 2024 20:47:40 +0530
Message-ID: <20241209151742.9128-4-divya.koppera@microchip.com>
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

Add ptp library support in Kconfig
As some of Microchip T1 phys support ptp, add dependency
of 1588 optional flag in Kconfig

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
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


