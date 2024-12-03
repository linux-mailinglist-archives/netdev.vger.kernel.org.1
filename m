Return-Path: <netdev+bounces-148408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF49E1657
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CD62813DC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D231DF25B;
	Tue,  3 Dec 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RFjEPE5J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF61DE3DD;
	Tue,  3 Dec 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216006; cv=none; b=ZPAn/v5ktDEARTV7YSCN0yr53P6sDcJdT1EDcmrBAGATGdFtXmUYF5/kWkV6geNF29rnJjpJtttRI3Wur5ntWPEtFi8GvbfUfZB4DQh46YCUDxdZpQhUKEJcM90IX98/zMqxVYS1dJS2t+zCMGTVXctfGMlAhNayYjFcVELCacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216006; c=relaxed/simple;
	bh=R2YS/jxJJHXhfd3FlZKNHPOX1QbTk8Ssq28VLClREyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDcEXZe3yYx5dTWXy05o95p9KtllxrcT0mncybQ6jxTgqR8KmjhcSJNnH97mgeIEXV278yVO81nMMRwPxOWqHK76nX3l58fZj9oor4HwLhxDtxV4Mncf0Pdhg2pYAMWo95TGIkOl7cQwWZWCUIm/fcbqvxI0G3JXDbKp2dD4/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RFjEPE5J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733216005; x=1764752005;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=R2YS/jxJJHXhfd3FlZKNHPOX1QbTk8Ssq28VLClREyw=;
  b=RFjEPE5J87tAwCiAidHSDN7zvg7V+2r1xnar6PiuVGsLSmyh3Xpvne7c
   gJcifyy8TSb0A7UN3ktJr1b0L4CSWsYDp8BpGSinjogBd0E427H8f+oij
   tHDdmGHRkUsIwew2euiVnBkwCCQVqUXk7cU+Cajq8lbkpWKHZFXoJ18y2
   Hxc0U7hrZ3zWEVlyPcTWXYR07PTQ4lXgihqWGptn1ZbnzAXopu13XEdoX
   GZFxrTtM2Xtfos7UEmNyAPHnDa18KM3XT4AqVAra+V0SWiR5ytXzw2488
   p/6rwqksHHYJKJAtj1+H1NYCPb/XQtLuospyCjN4LWgo3d15e1o+5Tvda
   w==;
X-CSE-ConnectionGUID: PYHc5D2VTXmCViyiEXibzQ==
X-CSE-MsgGUID: /h0mBHLpT6Ss8waaMj/pSw==
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="38706053"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Dec 2024 01:53:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Dec 2024 01:53:04 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Dec 2024 01:53:00 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library support and 1588 optional flag in Microchip phys
Date: Tue, 3 Dec 2024 14:22:46 +0530
Message-ID: <20241203085248.14575-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241203085248.14575-1-divya.koppera@microchip.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
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
index 15828f4710a9..e97d389bb250 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -287,8 +287,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING && \
+				  PTP_1588_CLOCK_OPTIONAL
 	help
-	  Supports the LAN87XX PHYs.
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHYPTP
+	tristate "Microchip PHY PTP"
+	help
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


