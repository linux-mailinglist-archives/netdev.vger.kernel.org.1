Return-Path: <netdev+bounces-24977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF770772686
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D461C204F8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8022107B3;
	Mon,  7 Aug 2023 13:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7406107AC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E4172A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBfRr7mS4caB9f27oGMHps+p5aGHSte+N/Csk4mz+SVigwOUPYS/y48MMH5K/wqumWJ2ZvBSI5Q1V/F+1+YrK8y1NwpIuqEWWIMHn9AD5SeOv+CbxG848za7R1IOjttRs1KtmhL0J7tcMIA5V83R0qojBlU8tUNLqfnB8aO1az0mwqzHUJsCyMb77i6V26PTP31kPTj8SvzFOvPe7jLy2PJSG9++jpAb/wxcmtdr3BHiIcm9glHlQq/ZjzcU/vwVx8WVfRMepIKgx9XjaS3aYS0C++1KuDrDKa+hRsIyp7FKx7Tc/0/s96UB7SaK+MG0cXTprZaUEgL+fre+0LrmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i1K5mOlDU7uP0/QQpH+v3n5tCe0o8+6YYEQIAgp/vs=;
 b=gQ/Jh2JWXT5kNmbYUPcJ62v65iFYF1RTxKP6StTRI7Ra6EHSPr3kW/XjjDwB7T75ZxBHnIbrdGGGK4/IT4w3mYAdNmQIur+R9IyVqkIYC0VITIjXLDCt7S6xSf29MDzlON6+/9h51qYRWXeIjDOmMSF+5m2EvSLHk0cu9+lElqNgbq+Xn0WphRzhZF8mQrVYQ8EOdvwzrEzxBBIpc7mmNTr9xfMZXKpZSxrkQWV+w7XdfurWXtWwHs19BQpBAqT43Vhzq3+SpWBFcQTW5AHEeJSdjROY/vKlXodF4Hh+JB0u0bmFgXaLGMyzwpHpYdhG64rLSxPJbXy+7KNGlGN4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i1K5mOlDU7uP0/QQpH+v3n5tCe0o8+6YYEQIAgp/vs=;
 b=I5gCpTB5x2sGDSV7w+5YSM32HbWsDMoUUoKa+FOajeKfLWPMALSOeyDgaU6yhiQqyICjq23MhmdGV7WN/+tpszpWhPuX7yA/lv9g7AZb2nzwMgtb3tNJmMsxm+X+PV8qFijB4hQ9+C984upTFf+2Ztfq1NG/i6+dvBYHZKdPGG8=
Received: from CYZPR19CA0014.namprd19.prod.outlook.com (2603:10b6:930:8e::6)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 13:49:18 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8e:cafe::23) by CYZPR19CA0014.outlook.office365.com
 (2603:10b6:930:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 13:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:49:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:49:14 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:49:13 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 2/7] sfc: functions to register for conntrack zone offload
Date: Mon, 7 Aug 2023 14:48:06 +0100
Message-ID: <53ef14cda15c4c642dd2247bf452f30b06882731.1691415479.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691415479.git.ecree.xilinx@gmail.com>
References: <cover.1691415479.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ea20c5-e157-4e77-9a75-08db974d17e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gSpsUayN2akCvf0CLR7ECOGyY0j0ZRTEO/24j+cU8NsRCUDm6xo1o0RWMGoxX+SZokkumLcRPtPju95l3TA5a6VYnZdIDedgD9H1sKbPKqxfddVOG7d7XKdTfAacuA4O1WKT7Qm1D/w2lV9u2h+OdPJccw1WdqRpPpNporsPvVAtmDBOTiZ7qJXa7V8RPQ684hSF+PvjEX9Pg3K0Ejvg2mCtkm70hlv6Dc7EFshLVSMM/ayfzgIUw2BVZ8fMsIZT/m1CINmaGwTtsKyGn9m8vGwa5GjVgMX5R0YaxykvUF8jpZg5HdFC9cZAUJQU+Fg5XQkUSUYzehxDFQyXuzuzmB5dimYsXScJNjLO002hBmsmh3AtGrsf1Yj7eXTMaW0vJmgXSQzMuAFE1g/7mwGObLjv1TlHfRkYk7a1FRdiUhirUSnkGm4mNicd6ddVZclDAJKHopXRVxOg0E0IFAbw+xX9n4EMHjVL2JgGjvU5ezlSul259NIkLe/tk9FeNtHtHuSpUTMT8NKWVY/PhuFJlnsvzmSLIFYraFhJkZXYp/2UmB+I2tef1xvJ+1YsSdnaPvNS4o0FcenNyj0otrbAssKGmQqi08KBlDl1QxJZ7Ql7bD6A0Vs5h4TIenYM6mcttgyKqeSnIAGfkpoKta8IFaothd6AqNhFMQ460di5qNtA5KCSoG9uv2nsnMCO2T2l+i8JAc3fhwyNUD4g2mGJaR6W5fzGAo0Q2wYiLjT52BHPJoqVc80217hUu0K1rOC5evoC+ByU/AvG3Nnoh7puXRwRDPKghzoXon8+EnPNY1k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(2876002)(2906002)(36756003)(83380400001)(5660300002)(426003)(36860700001)(110136005)(54906003)(6666004)(70206006)(70586007)(356005)(9686003)(4326008)(82740400003)(81166007)(316002)(40480700001)(41300700001)(55446002)(86362001)(40460700003)(8936002)(26005)(8676002)(336012)(478600001)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:49:17.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ea20c5-e157-4e77-9a75-08db974d17e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Bind a stub callback to the netfilter flow table.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/Makefile       |   2 +-
 drivers/net/ethernet/sfc/tc.c           |   7 ++
 drivers/net/ethernet/sfc/tc.h           |   2 +
 drivers/net/ethernet/sfc/tc_conntrack.c | 109 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc_conntrack.h |  37 ++++++++
 5 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.c
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.h

diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 16293b58e0a8..8f446b9bd5ee 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -11,7 +11,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
-                           tc_encap_actions.o
+                           tc_encap_actions.o tc_conntrack.o
 
 obj-$(CONFIG_SFC)	+= sfc.o
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 4dc979fdc968..44a6fc30b722 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -15,6 +15,7 @@
 #include "tc.h"
 #include "tc_bindings.h"
 #include "tc_encap_actions.h"
+#include "tc_conntrack.h"
 #include "mae.h"
 #include "ef100_rep.h"
 #include "efx.h"
@@ -1747,6 +1748,9 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = rhashtable_init(&efx->tc->match_action_ht, &efx_tc_match_action_ht_params);
 	if (rc < 0)
 		goto fail_match_action_ht;
+	rc = efx_tc_init_conntrack(efx);
+	if (rc < 0)
+		goto fail_conntrack;
 	efx->tc->reps_filter_uc = -1;
 	efx->tc->reps_filter_mc = -1;
 	INIT_LIST_HEAD(&efx->tc->dflt.pf.acts.list);
@@ -1759,6 +1763,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	efx->tc->facts.reps.fw_id = MC_CMD_MAE_ACTION_SET_ALLOC_OUT_ACTION_SET_ID_NULL;
 	efx->extra_channel_type[EFX_EXTRA_CHANNEL_TC] = &efx_tc_channel_type;
 	return 0;
+fail_conntrack:
+	rhashtable_destroy(&efx->tc->match_action_ht);
 fail_match_action_ht:
 	rhashtable_destroy(&efx->tc->encap_match_ht);
 fail_encap_match_ht:
@@ -1792,6 +1798,7 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 				    efx);
 	rhashtable_free_and_destroy(&efx->tc->encap_match_ht,
 				    efx_tc_encap_match_free, NULL);
+	efx_tc_fini_conntrack(efx);
 	efx_tc_fini_counters(efx);
 	efx_tc_fini_encap_actions(efx);
 	mutex_unlock(&efx->tc->mutex);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 27592f10b536..fc196eb897af 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -196,6 +196,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @encap_ht: Hashtable of TC encap actions
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
+ * @ct_zone_ht: Hashtable of TC conntrack flowtable bindings
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
  * @meta_ct: MAE table layout for conntrack table
  * @reps_mport_id: MAE port allocated for representor RX
