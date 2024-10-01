Return-Path: <netdev+bounces-130895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB698BE7F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26AD1B244C0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410191C8FC2;
	Tue,  1 Oct 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fbnEtzKL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D31C57BF;
	Tue,  1 Oct 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790695; cv=none; b=b+oj0H0tNyzD5k7FQ+cOdPluXXExuakkEqoXcL71dvnKc1Zo+KhA3Lhv8Obv0f0r2kvO+eGQOWImzKtyk8/EUFDuOGYUzqnInyAHHNx4D1A5sgyjPhlxExeZFoc2SwEPI0/f2+rPoIDGRHhy0EwAWbu0cimaTYU48v0kRi/BpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790695; c=relaxed/simple;
	bh=JK1ukKBpU/JQAiNa+xLuLjHWWyC8eN5abUByYEdGKOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KJ3eou8bRBYA3lKEpf3wq992dYkiyiSH7pa8hRog/a9te1qk49TtN+QRlsc/ya/aWgyMlPgWhMvzPBKCx+AB2zZSm1dgToNOsV2Rj8NrMXWoIRkFeWPF04mvXg4uExfkYroJKIA6ygRX+7XktHFWw1q1EWRIAU2FKdfRJrHfaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fbnEtzKL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790692; x=1759326692;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JK1ukKBpU/JQAiNa+xLuLjHWWyC8eN5abUByYEdGKOM=;
  b=fbnEtzKLCZpyvPBj9HTTcmo3WYEqdi9mlqZAWMu5kWYXOltdMHfNNdIu
   dRD6++11J9TvOGJwUrAGr0gadUAneX2bXFZfcWypLpH5QxyM7Q1Vw23ZQ
   ho2s9i8d9f5gyPXfZWVnIAnVMaKOkmW9UmeNoKbSr4pbTHkogZp1xMf6O
   B9Pms9FY/zgjtVZ0bbLnEgSS7pcwnATdZhBBm4aq0BjBcn3DMcXDfaX3d
   IrP1EE1fHGQRfaDrF8gvIRqcWOGS4YcCD3QUFpVP5L2+1LHBST9eDo9v/
   V5qwi/AkMzBXrtZC/11UdghBIj+KSmrp6Csx88IWQ0PC6iQfF2jhKh7kt
   Q==;
X-CSE-ConnectionGUID: xZlwFxFMQxGj0XznyNUoig==
X-CSE-MsgGUID: pE6HpFtnTz6VDwUN8ORwrQ==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057491"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:37 +0200
Subject: [PATCH net-next 07/15] net: sparx5: use SPX5_CONST for constants
 which already have a symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-7-8c6896fdce66@microchip.com>
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

Now that we have indentified all the chip constants, update the use of
them where a symbol is already defined for the constant.

