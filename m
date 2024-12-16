Return-Path: <netdev+bounces-152273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7F9F3544
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0686F1885B27
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E714AD1A;
	Mon, 16 Dec 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ScZZk999"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592413CA8A;
	Mon, 16 Dec 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365111; cv=none; b=OZIW13xWLBGvRbWGaZylSc8TAZM8fyZkFwzTVXFUTS3joB16mwHF8v724Pme1KYjYQaEoJm2zxg7lXpox9npcF14RmbqvjHxQg8fg48iZeu8zMZBY1px0njZLsF1Rb9mINXlsI9VESG3/92FaRIyBh5mMmZDMV8xw9Z6/60ub7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365111; c=relaxed/simple;
	bh=g2L9AVMHjMM8Fux6Jl1wU67ei42PttT/3ytQHwPmz6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmvIXWEnrTRmKHzzzZ+GYRmrUtLsOJJKPx1O+8dKaXkkzoGIbmDi7IgsBCkZ2K+zWIp2uAm79/QDfearVW0XhzHHQHC3lOfwLfuyoDhlkDXopE6L+o7Xf766D4Ei/q+y6p9TJJLAaSH9Iv8h0k6trCAlpZghIOPR1j3EIKyp0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ScZZk999; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734365110; x=1765901110;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=g2L9AVMHjMM8Fux6Jl1wU67ei42PttT/3ytQHwPmz6w=;
  b=ScZZk999bhIgida4zrZhG2507Bd+qeyken1YnsOIuYys6cvqSKpbmKHJ
   wzGG7ns5gjfd9iqN4Y5Wvhn8jcRoPTLVZYZzcHRU4Ya5ZWcSbNnHRYPsi
   5HooRS7T02q+gBRpIn1fXltKZwKy6CCbp3YN5sHk/2fP/IbHSak8TrNWP
   bBq2uYGGwPm9R8a/8sXilyoJDVRGvC9Z6EfujNKKZkgURHAXRJ/P2mU+n
   eppwZafLpkMrEu6CrMBEWsHmjiJ5Gb9Fi9oJGlLyCNF+oXV9K5nnOdwD3
   Bq8gLBLT7YeL4kYTfF+tKmIq/leUWB+OGi/WoNpyr5yf5GUJaoRcnq4Nh
   w==;
X-CSE-ConnectionGUID: AYfWQnHXTgabemkJFcJ5hA==
X-CSE-MsgGUID: emnjFK2eS3yh/VLiN+ap9A==
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="266819350"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 09:05:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 09:04:28 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Dec 2024 09:04:24 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] net: phy: phy-c45: Auto-negotiation restart status check for T1 phy
Date: Mon, 16 Dec 2024 21:28:29 +0530
Message-ID: <20241216155830.501596-2-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216155830.501596-1-Tarun.Alle@microchip.com>
References: <20241216155830.501596-1-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for auto-negotiation restart status check for T1 phys.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
v1 -> v2
- Separated out the fix patch.
- Changed the commit message.
---
 drivers/net/phy/phy-c45.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0dac08e85304..58be2d534b5c 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -418,11 +418,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_aneg_done);
 int genphy_c45_read_link(struct phy_device *phydev)
 {
 	u32 mmd_mask = MDIO_DEVS_PMAPMD;
+	u16 reg = MDIO_CTRL1;
 	int val, devad;
 	bool link = true;
 
 	if (phydev->c45_ids.mmds_present & MDIO_DEVS_AN) {
-		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_CTRL1);
+		if (genphy_c45_baset1_able(phydev))
+			reg = MDIO_AN_T1_CTRL;
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
 		if (val < 0)
 			return val;
 
-- 
2.34.1


