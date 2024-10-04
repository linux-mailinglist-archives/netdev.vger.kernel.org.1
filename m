Return-Path: <netdev+bounces-132055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22DF990405
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8DA1C216B9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A312194AB;
	Fri,  4 Oct 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UzZ2oBNE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7C2101B0;
	Fri,  4 Oct 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048085; cv=none; b=Gw0FU7sBO/h9I2DIfmkazne5u3MLExsUiGRPDhkQEnAcYxbV1tKL39kQSqaGlaQ45R30SCL6BvYYYZF6V7e2JS6tqrH11jq48dt5113ltHvWzgdP3T70XxgoMwSeYIlbEEPnbxstOHiAs0n+ib0yp5vGoaoKx6HeX9Xp2YK374o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048085; c=relaxed/simple;
	bh=GV0RVyEWRZ7t9VQxB8hB517NRO44R0FAWhwOXbldd6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oDEPx+Np/h3wb2CIGp5WVaBIoifBXDiAljrpuhhEfSMDEw/t1foeYJLx3CSUr7E+IpKmDQH/bjRcPaCly/jYcnP4K+B3pUMM1wUOHWnrfKmKRCvy+5NxyAnVnNkhplIxNTsYa+wwZQLQgWCNNMgfxTVWbZZsWgBmzDTjihlVbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UzZ2oBNE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048083; x=1759584083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GV0RVyEWRZ7t9VQxB8hB517NRO44R0FAWhwOXbldd6k=;
  b=UzZ2oBNEZ2sPFjPNifmqsQcpCxJohXQnKKREqzJ73BDQR02d+ye+I8Ta
   ekJsyrep/ZPKNvwDfKrAbH9gfAeFGFOQUcPNWr4PMd9hqwhL497r8jGxV
   Tn5n4Nd7qbx/t17AwufKsQEyq4DT9gYnqFS2Gxy197FxxNsD8VRpMfGrW
   85mH8MpSe1zFcrPz9l9RL7U7/ZZLCaAob73jo6RcEpzWrohoyU4PhvGmO
   RIG0XnNxQwdEo6RAr7K7TOm3OlDaFSPMHP6IZrM45mRVnPTCLHL4RP2Ml
   vTXtC06YaVOpr7pHGZ8pVCyg0ZBXKVjkdmFCGve7EL3DQo3Y+xE8jtoKs
   A==;
X-CSE-ConnectionGUID: tl4kxetcSMSl+/bXMkMidw==
X-CSE-MsgGUID: AUS4kIb1SfquuH0bzRhDOw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="200042227"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:21:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:41 +0200
Subject: [PATCH net-next v2 15/15] net: sparx5: redefine internal ports and
 PGID's as offsets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-15-d3290f581663@microchip.com>
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

Internal ports and PGID's are both defined relative to the number of
front ports on Sparx5. This will not work on lan969x. Instead make them
offsets to the number of front ports and add two helpers to retrieve
them. Use the helpers throughout.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 14 ++++++---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  4 ++-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |  3 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 14 +++++----
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 34 +++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  6 ++--
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  4 ++-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    | 13 +++++++--
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  5 ++++
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   | 31 ++++++++++++++------
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |  3 +-
 11 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 63f6c5484fdb..b2a8d04ab509 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -118,16 +118,22 @@ static enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5,
 
 	if (portno >= sparx5->data->consts->n_ports) {
 		/* Internal ports */
-		if (portno == SPX5_PORT_CPU_0 || portno == SPX5_PORT_CPU_1) {
+		if (portno ==
+			    sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_0) ||
+		    portno ==
+			    sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_1)) {
 			/* Equals 1.25G */
 			return SPX5_CAL_SPEED_2G5;
-		} else if (portno == SPX5_PORT_VD0) {
+		} else if (portno ==
+			   sparx5_get_internal_port(sparx5, SPX5_PORT_VD0)) {
 			/* IPMC only idle BW */
 			return SPX5_CAL_SPEED_NONE;
-		} else if (portno == SPX5_PORT_VD1) {
+		} else if (portno ==
+			   sparx5_get_internal_port(sparx5, SPX5_PORT_VD1)) {
 			/* OAM only idle BW */
 			return SPX5_CAL_SPEED_NONE;
-		} else if (portno == SPX5_PORT_VD2) {
+		} else if (portno ==
+			   sparx5_get_internal_port(sparx5, SPX5_PORT_VD2)) {
 			/* IPinIP gets only idle BW */
 			return SPX5_CAL_SPEED_NONE;
 		}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 4919719da0cb..88f7509f0980 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -364,7 +364,9 @@ static void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
 		sparx5, QS_INJ_GRP_CFG(INJ_QUEUE));
 
 	/* CPU ports capture setup */
