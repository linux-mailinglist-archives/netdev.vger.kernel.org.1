Return-Path: <netdev+bounces-97931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4428CE2A9
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB0128272F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A62128376;
	Fri, 24 May 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pksfY+HR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DC29AB;
	Fri, 24 May 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541007; cv=none; b=NYFoFCKkwrN2hroC20+pTW4g3xxvK+rdPxIh08hToj2a4P9cfKDbUHH8k6SZmlOLwLZ9ITg3OeUBuwkGfLIStPczzQSelm6kKF2Uy5vUQSeFNGYHSJdGbaBclZst4x5CDHK3GS3uPgMGQittIcoyEq6VD6EgxSeH8fRxzwpz1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541007; c=relaxed/simple;
	bh=zOnNjjQlnZgw6plWUTz4wcNjAHRlI4pl9KHutj3RZ/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XGbmyW1oQyHpF8dQhmsfHCelHH7jhliMLMGvx25b5GJg1xC8HWUBSwv0KnsgH8QLY/q4cgWtirnXWhF2mgoV6dnaObcHXMp7ujDNuJprcmWAM6Kf5Xc4GZbeKLxLonjomQknYUdTI/OfnJuAyUmnGzpxeIDZ7TvmfZGvgHOkC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pksfY+HR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716541005; x=1748077005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOnNjjQlnZgw6plWUTz4wcNjAHRlI4pl9KHutj3RZ/E=;
  b=pksfY+HR8ZJVV9iuv/h5dNjDLUmuTok94OgUv/217b/WEhfURwzfdDI9
   ZMUCTBsNhOFycIsavrmPzi8mvxG1dfEbtadNFcne/g0+iR7+h9ir1DUwh
   1AZ2yYLbbOtclVidqTLz4m6BEP3jQv7Eknfav6lyJksoaMJ7UTftml+dB
   +EeDGYvaryADFUTNayllfzPXD1dzZYhS9QXw7CRmwInZbHPNZC+wIopEu
   OW0By2JVJvdC7zakI3E2A2bfXiF93RFutP7The16+9LmMOKgrrJNzqE0R
   i9LYpxnq5/caGpoxJ4I5DFxgkJ0DtRVBRyKzb2Moj/8ULG3/jdchM4p9t
   Q==;
X-CSE-ConnectionGUID: DvDbo6VsSsGYja2SLKTuBw==
X-CSE-MsgGUID: m7rZXmPxTPSVDRTPhGUGBg==
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="26047010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2024 01:56:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 May 2024 01:56:36 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 24 May 2024 01:56:34 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <sumang@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2] net: micrel: Fix lan8841_config_intr after getting out of sleep mode
Date: Fri, 24 May 2024 10:53:50 +0200
Message-ID: <20240524085350.359812-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the interrupt is enabled, the function lan8841_config_intr tries to
clear any pending interrupts by reading the interrupt status, then
checks the return value for errors and then continue to enable the
interrupt. It has been seen that once the system gets out of sleep mode,
the interrupt status has the value 0x400 meaning that the PHY detected
that the link was in low power. That is correct value but the problem is
that the check is wrong.  We try to check for errors but we return an
error also in this case which is not an error. Therefore fix this by
returning only when there is an error.

Fixes: a8f1a19d27ef ("net: micrel: Add support for lan8841 PHY")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- do the same also in case the interrupts are disabled.
---
 drivers/net/phy/micrel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 13e30ea7eec5d..c0773d74d5104 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4029,7 +4029,7 @@ static int lan8841_config_intr(struct phy_device *phydev)
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		err = phy_read(phydev, LAN8814_INTS);
-		if (err)
+		if (err < 0)
 			return err;
 
 		/* Enable / disable interrupts. It is OK to enable PTP interrupt
@@ -4045,6 +4045,14 @@ static int lan8841_config_intr(struct phy_device *phydev)
 			return err;
 
 		err = phy_read(phydev, LAN8814_INTS);
+		if (err < 0)
+			return err;
+
+		/* Getting a positive value doesn't mean that is an error, it
+		 * just indicates what was the status. Therefore make sure to
+		 * clear the value and say that there is no error.
+		 */
+		err = 0;
 	}
 
 	return err;
-- 
2.34.1


