Return-Path: <netdev+bounces-132050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590E9903F9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26011F21442
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EC219480;
	Fri,  4 Oct 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="13YaPGD0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDA2178E7;
	Fri,  4 Oct 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048042; cv=none; b=uuh9f2pVNJPRRvKV8xM0dPQRXMJXyDWuXguyqxYqL6bESAwjiL6lJdRvIXD8/yBGfI5icYjmtZKdRCsHWVidNOfgTceg+uu5iPQLiOPeLY96N9D5uOg+ogl8g++g3zwLWp83sS6UO3cqSb85MTm7TY8dlQAv3KxDoXBfWf5ONCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048042; c=relaxed/simple;
	bh=yVqUS0i9o1U1+KqYvKTXU4iob+Ok5SuTvCJiC8mNcmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G1ibdh4mS41dZwVbhUjq6esuqpb4hXvrnjGb8e107NxHrD0cKAn+651E4Y1k5lW4IggUr7an0bc7ESADtfcBv8fbVcLS5b6KqDK7SVzcb4T4daCClUAmpdtREbyRAm46269iL+y6ZF/0DpaD4ZfmnAR0SyQINtd+E+FvNlf2M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=13YaPGD0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048040; x=1759584040;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yVqUS0i9o1U1+KqYvKTXU4iob+Ok5SuTvCJiC8mNcmA=;
  b=13YaPGD0V4SSXNUDpoL8KFbSRtFedeTFOoT/sZn0bzeRcNAcgavRFfPN
   lK8VeSqUVOoZBANLr881mV9wvUaR9el9v/GBmnMcBeBhpXG3aLiZbMsZU
   lindFWQ+6zRA3k0fp9T0/jCpgfF5kh2kax1R0jjxGiko/c76qYdtjUFj8
   ocu5h/fxjgxdCXVe/xAVM/myU+H0nTYEJTHj/gt6F+i2BAO+NZjcu0nj1
   QJl6maFcp750a34tu8y0quVxFLvoa75TsUcZWjWK/yzLA0qELPtYzgDcR
   fvjZ2KvACQEjDfV4pygdiJc2Y5/gJUbzGXOTgPCWWenU5e/Nc3BO65WZZ
   g==;
X-CSE-ConnectionGUID: Ejn4MYkwTnyyTXQz7FKjZw==
X-CSE-MsgGUID: 2aRRJxWYTBmseDecNkZQaw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35903141"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:37 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:34 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:36 +0200
Subject: [PATCH net-next v2 10/15] net: sparx5: ops out functions for
 getting certain array values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-10-d3290f581663@microchip.com>
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

