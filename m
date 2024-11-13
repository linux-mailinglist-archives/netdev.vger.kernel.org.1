Return-Path: <netdev+bounces-144588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C49C7D5F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7293A285582
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C6120899A;
	Wed, 13 Nov 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gs1iLeG7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BE207204;
	Wed, 13 Nov 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532329; cv=none; b=Fna34Pz9mUYfL8UaScrvcMKzQ/Si91K/Zttu0AMW0fGaLKeNDdg9nCHMG1tN4HvbbFKe2avkCNG/TI5IkbBHJMuL8DYGVJLeC16C9p0C2Yx3WRVT8v4qBb6XsUCZJe+DFj1534jjuhzfTrc155tqHWL+haO6ezdHfruJ9vIvukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532329; c=relaxed/simple;
	bh=KeW3AYf2jpvtv6/CK8M/J7DhmMsyVE7KO7tfyVKcTQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i4I+Js750TURGsCBPz7lLReqhbBoa0qUk8OZV3nSKQjraJUQtnS+xSP3Eur3zFgxjMtZLp3WVVOtD7mURkvb1ZS93FdcuFWJHM9lTWUXFCTAzmDO/BdVLmb7NkkxWZSG9LasMS2K8OQAmq8dPiEtKOU4xXNU5pKCzG2TAUeaY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gs1iLeG7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731532328; x=1763068328;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KeW3AYf2jpvtv6/CK8M/J7DhmMsyVE7KO7tfyVKcTQM=;
  b=gs1iLeG7xpP1lgknd/vqQ/wcOEqczcGFeqmh6Xcs+qgx29VBl88t1oyD
   qrKjFJUdJadnn3v3FbLGCwzMgcVV0nJduAqwiOp9n9iAftq+DRviiLxnh
   ftUCgfB3Z8kHZrUeaVFwg5rJqjPyOQGgFmVYdMCDc2xrJ/8So0y2LRlPw
   XPyXFHaHnQo3lQHKt5LIoMoZ/ongvgxLbhde4ZKKcXr2PvhPwyGSyt8w9
   ac7X/iBohlBNRDDzMclMv0/+42OZeu57oNLhON3SIUYmiQ6oKbtyPgXxU
   mcqpnU97vdZraMyT60LThoTWDQD92BeUFmmigF1yeWdfnpVKuHLc8uOFB
   A==;
X-CSE-ConnectionGUID: KA3skogJTWSLY1V4ky2YAQ==
X-CSE-MsgGUID: SOa7Gp9mT5CFOabQAhTMcQ==
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="265427893"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 14:12:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Nov 2024 14:11:37 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 13 Nov 2024 14:11:34 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 13 Nov 2024 22:11:09 +0100
Subject: [PATCH net-next v2 1/8] net: sparx5: do some preparation work
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-sparx5-lan969x-switch-driver-4-v2-1-0db98ac096d1@microchip.com>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The sparx5_port_init() does initial configuration of a variety of
different features and options for each port. Some are shared for all
types of devices, some are not. As it is now, common configuration is
done after configuration of low-speed devices. This will not work when
adding RGMII support in a subsequent patch.

In preparation for lan969x RGMII support, move a block of code, that
configures 2g5 devices, down. This ensures that the configuration common
to all devices is done before configuration of 2g5, 5g, 10g and 25g
devices.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 1401761c6251..c929b2a63386 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1067,24 +1067,6 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	if (err)
 		return err;
 
-	/* Configure MAC vlan awareness */
-	err = sparx5_port_max_tags_set(sparx5, port);
-	if (err)
-		return err;
-
-	/* Set Max Length */
-	spx5_rmw(DEV2G5_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
-		 DEV2G5_MAC_MAXLEN_CFG_MAX_LEN,
-		 sparx5,
-		 DEV2G5_MAC_MAXLEN_CFG(port->portno));
-
-	/* 1G/2G5: Signal Detect configuration */
-	spx5_wr(DEV2G5_PCS1G_SD_CFG_SD_POL_SET(sd_pol) |
-		DEV2G5_PCS1G_SD_CFG_SD_SEL_SET(sd_sel) |
-		DEV2G5_PCS1G_SD_CFG_SD_ENA_SET(sd_ena),
-		sparx5,
-		DEV2G5_PCS1G_SD_CFG(port->portno));
-
 	/* Set Pause WM hysteresis */
 	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_START_SET(pause_start) |
 		 QSYS_PAUSE_CFG_PAUSE_STOP_SET(pause_stop) |
@@ -1108,6 +1090,24 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		 ANA_CL_FILTER_CTRL_FILTER_SMAC_MC_DIS,
 		 sparx5, ANA_CL_FILTER_CTRL(port->portno));
 
+	/* Configure MAC vlan awareness */
+	err = sparx5_port_max_tags_set(sparx5, port);
+	if (err)
+		return err;
+
+	/* Set Max Length */
+	spx5_rmw(DEV2G5_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
+		 DEV2G5_MAC_MAXLEN_CFG_MAX_LEN,
+		 sparx5,
+		 DEV2G5_MAC_MAXLEN_CFG(port->portno));
+
+	/* 1G/2G5: Signal Detect configuration */
+	spx5_wr(DEV2G5_PCS1G_SD_CFG_SD_POL_SET(sd_pol) |
+		DEV2G5_PCS1G_SD_CFG_SD_SEL_SET(sd_sel) |
+		DEV2G5_PCS1G_SD_CFG_SD_ENA_SET(sd_ena),
+		sparx5,
+		DEV2G5_PCS1G_SD_CFG(port->portno));
+
 	if (conf->portmode == PHY_INTERFACE_MODE_QSGMII ||
 	    conf->portmode == PHY_INTERFACE_MODE_SGMII) {
 		err = sparx5_serdes_set(sparx5, port, conf);

-- 
2.34.1


