Return-Path: <netdev+bounces-36092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAB7AD2A0
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8D5201C204F7
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E01119D;
	Mon, 25 Sep 2023 08:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2957CA5D
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:02:16 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E71B3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695628936; x=1727164936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0+2Iy2xbSqXDIPVaBizBpUorgXvRuGyAr8zPG5G5ik=;
  b=Y83D8oDuNrFFmP8vUh3tdQowjUevXO6/ePlgYbAog2OBd60761PqoyMg
   xm2LsVKB9t+FtlRCN+kg+H73xK2WOtCLuvBFqezG9CRl6XnGd2XjBMZGV
   0Meg+Xr+nsn2/PmsbrkwGWMHGqFo51GqHoJYTB3KTLWksSvEq11h3NY29
   ohPGFqisHf4ygomZJialpz+4ZGdcomlULulX9rnLJugUO3vidBIT3LFyp
   RZz6Rlct7fYPhiNSCyJsePmyXQNoBAmyhSvG+5KWmkLJDDLWIFynPcHI2
   sdPYCWlmj3pQ34OrrYU9omzCxC+vukFI81xCqYp3HoJ2IRoYNcJzDUOMi
   A==;
X-CSE-ConnectionGUID: VBERyH2JRFKo6Q9UcpwIeA==
X-CSE-MsgGUID: 4tsKIINfQtGTxVY8XjUlBg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="236952379"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2023 01:01:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 25 Sep 2023 01:01:53 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 25 Sep 2023 01:01:51 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <Jose.Abreu@synopsys.com>, <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1] net: sfp: add quirk for FS's 2.5G copper SFP
Date: Mon, 25 Sep 2023 13:30:59 +0530
Message-ID: <20230925080059.266240-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a quirk for a copper SFP that identifies itself as "FS" "SFP-2.5G-T".
This module's PHY is inaccessible, and can only run at 2500base-X with the
host without negotiation. Add a quirk to enable the 2500base-X interface mode
with 2500base-T support and disable auto negotiation.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---

Change List:
============
V0 -> V1:
  - As per review comments, removed FS's DAC10 cable changes
    (i.e. [PATCH net-next 2/2] net: sfp: add quirk for FS's DAC10G SFP
(SFPP-PC01))

 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ecfac227865..297d7ce3e7d0 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -463,6 +463,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// FS 2.5G Base-T
+	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
-- 
2.34.1