-	for (portno = SPX5_PORT_CPU_0; portno <= SPX5_PORT_CPU_1; portno++) {
+	for (portno = sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_0);
+	     portno <= sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_1);
+	     portno++) {
 		/* ASM CPU port: No preamble, IFH, enable padding */
 		spx5_wr(ASM_PORT_CFG_PAD_ENA_SET(1) |
 			ASM_PORT_CFG_NO_PREAMBLE_ENA_SET(1) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 56f6b94c4ef3..f5584244612c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -129,7 +129,8 @@ int sparx5_mc_sync(struct net_device *dev, const unsigned char *addr)
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
 
-	return sparx5_mact_learn(sparx5, PGID_CPU, addr, port->pvid);
+	return sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU),
+				 addr, port->pvid);
 }
 
 static int sparx5_mact_get(struct sparx5 *sparx5,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 74b9b2b0a9cb..c9668b288d29 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -649,13 +649,14 @@ static int sparx5_start(struct sparx5 *sparx5)
 	sparx5_update_fwd(sparx5);
 
 	/* CPU copy CPU pgids */
-	spx5_wr(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(1),
-		sparx5, ANA_AC_PGID_MISC_CFG(PGID_CPU));
-	spx5_wr(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(1),
-		sparx5, ANA_AC_PGID_MISC_CFG(PGID_BCAST));
+	spx5_wr(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(1), sparx5,
+		ANA_AC_PGID_MISC_CFG(sparx5_get_pgid(sparx5, PGID_CPU)));
+	spx5_wr(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(1), sparx5,
+		ANA_AC_PGID_MISC_CFG(sparx5_get_pgid(sparx5, PGID_BCAST)));
 
 	/* Recalc injected frame FCS */
-	for (idx = SPX5_PORT_CPU_0; idx <= SPX5_PORT_CPU_1; idx++)
+	for (idx = sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_0);
+	     idx <= sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_1); idx++)
 		spx5_rmw(ANA_CL_FILTER_CTRL_FORCE_FCS_UPDATE_ENA_SET(1),
 			 ANA_CL_FILTER_CTRL_FORCE_FCS_UPDATE_ENA,
 			 sparx5, ANA_CL_FILTER_CTRL(idx));
@@ -670,7 +671,8 @@ static int sparx5_start(struct sparx5 *sparx5)
 	sparx5_vlan_init(sparx5);
 
 	/* Add host mode BC address (points only to CPU) */
