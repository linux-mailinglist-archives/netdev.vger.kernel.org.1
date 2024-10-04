Return-Path: <netdev+bounces-132048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623329903F4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3851C20922
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54792178FA;
	Fri,  4 Oct 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VRjfNNHU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DF216A01;
	Fri,  4 Oct 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048040; cv=none; b=XKZ0Fbbcy0OtTGCXO+tq8rNPH+xi7FHS9q7xTNewj/zG+o+u4bLZ0hI+/z57kCA1aA9wDE9a4sZNO3FiSKiDSaU4djrYg0UvWEjF0kg7UkohxncqxObT67GxgLYF30GuXHoQ1WQd9+X9NkoA3LVGUnfbUr9+olpmey/IEekI33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048040; c=relaxed/simple;
	bh=0F4llX9pVi8qYQGiMa90+QukKKzQzHUqNR83SzijURM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L9AheWvn8pLUxjkP7aGBLrjD/s9cNHgOHwfZbJlYnQRPxgqgEuO8l+ZtSkGYyqJJzmtq59MmsG1y9soMwL0f54REr7DCy0EtKoarl5+QIq9uMQ3N9spwTbHcA10kpNEaFEcOpYZGoXtafUs0PmBWYfUBC++SvZrDFNoHweHVixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VRjfNNHU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048038; x=1759584038;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0F4llX9pVi8qYQGiMa90+QukKKzQzHUqNR83SzijURM=;
  b=VRjfNNHUlQS5d5FWND3AwUjd6v9ks6RiCsmp4yo9opwB4m+0nwxq2iG7
   5NEPNi5tWFt9TrieiAn5Gn9cXtiU04dF/eKl1iTBm27qInizn9IhDUZT6
   WiLO3b/iLsoaTqnjpCsI3jCLzIN9NcNNwDEoq5x6DQbVqgPnjiPRN0zry
   o7gt681KcMpHw0LDfQp6EsrNNYoBmNxYRAb8WbwpGoGT1bR607Arwfg3R
   YO/9Lb+Fac0y/FfOOL7t9BhglvAV8xUJDFWVSc18CINl/OvKhNDGsM1yO
   XFxixgwZWPTKmkJUlc18AqxQkfA1gg4nou46+E+6v0coEjy9dpPlTVbvW
   w==;
X-CSE-ConnectionGUID: Ejn4MYkwTnyyTXQz7FKjZw==
X-CSE-MsgGUID: TPaBFoybRWu/gdBD2JHV/A==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35903139"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:30 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:34 +0200
Subject: [PATCH net-next v2 08/15] net: sparx5: add ops to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-8-d3290f581663@microchip.com>
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add new struct sparx5_ops, containing functions that needs to be
different as the implementation differs on Sparx5 and lan969x. Initially
we add functions for checking the port type (2g5, 5g, 10g or 25g) based
on the port number. Update the code to use the ops instead of the
platform specific functions.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  8 +++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  8 +++++
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 34 +++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_port.h    | 12 +++++---
 4 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 6c50d7875207..77abb966b6b5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -983,12 +983,20 @@ static const struct sparx5_consts sparx5_consts = {
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
index 6e6067568f2a..f3716bd2f9a2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -258,6 +258,13 @@ struct sparx5_consts {
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
@@ -267,6 +274,7 @@ struct sparx5_main_io_resource {
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


