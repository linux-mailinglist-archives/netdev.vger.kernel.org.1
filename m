Return-Path: <netdev+bounces-153689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD49F9394
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C191887DF9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301B21576A;
	Fri, 20 Dec 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w7XCvE4g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0971A2564;
	Fri, 20 Dec 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702574; cv=none; b=SQ6DMArJr89D7krI+vAGEb7tVjifr+g/M29JQLx4P7HeO25oKqPN2fK9iazF7OkkuDHHKgP/R0i6Iv0VYNLbbjQRiZZ2ByQBAtht2bE5vX+P7QCB6L8vyGf11YgM90ppGmqiKLdo3uzeo/5Fyg/S6sxdUuVODehnY0IzkL/RHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702574; c=relaxed/simple;
	bh=Fa4MoYSUgEAXJYUJjfJyLnvfZej585cUVu/9qUSRj/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nXa7+0ydFdLyg3AuPhxCTLh29GO7C1ZNk+au5wp3FgxBgfGV7JoXLCM2D5gwD5ZBgcth9NzZ2R7hCoFv0Ejcy3GCvcfhEgyWYhfRxEt1/I5ceylLIO1lZDAy3U7YXLgRNf5/hIgX4qHWra1PTicjgflRazUIw+wIDon07LFWXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w7XCvE4g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702573; x=1766238573;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Fa4MoYSUgEAXJYUJjfJyLnvfZej585cUVu/9qUSRj/4=;
  b=w7XCvE4glx0hw1Z3H+OmnGQB7t+kie8YrgBt0jHFCbWWqEkPXKyYtdNs
   SQN1bir70fDBNdH7CHVYWoCovLtDJ6cknFZWpA+mZU+pKYKWgJ3FEgmp7
   JLkZMs1/jCMkgsVyTKcNd/0uyBskvOq+xj0bsDLs5pEkp9ztFccuILgo6
   hjm+DBWnXrJt9XTkNQb5fkj63YH/TsGX7mvCuO+HZ8OTd/qdyiuUxc+RM
   srMgMBiGTIBO6bvRV/riY8y4fLJI74rqNVPXgOXWe/76uxMVPCtF/VKDS
   tkZ3/oerCk4sU0BGO96ar3WyCCX5F8oYi+LV6R/nMpQKmK8xnqVeh8BfA
   w==;
X-CSE-ConnectionGUID: mIAoSPyhQLi+IAfuQfXUsw==
X-CSE-MsgGUID: p1rymG+1Th2KUDbqhNuMNg==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="267028392"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:48:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:48:51 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:40 +0100
Subject: [PATCH net-next v5 1/9] net: sparx5: do some preparation work
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-1-fa8ba5dff732@microchip.com>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
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
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index f9d1a6bb9bff..f39bf4878e11 100644
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


