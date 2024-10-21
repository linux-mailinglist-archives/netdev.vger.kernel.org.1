Return-Path: <netdev+bounces-137500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE39A6BA9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83803B23A49
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDCF1FB3C3;
	Mon, 21 Oct 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AVMDO4V0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD461FAC35;
	Mon, 21 Oct 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519207; cv=none; b=sgwB6Lejc4f8K/73Qc7Ij/1JrQL0yqS1txGNSiwPp2IvShCbDBxbFI/syu7O2ZAxMDaxyV01Gx7GDobuZORlKptTCIVGVUHMD8TXdiR6y+SKl8wowFs240y2VVIth9EXwnfsxVbW1xdpUHyNiWn5Y7RDNTj6KJCMG8GSdDwcdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519207; c=relaxed/simple;
	bh=D7xAMTLDv4TQxDjXJeUMvOCBAk/pqgynXVKoYvMVZoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bhAaLoU9wtEebsRPEKGeAd8oYQSO2HOVs+jbKdQA694tc+P+cHzaWatE788WGFagi0y4eUNZDtdlf0ZbQXyoZ6eW4i+vNz4Pc9Jcyb6fu6gHuApqZfgQTn5sNkldZxsvFetYTcAqoJ5dsl74uCwnUIrx1uEYuLDI5i/JEMIV6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AVMDO4V0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519206; x=1761055206;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D7xAMTLDv4TQxDjXJeUMvOCBAk/pqgynXVKoYvMVZoI=;
  b=AVMDO4V0+qtEMzsM6gNyq7oCRtm0Gf0l7S5wuEt3XogJBe9W6Sn9mbjc
   DK+aZUav4E4y1Z6Brv0fRCDt4XPX3dPlUsbGjf/GDjssR+kMe6rlnRonM
   pOO+iyQdGIv9fI75fdIS2ge6Mj/pwLwRYyBt7TayLdt1T4AUBHxb8EXwN
   2ieFEchjzmnwPtayUxgu7Pm0OPWxHeMzRDt5jBIUxDOt7qhrNuuiQla33
   rUywONTnLBOhJ9nn38yySqw8m7fpnQO1XIj845i9z+2Cl09xV0tkguE6+
   Fp4kXXEx8VHkKebiVCloTYvbFMZ4161FWKXSZGEoLSXwVuwYZBa3q/RPH
   w==;
X-CSE-ConnectionGUID: pvCRZgD5R42wSDtWHihNlg==
X-CSE-MsgGUID: 2bD4nTdVQKaAsJSdAp6nAQ==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="264379128"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:39 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:35 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:48 +0200
Subject: [PATCH net-next 11/15] net: lan969x: add function for calculating
 the DSM calendar
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-11-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x has support for RedBox / HSR / PRP (not implemented yet). In
order to accommodate for this in the future, we need to give lan969x it's
own function for calculating the DSM calendar.

The function calculates the calendar for each taxi bus. The calendar is
used for bandwidth allocation towards the ports attached to the taxi
bus. A calendar configuration consists of up-to 64 slots, which may be
allocated to ports or left unused. Each slot accounts for 1 clock cycle.

Also expose sparx5_cal_speed_to_value(), sparx5_get_port_cal_speed,
sparx5_cal_bw and SPX5_DSM_CAL_EMPTY for use by lan969x.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |   1 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |   3 +
 .../ethernet/microchip/lan969x/lan969x_calendar.c  | 190 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  20 +--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  15 ++
 6 files changed, 214 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
index 41bf66b9fef5..56ba96388483 100644
--- a/drivers/net/ethernet/microchip/lan969x/Makefile
+++ b/drivers/net/ethernet/microchip/lan969x/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_LAN969X_SWITCH) += lan969x-switch.o
 
