Return-Path: <netdev+bounces-132053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644A990400
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2633E1C21FCD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FF21C17E;
	Fri,  4 Oct 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="laFo4JFi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4D21948C;
	Fri,  4 Oct 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048055; cv=none; b=JkgvZtzk0zTNPGDLlv37vVqWGAb9qLRvSRlhvbH6Xtwe/6n1YslV0ceEDp24l15nkpDJv+nbMxCerZJfvGFGtoGhSqTVcNUikbKGNQWftnenYPiXcPRDNPN5zAyvVtDvSjaRo3fKuroMlQ7+0dTFafxPbeHv2hcQYUB2UtwBpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048055; c=relaxed/simple;
	bh=7epCyCON/J3CUTA7QCN6jtv9rPCISXlwzHXvhgOq1q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q5GtNGtxfPnQPoMmsdjbiMt6sfhrCL8XFFyLYQ7Iijvzc9LlZRevqwVuEkA2+y8LjxhLklmrF+iga5P0EJ7Vv2zMglnDpwSdRtq3JaWBiS2sRc1js5X6cHLjGXGqXdJjpqxA9zl7hHcjH0N8296XoIQe4l7YB9E/f1XgbEfcVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=laFo4JFi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048054; x=1759584054;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7epCyCON/J3CUTA7QCN6jtv9rPCISXlwzHXvhgOq1q4=;
  b=laFo4JFi/rt+oj5JQvSvl0+NDiVNreKuAE4Ko1ncCD6zAvT/QPiiT8g+
   tlO9PIyJNwgQwS8oSC+Digv3MGPfYp/BkbKf+s8tJQqBxk1cI7ePePTYO
   RKIMox+Lyi+6GoLObOJo5jXXQgoo1TGKbJvCL45m/OWDzpYrfeQ7ts/jg
   58NOu86Ko049x4xSFQAzBmHxoRtJd3PmR81O6h138aIdSDFTpJAZyZTAw
   wo4zdM5ntcU/d0GXrphA2cnqtu+689LDvgxKWOsbIjpqiBgcYvsibgrIA
   97O26C3s4fHH/w0mHFuGrH25FFYMpS065ZQdAM3seuiFJW1TaStM8DnBg
   w==;
X-CSE-ConnectionGUID: ijig+GXpR1+FjNkYwRnQGA==
X-CSE-MsgGUID: TyAPDVAnR+eW0hv7+T4shA==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602260"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:47 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:39 +0200
Subject: [PATCH net-next v2 13/15] net: sparx5: ops out function for DSM
 calendar calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-13-d3290f581663@microchip.com>
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

The DSM (Disassembler) calendar grants each port access to internal
busses. The configuration of the calendar is done differently on Sparx5
and lan969x. Therefore ops out the function that calculates the
calendar.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 22 ++++------------------
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 9b54d952e91a..6b9565e0fd7b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -15,9 +15,7 @@
 #define SPX5_CALBITS_PER_PORT          3   /* Bit per port in calendar register */
 
 /* DSM calendar information */
-#define SPX5_DSM_CAL_LEN               64
 #define SPX5_DSM_CAL_EMPTY             0xFFFF
-#define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
 #define SPX5_DSM_CAL_TAXIS             8
 #define SPX5_DSM_CAL_BW_LOSS           553
 
@@ -37,19 +35,6 @@ static u32 sparx5_taxi_ports[SPX5_DSM_CAL_TAXIS][SPX5_DSM_CAL_MAX_DEVS_PER_TAXI]
 	{64, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99},
 };
 
-struct sparx5_calendar_data {
-	u32 schedule[SPX5_DSM_CAL_LEN];
-	u32 avg_dist[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 taxi_ports[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 taxi_speeds[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 dev_slots[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 new_slots[SPX5_DSM_CAL_LEN];
-	u32 temp_sched[SPX5_DSM_CAL_LEN];
-	u32 indices[SPX5_DSM_CAL_LEN];
-	u32 short_list[SPX5_DSM_CAL_LEN];
-	u32 long_list[SPX5_DSM_CAL_LEN];
-};
-
 static u32 sparx5_target_bandwidth(struct sparx5 *sparx5)
 {
 	switch (sparx5->target_ct) {
@@ -279,8 +264,8 @@ static u32 sparx5_dsm_cp_cal(u32 *sched)
 	return SPX5_DSM_CAL_EMPTY;
 }
 
-static int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
-				    struct sparx5_calendar_data *data)
+int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			     struct sparx5_calendar_data *data)
 {
 	bool slow_mode;
 	u32 gcd, idx, sum, min, factor;
@@ -566,6 +551,7 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 /* Configure the DSM calendar based on port configuration */
 int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	int taxi;
 	struct sparx5_calendar_data *data;
 	int err = 0;
@@ -575,7 +561,7 @@ int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 		return -ENOMEM;
 
 	for (taxi = 0; taxi < sparx5->data->consts->n_dsm_cal_taxis; ++taxi) {
-		err = sparx5_dsm_calendar_calc(sparx5, taxi, data);
+		err = ops->dsm_calendar_calc(sparx5, taxi, data);
 		if (err) {
 			dev_err(sparx5->dev, "DSM calendar calculation failed\n");
 			goto cal_out;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 393ee5116004..78791c7a9849 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -995,6 +995,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
 	.set_port_mux            = &sparx5_port_mux_set,
 	.ptp_irq_handler         = &sparx5_ptp_irq_handler,
+	.dsm_calendar_calc       = &sparx5_dsm_calendar_calc,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index cc8ab91d9805..f21ec878b9a8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -101,8 +101,24 @@ enum sparx5_vlan_port_type {
 #define IFH_PDU_TYPE_IPV4_UDP_PTP	0x6
 #define IFH_PDU_TYPE_IPV6_UDP_PTP	0x7
 
+#define SPX5_DSM_CAL_LEN               64
+#define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
+
 struct sparx5;
 
+struct sparx5_calendar_data {
+	u32 schedule[SPX5_DSM_CAL_LEN];
+	u32 avg_dist[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 taxi_ports[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 taxi_speeds[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 dev_slots[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 new_slots[SPX5_DSM_CAL_LEN];
+	u32 temp_sched[SPX5_DSM_CAL_LEN];
+	u32 indices[SPX5_DSM_CAL_LEN];
+	u32 short_list[SPX5_DSM_CAL_LEN];
+	u32 long_list[SPX5_DSM_CAL_LEN];
+};
+
 /* Frame DMA receive state:
  * For each DB, there is a SKB, and the skb data pointer is mapped in
  * the DB. Once a frame is received the skb is given to the upper layers
@@ -271,6 +287,8 @@ struct sparx5_ops {
 			    struct sparx5_port_config *conf);
 
 	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
+	int (*dsm_calendar_calc)(struct sparx5 *sparx5, u32 taxi,
+				 struct sparx5_calendar_data *data);
 };
 
 struct sparx5_main_io_resource {
@@ -418,6 +436,9 @@ void sparx5_vlan_port_apply(struct sparx5 *sparx5, struct sparx5_port *port);
 /* sparx5_calendar.c */
 int sparx5_config_auto_calendar(struct sparx5 *sparx5);
 int sparx5_config_dsm_calendar(struct sparx5 *sparx5);
+int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			     struct sparx5_calendar_data *data);
+
 
 /* sparx5_ethtool.c */
 void sparx5_get_stats64(struct net_device *ndev, struct rtnl_link_stats64 *stats);

-- 
2.34.1