Constants are accessed using the SPX5_CONSTS macro. Note that this macro
might hide the use of the *sparx5 context pointer. In such case, a
comment is added.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_calendar.c    | 12 ++++++------
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c     |  5 +++--
 drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c |  7 ++++---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c    |  6 ++++--
 .../net/ethernet/microchip/sparx5/sparx5_mactable.c    |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c    |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h    |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c  |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c  |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c    |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c    | 18 +++++++++---------
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c     |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h     |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c    |  4 ++--
 .../net/ethernet/microchip/sparx5/sparx5_switchdev.c   |  5 ++++-
 drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c    |  2 +-
 16 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 76a8bb596aec..b7b611b1ad34 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -131,7 +131,7 @@ static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
 {
 	struct sparx5_port *port;
 
-	if (portno >= SPX5_PORTS) {
+	if (portno >= SPX5_CONST(n_ports)) {
 		/* Internal ports */
 		if (portno == SPX5_PORT_CPU_0 || portno == SPX5_PORT_CPU_1) {
 			/* Equals 1.25G */
@@ -174,7 +174,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 	}
 
 	/* Setup the calendar with the bandwidth to each port */
-	for (portno = 0; portno < SPX5_PORTS_ALL; portno++) {
+	for (portno = 0; portno < SPX5_CONST(n_ports_all); portno++) {
 		u64 reg, offset, this_bw;
 
 		spd = sparx5_get_port_cal_speed(sparx5, portno);
@@ -182,7 +182,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 			continue;
 
 		this_bw = sparx5_cal_speed_to_value(spd);
-		if (portno < SPX5_PORTS)
+		if (portno < SPX5_CONST(n_ports))
 			used_port_bw += this_bw;
 		else
 			/* Internal ports are granted half the value */
@@ -213,7 +213,7 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 		 sparx5, QSYS_CAL_CTRL);
 
 	/* Assign port bandwidth to auto calendar */
-	for (idx = 0; idx < ARRAY_SIZE(cal); idx++)
+	for (idx = 0; idx < SPX5_CONST(n_auto_cals); idx++)
 		spx5_wr(cal[idx], sparx5, QSYS_CAL_AUTO(idx));
 
 	/* Increase grant rate of all ports to account for
@@ -304,7 +304,7 @@ static int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 	for (idx = 0; idx < SPX5_DSM_CAL_MAX_DEVS_PER_TAXI; idx++) {
 		u32 portno = data->taxi_ports[idx];
 
-		if (portno < SPX5_TAXI_PORT_MAX) {
+		if (portno < SPX5_CONST(n_ports_all)) {
 			data->taxi_speeds[idx] = sparx5_cal_speed_to_value
 				(sparx5_get_port_cal_speed(sparx5, portno));
 		} else {
@@ -573,7 +573,7 @@ int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 	if (!data)
 		return -ENOMEM;
 
-	for (taxi = 0; taxi < SPX5_DSM_CAL_TAXIS; ++taxi) {
+	for (taxi = 0; taxi < SPX5_CONST(n_dsm_cal_taxis); ++taxi) {
 		err = sparx5_dsm_calendar_calc(sparx5, taxi, data);
 		if (err) {
 			dev_err(sparx5->dev, "DSM calendar calculation failed\n");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c
index 2d763664dcda..9378d4d82480 100644
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
+	for (i = 0; i < SPX5_CONST(n_ports); i++) {
 		port_itr = port->sparx5->ports[i];
 		if (!port_itr)
 			continue;
@@ -386,7 +387,7 @@ int sparx5_dcb_init(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int i;
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < SPX5_CONST(n_ports); i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index ca97d51e6a8d..4176733179db 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1122,7 +1122,7 @@ static void sparx5_update_stats(struct sparx5 *sparx5)
 {
 	int idx;
 
-	for (idx = 0; idx < SPX5_PORTS; idx++)
+	for (idx = 0; idx < SPX5_CONST(n_ports); idx++)
 		if (sparx5->ports[idx])
 			sparx5_update_port_stats(sparx5, idx);
 }
@@ -1235,14 +1235,15 @@ int sparx_stats_init(struct sparx5 *sparx5)
 	sparx5->num_stats = spx5_stats_count;
 	sparx5->num_ethtool_stats = ARRAY_SIZE(sparx5_stats_layout);
 	sparx5->stats = devm_kcalloc(sparx5->dev,
-				     SPX5_PORTS_ALL * sparx5->num_stats,
+				     SPX5_CONST(n_ports_all) *
+				     sparx5->num_stats,
 				     sizeof(u64), GFP_KERNEL);
 	if (!sparx5->stats)
 		return -ENOMEM;
 
 	mutex_init(&sparx5->queue_stats_lock);
 	sparx5_config_stats(sparx5);
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < SPX5_CONST(n_ports); portno++)
 		if (sparx5->ports[portno])
 			sparx5_config_port_stats(sparx5, portno);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 61df874b7623..a3ad82cd29aa 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -156,7 +156,9 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	/* Now do the normal processing of the skb */
 	sparx5_ifh_parse((u32 *)skb->data, &fi);
 	/* Map to port netdev */
-	port = fi.src_port < SPX5_PORTS ?  sparx5->ports[fi.src_port] : NULL;
+	port = fi.src_port < SPX5_CONST(n_ports) ?
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
+	for (idx = 0; idx < SPX5_CONST(n_ports); ++idx) {
 		struct sparx5_port *port = sparx5->ports[idx];
 
 		if (port && port->ndev) {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 75868b3f548e..2bebca3460ae 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -82,13 +82,13 @@ int sparx5_mact_learn(struct sparx5 *sparx5, int pgid,
 {
 	int addr, type, ret;
 
-	if (pgid < SPX5_PORTS) {
+	if (pgid < SPX5_CONST(n_ports)) {
 		type = MAC_ENTRY_ADDR_TYPE_UPSID_PN;
 		addr = pgid % 32;
 		addr += (pgid / 32) << 5; /* Add upsid */
 	} else {
 		type = MAC_ENTRY_ADDR_TYPE_MC_IDX;
-		addr = pgid - SPX5_PORTS;
+		addr = pgid - SPX5_CONST(n_ports);
 	}
 
 	mutex_lock(&sparx5->lock);
@@ -371,7 +371,7 @@ static void sparx5_mact_handle_entry(struct sparx5 *sparx5,
 		return;
 
 	port = LRN_MAC_ACCESS_CFG_2_MAC_ENTRY_ADDR_GET(cfg2);
-	if (port >= SPX5_PORTS)
+	if (port >= SPX5_CONST(n_ports))
 		return;
 
 	if (!test_bit(port, sparx5->bridge_mask))
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 5f3690a59ac1..063f02fd36c3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -32,7 +32,7 @@
 const struct sparx5_regs *regs;
 
 #define QLIM_WM(fraction) \
-	((SPX5_BUFFER_MEMORY / SPX5_BUFFER_CELL_SZ - 100) * (fraction) / 100)
+	((SPX5_CONST(buf_size) / SPX5_BUFFER_CELL_SZ - 100) * (fraction) / 100)
 #define IO_RANGES 3
 
 struct initial_port_config {
@@ -584,7 +584,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 		 GCB_HW_SGPIO_SD_CFG);
 
 	/* Refer to LOS SGPIO */
-	for (idx = 0; idx < SPX5_PORTS; idx++)
+	for (idx = 0; idx < SPX5_CONST(n_ports); idx++)
 		if (sparx5->ports[idx])
 			if (sparx5->ports[idx]->conf.sd_sgpio != ~0)
 				spx5_wr(sparx5->ports[idx]->conf.sd_sgpio,
@@ -608,7 +608,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 	}
 
 	/* Enable CPU ports */
-	for (idx = SPX5_PORTS; idx < SPX5_PORTS_ALL; idx++)
+	for (idx = SPX5_CONST(n_ports); idx < SPX5_CONST(n_ports_all); idx++)
 		spx5_rmw(QFWD_SWITCH_PORT_MODE_PORT_ENA_SET(1),
 			 QFWD_SWITCH_PORT_MODE_PORT_ENA,
 			 sparx5,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 91f5a3be829e..8398f32ffaad 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -56,14 +56,14 @@ enum sparx5_vlan_port_type {
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
-#define SPX5_PORT_CPU          (SPX5_PORTS)  /* Next port is CPU port */
+#define SPX5_PORT_CPU          SPX5_CONST(n_ports)  /* Next port is CPU port */
 #define SPX5_PORT_CPU_0        (SPX5_PORT_CPU + 0) /* CPU Port 65 */
 #define SPX5_PORT_CPU_1        (SPX5_PORT_CPU + 1) /* CPU Port 66 */
 #define SPX5_PORT_VD0          (SPX5_PORT_CPU + 2) /* VD0/Port 67 used for IPMC */
 #define SPX5_PORT_VD1          (SPX5_PORT_CPU + 3) /* VD1/Port 68 used for AFI/OAM */
 #define SPX5_PORT_VD2          (SPX5_PORT_CPU + 4) /* VD2/Port 69 used for IPinIP*/
 
-#define PGID_BASE              SPX5_PORTS /* Starts after port PGIDs */
+#define PGID_BASE              SPX5_CONST(n_ports) /* Starts after port PGIDs */
 #define PGID_UC_FLOOD          (PGID_BASE + 0)
 #define PGID_MC_FLOOD          (PGID_BASE + 1)
 #define PGID_IPV4_MC_DATA      (PGID_BASE + 2)
@@ -532,7 +532,7 @@ int sparx5_policer_conf_set(struct sparx5 *sparx5, struct sparx5_policer *pol);
 #define SPX5_PSFP_SG_MIN_CYCLE_TIME_NS (1 * NSEC_PER_USEC)
 #define SPX5_PSFP_SG_MAX_CYCLE_TIME_NS ((1 * NSEC_PER_SEC) - 1)
 #define SPX5_PSFP_SG_MAX_IPV (SPX5_PRIOS - 1)
-#define SPX5_PSFP_SG_OPEN (SPX5_PSFP_SG_CNT - 1)
+#define SPX5_PSFP_SG_OPEN (SPX5_CONST(n_gates) - 1)
 #define SPX5_PSFP_SG_CYCLE_TIME_DEFAULT 1000000
 #define SPX5_PSFP_SF_MAX_SDU 16383
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 3ae6bad3bbb3..321ca9d51100 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -290,7 +290,7 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
 	int portno;
 	int err;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < SPX5_CONST(n_ports); portno++)
 		if (sparx5->ports[portno]) {
 			err = register_netdev(sparx5->ports[portno]->ndev);
 			if (err) {
@@ -309,7 +309,7 @@ void sparx5_destroy_netdevs(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int portno;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++) {
+	for (portno = 0; portno < SPX5_CONST(n_ports); portno++) {
 		port = sparx5->ports[portno];
 		if (port && port->phylink) {
 			/* Disconnect the phy */
@@ -327,7 +327,7 @@ void sparx5_unregister_netdevs(struct sparx5 *sparx5)
 {
 	int portno;
 
-	for (portno = 0; portno < SPX5_PORTS; portno++)
+	for (portno = 0; portno < SPX5_CONST(n_ports); portno++)
 		if (sparx5->ports[portno])
 			unregister_netdev(sparx5->ports[portno]->ndev);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index e637834b56df..22f6d753f5d1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -75,7 +75,7 @@ static void sparx5_xtr_grp(struct sparx5 *sparx5, u8 grp, bool byte_swap)
 	sparx5_ifh_parse(ifh, &fi);
 
 	/* Map to port netdev */
-	port = fi.src_port < SPX5_PORTS ?
+	port = fi.src_port < SPX5_CONST(n_ports) ?
 		sparx5->ports[fi.src_port] : NULL;
 	if (!port || !port->ndev) {
 		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
index 97adccea5352..56e96555b134 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
@@ -5,7 +5,7 @@ void sparx5_pgid_init(struct sparx5 *sparx5)
 {
 	int i;
 
-	for (i = 0; i < PGID_TABLE_SIZE; i++)
+	for (i = 0; i < SPX5_CONST(n_pgids); i++)
 		sparx5->pgid_map[i] = SPX5_PGID_FREE;
 
 	/* Reserved for unicast, flood control, broadcast, and CPU.
@@ -22,7 +22,7 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *sparx5, u16 *idx)
 	/* The multicast area starts at index 65, but the first 7
 	 * are reserved for flood masks and CPU. Start alloc after that.
 	 */
-	for (i = PGID_MCAST_START; i < PGID_TABLE_SIZE; i++) {
+	for (i = PGID_MCAST_START; i < SPX5_CONST(n_pgids); i++) {
 		if (sparx5->pgid_map[i] == SPX5_PGID_FREE) {
 			sparx5->pgid_map[i] = SPX5_PGID_MULTICAST;
 			*idx = i;
@@ -35,7 +35,7 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *sparx5, u16 *idx)
 
 int sparx5_pgid_free(struct sparx5 *sparx5, u16 idx)
 {
-	if (idx <= PGID_CPU || idx >= PGID_TABLE_SIZE)
+	if (idx <= PGID_CPU || idx >= SPX5_CONST(n_pgids))
 		return -EINVAL;
 
 	if (sparx5->pgid_map[idx] == SPX5_PGID_FREE)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 5d9c7b782352..58bc4eba996b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -22,34 +22,34 @@ static struct sparx5_pool_entry sparx5_psfp_sf_pool[SPX5_PSFP_SF_CNT];
 
 static int sparx5_psfp_sf_get(struct sparx5 *sparx5, u32 *id)
 {
-	return sparx5_pool_get(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
+	return sparx5_pool_get(sparx5_psfp_sf_pool, SPX5_CONST(n_filters), id);
 }
 
 static int sparx5_psfp_sf_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_sf_pool, SPX5_CONST(n_filters), id);
 }
 
 static int sparx5_psfp_sg_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
-	return sparx5_pool_get_with_idx(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT,
-					idx, id);
+	return sparx5_pool_get_with_idx(sparx5_psfp_sg_pool,
+					SPX5_CONST(n_gates), idx, id);
 }
 
 static int sparx5_psfp_sg_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_sg_pool, SPX5_CONST(n_gates), id);
 }
 
 static int sparx5_psfp_fm_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
-	return sparx5_pool_get_with_idx(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, idx,
-					id);
+	return sparx5_pool_get_with_idx(sparx5_psfp_fm_pool,
+					SPX5_CONST(n_sdlbs), idx, id);
 }
 
 static int sparx5_psfp_fm_put(struct sparx5 *sparx5, u32 id)
 {
-	return sparx5_pool_put(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, id);
+	return sparx5_pool_put(sparx5_psfp_fm_pool, SPX5_CONST(n_sdlbs), id);
 }
 
 u32 sparx5_psfp_isdx_get_sf(struct sparx5 *sparx5, u32 isdx)
@@ -318,7 +318,7 @@ void sparx5_psfp_init(struct sparx5 *sparx5)
 	const struct sparx5_sdlb_group *group;
 	int i;
 
-	for (i = 0; i < SPX5_SDLB_GROUP_CNT; i++) {
+	for (i = 0; i < SPX5_CONST(n_lb_groups); i++) {
 		group = &sdlb_groups[i];
 		sparx5_sdlb_group_init(sparx5, group->max_rate,
 				       group->min_burst, group->frame_size, i);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 5a932460db58..d2626fade52c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -13,7 +13,7 @@
 
 #define SPARX5_MAX_PTP_ID	512
 
-#define TOD_ACC_PIN		0x4
+#define TOD_ACC_PIN            SPX5_CONST(tod_pin)
 
 enum {
 	PTP_PIN_ACTION_IDLE = 0,
@@ -630,7 +630,7 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 	/* Enable master counters */
 	spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < SPX5_CONST(n_ports); i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
@@ -646,7 +646,7 @@ void sparx5_ptp_deinit(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int i;
 
-	for (i = 0; i < SPX5_PORTS; i++) {
+	for (i = 0; i < SPX5_CONST(n_ports); i++) {
 		port = sparx5->ports[i];
 		if (!port)
 			continue;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index ced35033a6c5..8419577cfda0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -14,7 +14,7 @@
 
 /* Scheduling elements per layer */
 #define SPX5_HSCH_L0_SE_CNT 5040
-#define SPX5_HSCH_L1_SE_CNT 64
+#define SPX5_HSCH_L1_SE_CNT SPX5_CONST(n_hsch_l1_elems)
 #define SPX5_HSCH_L2_SE_CNT 64
 
 /* Calculate Layer 0 Scheduler Element when using normal hierarchy */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index f5267218caeb..77fc2a14450d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
@@ -184,7 +184,7 @@ int sparx5_sdlb_group_get_by_rate(struct sparx5 *sparx5, u32 rate, u32 burst)
 
 	rate_bps = rate * 1000;
 
-	for (i = SPX5_SDLB_GROUP_CNT - 1; i >= 0; i--) {
+	for (i = SPX5_CONST(n_lb_groups) - 1; i >= 0; i--) {
 		group = &sdlb_groups[i];
 
 		count = sparx5_sdlb_group_get_count(sparx5, i);
@@ -208,7 +208,7 @@ int sparx5_sdlb_group_get_by_index(struct sparx5 *sparx5, u32 idx, u32 *group)
 	u32 itr, next;
 	int i;
 
-	for (i = 0; i < SPX5_SDLB_GROUP_CNT; i++) {
+	for (i = 0; i < SPX5_CONST(n_lb_groups); i++) {
 		if (sparx5_sdlb_group_is_empty(sparx5, i))
 			continue;
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index bcee9adcfbdb..c583479126fa 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -32,6 +32,7 @@ static int sparx5_port_attr_pre_bridge_flags(struct sparx5_port *port,
 static void sparx5_port_update_mcast_ip_flood(struct sparx5_port *port, bool flood_flag)
 {
 	bool should_flood = flood_flag || port->is_mrouter;
+	struct sparx5 *sparx5 = port->sparx5; /* Used by PGID_* macros */
 	int pgid;
 
 	for (pgid = PGID_IPV4_MC_DATA; pgid <= PGID_IPV6_MC_CTRL; pgid++)
@@ -41,6 +42,8 @@ static void sparx5_port_update_mcast_ip_flood(struct sparx5_port *port, bool flo
 static void sparx5_port_attr_bridge_flags(struct sparx5_port *port,
 					  struct switchdev_brport_flags flags)
 {
+	struct sparx5 *sparx5 = port->sparx5; /* Used by PGID_* macros */
+
 	if (flags.mask & BR_MCAST_FLOOD) {
 		sparx5_pgid_update_mask(port, PGID_MC_FLOOD, !!(flags.val & BR_MCAST_FLOOD));
 		sparx5_port_update_mcast_ip_flood(port, !!(flags.val & BR_MCAST_FLOOD));
@@ -547,7 +550,7 @@ static int sparx5_handle_port_mdb_add(struct net_device *dev,
 
 	/* Add any mrouter ports to the new entry */
 	if (is_new && ether_addr_is_ip_mcast(v->addr))
-		for (i = 0; i < SPX5_PORTS; i++)
+		for (i = 0; i < SPX5_CONST(n_ports); i++)
 			if (sparx5->ports[i] && sparx5->ports[i]->is_mrouter)
 				sparx5_pgid_update_mask(sparx5->ports[i],
 							entry->pgid_idx,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index ac001ae59a38..5d5e5c2c05c5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -169,7 +169,7 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 	}
 
 	/* Update SRC masks */
-	for (port = 0; port < SPX5_PORTS; port++) {
+	for (port = 0; port < SPX5_CONST(n_ports); port++) {
 		if (test_bit(port, sparx5->bridge_fwd_mask)) {
 			/* Allow to send to all bridged but self */
 			bitmap_copy(workmask, sparx5->bridge_fwd_mask, SPX5_PORTS);

-- 
2.34.1