-lan969x-switch-y := lan969x_regs.o lan969x.o
+lan969x-switch-y := lan969x_regs.o lan969x.o lan969x_calendar.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/sparx5
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 692b81e829ef..bd0725393e2b 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -332,6 +332,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.get_sdlb_group          = &lan969x_get_sdlb_group,
 	.set_port_mux            = &lan969x_port_mux_set,
 	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
+	.dsm_calendar_calc       = &lan969x_dsm_calendar_calc,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index 36a19de7faa2..e2b1b474e908 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -50,4 +50,7 @@ static inline bool lan969x_port_is_25g(int portno)
 	return false;
 }
 
+/* lan969x_calendar.c */
+int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			      struct sparx5_calendar_data *data);
 #endif
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c b/drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c
new file mode 100644
index 000000000000..96d552c788f6
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include "lan969x.h"
+
+#define LAN969X_DSM_CAL_DEVS_PER_TAXI 10
+#define LAN969X_DSM_CAL_TAXIS 5
+
+enum lan969x_dsm_cal_dev {
+	DSM_CAL_DEV_2G5,
+	DSM_CAL_DEV_5G,
+	DSM_CAL_DEV_10G,
+	DSM_CAL_DEV_OTHER, /* 1G or less */
+	DSM_CAL_DEV_MAX
+};
+
+/* Each entry in the following struct defines properties for a given speed
+ * (10G, 5G, 2.5G, or 1G or less).
+ */
+struct lan969x_dsm_cal_dev_speed {
+	/* Number of devices that requires this speed. */
+	u32 n_devs;
+
+	/* Array of devices that requires this speed. */
+	u32 devs[LAN969X_DSM_CAL_DEVS_PER_TAXI];
+
+	/* Number of slots required for one device running this speed. */
+	u32 n_slots;
+
+	/* Gap between two slots for one device running this speed. */
+	u32 gap;
+};
+
+static u32
+lan969x_taxi_ports[LAN969X_DSM_CAL_TAXIS][LAN969X_DSM_CAL_DEVS_PER_TAXI] = {
+	{  0,  4,  1,  2,  3,  5,  6,  7, 28, 29 },
+	{  8, 12,  9, 13, 10, 11, 14, 15, 99, 99 },
+	{ 16, 20, 17, 21, 18, 19, 22, 23, 99, 99 },
+	{ 24, 25, 99, 99, 99, 99, 99, 99, 99, 99 },
+	{ 26, 27, 99, 99, 99, 99, 99, 99, 99, 99 }
+};
+
+static int lan969x_dsm_cal_idx_find_next_free(u32 *calendar, u32 cal_len,
+					      u32 *cal_idx)
+{
+	if (*cal_idx >= cal_len)
+		return -EINVAL;
+
+	do {
+		if (calendar[*cal_idx] == SPX5_DSM_CAL_EMPTY)
+			return 0;
+
+		(*cal_idx)++;
+	} while (*cal_idx < cal_len);
+
+	return -ENOENT;
+}
+
+static enum lan969x_dsm_cal_dev lan969x_dsm_cal_get_dev(int speed)
+{
+	return (speed == 10000 ? DSM_CAL_DEV_10G :
+		speed == 5000  ? DSM_CAL_DEV_5G :
+		speed == 2500  ? DSM_CAL_DEV_2G5 :
+				 DSM_CAL_DEV_OTHER);
+}
+
+static int lan969x_dsm_cal_get_speed(enum lan969x_dsm_cal_dev dev)
+{
+	return (dev == DSM_CAL_DEV_10G ? 10000 :
+		dev == DSM_CAL_DEV_5G  ? 5000 :
+		dev == DSM_CAL_DEV_2G5 ? 2500 :
+					 1000);
+}
+
+int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			      struct sparx5_calendar_data *data)
+{
+	struct lan969x_dsm_cal_dev_speed dev_speeds[DSM_CAL_DEV_MAX] = {};
+	u32 cal_len, n_slots, taxi_bw, n_devs = 0, required_bw  = 0;
+	struct lan969x_dsm_cal_dev_speed *speed;
+
+	/* Maximum bandwidth for this taxi */
+	taxi_bw = (128 * 1000000) / sparx5_clk_period(sparx5->coreclock);
+
+	memcpy(data->taxi_ports, &lan969x_taxi_ports[taxi],
+	       LAN969X_DSM_CAL_DEVS_PER_TAXI * sizeof(u32));
+
+	for (int i = 0; i < LAN969X_DSM_CAL_DEVS_PER_TAXI; i++) {
+		u32 portno = data->taxi_ports[i];
+		enum sparx5_cal_bw bw;
+
+		bw = sparx5_get_port_cal_speed(sparx5, portno);
+
+		if (portno < sparx5->data->consts->n_ports_all)
+			data->taxi_speeds[i] = sparx5_cal_speed_to_value(bw);
+		else
+			data->taxi_speeds[i] = 0;
+	}
+
+	/* Determine the different port types (10G, 5G, 2.5G, <= 1G) in the
+	 * this taxi map.
+	 */
+	for (int i = 0; i < LAN969X_DSM_CAL_DEVS_PER_TAXI; i++) {
+		u32 taxi_speed = data->taxi_speeds[i];
+		enum lan969x_dsm_cal_dev dev;
+
+		if (taxi_speed == 0)
+			continue;
+
+		required_bw += taxi_speed;
+
+		dev = lan969x_dsm_cal_get_dev(taxi_speed);
+		speed = &dev_speeds[dev];
+		speed->devs[speed->n_devs++] = i;
+		n_devs++;
+	}
+
+	if (required_bw > taxi_bw) {
+		pr_err("Required bandwidth: %u is higher than total taxi bandwidth: %u",
+		       required_bw, taxi_bw);
+		return -EINVAL;
+	}
+
+	if (n_devs == 0) {
+		data->schedule[0] = SPX5_DSM_CAL_EMPTY;
+		return 0;
+	}
+
+	cal_len = n_devs;
+
+	/* Search for a calendar length that fits all active devices. */
+	while (cal_len < SPX5_DSM_CAL_LEN) {
+		u32 bw_per_slot = taxi_bw / cal_len;
+
+		n_slots = 0;
+
+		for (int i = 0; i < DSM_CAL_DEV_MAX; i++) {
+			speed = &dev_speeds[i];
+
+			if (speed->n_devs == 0)
+				continue;
+
+			required_bw = lan969x_dsm_cal_get_speed(i);
+			speed->n_slots = DIV_ROUND_UP(required_bw, bw_per_slot);
+
+			if (speed->n_slots)
+				speed->gap = DIV_ROUND_UP(cal_len,
+							  speed->n_slots);
+			else
+				speed->gap = 0;
+
+			n_slots += speed->n_slots * speed->n_devs;
+		}
+
+		if (n_slots <= cal_len)
+			break; /* Found a suitable calendar length. */
+
+		/* Not good enough yet. */
+		cal_len = n_slots;
+	}
+
+	if (cal_len > SPX5_DSM_CAL_LEN) {
+		pr_err("Invalid length: %u for taxi: %u", cal_len, taxi);
+		return -EINVAL;
+	}
+
+	for (u32 i = 0; i < SPX5_DSM_CAL_LEN; i++)
+		data->schedule[i] = SPX5_DSM_CAL_EMPTY;
+
+	/* Place the remaining devices */
+	for (u32 i = 0; i < DSM_CAL_DEV_MAX; i++) {
+		speed = &dev_speeds[i];
+		for (u32 dev = 0; dev < speed->n_devs; dev++) {
+			u32 idx = 0;
+
+			for (n_slots = 0; n_slots < speed->n_slots; n_slots++) {
+				lan969x_dsm_cal_idx_find_next_free(data->schedule,
+								   cal_len,
+								   &idx);
+				data->schedule[idx] = speed->devs[dev];
+				idx += speed->gap;
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index edc03b6ebf34..64c5ed70cc6b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -15,7 +15,6 @@
 #define SPX5_CALBITS_PER_PORT          3   /* Bit per port in calendar register */
 
 /* DSM calendar information */
-#define SPX5_DSM_CAL_EMPTY             0xFFFF
 #define SPX5_DSM_CAL_TAXIS             8
 #define SPX5_DSM_CAL_BW_LOSS           553
 
@@ -74,18 +73,6 @@ static u32 sparx5_target_bandwidth(struct sparx5 *sparx5)
 	}
 }
 
-/* This is used in calendar configuration */
-enum sparx5_cal_bw {
-	SPX5_CAL_SPEED_NONE = 0,
-	SPX5_CAL_SPEED_1G   = 1,
-	SPX5_CAL_SPEED_2G5  = 2,
-	SPX5_CAL_SPEED_5G   = 3,
-	SPX5_CAL_SPEED_10G  = 4,
-	SPX5_CAL_SPEED_25G  = 5,
-	SPX5_CAL_SPEED_0G5  = 6,
-	SPX5_CAL_SPEED_12G5 = 7
-};
-
 static u32 sparx5_clk_to_bandwidth(enum sparx5_core_clockfreq cclock)
 {
 	switch (cclock) {
@@ -98,7 +85,7 @@ static u32 sparx5_clk_to_bandwidth(enum sparx5_core_clockfreq cclock)
 	return 0;
 }
 
-static u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed)
+u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed)
 {
 	switch (speed) {
 	case SPX5_CAL_SPEED_1G:   return 1000;
@@ -111,6 +98,7 @@ static u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed)
 	default: return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(sparx5_cal_speed_to_value);
 
 static u32 sparx5_bandwidth_to_calendar(u32 bw)
 {
@@ -128,8 +116,7 @@ static u32 sparx5_bandwidth_to_calendar(u32 bw)
 	}
 }
 
-static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
-						    u32 portno)
+enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5, u32 portno)
 {
 	struct sparx5_port *port;
 
@@ -163,6 +150,7 @@ static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
 		return SPX5_CAL_SPEED_NONE;
 	return sparx5_bandwidth_to_calendar(port->conf.bandwidth);
 }
