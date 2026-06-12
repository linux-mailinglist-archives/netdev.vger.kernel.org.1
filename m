Return-Path: <netdev+bounces-298636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /zOTF9H+K2rbJAQAu9opvQ
	(envelope-from <netdev+bounces-298636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:42:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45966796D8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:42:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=e3ns7vTO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298636-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298636-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3D931AECCC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A63E9C2A;
	Fri, 12 Jun 2026 12:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106633E9585;
	Fri, 12 Jun 2026 12:38:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267941; cv=none; b=dj4X4Yq8+AjZ7pyFCEjryKLUZAHKAO2tAyIvC7rbniot1zGt3MWqDiW/gKrT4E5Yx6vfGgsy0RM3NNrrP+c4B5vcoR7ghHIYjMcUYDaWX1MiVghhrCwRKv8YMuriD11vzIX6mQHo0lmiRsQaVjKjV2MbuCgx9pZ3fgtpPn+9Sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267941; c=relaxed/simple;
	bh=A9vr/+uqaf3zDSHykzap0O/Z/YWGVy7TuaJKpfOygBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ApHgLVigYh+JgqUaCwdRRPtEdVM8Vzf7Lo4pOwfOZ6fV1t2FQ/TH8anA2ryyGQ0mo2l38XIGTw6cu8c/FOWEfNXifMxseY6v0rAknGRZys43loeG0Vajz4f0lrSpKAY9dvmjzJlqCvPh3lS1hNbsc1i59ZP4mGTPxVVgd3Bi8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e3ns7vTO; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267938; x=1812803938;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=A9vr/+uqaf3zDSHykzap0O/Z/YWGVy7TuaJKpfOygBg=;
  b=e3ns7vTOD6xwykyc0JP6ltw7HrZDKpuL5uORB6llx0oK/5tDONpWdMTV
   5mO1P9g6SAQ373S2nHv83ogOT/lreaVIT6GJ37zj2EFNtyi77mne5nmtL
   Q2s/yHIH4iqCOCjqBpYbCGmhf5z5efPiQL71FdPD/q3Oq/Ro5q/RDAxdM
   wt51jkIb+CddCp54ArMR0uWuuGDZMWUZ65SVcPRh1BAf8UXMAwkMD63n/
   OpA8snltjvOegQf+OwqvGTRKCjpfMoIXUL2z2A9sJwJkByzYTcwIJ6/wN
   KPXXkHZMjz7cJS82YjGbiWsJKhfrjGTUN5c7zdVaSOaUvXvnPlg3OSPkd
   g==;
X-CSE-ConnectionGUID: 4bgChoCeQZqYq1OyhcNWUQ==
X-CSE-MsgGUID: S53ERByWT1CuqN0Eh8HoYQ==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="290403662"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 05:38:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 05:38:56 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:53 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:16 +0200
Subject: [PATCH net-next 7/9] net: sparx5: add L3 router infrastructure and
 leg management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-7-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
In-Reply-To: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298636-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A45966796D8

Add event handling for netdevices and iaddrs to intercept VLAN uppers of
a bridge device, and their IP addresses. Add all the basic types we will
use for l3 routing management. Add lifecycle management for router legs.

The chips can only route in VLAN aware mode, and routing happens between
router legs (RLEG). To each VLAN upper of a VLAN aware bridge, we
associate a router leg. The indices to the router leg table are called
VMIDs in the datasheet.

There is a global router leg base MAC used for MAC rewrites by the chip.
Here we use the bridge MAC.

A specific leg is reserved to enable blackhole routes. The blackhole
route uses an reserved egress VLAN id for which the port mask is empty,
resulting in all frames being dropped.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   13 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   43 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 1051 ++++++++++++++++++++
 5 files changed, 1109 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index d447f9e84d92..d917734d9f12 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -11,7 +11,7 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
  sparx5_ptp.o sparx5_pgid.o sparx5_tc.o sparx5_qos.o \
  sparx5_vcap_impl.o sparx5_vcap_ag_api.o sparx5_tc_flower.o \
  sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o \
- sparx5_psfp.o sparx5_mirror.o sparx5_regs.o
+ sparx5_psfp.o sparx5_mirror.o sparx5_regs.o sparx5_router.o
 
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
 sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index f3a9c71bea36..f8d1741c264f 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -322,6 +322,8 @@ static const struct sparx5_consts lan969x_consts = {
 	.qres_max_prio_idx   = 315,
 	.qres_max_colour_idx = 323,
 	.tod_pin             = 4,
+	.vmid_cnt            = 127,
+	.arp_tbl_cnt         = 1024,
 	.vcaps               = lan969x_vcaps,
 	.vcap_stats          = &lan969x_vcap_stats,
 	.vcaps_cfg           = lan969x_vcap_inst_cfg,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index dad713e9ddd5..24acdbc20dc8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -994,14 +994,22 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ptp;
 	}
 
+	err = sparx5_rr_router_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Router initialization failed\n");
+		goto cleanup_netdevs;
+	}
+
 	err = sparx5_register_notifier_blocks(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register notifier blocks\n");
-		goto cleanup_netdevs;
+		goto cleanup_router;
 	}
 
 	goto cleanup_config;
 
+cleanup_router:
+	sparx5_rr_router_deinit(sparx5);
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
 cleanup_ptp:
@@ -1031,6 +1039,7 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
 	sparx5_ptp_deinit(sparx5);
+	sparx5_rr_router_deinit(sparx5);
 	sparx5_frame_io_deinit(sparx5);
 	sparx5_stats_deinit(sparx5);
 	sparx5_mact_deinit(sparx5);
