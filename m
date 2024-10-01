Return-Path: <netdev+bounces-130904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4198BE9B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7921F21FEB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A261CBE9D;
	Tue,  1 Oct 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WRSWKcVG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C91CB504;
	Tue,  1 Oct 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790721; cv=none; b=gk5LiIe85IuNiMIzgdHHqz90nXryOYTPkGWUnSsbBli5b5jiBa/W7EdhdPimyySdLtKXapoJJmJemLcbIvpv5N4bevJiCILN14xlKX/lVcS6WDBiZacFxO/CMz3L70q++54vEM/V3GjBsd0KpKs10ht8O05XgrStThq8G1Rwvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790721; c=relaxed/simple;
	bh=dYy4r8ISm2V8ld8hHER5aCI5QMUspN453eapeLoaIDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N0VKJud3yjMl+eRg6MpZtcWqACxUWbMm8nALpOhqxJXO3oiDhoQpOK694cQ89OSpsN73OjzZTvbiSx3mjjKGsyjKkhWH2WoAyHqpiVl6tS2Mnj8qLbJ7WBmercL1KHxnrkbrF4gbFAN+luSoy2kz6KnGQZyHRAn36sBYvfQ8/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WRSWKcVG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790719; x=1759326719;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dYy4r8ISm2V8ld8hHER5aCI5QMUspN453eapeLoaIDI=;
  b=WRSWKcVG9VB3C8OdhFhGqvxNRuJbHGUZ69xBdzfTNs1JHGij/pjCKV82
   sBNuot721gw+bVhA8/RUi9R+HnLLhKQQt8yG7Lnj3S5SMfmrKU+jsRKFz
   lAS9xeHepYmOS4wonW7yOu79U7dbyvIinwNNCXgFFk639+1OjSZMYrg9M
   abGlVfPFkoZD0JK4tr9R3TCs6DEpqwHC2jVIhOlz0JxcZ7QGMk4wkuOrw
   Ru2h/ZoemqKQ4NQSsyLwmVwkk8mxb7+SKOAUs7kmjOofAmSOeePfwum7Z
   tYTZ2ZJCHAi5GWQOtLANSOuvV9GVgjS+J5I1+A28fceTNljnE7wWw49ag
   Q==;
X-CSE-ConnectionGUID: Cvj7zfnKQLmxTbAcCPAKFQ==
X-CSE-MsgGUID: wCIexvkqTMGn/6PmkGUIOA==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="32447686"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:29 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:26 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:39 +0200
Subject: [PATCH net-next 09/15] net: sparx5: add ops to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-9-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add new struct sparx5_ops, containing functions that needs to be
different as the implementation differs on Sparx5 and lan969x. Initially
we add functions for checking the port type (2g5, 5g, 10g or 25g) based
on the port number. Update the code to use the ops instead of the
platform specific functions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  8 +++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  8 +++++
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 34 +++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_port.h    | 12 +++++---
 4 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 4b3e6986af55..8b1033c49cfe 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -977,12 +977,20 @@ static const struct sparx5_consts sparx5_consts = {
 	.tod_pin             = 4,
 };
 
+static const struct sparx5_ops sparx5_ops = {
+	.is_port_2g5             = &sparx5_port_is_2g5,
+	.is_port_5g              = &sparx5_port_is_5g,
+	.is_port_10g             = &sparx5_port_is_10g,
+	.is_port_25g             = &sparx5_port_is_25g,
+};
+
 static const struct sparx5_match_data sparx5_desc = {
 	.iomap = sparx5_main_iomap,
 	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
 	.ioranges = 3,
 	.regs = &sparx5_regs,
 	.consts = &sparx5_consts,
+	.ops = &sparx5_ops,
 };
 
 static const struct of_device_id mchp_sparx5_match[] = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8398f32ffaad..5a8a37681312 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -260,6 +260,13 @@ struct sparx5_consts {
 	u32 tod_pin;             /* PTP TOD pin */
 };
 
