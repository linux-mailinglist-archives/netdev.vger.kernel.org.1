Return-Path: <netdev+bounces-130898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71E98BE8A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8DF1C23C30
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EB1C9DE9;
	Tue,  1 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2An/CsH6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CA1C5796;
	Tue,  1 Oct 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790716; cv=none; b=BnZIjMfLCph2xvcPIJnhIB1NSdwOPYEVo84N0hxO+aiBHOS4ztrayOfSb+XJJ7fdLm/bXB2oROX62QI4ymQ9mVqAU3DqgbHRvgFaovrIGlK3ScKrT2N3emfGFsGERqrkWK3/XkgDqB5fwyXDrdRAFQEbZIIOZaBJu7RYhUn7oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790716; c=relaxed/simple;
	bh=0rCL+IF1jVL+/ll92cA5FXoBQENusGoDFyF8h+oLy8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XwphVvVEzb0TN1qWOZd0Gef275XElSo7NAhj6ueACSxFgD28P4U3x5bYYamWAJBNNDft2XWqz/g1VMjVp6yiVtTKxxdpjS3zCESAsWHi7ED3IxBU4xW5F0aQiec86zLWQDhpraqDp/LpNEEhvNIBuM8HBgt3PSKg5yK6ojAjlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2An/CsH6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790714; x=1759326714;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0rCL+IF1jVL+/ll92cA5FXoBQENusGoDFyF8h+oLy8c=;
  b=2An/CsH6rLI35dIA3H1A/bdw8RJ5OIlAycrSBLq9dgicXZ22aKevDmPy
   n/2QRkkqP91vAj9S7XAPDaKVQpvn+58UNtl9ZFIdn5aUxuvjiK86o8HIA
   KA21Sz17XZ6rcD2mwD8SUUMgxtxFwzCxoI17SjAG5FzeQpVe429h5Rlc2
   2DPRDgR/vyqmkrrGv0v699Jx3cPDOfl+tY1mSp3EWdkYi56jEOnr0UqxL
   226u7lerwEd5N70Fa464HcEVIHnuuebBhm+3rqY7omdlx7wCSKzw7rwWJ
   5wGFw0c/Mzzo8Xio5Jqik/D2uBsiShE42J0M8YBawH8XuBgnG89vX71Jt
   A==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: fiws9S0xTa6H+3dSIuEHRQ==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:35 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:32 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:41 +0200
Subject: [PATCH net-next 11/15] net: sparx5: ops out functions for getting
 certain array values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-11-8c6896fdce66@microchip.com>
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

Add getters for getting values in arrays: sdlb_groups and
sparx5_hsch_max_group_rate and ops out the getters, as these arrays will
differ on lan969x.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
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
index 8617fc3983cc..0d8cb9a3ed1f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -984,6 +984,8 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_25g             = &sparx5_port_is_25g,
 	.get_port_dev_index      = &sparx5_port_dev_mapping,
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
+	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
+	.get_sdlb_group          = &sparx5_get_sdlb_group,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 68d5a14603dc..99174aef88f8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -267,6 +267,8 @@ struct sparx5_ops {
 	bool (*is_port_25g)(int portno);
 	u32  (*get_port_dev_index)(struct sparx5 *sparx5, int port);
 	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
+	u32  (*get_hsch_max_group_rate)(int grp);
+	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
 };
 
 struct sparx5_main_io_resource {
@@ -506,6 +508,7 @@ struct sparx5_sdlb_group {
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
index 58bc4eba996b..e8d6f580676d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -315,11 +315,12 @@ int sparx5_psfp_fm_del(struct sparx5 *sparx5, u32 id)
 
 void sparx5_psfp_init(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	const struct sparx5_sdlb_group *group;
 	int i;
 
 	for (i = 0; i < SPX5_CONST(n_lb_groups); i++) {
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
index 8419577cfda0..dbd2e7fff275 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -79,4 +79,6 @@ int sparx5_tc_ets_add(struct sparx5_port *port,
 
 int sparx5_tc_ets_del(struct sparx5_port *port);
 
+u32 sparx5_get_hsch_max_group_rate(int grp);
+
 #endif	/* __SPARX5_QOS_H__ */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index 77fc2a14450d..28ba35c889b9 100644
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
 
 	for (i = SPX5_CONST(n_lb_groups) - 1; i >= 0; i--) {
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