@@ -1067,6 +1076,8 @@ static const struct sparx5_consts sparx5_consts = {
 	.qres_max_prio_idx   = 630,
 	.qres_max_colour_idx = 638,
 	.tod_pin             = 4,
+	.vmid_cnt            = 511,
+	.arp_tbl_cnt         = 2048,
 	.vcaps               = sparx5_vcaps,
 	.vcaps_cfg           = sparx5_vcap_inst_cfg,
 	.vcap_stats          = &sparx5_vcap_stats,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index eb57b86fbe22..5dc18b8dbed0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -136,6 +136,10 @@ enum sparx5_feature {
 
 #define SPARX5_MAX_PTP_ID	512
 
+/* Must be maximum values across all L3 enabled platforms */
+#define SPARX5_ROUTER_LEG_N_VMID 511
+#define SPARX5_ARP_TBL_SIZE 2048
+
 struct sparx5;
 
 struct sparx5_calendar_data {
@@ -320,6 +324,8 @@ struct sparx5_consts {
 	u32 qres_max_prio_idx;   /* Maximum QRES prio index */
 	u32 qres_max_colour_idx; /* Maximum QRES colour index */
 	u32 tod_pin;             /* PTP TOD pin */
+	u32 vmid_cnt;            /* Number of router leg VMID's */
+	u32 arp_tbl_cnt;         /* Number of ARP table entries */
 	const struct sparx5_vcap_inst *vcaps_cfg;
 	const struct vcap_info *vcaps;
 	const struct vcap_statistics *vcap_stats;
@@ -434,6 +440,8 @@ struct sparx5 {
 	/* Common root for debugfs */
 	struct dentry *debugfs_root;
 	const struct sparx5_match_data *data;
+	/* L3 Forwarding */
+	struct sparx5_router *router;
 };
 
 /* sparx5_main.c */
@@ -503,6 +511,41 @@ int sparx5_vlan_vid_add(struct sparx5_port *port, u16 vid, bool pvid,
 int sparx5_vlan_vid_del(struct sparx5_port *port, u16 vid);
 void sparx5_vlan_port_apply(struct sparx5 *sparx5, struct sparx5_port *port);
 
+/* sparx5_router.c */
+int sparx5_rr_router_init(struct sparx5 *sparx5);
+void sparx5_rr_router_deinit(struct sparx5 *sparx5);
+
+struct sparx5_rr_hw_route {
+	u32 vrule_id;
+	bool vrule_id_valid;
+};
+
+struct sparx5_router {
+	struct sparx5 *sparx5;
+	struct notifier_block fib_nb;
+	struct notifier_block netevent_nb;
+	struct notifier_block inetaddr_nb;
+	struct notifier_block inetaddr_valid_nb;
+	struct notifier_block netdevice_nb;
+	struct notifier_block inet6addr_nb;
+	struct notifier_block inet6addr_valid_nb;
+	struct sparx5_rr_hw_route link_local; /* Trap all link-local traffic. */
+	struct net_device *port_dev; /* For VCAP API. */
+
+	struct list_head fib_lpm4_list;
+	struct list_head fib_lpm6_list;
+	struct mutex lock; /* Global router lock for all shared data. */
+
+	struct workqueue_struct *sparx5_router_owq;
+
+	atomic_t legs_count;
+	struct list_head leg_list;
+	/* Track allocated router leg indices in hw */
+	DECLARE_BITMAP(vmid_mask, SPARX5_ROUTER_LEG_N_VMID);
+	/* Track allocated arp table indices in hw */
+	DECLARE_BITMAP(arp_tbl_mask, SPARX5_ARP_TBL_SIZE);
+};
+
 /* sparx5_calendar.c */
 int sparx5_calendar_init(struct sparx5 *sparx5);
 int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
new file mode 100644
index 000000000000..03923d91fdfb
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -0,0 +1,1051 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch driver
+ *
+ * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include <linux/inet.h>
+#include <linux/inetdevice.h>
+#include <linux/list.h>
+#include <linux/rhashtable.h>
+#include <net/addrconf.h>
+#include <net/arp.h>
+#include <net/fib_notifier.h>
+#include <net/ip6_fib.h>
+#include <net/ipv6.h>
+#include <net/ndisc.h>
+#include <net/neighbour.h>
+#include <net/netevent.h>
+#include <net/nexthop.h>
+
+#include "sparx5_main.h"
+#include "sparx5_port.h"
+#include "sparx5_vcap_ag_api.h"
+#include "sparx5_vcap_impl.h"
+
+/* The main routing objects are
+ *
+ * 1) Router legs, which correspond to IP interfaces. They can have multiple IPs
+ *    attached and are associated with a VLAN. Only routes with nexthops that
+ *    egress on ports that are part of a router leg are considered for
+ *    offloading.
+ *
+ * 2) Fib entries, which correspond to entries in the routing table.
+ *    > ip route add 6.6.0.0/16 nexthop via 1.0.10.10
+ *    will create fib entry for 6.6.0.0/16, if it is offloadable.
+ *
+ * 3) Nexthop groups and nexthops. Each fib entry has exactly one nexthop hop.
+ *    To simplify the SW representation, we duplicate nexthops and nexthops
+ *    groups for each fib entry, even when the same nexthop is used for many
+ *    different routes.
+ *
+ * 4) Neigh entries, which correspond to directly connected neighbours.
+ *    These are created mainly by ARP events. Their job is to maintain the
+ *    association of L3 and L2 addresses.
+ *
+ *    The neigh entries are referenced by nexthops and fib entries. They are
+ *    shared so we must keep track of the objects that are referencing them.
+ *
+ *    If a neighbour which is used in a nexthop group dies, we will set the mac
+ *    to zero, so traffic for this nexthop is trapped.
+ *
+ *
+ * Both fib_entry and neigh_entry can trigger writes to the LPM VCAP, and own
+ * entries in HW. Fib entries own the corresponding route associated with them.
+ * Neigh entries own a /32 route, for traffic destined directly to the
+ * neighbour.
+ *
+ * We have 3 main cases for routing:
+ *
+ * 1) Routes for directly connected subnets. E.g. router has IP 1.0.10.1, and
+ *    routes subnet 1.0.10.0/24.
+ *
+ *    In this case, we have a fib_entry, with a non-gateway nexthop group. We
+ *    install a LPM VCAP route, with action type arp entry, for 1.0.10.0/24 with
+ *    a zero mac, to ensure frames destined for this subnet will be sent to the
+ *    CPU and start the ARP process.
+ *
+ *    When we get the arp reply, we create a neigh_entry for each neighbour and
+ *    install a direct route in the LPM VCAP for this neighbour. For example,
+ *    1.0.10.11 is sent to DMAC 0x1111110001. This is how we route directly
+ *    connected subnets.
+ *
+ *    Moreover, the fib_entry maintains a list of all neighbours discovered in
+ *    the subnet it is routing. These neighbours hold a reference back to the
+ *    fib_entry.
+ *
+ *                   |-> neigh_entry 1.0.10.10
+ *        neigh_list |-> neigh_entry 1.0.10.11
+ *                   |-> neigh_entry 1.0.10.12
+ *                   |
+ *   +-------------+ |  +--------------+
+ *   |  fib_entry  |-+  | nexthop group|
+ *   | 1.0.10.1/24 |----+              |
+ *   +-------------+    |  nexthop --------> NULL (Write zero mac in VCAP)
+ *                      +--------------+
+ *
+ *
+ * 2) Routes for non-connected subnets. E.g. we are routing subnet 6.6.0.0/16,
+ *    but we have no IP in this subnet. We are routing via nexthops, which are
+ *    directly connected. Say we have >=2 nexthops.
+ *
+ *    In this case, have a fib_entry with a gateway nexthop group. Each nexthop
+ *    points to a neigh_entry, corresponding to the gateway used for routing.
+ *
+ *    Say we use the nexthops:
+ *
+ *    - 1.0.11.10
+ *    - 1.0.10.10
+ *    - 1.0.9.10
+ *
+ *    We install a LPM VCAP route for 6.6.0.0/16, which contains a pointer
+ *    to the hw arp table, and the size of the group. The ARP table
+ *    contains the Mac addresses of the nexthops. The Mac addresses are
+ *    supplied by neigh_entries.
+ *
+ *
+ *   +-------------+    +--------------+
+ *   |  fib_entry  |    | nexthop group|
+ *   | 6.6.0.0/164 |----+              |
+ *   +-------------+    |  nexthop --------> neigh_entry 1.0.11.10
+ *                      |  nexthop --------> neigh_entry 1.0.10.10
+ *                      |  nexthop --------> neigh_entry 1.0.9.10
+ *                      +--------------+
+ *
+ *
+ * 3) Local routes for traffic destined to the router. If the router has an IP
+ *    1.0.10.1, then we must ensure this traffic is sent to the CPU.
+ *    Therefore, we install a direct route for 1.0.10.1/32 in the LPM VCAP, with
+ *    zero mac.
+ *
+ * 4) All IPv6 link-local traffic is explicitly trapped.
+ *
+ * On the hardware side, we use the VCAP LPM and ARP table for UC IPv4
+ * routing. HW picks the match found at the highest address in the VCAP LPM.
+ * To ensure the longest prefix match we make sure to order the entries
+ * according to mask length, with longer masks at higher addresses.
+ *
+ * It is possible to store ARP data, such as DMAC, directly in the VCAP LPM
+ * using ARP entry actions. We do this whenever possible, so the ARP table
+ * is only used when a route has multiple nexthops.
+ *
+ * With the above breakdown in mind, cases 1) and 3) use arp entries, and
+ * case 2) use the arp table if the number of nexthops is >1.
+ *
+ * If the DMAC written to HW is all zero, the chip will trap the frame,
+ * redirecting it to the CPU. This is how we get the kernel to perform ARP
+ * requests on our behalf.
+ *
+ * The nexthop group must be laid out at contiguous addresses in the ARP table.
+ * The VCAP LPM stores a pointer to the bottom address in the group, and the
+ * group size. We do not use the arp pointer remap table.
+ *
+ * The layout of nexthops in a nexthop group matches the layout in HW, e.g.
+ *
+ * nhgi->nexthops[0] -> arp table address n
+ * ...
+ * nhgi->nexthops[k] -> arp table address n+k
+ *
+ * where the n is the ARP table offset (atbl_offset) for the group.
+ */
+
+#define SPARX5_MAX_ECMP_SIZE		16
+#define SPARX5_RLEG_USE_GLOBAL_BASE_MAC	2
+#define SPARX5_LINK_LOCAL_PREFIX_LEN	64
+#define SPARX5_BLACKHOLE_VMID(spx5)	((spx5)->data->consts->vmid_cnt - 1)
+/* The rewriter field REW_RLEG_CTRL_RLEG_EVID will be written with the
+ * blackhole vid, but it is only 12 bits wide. However, this is only used for
+ * routing based rewrites on egress, which is not used for the blackhole.
+ * The important field is ANA_L3_RLEG_CTRL_RLEG_EVID which is 13 bits wide.
+ * Therefore, it is safe to use VIDs wider than 12 bits for the blackhole
+ * vid, frames will not be forwarded into VLAN 0s port mask.
+ */
+#define SPARX5_BLACKHOLE_VID		VLAN_N_VID
+
+struct sparx5_rr_fib6_entry_info {
+	struct fib6_info **rt_arr;
+	unsigned int nrt6;
+};
+
+enum sparx5_rr_l3_version {
+	SPARX5_IPV4 = 0,
+	SPARX5_IPV6,
+};
+
+#define SPARX5_IADDR_LEN(v)		((v) == SPARX5_IPV4 ? 32 : 128)
+/* Order longer prefixes at high addresses. */
+#define LPM_SORT_KEY(plen)		(SPARX5_IADDR_LEN(SPARX5_IPV6) - (plen))
+
+struct sparx5_rr_fib_info {
+	union {
+		struct fib_entry_notifier_info fen4_info;
+		struct sparx5_rr_fib6_entry_info fe6_info;
+	};
+	enum sparx5_rr_l3_version version;
+};
+
+struct sparx5_fib_event_work {
+	struct work_struct work;
+	struct sparx5_rr_fib_info fi;
+	struct sparx5 *sparx5;
+	unsigned long event;
+};
+
+struct sparx5_rr_netevent_work {
+	struct work_struct work;
+	struct sparx5 *sparx5;
+	struct neighbour *neigh;
+	unsigned long event;
+};
+
+struct sparx5_rr_router_leg {
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	struct sparx5 *sparx5;
+	struct list_head leg_list_node; /* Router member */
+	u16 vmid; /* Internal id */
+	u32 vid; /* VLAN id */
+};
+
+struct sparx5_iaddr {
+	union {
+		__be32 ipv4;
+		struct in6_addr ipv6;
+	}; /* Must be first */
+	enum sparx5_rr_l3_version version;
+};
+
+#define LPM_PROTO(iaddr) ((iaddr)->version ? ETH_P_IPV6 : ETH_P_IP)
+
+struct sparx5_rr_neigh_entry {
+	struct sparx5_rr_neigh_key {
+		struct net_device *dev;
+		struct sparx5_iaddr iaddr;
+	} key;
+	struct rhash_head ht_node;
+	struct sparx5_rr_fib_entry *fib_entry;
+	struct list_head fib_list_node; /* Fib route for this neighbour */
+	struct neigh_table *neigh_tbl; /* Kernel neighbour table */
+	struct list_head nexthop_list; /* Nexthops using this neigh entry */
+	struct sparx5_rr_hw_route hw_route;
+	unsigned char hwaddr[ETH_ALEN];
+	u16 vmid;
+	bool connected;
+};
+
+struct sparx5_rr_nexthop {
+	struct sparx5_rr_neigh_entry *neigh_entry;
+	struct sparx5_rr_nexthop_group *grp;
+	struct list_head neigh_list_node; /* Neigh entry member */
+	struct list_head leg_list_node; /* Router leg member */
+	struct neigh_table *neigh_tbl; /* Kernel neighbour table */
+	struct sparx5_iaddr gw_addr;
+	int ifindex;
+	bool gateway;
+	bool trapped;
+};
+
+struct sparx5_rr_nexthop_group_info {
+	struct sparx5_rr_nexthop_group *grp;
+	u16 atbl_offset;
+	bool atbl_offset_valid;
+	u8 count; /* HW allows up to 16 nexthops */
+	struct sparx5_rr_nexthop nexthops[] __counted_by(count);
+};
+
+struct sparx5_rr_nexthop_group {
+	struct sparx5_rr_fib_entry *fib_entry;
+	struct sparx5_rr_nexthop_group_info *nhgi;
+};
+
+enum sparx5_rr_fib_type {
+	SPARX5_RR_FIB_TYPE_INVALID = 0,
+	SPARX5_RR_FIB_TYPE_LOCAL,
+	SPARX5_RR_FIB_TYPE_UNICAST,
+	SPARX5_RR_FIB_TYPE_MULTICAST,
+	SPARX5_RR_FIB_TYPE_BLACKHOLE,
+	SPARX5_RR_FIB_TYPE_PROHIBIT,
+	SPARX5_RR_FIB_TYPE_UNREACHABLE,
+};
+
+struct sparx5_rr_fib_key {
+	struct sparx5_iaddr addr;
+	u32 prefix_len;
+	u32 tb_id; /* Routing table type: RT_TABLE_* */
+};
+
+struct sparx5_rr_fib_entry {
+	struct sparx5_rr_fib_key key;
+	enum sparx5_rr_fib_type type;
+	struct rhash_head ht_node; /* Router member */
+	struct list_head fib_lpm_node; /* Router member */
+	struct list_head neigh_list; /* Neighbours under this route */
+	struct sparx5_rr_hw_route hw_route;
+	struct sparx5_rr_nexthop_group *nh_grp;
+	struct sparx5_rr_fib_info fi;
+	u64 sort_key; /* For sw lpm lookup */
+	bool trap;
+	bool offload_fail;
+};
+
+struct sparx5_rr_inet6addr_event_work {
+	struct work_struct work;
+	struct sparx5 *sparx5;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	unsigned long event;
+};
+
+static void sparx5_rr_schedule_work(struct sparx5 *sparx5,
+				    struct work_struct *work)
+{
+	queue_work(sparx5->router->sparx5_router_owq, work);
+}
+
+static void sparx5_rr_split_mac(unsigned char mac[ETH_ALEN], u32 split,
+				u32 *msb, u32 *lsb)
+{
+	u32 mask = GENMASK(split - 1, 0);
+	u64 m = ether_addr_to_u64(mac);
+
+	*lsb = m & mask;
+	*msb = m >> split;
+}
+
+static int sparx5_vmid_alloc(struct sparx5 *sparx5)
+{
+	int vmid;
+
+	vmid = find_first_zero_bit(sparx5->router->vmid_mask,
+				   sparx5->data->consts->vmid_cnt);
+	if (vmid >= sparx5->data->consts->vmid_cnt)
+		return -ENOMEM;
+
+	set_bit(vmid, sparx5->router->vmid_mask);
+
+	return vmid;
+}
+
+static void sparx5_vmid_free(struct sparx5 *sparx5, u16 vmid)
+{
+	clear_bit(vmid, sparx5->router->vmid_mask);
+}
+
+static void sparx5_rr_inet6_make_mask_le(int logmask, u8 *mask)
+{
+	/* Caller must ensure 0 <= logmask <= 128 */
+	int rem, byte_prefix = logmask;
+
+	rem = do_div(byte_prefix, BITS_PER_BYTE);
+
+	memset(mask, 0, 16);
+
+	for (int i = 0; i < byte_prefix; i++)
+		mask[15 - i] = 0xff;
+
+	if (rem)
+		mask[15 - byte_prefix] = GENMASK(7, 7 - rem + 1);
+}
+
+static int sparx5_rr_lpm_rule_xip_add(struct vcap_rule *rule,
+				      struct sparx5_iaddr *addr, u32 prefix_len)
+{
+	struct vcap_u128_key addr_key;
+	u32 mask, iaddr;
+
+	switch (addr->version) {
+	case SPARX5_IPV4:
+		mask = ntohl(inet_make_mask(prefix_len));
+		iaddr = ntohl(addr->ipv4);
+
+		return vcap_rule_add_key_u32(rule, VCAP_KF_IP4_XIP, iaddr,
+					     mask);
+	case SPARX5_IPV6:
+		sparx5_rr_inet6_make_mask_le(prefix_len, addr_key.mask);
+		vcap_netbytes_copy(addr_key.value, addr->ipv6.s6_addr, 16);
+
+		return vcap_rule_add_key_u128(rule, VCAP_KF_IP6_XIP, &addr_key);
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_leg_find_by_dev(struct sparx5 *sparx5, struct net_device *dev)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	list_for_each_entry(leg, &sparx5->router->leg_list, leg_list_node) {
+		if (leg->dev == dev)
+			return leg;
+	}
+
+	return NULL;
+}
+
+static int
+sparx5_rr_lpm_arp_entry_create(struct sparx5 *sparx5,
+			       struct sparx5_iaddr *addr,
+			       u32 prefix_len, unsigned char mac[ETH_ALEN],
+			       u16 evmid, struct sparx5_rr_hw_route *hw_route)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+	u32 priority = LPM_SORT_KEY(prefix_len);
+	struct vcap_rule *rule;
+	u32 mac_msb, mac_lsb;
+	int err;
+
+	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
+
+	rule = vcap_alloc_rule(vctrl, pdev, VCAP_CID_PREROUTING_L0,
+			       VCAP_USER_L3, priority, 0);
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
+
+	err = sparx5_rr_lpm_rule_xip_add(rule, addr, prefix_len);
+	err |= vcap_rule_add_key_u32(rule, VCAP_KF_AFFIX, 0, 0);
+	err |= vcap_rule_add_key_bit(rule, VCAP_KF_DST_FLAG, VCAP_BIT_1);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_MAC_MSB, mac_msb);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_MAC_LSB, mac_lsb);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_ARP_VMID, evmid);
+	err |= vcap_rule_add_action_bit(rule, VCAP_AF_ARP_ENA, VCAP_BIT_1);
+
+	err = err ? -EINVAL : vcap_val_add_rule(rule, LPM_PROTO(addr));
+	if (!err) {
+		hw_route->vrule_id = rule->id;
+		hw_route->vrule_id_valid = true;
+	}
+	vcap_free_rule(rule);
+	return err;
+}
+
+static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
+				  struct sparx5_rr_router_leg *leg)
+{
+	/* Associate Router leg VMID to VLAN */
+	spx5_rmw(ANA_L3_VMID_CFG_VMID_SET(leg->vmid), ANA_L3_VMID_CFG_VMID,
+		 sparx5, ANA_L3_VMID_CFG(leg->vid));
+
+	/* Enable Router leg for VLAN */
+	spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(1),
+		 ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
+		 ANA_L3_VLAN_CFG(leg->vid));
+
+	/* Configure router leg */
+
+#if IS_ENABLED(CONFIG_IPV6)
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(1) |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID_SET(leg->vid) |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(1),
+		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+#else
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(1) |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID_SET(leg->vid),
+		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+#endif
+
+	/* Configure egress VLAN in rewriter */
+	spx5_rmw(REW_RLEG_CTRL_RLEG_EVID_SET(leg->vid), REW_RLEG_CTRL_RLEG_EVID,
+		 sparx5, REW_RLEG_CTRL(leg->vmid));
+}
+
+static void sparx5_rr_leg_hw_deinit(struct sparx5 *sparx5,
+				    struct sparx5_rr_router_leg *leg)
+{
+	/* Disable Router leg for VLAN */
+	spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(0),
+		 ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
+		 ANA_L3_VLAN_CFG(leg->vid));
+
+	/* Disable IP UC routing on leg */
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(0) |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(0),
+		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+}
+
+static int sparx5_rr_lpm_link_local_create(struct sparx5 *sparx5)
+{
+	struct sparx5_iaddr addr __aligned(2) = { };
+	unsigned char zero_mac[ETH_ALEN];
+
+	eth_zero_addr(zero_mac);
+
+	/* Trap traffic to fe80::/64 */
+	addr.version = SPARX5_IPV6;
+	addr.ipv6.in6_u.u6_addr8[0] = 0xfe;
+	addr.ipv6.in6_u.u6_addr8[1] = 0x80;
+
+	return sparx5_rr_lpm_arp_entry_create(sparx5, &addr,
+					      SPARX5_LINK_LOCAL_PREFIX_LEN,
+					      zero_mac, 0,
+					      &sparx5->router->link_local);
+}
+
+static void sparx5_rr_lpm_link_local_destroy(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_hw_route *llocal = &sparx5->router->link_local;
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+
+	if (!llocal->vrule_id_valid)
+		return;
+
+	vcap_del_rule(vctrl, pdev, llocal->vrule_id);
+	llocal->vrule_id_valid = false;
+}
+
+static struct sparx5_rr_router_leg *
+__sparx5_rr_leg_alloc(struct sparx5 *sparx5, struct net_device *dev, u16 vmid,
+		      u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	leg = kzalloc_obj(*leg);
+	if (!leg)
+		return NULL;
+
+	INIT_LIST_HEAD(&leg->leg_list_node);
+	leg->dev = dev;
+	leg->vmid = vmid;
+	leg->vid = vid;
+	leg->sparx5 = sparx5;
+
+	return leg;
+}
+
+/* Router legs are identified by their VMID in hw */
+static struct sparx5_rr_router_leg *
+sparx5_rr_leg_alloc(struct sparx5 *sparx5, struct net_device *dev, u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+	int next_vmid;
+
+	next_vmid = sparx5_vmid_alloc(sparx5);
+	if (next_vmid < 0)
+		return NULL;
+
+	leg = __sparx5_rr_leg_alloc(sparx5, dev, next_vmid, vid);
+	if (!leg)
+		goto err_kzalloc;
+
+	return leg;
+
+err_kzalloc:
+	sparx5_vmid_free(sparx5, next_vmid);
+
+	return NULL;
+}
+
+static void sparx5_rr_router_leg_destroy(struct sparx5_rr_router_leg *leg)
+{
+	struct sparx5 *sparx5 = leg->sparx5;
+
+	dev_dbg(sparx5->dev, "Leg destroy vid=%u vmid=%u dev=%s\n", leg->vid,
+		leg->vmid, leg->dev ? netdev_name(leg->dev) : "blackhole");
+
+	sparx5_rr_leg_hw_deinit(sparx5, leg);
+	sparx5_vmid_free(leg->sparx5, leg->vmid);
+	list_del(&leg->leg_list_node);
+
+	if (leg->dev) {
+		if (atomic_dec_return(&sparx5->router->legs_count) == 0)
+			sparx5_rr_lpm_link_local_destroy(sparx5);
+
+		netdev_put(leg->dev, &leg->dev_tracker);
+	}
+	kfree(leg);
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
+			    u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	leg = sparx5_rr_leg_alloc(sparx5, dev, vid);
+	if (!leg)
+		return ERR_PTR(-ENOMEM);
+
+	/* Prevent net device from being freed while we have added it to a
+	 * router leg.
+	 */
+	netdev_hold(dev, &leg->dev_tracker, GFP_KERNEL);
+
+	/* While a router leg exists, add route to trap link-local traffic. */
+	if (atomic_inc_return(&sparx5->router->legs_count) == 1) {
+		if (sparx5_rr_lpm_link_local_create(sparx5))
+			dev_warn(sparx5->dev,
+				 "Failed to create link-local route\n");
+	}
+
+	list_add(&leg->leg_list_node, &sparx5->router->leg_list);
+	sparx5_rr_leg_hw_init(sparx5, leg);
+
+	dev_dbg(sparx5->dev, "Leg create dev=%s vid=%u vmid=%u\n", dev->name,
+		leg->vid, leg->vmid);
+
+	return leg;
+}
+
+static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
+{
+	struct net_device *vlan_rdev;
+	/* Support l3 offloading for:
+	 *	1) upper vlan interfaces for the bridge.
+	 */
+	if (is_vlan_dev(dev)) {
+		if (netif_is_bridge_port(dev))
+			return false;
+
+		vlan_rdev = vlan_dev_real_dev(dev);
+		if (sparx5_netdevice_check(vlan_rdev))
+			return false;
+
+		return netif_is_bridge_master(vlan_rdev) &&
+		       br_vlan_enabled(vlan_rdev);
+	}
+
+	return false;
+}
+
+static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
+				       unsigned char mac[ETH_ALEN])
+{
+	u8 rleg_type_sel = SPARX5_RLEG_USE_GLOBAL_BASE_MAC;
+	u32 mac_msb, mac_lsb;
+
+	sparx5_rr_split_mac(mac, 24, &mac_msb, &mac_lsb);
+
+	dev_dbg(sparx5->dev, "Router leg base MAC=%pM\n", mac);
+
+	/* The global router leg MAC must be set consistently across ANA_L3, REW
+	 * and EACL.
+	 */
+	spx5_wr(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		ANA_L3_RLEG_CFG_0);
+
+	spx5_rmw(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB |
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, ANA_L3_RLEG_CFG_1);
+
+	/* Set global Router leg MAC (REW) */
+	spx5_wr(REW_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		REW_RLEG_CFG_0);
+
+	spx5_rmw(REW_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 REW_RLEG_CFG_1_RLEG_MAC_MSB | REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, REW_RLEG_CFG_1);
+
+	/* Set global Router leg MAC (EACL) */
+	spx5_wr(EACL_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		EACL_RLEG_CFG_0);
+
+	spx5_rmw(EACL_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 EACL_RLEG_CFG_1_RLEG_MAC_MSB |
+		 EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, EACL_RLEG_CFG_1);
+}
+
+static bool
+sparx5_rr_router_leg_addr_list_empty_rcu(struct sparx5_rr_router_leg *leg)
+{
+	struct inet6_dev *inet6_dev;
+	struct in_device *in_dev;
+
+	in_dev = __in_dev_get_rcu(leg->dev);
+	if (in_dev && in_dev->ifa_list)
+		return false;
+
+	inet6_dev = __in6_dev_get(leg->dev);
+	if (inet6_dev && !list_empty(&inet6_dev->addr_list))
+		return false;
+
+	return true;
+}
+
+static bool
+sparx5_rr_router_leg_addr_list_empty(struct sparx5_rr_router_leg *leg)
+{
+	bool addr_list_empty;
+
+	rcu_read_lock();
+	addr_list_empty = sparx5_rr_router_leg_addr_list_empty_rcu(leg);
+	rcu_read_unlock();
+
+	return addr_list_empty;
+}
+
+static int __sparx5_rr_inetaddr_event(struct sparx5 *sparx5,
+				      struct net_device *dev,
+				      unsigned long event)
+{
+	struct sparx5_rr_router_leg *leg;
+	u16 vid;
+
+	if (!sparx5_rr_dev_real_is_vlan_aware(dev))
+		return 0;
+
+	/* Our basic case: ip addr/subnet added to vlan upper of
+	 * bridge dev.
+	 */
+	switch (event) {
+	case NETDEV_UP:
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (leg)
+			return 0;
+
+		/* HW allows at most 1 leg per VLAN, but we do not need to
+		 * lookup leg by vid, since the kernel does not allow multiple
+		 * vlan devs with the same vid on top of a given device.
+		 */
+		vid = vlan_dev_vlan_id(dev);
+
+		leg = sparx5_rr_router_leg_create(sparx5, dev, vid);
+		if (IS_ERR(leg))
+			return PTR_ERR(leg);
+		break;
+	case NETDEV_DOWN:
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (!leg || !sparx5_rr_router_leg_addr_list_empty(leg))
+			return 0;
+
+		sparx5_rr_router_leg_destroy(leg);
+		break;
+	}
+
+	return 0;
+}
+
+static int sparx5_rr_inetaddr_event_handle(struct sparx5 *sparx5,
+					   struct net_device *dev,
+					   unsigned long event)
+{
+	int err;
+
+	mutex_lock(&sparx5->router->lock);
+	err = __sparx5_rr_inetaddr_event(sparx5, dev, event);
+	mutex_unlock(&sparx5->router->lock);
+
+	return notifier_from_errno(err);
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_inet6addr_valid_event(struct notifier_block *nb,
+					   unsigned long event, void *ptr)
+{
+	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
+	struct net_device *dev = i6vi->i6vi_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_UP)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inet6addr_valid_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event);
+}
+
+static void sparx5_rr_inet6addr_event_work(struct work_struct *work)
+{
+	struct sparx5_rr_inet6addr_event_work *addr_work =
+		container_of(work, struct sparx5_rr_inet6addr_event_work, work);
+	struct sparx5_router *router = addr_work->sparx5->router;
+
+	rtnl_lock();
+	mutex_lock(&router->lock);
+
+	__sparx5_rr_inetaddr_event(addr_work->sparx5, addr_work->dev,
+				   addr_work->event);
+
+	mutex_unlock(&router->lock);
+	rtnl_unlock();
+	netdev_put(addr_work->dev, &addr_work->dev_tracker);
+	kfree(addr_work);
+}
+
+/* Called in atomic context. */
+static int sparx5_rr_inet6addr_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
+	struct sparx5_rr_inet6addr_event_work *work;
+	struct net_device *dev = if6->idev->dev;
+	struct sparx5_router *router;
+
+	if (event != NETDEV_DOWN)
+		return NOTIFY_DONE;
+
+	work = kzalloc_obj(*work, GFP_ATOMIC);
+	if (!work)
+		return NOTIFY_BAD;
+
+	router = container_of(nb, struct sparx5_router, inet6addr_nb);
+	INIT_WORK(&work->work, sparx5_rr_inet6addr_event_work);
+	work->sparx5 = router->sparx5;
+	work->dev = dev;
+	work->event = event;
+	netdev_hold(dev, &work->dev_tracker, GFP_ATOMIC);
+	sparx5_rr_schedule_work(router->sparx5, &work->work);
+
+	return NOTIFY_DONE;
+}
+
+/* Handle events for ip address changes on ifs. Used to manage router legs.
+ * Called with RTNL.
+ */
+static int sparx5_rr_inetaddr_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_DOWN)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inetaddr_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event);
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_inetaddr_valid_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
+	struct net_device *dev = ivi->ivi_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_UP)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inetaddr_valid_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event);
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_netdevice_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	unsigned char mac[ETH_ALEN] __aligned(2);
+	struct sparx5_router *router;
+	struct sparx5 *sparx5;
+
+	ASSERT_RTNL();
+
+	router = container_of(nb, struct sparx5_router, netdevice_nb);
+	sparx5 = router->sparx5;
+
+	/* Allow single bridge. Global router leg MAC tracks bridge mac. */
+	if (!netif_is_bridge_master(dev))
+		return NOTIFY_OK;
+
+	switch (event) {
+	case NETDEV_CHANGEADDR:
+		ether_addr_copy(mac, dev->dev_addr);
+		sparx5_rr_leg_base_mac_set(sparx5, mac);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int sparx5_rr_blackhole_leg_create(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_router_leg *leg;
+	u16 vmid, vid;
+
+	vmid = SPARX5_BLACKHOLE_VMID(sparx5);
+	vid = SPARX5_BLACKHOLE_VID;
+
+	leg = __sparx5_rr_leg_alloc(sparx5, NULL, vmid, vid);
+	if (!leg)
+		return -ENOMEM;
+
+	set_bit(vmid, sparx5->router->vmid_mask);
+
+	list_add(&leg->leg_list_node, &sparx5->router->leg_list);
+	sparx5_rr_leg_hw_init(sparx5, leg);
+
+	dev_dbg(sparx5->dev, "Blackhole leg create vid=%u vmid=%u\n",
+		leg->vid, leg->vmid);
+
+	return 0;
+}
+
+static void sparx5_rr_router_legs_flush(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_router_leg *leg, *tmp;
+
+	list_for_each_entry_safe(leg, tmp, &sparx5->router->leg_list,
+				 leg_list_node)
+		sparx5_rr_router_leg_destroy(leg);
+}
+
+int sparx5_rr_router_init(struct sparx5 *sparx5)
+{
+	struct sparx5_router *r;
+	int err;
+
+	r = kzalloc_obj(*sparx5->router);
+	if (!r)
+		return -ENOMEM;
+
+	mutex_init(&r->lock);
+	sparx5->router = r;
+	r->sparx5 = sparx5;
+
+	INIT_LIST_HEAD(&r->leg_list);
+	INIT_LIST_HEAD(&r->fib_lpm4_list);
+	INIT_LIST_HEAD(&r->fib_lpm6_list);
+
+	/* Add reserved leg for blackhole routes. */
+	err = sparx5_rr_blackhole_leg_create(sparx5);
+	if (err)
+		goto err_free_router;
+
+	r->sparx5_router_owq = alloc_ordered_workqueue("sparx5_router_owq", 0);
+	if (!r->sparx5_router_owq) {
+		err = -ENOMEM;
+		goto err_blackhole_destroy;
+	}
+
+	atomic_set(&r->legs_count, 0);
+	r->link_local.vrule_id = 0;
+	r->link_local.vrule_id_valid = false;
+	/* VCAP API requires a port net_device, to get a sparx5 reference.
+	 * Fetch any valid port.
+	 */
+	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
+		if (!sparx5->ports[i])
+			continue;
+
+		r->port_dev = sparx5->ports[i]->ndev;
+		if (r->port_dev)
+			break;
+	}
+	if (!r->port_dev) {
+		err = -ENXIO;
+		goto err_workqueue_destroy;
+	}
+
+	/* Enable L3 UC routing on all ports. */
+	spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA);
+	if (is_sparx5(sparx5)) {
+		spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA1);
+		spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA2);
+	}
+
+	/* Enable routing and global router options */
+	spx5_rmw(ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(1) |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_SET(1),
+		 ANA_L3_ROUTING_CFG_L3_ENA_MODE |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA,
+		 sparx5, ANA_L3_ROUTING_CFG);
+
+	/* By default, routing related frame edits are done in REW, but when
+	 * combining routing with PTP, ANA_ACL must be configured to change DMAC
+	 * to next-hop DMAC in order to allow other information to be stored in
+	 * the IFH.
+	 *
+	 * This enables routing related frame edits independently of VCAP_S2
+	 * action ACL_RT_MODE.
+	 */
+	spx5_rmw(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_SET(1),
+		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
+		 ANA_ACL_VCAP_S2_MISC_CTRL);
+
+	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
+	err = register_inetaddr_notifier(&r->inetaddr_nb);
+	if (err)
+		goto err_workqueue_destroy;
+
+	r->inetaddr_valid_nb.notifier_call = sparx5_rr_inetaddr_valid_event;
+	err = register_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
+	if (err)
+		goto err_unreg_inet_notifier;
+
+	r->netdevice_nb.notifier_call = sparx5_rr_netdevice_event;
+	err = register_netdevice_notifier(&r->netdevice_nb);
+	if (err)
+		goto err_unreg_inet_addr_val_notifier;
+
+	r->inet6addr_valid_nb.notifier_call = sparx5_rr_inet6addr_valid_event;
+	err = register_inet6addr_validator_notifier(&r->inet6addr_valid_nb);
+	if (err)
+		goto err_unreg_netdev_notifier;
+
+	r->inet6addr_nb.notifier_call = sparx5_rr_inet6addr_event;
+	err = register_inet6addr_notifier(&r->inet6addr_nb);
+	if (err)
+		goto err_unreg_inet6_addr_val_notifier;
+
+	return 0;
+
+err_unreg_inet6_addr_val_notifier:
+	unregister_inet6addr_validator_notifier(&r->inet6addr_valid_nb);
+err_unreg_netdev_notifier:
+	unregister_netdevice_notifier(&r->netdevice_nb);
+err_unreg_inet_addr_val_notifier:
+	unregister_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
+err_unreg_inet_notifier:
+	unregister_inetaddr_notifier(&r->inetaddr_nb);
+err_workqueue_destroy:
+	destroy_workqueue(r->sparx5_router_owq);
+err_blackhole_destroy:
+	sparx5_rr_router_legs_flush(sparx5);
+err_free_router:
+	mutex_destroy(&r->lock);
+	kfree(r);
+
+	return err;
+}
+
+void sparx5_rr_router_deinit(struct sparx5 *sparx5)
+{
+	struct sparx5_router *router = sparx5->router;
+
+	unregister_inet6addr_notifier(&router->inet6addr_nb);
+	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
+	unregister_netdevice_notifier(&router->netdevice_nb);
+	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
+	unregister_inetaddr_notifier(&router->inetaddr_nb);
+	destroy_workqueue(router->sparx5_router_owq);
+	sparx5_rr_router_legs_flush(sparx5);
+	mutex_destroy(&router->lock);
+	kfree(router);
+}

-- 
2.52.0