-	sparx5_mact_learn(sparx5, PGID_CPU, broadcast, NULL_VID);
+	sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU), broadcast,
+			  NULL_VID);
 
 	/* Enable queue limitation watermarks */
 	sparx5_qlim_set(sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index fb179088588a..364ae92969bc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -54,23 +54,21 @@ enum sparx5_vlan_port_type {
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
-#define SPX5_PORT_CPU          (SPX5_PORTS)  /* Next port is CPU port */
-#define SPX5_PORT_CPU_0        (SPX5_PORT_CPU + 0) /* CPU Port 65 */
-#define SPX5_PORT_CPU_1        (SPX5_PORT_CPU + 1) /* CPU Port 66 */
-#define SPX5_PORT_VD0          (SPX5_PORT_CPU + 2) /* VD0/Port 67 used for IPMC */
-#define SPX5_PORT_VD1          (SPX5_PORT_CPU + 3) /* VD1/Port 68 used for AFI/OAM */
-#define SPX5_PORT_VD2          (SPX5_PORT_CPU + 4) /* VD2/Port 69 used for IPinIP*/
-
-#define PGID_BASE              SPX5_PORTS /* Starts after port PGIDs */
-#define PGID_UC_FLOOD          (PGID_BASE + 0)
-#define PGID_MC_FLOOD          (PGID_BASE + 1)
-#define PGID_IPV4_MC_DATA      (PGID_BASE + 2)
-#define PGID_IPV4_MC_CTRL      (PGID_BASE + 3)
-#define PGID_IPV6_MC_DATA      (PGID_BASE + 4)
-#define PGID_IPV6_MC_CTRL      (PGID_BASE + 5)
-#define PGID_BCAST	       (PGID_BASE + 6)
-#define PGID_CPU	       (PGID_BASE + 7)
-#define PGID_MCAST_START       (PGID_BASE + 8)
+#define SPX5_PORT_CPU_0        0 /* CPU Port 0 */
+#define SPX5_PORT_CPU_1        1 /* CPU Port 1 */
+#define SPX5_PORT_VD0          2 /* VD0/Port used for IPMC */
+#define SPX5_PORT_VD1          3 /* VD1/Port used for AFI/OAM */
+#define SPX5_PORT_VD2          4 /* VD2/Port used for IPinIP*/
+
+#define PGID_UC_FLOOD          0
+#define PGID_MC_FLOOD          1
+#define PGID_IPV4_MC_DATA      2
+#define PGID_IPV4_MC_CTRL      3
+#define PGID_IPV6_MC_DATA      4
+#define PGID_IPV6_MC_CTRL      5
+#define PGID_BCAST             6
+#define PGID_CPU               7
+#define PGID_MCAST_START       8
 
 #define PGID_TABLE_SIZE	       3290
 
@@ -500,6 +498,7 @@ enum sparx5_pgid_type {
 void sparx5_pgid_init(struct sparx5 *spx5);
 int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx);
 int sparx5_pgid_free(struct sparx5 *spx5, u16 idx);
+int sparx5_get_pgid(struct sparx5 *sparx5, int pgid);
 
 /* sparx5_pool.c */
 struct sparx5_pool_entry {
@@ -516,6 +515,7 @@ int sparx5_pool_get_with_idx(struct sparx5_pool_entry *pool, int size, u32 idx,
 /* sparx5_port.c */
 int sparx5_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
 			struct sparx5_port_config *conf);
+int sparx5_get_internal_port(struct sparx5 *sparx5, int port);
 
 /* sparx5_sdlb.c */
 #define SPX5_SDLB_PUP_TOKEN_DISABLE 0x1FFF
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index c61b22a96e22..d4e9986ef16a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -68,7 +68,8 @@ void sparx5_set_port_ifh(struct sparx5 *sparx5, void *ifh_hdr, u16 portno)
 	/* MISC.PIPELINE_ACT */
 	ifh_encode_bitfield(ifh_hdr, 1,        42, 3);
 	/* FWD.SRC_PORT = CPU */
-	ifh_encode_bitfield(ifh_hdr, SPX5_PORT_CPU, 46, 7);
+	ifh_encode_bitfield(ifh_hdr, sparx5_get_pgid(sparx5, SPX5_PORT_CPU_0),
+			    46, 7);
 	/* FWD.SFLOW_ID (disable SFlow sampling) */
 	ifh_encode_bitfield(ifh_hdr, 124,      57, 7);
 	/* FWD.UPDATE_FCS = Enable. Enforce update of FCS. */
@@ -190,7 +191,8 @@ static int sparx5_set_mac_address(struct net_device *dev, void *p)
 	sparx5_mact_forget(sparx5, dev->dev_addr,  port->pvid);
 
 	/* Add new */
-	sparx5_mact_learn(sparx5, PGID_CPU, addr->sa_data, port->pvid);
+	sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU),
+			  addr->sa_data, port->pvid);
 
 	/* Record the address */
 	eth_hw_addr_set(dev, addr->sa_data);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 700842ec7608..5bfa86a71ac8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -317,7 +317,9 @@ int sparx5_manual_injection_mode(struct sparx5 *sparx5)
 		sparx5, QS_INJ_GRP_CFG(INJ_QUEUE));
 
 	/* CPU ports capture setup */