@@ -228,6 +229,7 @@ struct efx_tc_state {
 	struct rhashtable encap_ht;
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
+	struct rhashtable ct_zone_ht;
 	struct rhashtable neigh_ht;
 	struct efx_tc_table_ct meta_ct;
 	u32 reps_mport_id, reps_mport_vport_id;
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
new file mode 100644
index 000000000000..d67302715ec3
--- /dev/null
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include "tc_conntrack.h"
+#include "tc.h"
+#include "mae.h"
+
+static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
+			     void *cb_priv);
+
+static const struct rhashtable_params efx_tc_ct_zone_ht_params = {
+	.key_len	= offsetof(struct efx_tc_ct_zone, linkage),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_ct_zone, linkage),
+};
+
+static void efx_tc_ct_zone_free(void *ptr, void *arg)
+{
+	struct efx_tc_ct_zone *zone = ptr;
+	struct efx_nic *efx = zone->efx;
+
+	netif_err(efx, drv, efx->net_dev,
+		  "tc ct_zone %u still present at teardown, removing\n",
+		  zone->zone);
+
+	nf_flow_table_offload_del_cb(zone->nf_ft, efx_tc_flow_block, zone);
+	kfree(zone);
+}
+
+int efx_tc_init_conntrack(struct efx_nic *efx)
+{
+	int rc;
+
+	rc = rhashtable_init(&efx->tc->ct_zone_ht, &efx_tc_ct_zone_ht_params);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+void efx_tc_fini_conntrack(struct efx_nic *efx)
+{
+	rhashtable_free_and_destroy(&efx->tc->ct_zone_ht, efx_tc_ct_zone_free, NULL);
+}
+
+static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
+			     void *cb_priv)
+{
+	return -EOPNOTSUPP;
+}
+
+struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
+					       struct nf_flowtable *ct_ft)
+{
+	struct efx_tc_ct_zone *ct_zone, *old;
+	int rc;
+
+	ct_zone = kzalloc(sizeof(*ct_zone), GFP_USER);
+	if (!ct_zone)
+		return ERR_PTR(-ENOMEM);
+	ct_zone->zone = zone;
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->ct_zone_ht,
+						&ct_zone->linkage,
+						efx_tc_ct_zone_ht_params);
+	if (old) {
+		/* don't need our new entry */
+		kfree(ct_zone);
+		if (!refcount_inc_not_zero(&old->ref))
+			return ERR_PTR(-EAGAIN);
+		/* existing entry found */
+		WARN_ON_ONCE(old->nf_ft != ct_ft);
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Found existing ct_zone for %u\n", zone);
+		return old;
+	}
+	ct_zone->nf_ft = ct_ft;
+	ct_zone->efx = efx;
+	rc = nf_flow_table_offload_add_cb(ct_ft, efx_tc_flow_block, ct_zone);
+	netif_dbg(efx, drv, efx->net_dev, "Adding new ct_zone for %u, rc %d\n",
+		  zone, rc);
+	if (rc < 0)
+		goto fail;
+	refcount_set(&ct_zone->ref, 1);
+	return ct_zone;
+fail:
+	rhashtable_remove_fast(&efx->tc->ct_zone_ht, &ct_zone->linkage,
+			       efx_tc_ct_zone_ht_params);
+	kfree(ct_zone);
+	return ERR_PTR(rc);
+}
+
+void efx_tc_ct_unregister_zone(struct efx_nic *efx,
+			       struct efx_tc_ct_zone *ct_zone)
+{
+	if (!refcount_dec_and_test(&ct_zone->ref))
+		return; /* still in use */
+	nf_flow_table_offload_del_cb(ct_zone->nf_ft, efx_tc_flow_block, ct_zone);
+	rhashtable_remove_fast(&efx->tc->ct_zone_ht, &ct_zone->linkage,
+			       efx_tc_ct_zone_ht_params);
+	netif_dbg(efx, drv, efx->net_dev, "Removed ct_zone for %u\n",
+		  ct_zone->zone);
+	kfree(ct_zone);
+}
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
new file mode 100644
index 000000000000..f1e5fb74a73f
--- /dev/null
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_TC_CONNTRACK_H
+#define EFX_TC_CONNTRACK_H
+#include "net_driver.h"
+
+#if IS_ENABLED(CONFIG_SFC_SRIOV)
+#include <linux/refcount.h>
+#include <net/netfilter/nf_flow_table.h>
+
+struct efx_tc_ct_zone {
+	u16 zone;
+	struct rhash_head linkage;
+	refcount_t ref;
+	struct nf_flowtable *nf_ft;
+	struct efx_nic *efx;
+};
+
+/* create/teardown hashtables */
+int efx_tc_init_conntrack(struct efx_nic *efx);
+void efx_tc_fini_conntrack(struct efx_nic *efx);
+
+struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
+					       struct nf_flowtable *ct_ft);
+void efx_tc_ct_unregister_zone(struct efx_nic *efx,
+			       struct efx_tc_ct_zone *ct_zone);
+
+#endif /* CONFIG_SFC_SRIOV */
+#endif /* EFX_TC_CONNTRACK_H */

