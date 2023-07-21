Return-Path: <netdev+bounces-19736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31FB75BE31
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43431C21614
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541F10FC;
	Fri, 21 Jul 2023 06:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B5A5B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:02:35 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6945273C;
	Thu, 20 Jul 2023 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919329; x=1721455329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6CQs54q/v1moVIj+/SNnFPZ3nakzOWZlEo//zuDhx4=;
  b=koCqNK40ZAmbxWg6sUIMP8ZSR6FaH2+0fmsOH/VvaUy3lSj7IZ5U7jP5
   YQdV2tU+ABXBZ5/IpqDcSTPijEBTjQ0SxivEGGp3C4H5CZYESXtV71ko0
   VtZUd7OXnjXKe9sC2XnPFcmtjuUsGNwrFp2EuwLXaXqxhcdlxznPcLPZt
   mGuNFm7buTcbfgmx2Dii/Yr1bV8rmRJHTvcVgWiTInYYAzzWGauil2IZ8
   cS/NBuu8qszi6QA1gJ5u+rd02q30WndZZ5iIBrpyjE3yYr8nExBCmfnka
   GMGtSZELxj/N77MsRY2rNcg1cvotAda4N6jfT06P2RkajoZ1RNoG4mjgU
   A==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="221463770"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:01:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:01:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:01:14 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 2/2] net: sfp: add quirk for FS's DAC10G SFP (SFPP-PC01)
Date: Fri, 21 Jul 2023 11:30:57 +0530
Message-ID: <20230721060057.2998-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
References: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
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
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a quirk for a DAC10G SFP that identifies itself as "FS" "SFPP-PC01".
Add a quirk to enable the SGMII interface, modes 2500base-T, 1000base-T,
100base-T/Full and 100base-T/Half support.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/sfp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index ee049efdf71b..80d2680f08ab 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -421,6 +421,18 @@ static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
 	sfp_quirk_disable_autoneg(id, modes, interfaces);
 }
 
+static void sfp_quirk_fs_dac(const struct sfp_eeprom_id *id,
+			     unsigned long *modes,
+			     unsigned long *interfaces)
+{
+	/* Fiberstore(FS)'s DAC SFP (SFPP-PC01) */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, modes);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
+}
+
 static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 				      unsigned long *modes,
 				      unsigned long *interfaces)
@@ -465,6 +477,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	// FS 2.5G Base-T
 	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	// FS DAC10G (SFPP-PC01)
+	SFP_QUIRK_M("FS", "SFPP-PC01", sfp_quirk_fs_dac),
 
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
-- 
2.25.1


