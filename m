Return-Path: <netdev+bounces-226189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEBB9DBAF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB03AA8B6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C122DFA7;
	Thu, 25 Sep 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TAYWWN5G"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210F1D5CFB;
	Thu, 25 Sep 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783128; cv=none; b=RzK3knXD8Z0JFT2VLlujafV9ODcVYPQvswEsC+8praePW6+Xyz0IryRY/dblXJXnQbnf0NJJIqd4KtvqdTfShmlUruuNEKHlVst+c0hkhlS2Yon+7gVPCrc3wfspLw68bokeuZnvs6XABA87fDPB2UQyGM3sxDZlMt+e7R1fkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783128; c=relaxed/simple;
	bh=fQQ50PR0PgPFlQf8/sEwyfSHGzGT2RZAT2YH1IjmRCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RcPNp6rB/gaNicJuj0N6WF974Yac2TjgstHfEYZU6IQ5SByhw/OlksQ4Kqz4HXtRMr9p/+46FRln3b7UidFUL0opkBjRqeSuBxG3OpDoLRP9QEenmCVNziqUzYzLw9j/5QN8NDrqyEedBRpWtn+JWTYmMvZh0vZzVIBG4zyeFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TAYWWN5G; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758783126; x=1790319126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fQQ50PR0PgPFlQf8/sEwyfSHGzGT2RZAT2YH1IjmRCw=;
  b=TAYWWN5Ge9rppGyFC9C+Oo86tCphHndQs2nid0dB8omKPSngiZjzXh72
   XQYMJ9+qmGHCYkDlCT+7HCwt6WuxfOp1GKFndLZlv3WKF1BLEW8uwnN+0
   Wvp8r9jjCaJvdi4W/tcVCuGtBTvo0svGcjMrQLI4JHciCyPyNVmREjBBK
   7VADXgwgrTP/Bq/WxCV6KIaAve6rZJBHYTg2QsgGS6AjcvEVLNf+DAf82
   TnB6UNpIvCXIlYfYhDANJ3zQCCDlmvTLcOytQVj0IpjgffX7hYtOZQGEH
   9SRxpUuZ2q0QqIVqw4GCCUjGY7MzR/8i/J+qrQpUmZVDmOQZo5ey02YZa
   Q==;
X-CSE-ConnectionGUID: h7nOp6bzTJGeaKMDNeEAFQ==
X-CSE-MsgGUID: TZOrH604Rhim90OYIMkirg==
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="46965777"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2025 23:51:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 24 Sep 2025 23:51:19 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 24 Sep 2025 23:51:17 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Fix lan8814_config_init
Date: Thu, 25 Sep 2025 08:47:02 +0200
Message-ID: <20250925064702.3906950-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The blamed commit introduced the function lanphy_modify_page_reg which
as name suggests it, it modifies the registers. In the same commit we
have started to use this function inside the drivers. The problem is
that in the function lan8814_config_init we passed the wrong page number
when disabling the aneg towards host side. We passed extended page number
4(LAN8814_PAGE_COMMON_REGS) instead of extended page
5(LAN8814_PAGE_PORT_REGS)

Fixes: a0de636ed7a264 ("net: phy: micrel: Introduce lanphy_modify_page_reg")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
this is targeting net-next and not net because the blamed commit doesn't
exist on net
---
 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 0b42400e5e098..79ce3eb6752b6 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4367,7 +4367,7 @@ static int lan8814_config_init(struct phy_device *phydev)
 			       LAN8814_QSGMII_SOFT_RESET_BIT);
 
 	/* Disable ANEG with QSGMII PCS Host side */
-	lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
 			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
 			       0);
-- 
2.34.1