+EXPORT_SYMBOL_GPL(sparx5_get_port_cal_speed);
 
 /* Auto configure the QSYS calendar based on port configuration */
 int sparx5_config_auto_calendar(struct sparx5 *sparx5)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 3f66045c57ef..1828e2a7d610 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -63,6 +63,18 @@ enum sparx5_vlan_port_type {
 	SPX5_VLAN_PORT_TYPE_S_CUSTOM /* S-port using custom type */
 };
 
+/* This is used in calendar configuration */
+enum sparx5_cal_bw {
+	SPX5_CAL_SPEED_NONE = 0,
+	SPX5_CAL_SPEED_1G   = 1,
+	SPX5_CAL_SPEED_2G5  = 2,
+	SPX5_CAL_SPEED_5G   = 3,
+	SPX5_CAL_SPEED_10G  = 4,
+	SPX5_CAL_SPEED_25G  = 5,
+	SPX5_CAL_SPEED_0G5  = 6,
+	SPX5_CAL_SPEED_12G5 = 7
+};
+
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
@@ -113,6 +125,7 @@ enum sparx5_vlan_port_type {
 
 #define SPX5_DSM_CAL_LEN               64
 #define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
+#define SPX5_DSM_CAL_EMPTY             0xFFFF
 
 #define SPARX5_MAX_PTP_ID	512
 
@@ -454,6 +467,8 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5);
 int sparx5_config_dsm_calendar(struct sparx5 *sparx5);
 int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 			     struct sparx5_calendar_data *data);
+u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed);
+enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5, u32 portno);
 
 
 /* sparx5_ethtool.c */

-- 
2.34.1


