Return-Path: <netdev+bounces-97706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7D8CCD31
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE243B217D6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8413C9CD;
	Thu, 23 May 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DTgbxwgq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE343B29D;
	Thu, 23 May 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450207; cv=none; b=OfErQklekUbhkI5XnI+Ejg2JVexbgxcc58FyFwnK+OUw7H/YW0RioDBBrt4CZTT16hVJgTRt1uTttmFQc98R9rr3+VmBG5GoMiaNtEqEnymNUER0tpbSGWt4czb822GKD5zcmRJ5s+fryZSECwpI39W4vsj++uwt+novHnQ9owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450207; c=relaxed/simple;
	bh=hx8x5NT6gYjGcXh/GIKgZ9Q3VtbgTcRowFPOrTkUOQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kOB0YjeGSzH6/LC24Jmxgz/jvIXvpZxNEPjAxyUHNQErgjrewF+G+TSBEVKfuJrN9lvjPFZbpd0ttHnifiw2ACg2LIScwhS229+OzxHFk3fdIL+SyZtK9qVOTMd6rQtC/GltWKVTiNoGuyL3Fe74BfpwN2vu7TUArTVGQb+2Nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DTgbxwgq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716450205; x=1747986205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hx8x5NT6gYjGcXh/GIKgZ9Q3VtbgTcRowFPOrTkUOQI=;
  b=DTgbxwgqcLlp/+G2Qp+g73mG6VhHF2nSlKORlOQ336Dj0yHBStzzNCbx
   LDKPgTlt56HDCVGQRImPyXAWle5CvfkZ2Z0oyfKE+Z02Z+xLl1IimgAzi
   8oS3GayvdruJVzhdOH/33Bk5+ViuVKRLbw4TGL5n+y3epHTg38eXqMqBb
   m0OLMwKSICHuv9ZvfBhUsvj/IHWsCRHl1YzYRkaRwUCkom4N8xU0YkgRY
   s4q0QcgZpfs7GCV6yKZAuVMC8BYmkSYw9Pgiu35Bl05zuraZ58PBarCCm
   mJ3kLhx4HuTpsdjKmkzYqDuc6BvqB9brxfKUSW20THHqiBZyoJyAUbHwO
   g==;
X-CSE-ConnectionGUID: fDMj33hCS5iEOCfkyK243g==
X-CSE-MsgGUID: v3vEib1/SUGLu1Ii73sKbw==
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="26474956"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 00:43:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 00:42:33 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 00:42:31 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: micrel: Fix lan8841_config_intr after getting out of sleep mode
Date: Thu, 23 May 2024 09:42:26 +0200
Message-ID: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
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
 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 13e30ea7eec5d..79477f0c90d82 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4029,7 +4029,7 @@ static int lan8841_config_intr(struct phy_device *phydev)
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		err = phy_read(phydev, LAN8814_INTS);
-		if (err)
+		if (err < 0)
 			return err;
 
 		/* Enable / disable interrupts. It is OK to enable PTP interrupt
-- 
2.34.1


