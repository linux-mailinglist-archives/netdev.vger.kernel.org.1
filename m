Return-Path: <netdev+bounces-232250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F0C03280
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1E38506173
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978C2356C7;
	Thu, 23 Oct 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UlE0riLV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE934CFD3;
	Thu, 23 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246963; cv=none; b=Vp5p3dNiecMzXqqu7GHNCc5j7veDyeAqkLz11AXix/FT20MzflfR7sGpDMCAX6GevAkt4QRYjGjCuemAgfW5npYJazDoFWpHQ+G8m6og+yuI/n7fNSZT9PmwxQMoeu8UM0HwWRG0Ohou0oJIGhdfsWtJY8rcHKuaduJ8ubbvEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246963; c=relaxed/simple;
	bh=uh5+lqrS/SBTXR/rciPknKgV/zgEE2VyVIqvRo/hAGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1cZCsxsdR1MuRRCX3g8xbLANXwCXdm5RTbKfEMCfH4OnEysYMc5veeWtvi4DNi7BPCjmfCdPg76MjWmjU3RtF94SqUXlSflAkk3PMOcghQ6YKFY21++rG0+VCCCzXalL9yj1EardWLIxDIAyi2LqCOG5iA4KC3OJnLBlH+O2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UlE0riLV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761246961; x=1792782961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uh5+lqrS/SBTXR/rciPknKgV/zgEE2VyVIqvRo/hAGw=;
  b=UlE0riLVJ/y+MHGYnF7S7wGUf/iGDfg6U6BFOUnyCyMhcJPcyS+DmXN9
   gEOyiC7PWirMsUybWYn+OzFObBjcny4WBKkGO4LYkTHiweWKGZqW9e0G8
   lWCpyb5x5aCakRQwlkRvjI9pGk62Q375LAuAi9O0KwR8UvTujKRaSk5se
   5nS7V0BDPQW5EdTdRlbkh5ja/raFvsQ0KIlIkFVJfOr1sFvcwMGHNeQTB
   M4GB8aUpGg6WW1BE5AqjEY6xIkj9pyaKAJ3qc7zvEVbluZDhexhIUjghL
   YtOMm5H3wrL0H7XZcUVYtbVrUAShy/yK942hI5wXLDhDlP3zQXJzDRE40
   Q==;
X-CSE-ConnectionGUID: Bo16A/8xSLi5sWxfr2eeOg==
X-CSE-MsgGUID: Z7o9yn77Q+KSRfPvVIZjQw==
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="215529397"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2025 12:16:00 -0700
Received: from chn-vm-ex2.mchp-main.com (10.10.87.31) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 23 Oct 2025 12:15:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Thu, 23 Oct 2025 12:15:19 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 23 Oct 2025 12:15:16 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <steen.hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Date: Thu, 23 Oct 2025 21:13:50 +0200
Message-ID: <20251023191350.190940-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023191350.190940-1-horatiu.vultur@microchip.com>
References: <20251023191350.190940-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP initialization is two-step. First part are the function
vsc8584_ptp_probe_once() and vsc8584_ptp_probe() at probe time which
initialize the locks, queues, creates the PTP device. The second part is
the function vsc8584_ptp_init() at config_init() time which initialize
PTP in the HW.

For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
missing the first part but it makes the second part. Meaning that the
ptp_clock_register() is never called.

There is no crash without the first part when enabling PTP but this is
unexpected because some PHys have PTP functionality exposed by the
driver and some don't even though they share the same PTP clock PTP.

Fixes: 774626fa440e ("net: phy: mscc: Add PTP support for 2 more VSC PHYs")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 9343ed3b000d4..8678ebf89cca5 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2613,7 +2613,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
@@ -2636,12 +2636,12 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_aneg    = &vsc85xx_config_aneg,
 	.aneg_done	= &genphy_aneg_done,
 	.read_status	= &vsc85xx_read_status,
-	.handle_interrupt = vsc85xx_handle_interrupt,
+	.handle_interrupt = vsc8584_handle_interrupt,
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
-- 
2.34.1


