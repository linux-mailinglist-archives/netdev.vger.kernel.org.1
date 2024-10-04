Return-Path: <netdev+bounces-132046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F39903F0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDDC1C2194A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9387216A21;
	Fri,  4 Oct 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SuE6UN2Q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D752141DE;
	Fri,  4 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048038; cv=none; b=Q89irErioanECKYsBe24I+74fYcNWITj1FOBLjiX56gjl8OL9olk6n3AYLaUjct6X/KE6XGJAf2LajPLxrVFcwfxuQ9SLYbvVICMYBhBKO8V5xtKb1PI3iBeUFYW6r0/OpCDeofwyaEPBYpD4fWZncl65JMmiDbbJSkD5+OiG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048038; c=relaxed/simple;
	bh=g6ihk+1MuTSl4LWzIo2tsPO4k7+cd1+97Ad3DoTlRuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jE55zQ+DMZx8HRPaepsXBsikAkL0skX1z+bO4Q0Kg8zOFF4VLHohauglsjyyDNMRxm6BNlwXX56fMqUsguAZVbtfvmjbBTMYGAuxkuC4Yzuzl2ZbTwcNMAI1FPXM1tXzTv7lI5y/TxqPdRi6sxDsupcFIKphmHHws8Gfx8H6blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SuE6UN2Q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048037; x=1759584037;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g6ihk+1MuTSl4LWzIo2tsPO4k7+cd1+97Ad3DoTlRuI=;
  b=SuE6UN2QGinWHJzCqqhI77CkDAs//CzJXD77eC4/Viu3Le+ygZ2LLFXF
   Rtylr0+hR6uv9A+imNOMHGp5F6r8lQRxDeYpFFIa1LTcFn1pRgph62pDX
   FLjzRjx9iBgNwTNrNe0QR6ipG7Z/FVw0g8UIViYeeeKt1xMz6aTA67Hv0
   Xy7SPcxflu/pWYm7AWrRSe1hhfj8mIwRdFRLxdE6odFgSL8Xy9aAgrjCH
   F4Sg5ddmzk7dohy1PCCounr2cxcaIc3m3EkNrmT1ZyQ59DHDMEnBz7/dE
   9mngn3MhIdpMyJ9ARzU+NDb3/RrYEmrLPyT7/x7hVWRCMVjdpB53ofFyY
   A==;
X-CSE-ConnectionGUID: wYEhTCIITtS2MLde76jJ4w==
X-CSE-MsgGUID: ZYbMu2nFR7uYlCs502E6fw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:20 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:32 +0200
Subject: [PATCH net-next v2 06/15] net: sparx5: use SPX5_CONST for
 constants which already have a symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-6-d3290f581663@microchip.com>
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

