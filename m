Return-Path: <netdev+bounces-130891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75AC98BE73
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDC1F243BD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0AF1C6F46;
	Tue,  1 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DwERKRSb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73061C57AF;
	Tue,  1 Oct 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790690; cv=none; b=prUYjjX7DLFUAteHJFQp23cSPcw2AUnTHkD8AKCjIQdVqHtLRNwdxGXR77BShX57Z87eP8oxNjmhu8UxAx3dmnN+OFBfcvTtE/AnE04YKnAp1W0JlGcGdnty8cgL5sQWnoqDzzk8D/LFJaDQSElqG3Yq+uZFX/l5D2y3QFLF8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790690; c=relaxed/simple;
	bh=GW0CkmxZUMAJyz2lueB7K5XdnpbRBVCw7BP5D2Sd928=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XS+ANMZhq4IyLaTv2JmTLkaNkDSDy22RCBSXiucIWqatxP6twaav3ifc4mOXc/zN23gv9dPnEcxXPDjVJ5AVcU+w0GJoU5R980ZW3XMKpzKA34Z/BbfDkw9tr9JGzMlr46fmcChwNM65iHD9tjPHS3jNV1FH6u++1uYbNAA1YAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DwERKRSb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790688; x=1759326688;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GW0CkmxZUMAJyz2lueB7K5XdnpbRBVCw7BP5D2Sd928=;
  b=DwERKRSbDpTGsujxW+guR8rn1fTMiye53WMft8UfATiYVO6N/mBKFeEH
   iNZIOpiLWLqcP8GUsQA2Lbq9JK/C7MDV15mLj1PRStrwauwh0v8r6ZN78
   hJobnnz4mx1QwQ8LGgoKdA8aQsmDuX/BQ3TikTtxQSEM6m/xS2LZTqvO+
   9rw/17JnRYHZ5WMYJ1W4bydQCJZ9gH3gAxHjlmPPjBh0z95j9C6rTcRaY
   BEkn7ssO1stzxZB6o9MMDV2GGljpXocvGDzkcFIV8nfOwfDC5leK0FKqR
   CXepeOO4nDihM1IrypXePuITsg6VwBy4VCXnYmiVegib7XWU7Ff2f+PZ6
   Q==;
X-CSE-ConnectionGUID: +oQdX0lcTd+VPfROt+JSQg==
X-CSE-MsgGUID: BaVOSJnYTMCJaOZJSeNurg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057484"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:19 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:36 +0200
Subject: [PATCH net-next 06/15] net: sparx5: add constants to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
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

Add new struct sparx5_consts, containing all the chip constants that are
known to be different for Sparx5 and lan969x. Also add a macro to access
the constants.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 21 ++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 23 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 9a8d2e8c02a5..5f3690a59ac1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -953,11 +953,32 @@ static const struct sparx5_regs sparx5_regs = {
 	.fsize = sparx5_fsize,
 };
 
+static const struct sparx5_consts sparx5_consts = {
+	.n_ports             = 65,
+	.n_ports_all         = 70,
+	.n_hsch_l1_elems     = 64,
+	.n_hsch_queues       = 8,
+	.n_lb_groups         = 10,
+	.n_pgids             = 2113, /* (2048 + n_ports) */
+	.n_sio_clks          = 3,
+	.n_own_upsids        = 3,
+	.n_auto_cals         = 7,
+	.n_filters           = 1024,
+	.n_gates             = 1024,
+	.n_sdlbs             = 4096,
+	.n_dsm_cal_taxis     = 8,
+	.buf_size            = 4194280,
+	.qres_max_prio_idx   = 630,
+	.qres_max_colour_idx = 638,
+	.tod_pin             = 4,
+};
+
 static const struct sparx5_match_data sparx5_desc = {
 	.iomap = sparx5_main_iomap,
 	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
 	.ioranges = 3,
 	.regs = &sparx5_regs,
+	.consts = &sparx5_consts,
 };
 
 static const struct of_device_id mchp_sparx5_match[] = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 738b86999fd8..91f5a3be829e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -51,6 +51,8 @@ enum sparx5_vlan_port_type {
 	SPX5_VLAN_PORT_TYPE_S_CUSTOM /* S-port using custom type */
 };
 
+#define SPX5_CONST(const) sparx5->data->consts->const
+
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
@@ -238,6 +240,26 @@ struct sparx5_regs {
 	const unsigned int *fsize;
 };
 
+struct sparx5_consts {
+	u32 n_ports;             /* Number of front ports */
+	u32 n_ports_all;         /* Number of front ports + internal ports */
+	u32 n_hsch_l1_elems;     /* Number of HSCH layer 1 elements */
+	u32 n_hsch_queues;       /* Number of HSCH queues */
+	u32 n_lb_groups;         /* Number of leacky bucket groupd */
+	u32 n_pgids;             /* Number of PGID's */
+	u32 n_sio_clks;          /* Number of serial IO clocks */
+	u32 n_own_upsids;        /* Number of own UPSID's */
+	u32 n_auto_cals;         /* Number of auto calendars */
+	u32 n_filters;           /* Number of PSFP filters */
+	u32 n_gates;             /* Number of PSFP gates */
+	u32 n_sdlbs;             /* Number of service dual leaky buckets */
+	u32 n_dsm_cal_taxis;     /* Number of DSM calendar taxis */
+	u32 buf_size;            /* Amount of QLIM watermark memory */
+	u32 qres_max_prio_idx;   /* Maximum QRES prio index */
+	u32 qres_max_colour_idx; /* Maximum QRES colour index */
+	u32 tod_pin;             /* PTP TOD pin */
+};
+
 struct sparx5_main_io_resource {
 	enum sparx5_target id;
 	phys_addr_t offset;
@@ -246,6 +268,7 @@ struct sparx5_main_io_resource {
 
 struct sparx5_match_data {
 	const struct sparx5_regs *regs;
+	const struct sparx5_consts *consts;
 	const struct sparx5_main_io_resource *iomap;
 	int ioranges;
 	int iomap_size;

-- 
2.34.1


