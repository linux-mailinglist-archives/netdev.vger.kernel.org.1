Return-Path: <netdev+bounces-134108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D914099805B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829B81F2564B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FC1CC152;
	Thu, 10 Oct 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OmgXuK1f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F701CBE92;
	Thu, 10 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548593; cv=none; b=PrvmMLXTRAMS0q4bG7P2eo4HD6Ub5lmnEw2e2lHnU/tBvMGejLHVzSsYWxzQyL9Wh37GWzr/F/pvzuo6ZT4wHjCxAsYgSHOyjQPI6BxdzzgVOtHbA4n3WbeT014DbclGM7IoJkPmVhPvnCSJplI2eQnu301kxbC1LYmbBDW3fD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548593; c=relaxed/simple;
	bh=zTw7acJ7fOs6jwTWn4qAjPWyO4lr3JryK1WoEZU2JDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exEwGdcys5chmIXrGJ2KTtYq5noRT9GFjScNQneUpxlT/+db/biWzLg1EXE30FajqucJQ8LY4AGXUtqCmy/z2CyMjY5zaK883+Sn8KKfPye832lEGeV3yYachX3BhblZEpBLUHAIwLb9pVtPrAWSjHlkBLrmmedTS1nmtQnVtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OmgXuK1f; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548591; x=1760084591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zTw7acJ7fOs6jwTWn4qAjPWyO4lr3JryK1WoEZU2JDw=;
  b=OmgXuK1fsTFrEn/3MLKJrPf9T8HUnB9gt3AT8L9NA0+kmNOV6r9Fi9SD
   F+0hlfHMWpsCjd24/vJ8QV51fwqD5P9ElN8vK2PYWjJJf2HHMfOzJYfFw
   Fw141is3Ue9da0hbXkTiDd8XbCrEnBintpfX+rtPCij2SBtrIq4sqsT0v
   DeICOq1iS5xnlYMjWJVdXmjg9dqrOaZZFHeimfRNUaVYAwhw31UloAIil
   rPwbAXhhar4znm4ujMhNfT7+Mj+noG7e2yVRASsa661Ja7L3mS72eM/Xv
   z8TyMiSXolCjZVeeJyktRlyBt1n7SAaFb3uajtAa6/2ZdCVjNPUZHb7LF
   A==;
X-CSE-ConnectionGUID: D165IrQCQQaSZj0APvNNjA==
X-CSE-MsgGUID: u7FeyX/sQ/SSqhG1N6unLw==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163261"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:23:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:43 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:40 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 4/7] net: phy: microchip_t1s: move LAN867X reset handling to a new function
Date: Thu, 10 Oct 2024 13:52:02 +0530
Message-ID: <20241010082205.221493-5-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
References: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move LAN867X reset handling code to a new function called
lan867x_check_reset_complete() which will be useful for the next patch
which also uses the same code to handle the reset functionality.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index b21f5acb4468..d9814a09a026 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -266,7 +266,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int lan867x_revb1_config_init(struct phy_device *phydev)
+static int lan867x_check_reset_complete(struct phy_device *phydev)
 {
 	int err;
 
@@ -288,6 +288,17 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 		}
 	}
 
+	return 0;
+}
+
+static int lan867x_revb1_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	err = lan867x_check_reset_complete(phydev);
+	if (err)
+		return err;
+
 	/* Reference to AN1699
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
 	 * AN1699 says Read, Modify, Write, but the Write is not required if the
-- 
2.34.1