Now that we have indentified all the chip constants, update the use of
them where a symbol is already defined for the constant.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 13 ++++---
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |  5 ++-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  8 ++--
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  6 ++-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |  7 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 21 +++++++----
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  7 ++--
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    |  6 +--
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    | 22 ++++++-----
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 44 +++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |  4 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |  2 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |  4 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |  2 +-
 15 files changed, 90 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 76a8bb596aec..9b54d952e91a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -131,7 +131,7 @@ static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
 {
 	struct sparx5_port *port;
 
-	if (portno >= SPX5_PORTS) {
+	if (portno >= sparx5->data->consts->n_ports) {
 		/* Internal ports */
 		if (portno == SPX5_PORT_CPU_0 || portno == SPX5_PORT_CPU_1) {
 			/* Equals 1.25G */
@@ -159,6 +159,7 @@ static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
 /* Auto configure the QSYS calendar based on port configuration */
 int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	u32 cal[7], value, idx, portno;
 	u32 max_core_bw;
 	u32 total_bw = 0, used_port_bw = 0;
@@ -174,7 +175,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 	}
 
 	/* Setup the calendar with the bandwidth to each port */
-	for (portno = 0; portno < SPX5_PORTS_ALL; portno++) {
+	for (portno = 0; portno < consts->n_ports_all; portno++) {
 		u64 reg, offset, this_bw;
 
 		spd = sparx5_get_port_cal_speed(sparx5, portno);
@@ -182,7 +183,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 			continue;
 
 		this_bw = sparx5_cal_speed_to_value(spd);
-		if (portno < SPX5_PORTS)
+		if (portno < consts->n_ports)
 			used_port_bw += this_bw;
 		else
 			/* Internal ports are granted half the value */
@@ -213,7 +214,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 		 sparx5, QSYS_CAL_CTRL);
 
 	/* Assign port bandwidth to auto calendar */
-	for (idx = 0; idx < ARRAY_SIZE(cal); idx++)
+	for (idx = 0; idx < consts->n_auto_cals; idx++)
 		spx5_wr(cal[idx], sparx5, QSYS_CAL_AUTO(idx));
 
 	/* Increase grant rate of all ports to account for
@@ -304,7 +305,7 @@ static int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 	for (idx = 0; idx < SPX5_DSM_CAL_MAX_DEVS_PER_TAXI; idx++) {
 		u32 portno = data->taxi_ports[idx];
 
-		if (portno < SPX5_TAXI_PORT_MAX) {
+		if (portno < sparx5->data->consts->n_ports_all) {
 			data->taxi_speeds[idx] = sparx5_cal_speed_to_value
 				(sparx5_get_port_cal_speed(sparx5, portno));
 		} else {
@@ -573,7 +574,7 @@ int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 	if (!data)
 		return -ENOMEM;
 
-	for (taxi = 0; taxi < SPX5_DSM_CAL_TAXIS; ++taxi) {
+	for (taxi = 0; taxi < sparx5->data->consts->n_dsm_cal_taxis; ++taxi) {
 		err = sparx5_dsm_calendar_calc(sparx5, taxi, data);
 		if (err) {
 			dev_err(sparx5->dev, "DSM calendar calculation failed\n");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c
index 2d763664dcda..10224ad63a78 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c
@@ -234,10 +234,11 @@ static int sparx5_dcb_ieee_dscp_setdel(struct net_device *dev,
 						     struct dcb_app *))
 {
 	struct sparx5_port *port = netdev_priv(dev);
+	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_port *port_itr;
 	int err, i;
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
 		port_itr = port->sparx5->ports[i];
 		if (!port_itr)
 			continue;
@@ -386,7 +387,7 @@ int sparx5_dcb_init(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int i;
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index ca97d51e6a8d..4c6375872f82 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1122,7 +1122,7 @@ static void sparx5_update_stats(struct sparx5 *sparx5)
 {
 	int idx;
 
-	for (idx = 0; idx < SPX5_PORTS; idx++)
+	for (idx = 0; idx < sparx5->data->consts->n_ports; idx++)
 		if (sparx5->ports[idx])
 			sparx5_update_port_stats(sparx5, idx);
 }
@@ -1228,6 +1228,7 @@ const struct ethtool_ops sparx5_ethtool_ops = {
 
 int sparx_stats_init(struct sparx5 *sparx5)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	char queue_name[32];
 	int portno;
 
@@ -1235,14 +1236,15 @@ int sparx_stats_init(struct sparx5 *sparx5)
 	sparx5->num_stats = spx5_stats_count;
 	sparx5->num_ethtool_stats = ARRAY_SIZE(sparx5_stats_layout);
 	sparx5->stats = devm_kcalloc(sparx5->dev,
-				     SPX5_PORTS_ALL * sparx5->num_stats,
+				     consts->n_ports_all *
+				     sparx5->num_stats,
 				     sizeof(u64), GFP_KERNEL);
 	if (!sparx5->stats)
 		return -ENOMEM;
 
 	mutex_init(&sparx5->queue_stats_lock);
 	sparx5_config_stats(sparx5);
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < consts->n_ports; portno++)
 		if (sparx5->ports[portno])
 			sparx5_config_port_stats(sparx5, portno);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 61df874b7623..4919719da0cb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -156,7 +156,9 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	/* Now do the normal processing of the skb */
 	sparx5_ifh_parse((u32 *)skb->data, &fi);
 	/* Map to port netdev */
-	port = fi.src_port < SPX5_PORTS ?  sparx5->ports[fi.src_port] : NULL;
+	port = fi.src_port < sparx5->data->consts->n_ports ?
+		       sparx5->ports[fi.src_port] :
+		       NULL;
 	if (!port || !port->ndev) {
 		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
 		sparx5_xtr_flush(sparx5, XTR_QUEUE);
@@ -296,7 +298,7 @@ static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 	fdma->ops.dataptr_cb = &sparx5_fdma_rx_dataptr_cb;
 	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 	/* Fetch a netdev for SKB and NAPI use, any will do */
-	for (idx = 0; idx < SPX5_PORTS; ++idx) {
+	for (idx = 0; idx < sparx5->data->consts->n_ports; ++idx) {
 		struct sparx5_port *port = sparx5->ports[idx];
 
 		if (port && port->ndev) {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 75868b3f548e..56f6b94c4ef3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -80,15 +80,16 @@ static void sparx5_mact_select(struct sparx5 *sparx5,
 int sparx5_mact_learn(struct sparx5 *sparx5, int pgid,
 		      const unsigned char mac[ETH_ALEN], u16 vid)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int addr, type, ret;
 
-	if (pgid < SPX5_PORTS) {
+	if (pgid < consts->n_ports) {
 		type = MAC_ENTRY_ADDR_TYPE_UPSID_PN;
 		addr = pgid % 32;
 		addr += (pgid / 32) << 5; /* Add upsid */
 	} else {
 		type = MAC_ENTRY_ADDR_TYPE_MC_IDX;
-		addr = pgid - SPX5_PORTS;
+		addr = pgid - consts->n_ports;
 	}
 
 	mutex_lock(&sparx5->lock);
@@ -371,7 +372,7 @@ static void sparx5_mact_handle_entry(struct sparx5 *sparx5,
 		return;
 
 	port = LRN_MAC_ACCESS_CFG_2_MAC_ENTRY_ADDR_GET(cfg2);
-	if (port >= SPX5_PORTS)
+	if (port >= sparx5->data->consts->n_ports)
 		return;
 
 	if (!test_bit(port, sparx5->bridge_mask))
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 5f3690a59ac1..1fa98158b0a8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -31,8 +31,6 @@
 
 const struct sparx5_regs *regs;
 
-#define QLIM_WM(fraction) \
-	((SPX5_BUFFER_MEMORY / SPX5_BUFFER_CELL_SZ - 100) * (fraction) / 100)
 #define IO_RANGES 3
 
 struct initial_port_config {
@@ -544,6 +542,12 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 	return 0;
 }
 
+static u32 qlim_wm(struct sparx5 *sparx5, int fraction)
+{
+	return (sparx5->data->consts->buf_size / SPX5_BUFFER_CELL_SZ - 100) *
+	       fraction / 100;
+}
+
 static int sparx5_qlim_set(struct sparx5 *sparx5)
 {
 	u32 res, dp, prio;
@@ -559,10 +563,10 @@ static int sparx5_qlim_set(struct sparx5 *sparx5)
 	}
 
 	/* Set 80,90,95,100% of memory size for top watermarks */
-	spx5_wr(QLIM_WM(80), sparx5, XQS_QLIMIT_SHR_QLIM_CFG(0));
-	spx5_wr(QLIM_WM(90), sparx5, XQS_QLIMIT_SHR_CTOP_CFG(0));
-	spx5_wr(QLIM_WM(95), sparx5, XQS_QLIMIT_SHR_ATOP_CFG(0));
-	spx5_wr(QLIM_WM(100), sparx5, XQS_QLIMIT_SHR_TOP_CFG(0));
+	spx5_wr(qlim_wm(sparx5, 80), sparx5, XQS_QLIMIT_SHR_QLIM_CFG(0));
+	spx5_wr(qlim_wm(sparx5, 90), sparx5, XQS_QLIMIT_SHR_CTOP_CFG(0));
+	spx5_wr(qlim_wm(sparx5, 95), sparx5, XQS_QLIMIT_SHR_ATOP_CFG(0));
+	spx5_wr(qlim_wm(sparx5, 100), sparx5, XQS_QLIMIT_SHR_TOP_CFG(0));
 
 	return 0;
 }
@@ -584,7 +588,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 		 GCB_HW_SGPIO_SD_CFG);
 
 	/* Refer to LOS SGPIO */
-	for (idx = 0; idx < SPX5_PORTS; idx++)
+	for (idx = 0; idx < sparx5->data->consts->n_ports; idx++)
 		if (sparx5->ports[idx])
 			if (sparx5->ports[idx]->conf.sd_sgpio != ~0)
 				spx5_wr(sparx5->ports[idx]->conf.sd_sgpio,
@@ -595,6 +599,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 static int sparx5_start(struct sparx5 *sparx5)
 {
 	u8 broadcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	char queue_name[32];
 	u32 idx;
 	int err;
@@ -608,7 +613,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 	}
 
 	/* Enable CPU ports */
-	for (idx = SPX5_PORTS; idx < SPX5_PORTS_ALL; idx++)
+	for (idx = consts->n_ports; idx < consts->n_ports_all; idx++)
 		spx5_rmw(QFWD_SWITCH_PORT_MODE_PORT_ENA_SET(1),
 			 QFWD_SWITCH_PORT_MODE_PORT_ENA,
 			 sparx5,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 3ae6bad3bbb3..c61b22a96e22 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -290,7 +290,7 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
 	int portno;
 	int err;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
 		if (sparx5->ports[portno]) {
 			err = register_netdev(sparx5->ports[portno]->ndev);
 			if (err) {
@@ -309,7 +309,7 @@ void sparx5_destroy_netdevs(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int portno;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++) {
+	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++) {
 		port = sparx5->ports[portno];
 		if (port && port->phylink) {
 			/* Disconnect the phy */
@@ -327,8 +327,7 @@ void sparx5_unregister_netdevs(struct sparx5 *sparx5)
 {
 	int portno;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
 		if (sparx5->ports[portno])
 			unregister_netdev(sparx5->ports[portno]->ndev);
 }
-
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index e637834b56df..700842ec7608 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -75,7 +75,7 @@ static void sparx5_xtr_grp(struct sparx5 *sparx5, u8 grp, bool byte_swap)
 	sparx5_ifh_parse(ifh, &fi);
 
 	/* Map to port netdev */
-	port = fi.src_port < SPX5_PORTS ?
+	port = fi.src_port < sparx5->data->consts->n_ports ?
 		sparx5->ports[fi.src_port] : NULL;
 	if (!port || !port->ndev) {
 		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
index af8b435009f4..78ef99b833ed 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
@@ -5,7 +5,7 @@ void sparx5_pgid_init(struct sparx5 *spx5)
 {
 	int i;
 
-	for (i = 0; i < PGID_TABLE_SIZE; i++)
+	for (i = 0; i < spx5->data->consts->n_pgids; i++)
 		spx5->pgid_map[i] = SPX5_PGID_FREE;
 
 	/* Reserved for unicast, flood control, broadcast, and CPU.
@@ -22,7 +22,7 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 	/* The multicast area starts at index 65, but the first 7
 	 * are reserved for flood masks and CPU. Start alloc after that.
 	 */
-	for (i = PGID_MCAST_START; i < PGID_TABLE_SIZE; i++) {
+	for (i = PGID_MCAST_START; i < spx5->data->consts->n_pgids; i++) {
 		if (spx5->pgid_map[i] == SPX5_PGID_FREE) {
 			spx5->pgid_map[i] = SPX5_PGID_MULTICAST;
 			*idx = i;
@@ -35,7 +35,7 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 
 int sparx5_pgid_free(struct sparx5 *spx5, u16 idx)
 {
-	if (idx <= PGID_CPU || idx >= PGID_TABLE_SIZE)
+	if (idx <= PGID_CPU || idx >= spx5->data->consts->n_pgids)
 		return -EINVAL;
 
 	if (spx5->pgid_map[idx] == SPX5_PGID_FREE)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 5d9c7b782352..fa6cc052bf81 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -22,34 +22,38 @@ static struct sparx5_pool_entry sparx5_psfp_sf_pool[SPX5_PSFP_SF_CNT];
 
 static int sparx5_psfp_sf_get(struct sparx5 *sparx5, u32 *id)
 {
-	return sparx5_pool_get(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
+	return sparx5_pool_get(sparx5_psfp_sf_pool,
+			       sparx5->data->consts->n_filters, id);
 }
 
 static int sparx5_psfp_sf_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_sf_pool,
+			       sparx5->data->consts->n_filters, id);
 }
 
 static int sparx5_psfp_sg_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
-	return sparx5_pool_get_with_idx(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT,
-					idx, id);
+	return sparx5_pool_get_with_idx(sparx5_psfp_sg_pool,
+					sparx5->data->consts->n_gates, idx, id);
 }
 
 static int sparx5_psfp_sg_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_sg_pool,
+			       sparx5->data->consts->n_gates, id);
 }
 
 static int sparx5_psfp_fm_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
-	return sparx5_pool_get_with_idx(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, idx,
-					id);
+	return sparx5_pool_get_with_idx(sparx5_psfp_fm_pool,
+					sparx5->data->consts->n_sdlbs, idx, id);
 }
 
 static int sparx5_psfp_fm_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_fm_pool,
+			       sparx5->data->consts->n_sdlbs, id);
 }
 
 u32 sparx5_psfp_isdx_get_sf(struct sparx5 *sparx5, u32 isdx)
@@ -318,7 +322,7 @@ void sparx5_psfp_init(struct sparx5 *sparx5)
 	const struct sparx5_sdlb_group *group;
 	int i;
 
-	for (i = 0; i < SPX5_SDLB_GROUP_CNT; i++) {
+	for (i = 0; i < sparx5->data->consts->n_lb_groups; i++) {
 		group = &sdlb_groups[i];
 		sparx5_sdlb_group_init(sparx5, group->max_rate,
 				       group->min_burst, group->frame_size, i);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 5a932460db58..9b15e44f9e64 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -274,6 +274,7 @@ static void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 				   u32 nsec)
 {
 	/* Read current PTP time to get seconds */
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	unsigned long flags;
 	u32 curr_nsec;
 
@@ -285,10 +286,10 @@ static void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 		 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 		 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 		 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-		 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+		 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
-	ts->tv_sec = spx5_rd(sparx5, PTP_PTP_TOD_SEC_LSB(TOD_ACC_PIN));
-	curr_nsec = spx5_rd(sparx5, PTP_PTP_TOD_NSEC(TOD_ACC_PIN));
+	ts->tv_sec = spx5_rd(sparx5, PTP_PTP_TOD_SEC_LSB(consts->tod_pin));
+	curr_nsec = spx5_rd(sparx5, PTP_PTP_TOD_NSEC(consts->tod_pin));
 
 	ts->tv_nsec = nsec;
 
@@ -440,8 +441,11 @@ static int sparx5_ptp_settime64(struct ptp_clock_info *ptp,
 {
 	struct sparx5_phc *phc = container_of(ptp, struct sparx5_phc, info);
 	struct sparx5 *sparx5 = phc->sparx5;
+	const struct sparx5_consts *consts;
 	unsigned long flags;
 
+	consts = sparx5->data->consts;
+
 	spin_lock_irqsave(&sparx5->ptp_clock_lock, flags);
 
 	/* Must be in IDLE mode before the time can be loaded */
@@ -451,14 +455,14 @@ static int sparx5_ptp_settime64(struct ptp_clock_info *ptp,
 		 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 		 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 		 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-		 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+		 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
 	/* Set new value */
 	spx5_wr(PTP_PTP_TOD_SEC_MSB_PTP_TOD_SEC_MSB_SET(upper_32_bits(ts->tv_sec)),
-		sparx5, PTP_PTP_TOD_SEC_MSB(TOD_ACC_PIN));
+		sparx5, PTP_PTP_TOD_SEC_MSB(consts->tod_pin));
 	spx5_wr(lower_32_bits(ts->tv_sec),
-		sparx5, PTP_PTP_TOD_SEC_LSB(TOD_ACC_PIN));
-	spx5_wr(ts->tv_nsec, sparx5, PTP_PTP_TOD_NSEC(TOD_ACC_PIN));
+		sparx5, PTP_PTP_TOD_SEC_LSB(consts->tod_pin));
+	spx5_wr(ts->tv_nsec, sparx5, PTP_PTP_TOD_NSEC(consts->tod_pin));
 
 	/* Apply new values */
 	spx5_rmw(PTP_PTP_PIN_CFG_PTP_PIN_ACTION_SET(PTP_PIN_ACTION_LOAD) |
@@ -467,7 +471,7 @@ static int sparx5_ptp_settime64(struct ptp_clock_info *ptp,
 		 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 		 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 		 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-		 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+		 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
 	spin_unlock_irqrestore(&sparx5->ptp_clock_lock, flags);
 
@@ -478,10 +482,13 @@ int sparx5_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct sparx5_phc *phc = container_of(ptp, struct sparx5_phc, info);
 	struct sparx5 *sparx5 = phc->sparx5;
+	const struct sparx5_consts *consts;
 	unsigned long flags;
 	time64_t s;
 	s64 ns;
 
+	consts = sparx5->data->consts;
+
 	spin_lock_irqsave(&sparx5->ptp_clock_lock, flags);
 
 	spx5_rmw(PTP_PTP_PIN_CFG_PTP_PIN_ACTION_SET(PTP_PIN_ACTION_SAVE) |
@@ -490,12 +497,12 @@ int sparx5_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 		 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 		 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 		 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-		 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+		 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
-	s = spx5_rd(sparx5, PTP_PTP_TOD_SEC_MSB(TOD_ACC_PIN));
+	s = spx5_rd(sparx5, PTP_PTP_TOD_SEC_MSB(consts->tod_pin));
 	s <<= 32;
-	s |= spx5_rd(sparx5, PTP_PTP_TOD_SEC_LSB(TOD_ACC_PIN));
-	ns = spx5_rd(sparx5, PTP_PTP_TOD_NSEC(TOD_ACC_PIN));
+	s |= spx5_rd(sparx5, PTP_PTP_TOD_SEC_LSB(consts->tod_pin));
+	ns = spx5_rd(sparx5, PTP_PTP_TOD_NSEC(consts->tod_pin));
 	ns &= PTP_PTP_TOD_NSEC_PTP_TOD_NSEC;
 
 	spin_unlock_irqrestore(&sparx5->ptp_clock_lock, flags);
@@ -515,6 +522,9 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct sparx5_phc *phc = container_of(ptp, struct sparx5_phc, info);
 	struct sparx5 *sparx5 = phc->sparx5;
+	const struct sparx5_consts *consts;
+
+	consts = sparx5->data->consts;
 
 	if (delta > -(NSEC_PER_SEC / 2) && delta < (NSEC_PER_SEC / 2)) {
 		unsigned long flags;
@@ -528,10 +538,10 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 			 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 			 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 			 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-			 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+			 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
 		spx5_wr(PTP_PTP_TOD_NSEC_PTP_TOD_NSEC_SET(delta),
-			sparx5, PTP_PTP_TOD_NSEC(TOD_ACC_PIN));
+			sparx5, PTP_PTP_TOD_NSEC(consts->tod_pin));
 
 		/* Adjust time with the value of PTP_TOD_NSEC */
 		spx5_rmw(PTP_PTP_PIN_CFG_PTP_PIN_ACTION_SET(PTP_PIN_ACTION_DELTA) |
@@ -540,7 +550,7 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 			 PTP_PTP_PIN_CFG_PTP_PIN_ACTION |
 			 PTP_PTP_PIN_CFG_PTP_PIN_DOM |
 			 PTP_PTP_PIN_CFG_PTP_PIN_SYNC,
-			 sparx5, PTP_PTP_PIN_CFG(TOD_ACC_PIN));
+			 sparx5, PTP_PTP_PIN_CFG(consts->tod_pin));
 
 		spin_unlock_irqrestore(&sparx5->ptp_clock_lock, flags);
 	} else {
@@ -630,7 +640,7 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 	/* Enable master counters */
 	spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
@@ -646,7 +656,7 @@ void sparx5_ptp_deinit(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int i;
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index f5267218caeb..f79130293c4e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
@@ -184,7 +184,7 @@ int sparx5_sdlb_group_get_by_rate(struct sparx5 *sparx5, u32 rate, u32 burst)
 
 	rate_bps = rate * 1000;
 
-	for (i = SPX5_SDLB_GROUP_CNT - 1; i >= 0; i--) {
+	for (i = sparx5->data->consts->n_lb_groups - 1; i >= 0; i--) {
 		group = &sdlb_groups[i];
 
 		count = sparx5_sdlb_group_get_count(sparx5, i);
@@ -208,7 +208,7 @@ int sparx5_sdlb_group_get_by_index(struct sparx5 *sparx5, u32 idx, u32 *group)
 	u32 itr, next;
 	int i;
 
-	for (i = 0; i < SPX5_SDLB_GROUP_CNT; i++) {
+	for (i = 0; i < sparx5->data->consts->n_lb_groups; i++) {
 		if (sparx5_sdlb_group_is_empty(sparx5, i))
 			continue;
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 0b4abc3eb53d..d1e7b85bdffa 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -547,7 +547,7 @@ static int sparx5_handle_port_mdb_add(struct net_device *dev,
 
 	/* Add any mrouter ports to the new entry */
 	if (is_new && ether_addr_is_ip_mcast(v->addr))
-		for (i = 0; i < SPX5_PORTS; i++)
+		for (i = 0; i < spx5->data->consts->n_ports; i++)
 			if (spx5->ports[i] && spx5->ports[i]->is_mrouter)
 				sparx5_pgid_update_mask(spx5->ports[i],
 							entry->pgid_idx,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 8d67d9f24c76..c3bbed140554 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -785,7 +785,9 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 	 * allocate a stream gate that is always open.
 	 */
 	if (sg_idx < 0) {
-		sg_idx = sparx5_pool_idx_to_id(SPX5_PSFP_SG_OPEN);
+		/* Always-open stream gate is always the last */
+		sg_idx = sparx5_pool_idx_to_id(sparx5->data->consts->n_gates -
+					       1);
 		sg->ipv = 0; /* Disabled */
 		sg->cycletime = SPX5_PSFP_SG_CYCLE_TIME_DEFAULT;
 		sg->num_entries = 1;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index ac001ae59a38..f5708f4f17c8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -169,7 +169,7 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 	}
 
 	/* Update SRC masks */
-	for (port = 0; port < SPX5_PORTS; port++) {
+	for (port = 0; port < sparx5->data->consts->n_ports; port++) {
 		if (test_bit(port, sparx5->bridge_fwd_mask)) {
 			/* Allow to send to all bridged but self */
 			bitmap_copy(workmask, sparx5->bridge_fwd_mask, SPX5_PORTS);

-- 
2.34.1