Add getters for getting values in arrays: sdlb_groups and
sparx5_hsch_max_group_rate and ops out the getters, as these arrays will
differ on lan969x.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c   |  2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   |  3 +++
 drivers/net/ethernet/microchip/sparx5/sparx5_police.c |  3 ++-
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c   |  3 ++-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c    |  8 +++++++-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h    |  2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c   | 11 +++++++++--
 7 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index c30ccca72c78..fb677a4a58ee 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -990,6 +990,8 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_25g             = &sparx5_port_is_25g,
 	.get_port_dev_index      = &sparx5_port_dev_mapping,
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
+	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
+	.get_sdlb_group          = &sparx5_get_sdlb_group,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index f7e1b7d18f81..b6abbae119c2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -265,6 +265,8 @@ struct sparx5_ops {
 	bool (*is_port_25g)(int portno);
 	u32  (*get_port_dev_index)(struct sparx5 *sparx5, int port);
 	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
+	u32  (*get_hsch_max_group_rate)(int grp);
+	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
 };
 
 struct sparx5_main_io_resource {
@@ -501,6 +503,7 @@ struct sparx5_sdlb_group {
 };
 
 extern struct sparx5_sdlb_group sdlb_groups[SPX5_SDLB_GROUP_CNT];
+struct sparx5_sdlb_group *sparx5_get_sdlb_group(int idx);
 int sparx5_sdlb_pup_token_get(struct sparx5 *sparx5, u32 pup_interval,
 			      u64 rate);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
index 8ada5cee1342..c88820e83812 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
@@ -11,10 +11,11 @@ static int sparx5_policer_service_conf_set(struct sparx5 *sparx5,
 					   struct sparx5_policer *pol)
 {
 	u32 idx, pup_tokens, max_pup_tokens, burst, thres;
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	struct sparx5_sdlb_group *g;
 	u64 rate;
 
-	g = &sdlb_groups[pol->group];
+	g = ops->get_sdlb_group(pol->group);
 	idx = pol->idx;
 
 	rate = pol->rate * 1000;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index fa6cc052bf81..cd4f42c3f7eb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -319,11 +319,12 @@ int sparx5_psfp_fm_del(struct sparx5 *sparx5, u32 id)
 
 void sparx5_psfp_init(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	const struct sparx5_sdlb_group *group;
 	int i;
 
 	for (i = 0; i < sparx5->data->consts->n_lb_groups; i++) {
-		group = &sdlb_groups[i];
+		group = ops->get_sdlb_group(i);
 		sparx5_sdlb_group_init(sparx5, group->max_rate,
 				       group->min_burst, group->frame_size, i);
 	}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
index 5f34febaee6b..d065f8c40d37 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
@@ -74,6 +74,11 @@ static const u32 spx5_hsch_max_group_rate[SPX5_HSCH_LEAK_GRP_CNT] = {
 	26214200 /* 26.214 Gbps */
 };
 
+u32 sparx5_get_hsch_max_group_rate(int grp)
+{
+	return spx5_hsch_max_group_rate[grp];
+}
+
 static struct sparx5_layer layers[SPX5_HSCH_LAYER_CNT];
 
 static u32 sparx5_lg_get_leak_time(struct sparx5 *sparx5, u32 layer, u32 group)
@@ -385,6 +390,7 @@ static int sparx5_dwrr_conf_set(struct sparx5_port *port,
 
 static int sparx5_leak_groups_init(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	struct sparx5_layer *layer;
 	u32 sys_clk_per_100ps;
 	struct sparx5_lg *lg;
@@ -397,7 +403,7 @@ static int sparx5_leak_groups_init(struct sparx5 *sparx5)
 		layer = &layers[i];
 		for (ii = 0; ii < SPX5_HSCH_LEAK_GRP_CNT; ii++) {
 			lg = &layer->leak_groups[ii];
-			lg->max_rate = spx5_hsch_max_group_rate[ii];
+			lg->max_rate = ops->get_hsch_max_group_rate(i);
 
 			/* Calculate the leak time in us, to serve a maximum
 			 * rate of 'max_rate' for this group
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index ced35033a6c5..1231a80335d7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -79,4 +79,6 @@ int sparx5_tc_ets_add(struct sparx5_port *port,
 
 int sparx5_tc_ets_del(struct sparx5_port *port);
 
+u32 sparx5_get_hsch_max_group_rate(int grp);
+
 #endif	/* __SPARX5_QOS_H__ */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index f79130293c4e..df1d15600aad 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
@@ -20,6 +20,11 @@ struct sparx5_sdlb_group sdlb_groups[SPX5_SDLB_GROUP_CNT] = {
 	{     5000000ULL,              8192 / 8, 64 }  /*   5 M */
 };
 
+struct sparx5_sdlb_group *sparx5_get_sdlb_group(int idx)
+{
+	return &sdlb_groups[idx];
+}
+
 int sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5)
 {
 	u32 clk_per_100ps;
@@ -178,6 +183,7 @@ static int sparx5_sdlb_group_get_count(struct sparx5 *sparx5, u32 group)
 
 int sparx5_sdlb_group_get_by_rate(struct sparx5 *sparx5, u32 rate, u32 burst)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	const struct sparx5_sdlb_group *group;
 	u64 rate_bps;
 	int i, count;
@@ -185,7 +191,7 @@ int sparx5_sdlb_group_get_by_rate(struct sparx5 *sparx5, u32 rate, u32 burst)
 	rate_bps = rate * 1000;
 
 	for (i = sparx5->data->consts->n_lb_groups - 1; i >= 0; i--) {
-		group = &sdlb_groups[i];
+		group = ops->get_sdlb_group(i);
 
 		count = sparx5_sdlb_group_get_count(sparx5, i);
 
@@ -303,11 +309,12 @@ int sparx5_sdlb_group_del(struct sparx5 *sparx5, u32 group, u32 idx)
 void sparx5_sdlb_group_init(struct sparx5 *sparx5, u64 max_rate, u32 min_burst,
 			    u32 frame_size, u32 idx)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 thres_shift, mask = 0x01, power = 0;
 	struct sparx5_sdlb_group *group;
 	u64 max_token;
 
-	group = &sdlb_groups[idx];
+	group = ops->get_sdlb_group(idx);
 
 	/* Number of positions to right-shift LB's threshold value. */
 	while ((min_burst & mask) == 0) {

-- 
2.34.1