-	for (portno = SPX5_PORT_CPU_0; portno <= SPX5_PORT_CPU_1; portno++) {
+	for (portno = sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_0);
+	     portno <= sparx5_get_internal_port(sparx5, SPX5_PORT_CPU_1);
+	     portno++) {
 		/* ASM CPU port: No preamble, IFH, enable padding */
 		spx5_wr(ASM_PORT_CFG_PAD_ENA_SET(1) |
 			ASM_PORT_CFG_NO_PREAMBLE_ENA_SET(1) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
index 78ef99b833ed..eae819fa9486 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
@@ -11,7 +11,7 @@ void sparx5_pgid_init(struct sparx5 *spx5)
 	/* Reserved for unicast, flood control, broadcast, and CPU.
 	 * These cannot be freed.
 	 */
-	for (i = 0; i <= PGID_CPU; i++)
+	for (i = 0; i <= sparx5_get_pgid(spx5, PGID_CPU); i++)
 		spx5->pgid_map[i] = SPX5_PGID_RESERVED;
 }
 
@@ -22,7 +22,8 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 	/* The multicast area starts at index 65, but the first 7
 	 * are reserved for flood masks and CPU. Start alloc after that.
 	 */
-	for (i = PGID_MCAST_START; i < spx5->data->consts->n_pgids; i++) {
+	for (i = sparx5_get_pgid(spx5, PGID_MCAST_START);
+	     i < spx5->data->consts->n_pgids; i++) {
 		if (spx5->pgid_map[i] == SPX5_PGID_FREE) {
 			spx5->pgid_map[i] = SPX5_PGID_MULTICAST;
 			*idx = i;
@@ -35,7 +36,8 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 
 int sparx5_pgid_free(struct sparx5 *spx5, u16 idx)
 {
-	if (idx <= PGID_CPU || idx >= spx5->data->consts->n_pgids)
+	if (idx <= sparx5_get_pgid(spx5, PGID_CPU) ||
+	    idx >= spx5->data->consts->n_pgids)
 		return -EINVAL;
 
 	if (spx5->pgid_map[idx] == SPX5_PGID_FREE)
@@ -44,3 +46,8 @@ int sparx5_pgid_free(struct sparx5 *spx5, u16 idx)
 	spx5->pgid_map[idx] = SPX5_PGID_FREE;
 	return 0;
 }
+
+int sparx5_get_pgid(struct sparx5 *sparx5, int pgid)
+{
+	return sparx5->data->consts->n_ports + pgid;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 0dc2201fe653..0b38b4cb0929 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1352,3 +1352,8 @@ int sparx5_port_qos_default_set(const struct sparx5_port *port,
 
 	return 0;
 }
+
+int sparx5_get_internal_port(struct sparx5 *sparx5, int port)
+{
+	return sparx5->data->consts->n_ports + port;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index d1e7b85bdffa..bc9ecb9392cd 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -32,24 +32,34 @@ static int sparx5_port_attr_pre_bridge_flags(struct sparx5_port *port,
 static void sparx5_port_update_mcast_ip_flood(struct sparx5_port *port, bool flood_flag)
 {
 	bool should_flood = flood_flag || port->is_mrouter;
+	struct sparx5 *sparx5 = port->sparx5;
 	int pgid;
 
-	for (pgid = PGID_IPV4_MC_DATA; pgid <= PGID_IPV6_MC_CTRL; pgid++)
+	for (pgid = sparx5_get_pgid(sparx5, PGID_IPV4_MC_DATA);
+	     pgid <= sparx5_get_pgid(sparx5, PGID_IPV6_MC_CTRL); pgid++)
 		sparx5_pgid_update_mask(port, pgid, should_flood);
 }
 
 static void sparx5_port_attr_bridge_flags(struct sparx5_port *port,
 					  struct switchdev_brport_flags flags)
 {
+	struct sparx5 *sparx5 = port->sparx5;
+
 	if (flags.mask & BR_MCAST_FLOOD) {
-		sparx5_pgid_update_mask(port, PGID_MC_FLOOD, !!(flags.val & BR_MCAST_FLOOD));
+		sparx5_pgid_update_mask(port,
+					sparx5_get_pgid(sparx5, PGID_MC_FLOOD),
+					!!(flags.val & BR_MCAST_FLOOD));
 		sparx5_port_update_mcast_ip_flood(port, !!(flags.val & BR_MCAST_FLOOD));
 	}
 
 	if (flags.mask & BR_FLOOD)
-		sparx5_pgid_update_mask(port, PGID_UC_FLOOD, !!(flags.val & BR_FLOOD));
+		sparx5_pgid_update_mask(port,
+					sparx5_get_pgid(sparx5, PGID_UC_FLOOD),
+					!!(flags.val & BR_FLOOD));
 	if (flags.mask & BR_BCAST_FLOOD)
-		sparx5_pgid_update_mask(port, PGID_BCAST, !!(flags.val & BR_BCAST_FLOOD));
+		sparx5_pgid_update_mask(port,
+					sparx5_get_pgid(sparx5, PGID_BCAST),
+					!!(flags.val & BR_BCAST_FLOOD));
 }
 
 static void sparx5_attr_stp_state_set(struct sparx5_port *port,
@@ -219,7 +229,8 @@ static void sparx5_port_bridge_leave(struct sparx5_port *port,
 	port->vid = NULL_VID;
 
 	/* Forward frames to CPU */
-	sparx5_mact_learn(sparx5, PGID_CPU, port->ndev->dev_addr, 0);
+	sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU),
+			  port->ndev->dev_addr, 0);
 
 	/* Port enters in host more therefore restore mc list */
 	__dev_mc_sync(port->ndev, sparx5_mc_sync, sparx5_mc_unsync);
@@ -254,7 +265,8 @@ static int sparx5_port_add_addr(struct net_device *dev, bool up)
 	u16 vid = port->pvid;
 
 	if (up)
-		sparx5_mact_learn(sparx5, PGID_CPU, port->ndev->dev_addr, vid);
+		sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU),
+				  port->ndev->dev_addr, vid);
 	else
 		sparx5_mact_forget(sparx5, port->ndev->dev_addr, vid);
 
@@ -330,7 +342,8 @@ static void sparx5_switchdev_bridge_fdb_event_work(struct work_struct *work)
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (host_addr)
-			sparx5_add_mact_entry(sparx5, dev, PGID_CPU,
+			sparx5_add_mact_entry(sparx5, dev,
+					      sparx5_get_pgid(sparx5, PGID_CPU),
 					      fdb_info->addr, vid);
 		else
 			sparx5_add_mact_entry(sparx5, port->ndev, port->portno,
@@ -418,8 +431,8 @@ static int sparx5_handle_port_vlan_add(struct net_device *dev,
 				     switchdev_blocking_nb);
 
 		/* Flood broadcast to CPU */
-		sparx5_mact_learn(sparx5, PGID_BCAST, dev->broadcast,
-				  v->vid);
+		sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_BCAST),
+				  dev->broadcast, v->vid);
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index 80d2d3e8f458..d42097aa60a0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -168,7 +168,8 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 	bitmap_to_arr32(mask, sparx5->bridge_fwd_mask, SPX5_PORTS);
 
 	/* Update flood masks */
-	for (port = PGID_UC_FLOOD; port <= PGID_BCAST; port++) {
+	for (port = sparx5_get_pgid(sparx5, PGID_UC_FLOOD);
+	     port <= sparx5_get_pgid(sparx5, PGID_BCAST); port++) {
 		spx5_wr(mask[0], sparx5, ANA_AC_PGID_CFG(port));
 		if (is_sparx5(sparx5)) {
 			spx5_wr(mask[1], sparx5, ANA_AC_PGID_CFG1(port));

-- 
2.34.1