+struct sparx5_ops {
+	bool (*is_port_2g5)(int portno);
+	bool (*is_port_5g)(int portno);
+	bool (*is_port_10g)(int portno);
+	bool (*is_port_25g)(int portno);
+};
+
 struct sparx5_main_io_resource {
 	enum sparx5_target id;
 	phys_addr_t offset;
@@ -269,6 +276,7 @@ struct sparx5_main_io_resource {
 struct sparx5_match_data {
 	const struct sparx5_regs *regs;
 	const struct sparx5_consts *consts;
+	const struct sparx5_ops *ops;
 	const struct sparx5_main_io_resource *iomap;
 	int ioranges;
 	int iomap_size;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index ea3454342665..c5dfe0fa847b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -213,11 +213,13 @@ static int sparx5_port_verify_speed(struct sparx5 *sparx5,
 				    struct sparx5_port *port,
 				    struct sparx5_port_config *conf)
 {
-	if ((sparx5_port_is_2g5(port->portno) &&
+	const struct sparx5_ops *ops = sparx5->data->ops;
+
+	if ((ops->is_port_2g5(port->portno) &&
 	     conf->speed > SPEED_2500) ||
-	    (sparx5_port_is_5g(port->portno)  &&
+	    (ops->is_port_5g(port->portno)  &&
 	     conf->speed > SPEED_5000) ||
-	    (sparx5_port_is_10g(port->portno) &&
+	    (ops->is_port_10g(port->portno) &&
 	     conf->speed > SPEED_10000))
 		return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
 
@@ -226,14 +228,14 @@ static int sparx5_port_verify_speed(struct sparx5 *sparx5,
 		return -EINVAL;
 	case PHY_INTERFACE_MODE_1000BASEX:
 		if (conf->speed != SPEED_1000 ||
-		    sparx5_port_is_2g5(port->portno))
+		    ops->is_port_2g5(port->portno))
 			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
-		if (sparx5_port_is_2g5(port->portno))
+		if (ops->is_port_2g5(port->portno))
 			return sparx5_port_error(port, conf, SPX5_PERR_IFTYPE);
 		break;
 	case PHY_INTERFACE_MODE_2500BASEX:
 		if (conf->speed != SPEED_2500 ||
-		    sparx5_port_is_2g5(port->portno))
+		    ops->is_port_2g5(port->portno))
 			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
 		break;
 	case PHY_INTERFACE_MODE_QSGMII:
@@ -320,6 +322,7 @@ static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port,
 	u32 dev = high_spd_dev ?
 		  sparx5_to_high_dev(sparx5, port->portno) : TARGET_DEV2G5;
 	void __iomem *devinst = spx5_inst_get(sparx5, dev, tinst);
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 spd = port->conf.speed;
 	u32 spd_prm;
 	int err;
@@ -436,7 +439,7 @@ static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port,
 			      pcsinst,
 			      PCS10G_BR_PCS_CFG(0));
 
-		if (sparx5_port_is_25g(port->portno))
+		if (ops->is_port_25g(port->portno))
 			/* Disable 25G PCS */
 			spx5_rmw(DEV25G_PCS25G_CFG_PCS25G_ENA_SET(0),
 				 DEV25G_PCS25G_CFG_PCS25G_ENA,
@@ -561,6 +564,7 @@ static int sparx5_port_max_tags_set(struct sparx5 *sparx5,
 	u32 dev             = sparx5_to_high_dev(sparx5, port->portno);
 	u32 tinst           = sparx5_port_dev_index(sparx5, port->portno);
 	void __iomem *inst  = spx5_inst_get(sparx5, dev, tinst);
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 etype;
 
 	etype = (vlan_type == SPX5_VLAN_PORT_TYPE_S_CUSTOM ?
@@ -575,7 +579,7 @@ static int sparx5_port_max_tags_set(struct sparx5 *sparx5,
 		sparx5,
 		DEV2G5_MAC_TAGS_CFG(port->portno));
 
-	if (sparx5_port_is_2g5(port->portno))
+	if (ops->is_port_2g5(port->portno))
 		return 0;
 
 	spx5_inst_rmw(DEV10G_MAC_TAGS_CFG_TAG_ID_SET(etype) |
@@ -844,18 +848,19 @@ static int sparx5_port_pcs_high_set(struct sparx5 *sparx5,
 static void sparx5_dev_switch(struct sparx5 *sparx5, int port, bool hsd)
 {
 	int bt_indx = BIT(sparx5_port_dev_index(sparx5, port));
+	const struct sparx5_ops *ops = sparx5->data->ops;
 
-	if (sparx5_port_is_5g(port)) {
+	if (ops->is_port_5g(port)) {
 		spx5_rmw(hsd ? 0 : bt_indx,
 			 bt_indx,
 			 sparx5,
 			 PORT_CONF_DEV5G_MODES);
-	} else if (sparx5_port_is_10g(port)) {
+	} else if (ops->is_port_10g(port)) {
 		spx5_rmw(hsd ? 0 : bt_indx,
 			 bt_indx,
 			 sparx5,
 			 PORT_CONF_DEV10G_MODES);
-	} else if (sparx5_port_is_25g(port)) {
+	} else if (ops->is_port_25g(port)) {
 		spx5_rmw(hsd ? 0 : bt_indx,
 			 bt_indx,
 			 sparx5,
@@ -1016,6 +1021,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 {
 	u32 pause_start = sparx5_wm_enc(6  * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
 	u32 atop = sparx5_wm_enc(20 * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 devhigh = sparx5_to_high_dev(sparx5, port->portno);
 	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
 	u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
@@ -1082,7 +1088,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		if (err)
 			return err;
 
-		if (!sparx5_port_is_2g5(port->portno))
+		if (!ops->is_port_2g5(port->portno))
 			/* Enable shadow device */
 			spx5_rmw(DSM_DEV_TX_STOP_WM_CFG_DEV10G_SHADOW_ENA_SET(1),
 				 DSM_DEV_TX_STOP_WM_CFG_DEV10G_SHADOW_ENA,
@@ -1105,7 +1111,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		sparx5,
 		DEV2G5_MAC_IFG_CFG(port->portno));
 
-	if (sparx5_port_is_2g5(port->portno))
+	if (ops->is_port_2g5(port->portno))
 		return 0; /* Low speed device only - return */
 
 	/* Now setup the high speed device */
@@ -1128,7 +1134,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		     pcsinst,
 		     PCS10G_BR_PCS_SD_CFG(0));
 
-	if (sparx5_port_is_25g(port->portno)) {
+	if (ops->is_port_25g(port->portno)) {
 		/* Handle Signal Detect in 25G PCS */
 		spx5_wr(DEV25G_PCS25G_SD_CFG_SD_POL_SET(sd_pol) |
 			DEV25G_PCS25G_SD_CFG_SD_SEL_SET(sd_sel) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index 468e3d34d6e1..934e2d3dedbb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -42,18 +42,22 @@ static inline bool sparx5_port_is_25g(int portno)
 
 static inline u32 sparx5_to_high_dev(struct sparx5 *sparx5, int port)
 {
-	if (sparx5_port_is_5g(port))
+	const struct sparx5_ops *ops = sparx5->data->ops;
+
+	if (ops->is_port_5g(port))
 		return TARGET_DEV5G;
-	if (sparx5_port_is_10g(port))
+	if (ops->is_port_10g(port))
 		return TARGET_DEV10G;
 	return TARGET_DEV25G;
 }
 
 static inline u32 sparx5_to_pcs_dev(struct sparx5 *sparx5, int port)
 {
-	if (sparx5_port_is_5g(port))
+	const struct sparx5_ops *ops = sparx5->data->ops;
+
+	if (ops->is_port_5g(port))
 		return TARGET_PCS5G_BR;
-	if (sparx5_port_is_10g(port))
+	if (ops->is_port_10g(port))
 		return TARGET_PCS10G_BR;
 	return TARGET_PCS25G_BR;
 }

-- 
2.34.1


