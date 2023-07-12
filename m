Return-Path: <netdev+bounces-17231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DF750E14
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E611C211DB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3A14F69;
	Wed, 12 Jul 2023 16:16:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314982150C
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:16:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCE1BF1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnuMR22FZSMHshIrHpXyTSpsx0VZWJ2Na/zJ2YDfKuNtUP+qM7hDjy488Uht4i2XxbM1ep2NEDWnXPBhRU32q16B7vg6RLYIJZlD2cddoVIys/GBWOxaSQBUAwF+2kM4e4cK7/Pa9INRbxrjlF4WbpaM4TKKKJ6/yqBMpex0Qt6TS15KCfhFv7hrqkPCCjaRStHxyWCtaG4sj9/C8XFTL9Ux7JUO1XBy+fF1Ss8EUU+qLCWuF2PK2pdiHCFYzMo3hjgGslVb2/nam+BUh+GPGOLy4BEvw9XwObGO5XSO6YIwGl9ULmc835sHhOLbtZti0U4ChC2mSCN/RNCYmTWVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIYbEPT6t56fKezu2wZCfsrAPTHhXQoby0xA6zrZPWs=;
 b=NYnlSxD6AQskev8cjfswRfA5HfZcmiJxB0pnjArLMPk6KQeZzpVzk1inLPRbo6RuH+czzy9vIeCBQIaJJVZ4drnXzOy1ZMzEo4tE0npf7Zv9+cEWPwGxGwhk58AnGzbh636KqPIyDbe7w9m/8zdLz3czTjNg5qXTB0AeYXTekqATfsg1+8dVTyl+GYy8nTICOZRDtmZy/WL//vShzgb+89wQKo5o3LhQ8HCOEeIG3Mvg5znNPp73M6XsO35MKVkjn+m5RncbLginb5rfgiQc9fzCZdcpI7+DTnpUtOvl+hHKmvQy11T4NRVORTgVkJ2rQT/lkKUcDXymxebeq2+61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIYbEPT6t56fKezu2wZCfsrAPTHhXQoby0xA6zrZPWs=;
 b=dPRV/TniepnJTBN/Dqqcr43/WXqMfhV3d5m8qTTKOC1Z4PRkE/v2o3B2jd1r8KnW9MwEX+Lj1z90S4qEgdVPGDmXvpwpRUme/z8A+7+JtLIkiFxvhfqQbUSUDWwHDIjePVDqPCwTNa453Z2LxmzLYhuFeYXae+5sqc3S6Fhwfmv+1nVzAL/jiTUapqvsoe3JyOoBSGSZnGH+FzFI8a1VnSgPeuEMzSsLDmY0rLPJce+t3pGsh6oDmLCHth3zA1qiYDeNe8Ajq/e5nt/K4ZC0AbJfjBzN67F6XEe9WUBde4ToRHPv2F0UlZm+KSI77hto0T9EdNMDK0ekGWZITkufZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:16:35 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:16:34 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 02/26] net/ethtool: add new stringset ETH_SS_ULP_DDP_{CAPS,STATS}
Date: Wed, 12 Jul 2023 16:14:49 +0000
Message-Id: <20230712161513.134860-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6b2a0a-19ad-463e-5105-08db82f35c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kco8r6FHItfOofpfpnisLGLErB8GKO0s0rT1iVW0JxDhxnYJ6TlXTAr5oCR8GBysDchmNLfNcJYxgmOFYPicPQpWuFOmFdC3BIZHXWrtUQcOEobwBfkde3RfoTJX2xuG9ORrqDdRrRsZRiXfzdCjjhL2Ru7Su/tcXyzsGDJ6uBObF4z6HNbbqOTJI0Cmf3AzNq+MIByPbrT3IjmjMS15UnA/OYxcEfQ/XLq4yUGZ6T5nGXNL3ghFIq4rQugjPPZARtgukiAQ3iqzy80IkYrlWjniCiz4GuY/uVuNWsaTaGX4bPa7ElCHWqS+SEVlxVItY0GZeJp6VpVVgT0L/zYkaj9tlSotovdNuJG/yVgKghsC8PmFqaKV6yqPrcnauUFrnIAzsanmYbBda+5PuZ5cMhUJtu0TDllnpsO4SYMT1D0jG/nihHgBa5+ZE4M9O6SoDz7Tpn0+/IJGSOseJKDGOz1ljC0xD1liTqUz3hGKfczHLgS96C7mrnsejFkkWfktIfkDQ1PGLLI9qPDIgeDxMHjKaQLoutYmqpi4We8Os5l1EN8Sh4T48TdI3wTCVuy1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6m7mQfd8W5NlgWU3oRQV4/JyjpAzt9bSvybfuiPgj1nz6UOYKQVeig3XxDQs?=
 =?us-ascii?Q?TEdFc5dhlaD7AnxuZvXWcwjO1TPCDxeu499KvieKISjwvfes882ujFDNWCRB?=
 =?us-ascii?Q?pTXyi4rEuDE6DHY5WreExc8/YN9HVh98wY78RIrdpz+IVOcuGXpmJXu0TlZ+?=
 =?us-ascii?Q?KYL0ibnK3zbiNSDk5Fl5wiNsrOEd7Q3NQVSgEuiCf6NMa49xp5wl94zqF/iq?=
 =?us-ascii?Q?uIiTxR/LzRNNvDt/+Goon27p9wJbCNx0yXZ63hukJEw5rPXREdQeFRgxh3wV?=
 =?us-ascii?Q?NvSj1JyHvVuUtB5bPxFKlkdxso6KfxLfRi793kA2TxMNuRkdbsH1BTAOir+p?=
 =?us-ascii?Q?mJzBGQ+mch7FVRDFfi8uXWaK5TiDqJSgrNdB4c8qMHyysNSkJpSkuWYgOyTi?=
 =?us-ascii?Q?vQ90evC7/Y0GNgcm5DjX1ojvJGOsJKCWEXDzg9dy/jJ4LqfPxj9RleT4GjOF?=
 =?us-ascii?Q?Pwi2csksxgBjocCtT4onTkgxMOc1W0tf3tVvGigZYvMcO/wNEUnLO0yP+c6N?=
 =?us-ascii?Q?xltpV82Dk+Vvhny8HrchbG1oYonfxeay4CjCg+bzm+JJ7ops5QjtJSnu+KGZ?=
 =?us-ascii?Q?vyd4C9pIRVrnrpdtcipjnwWooqpfWE4Rn/h9gzbf0ejsTpedx7nA6apuKU5s?=
 =?us-ascii?Q?+ZKGaOUmsDJh9jSJjBLx2/cQ6pJgITSxPIeve+16Nl1/j3c8EWoqrROa0LdC?=
 =?us-ascii?Q?0sFPMkzK0ntTtvbKLFMf/3dt/tPk1iKHMYNNc9YUIR4SvI+VsZUh2yWMaX54?=
 =?us-ascii?Q?wjeh3gA2An6yLa6UdJLnadlxCUVFcM+FbtsNxUlX4u9L50HjAb47RNYoWjOP?=
 =?us-ascii?Q?C3rx1WknqPXsP+JCYt/ffhKSltU7wXsHDM4AyuFU5W5cK07xvgV64uH7cgrn?=
 =?us-ascii?Q?iUHPHFlTPLsYTkD6q8703qne+WFyXm3YsC3JV/5l3jvnKQOMjHgUd8iQeZ6O?=
 =?us-ascii?Q?Wdgj7wNV6o85x9WATiTZ7Dbiu4RlDT55CyantOmH5lAPr+O0uJmD2qRBayG/?=
 =?us-ascii?Q?zn1b3i/fZKLpbPGwBU2wxA5gRvzxyBvEPlWP3+95KNX+ozYCgG9KtdeUvG+q?=
 =?us-ascii?Q?VGGf4BhzbGyp/NNoOzEZZGfJcqRsXc+MQrxCKDc1gQqNhFz4fb2kJpeByVFY?=
 =?us-ascii?Q?AaAKpLXEUePwSMx70/HyNxw0YZSr91zEDsFo2Q1OBHEOYB2/SdAh1sBA83Zu?=
 =?us-ascii?Q?fUS46lNnQsIm1YrH/7hhTs8iW9XJoc2DMc9oFNnQyfquTSiB9ekcwB3QqpMa?=
 =?us-ascii?Q?cZcqu5jOLCGav+A1n8AG0hYsQtU3rPdSfbM8ggYrHKcM0FjFH9JcNV0ryuhw?=
 =?us-ascii?Q?MRtvPfcm0ho1WsvI8+VGN2q3hyOunM821J8BFbgWR+nTPEB/L+dxPfpyDxUh?=
 =?us-ascii?Q?lekCaUlZRWg/1Nq/HQBF3aaKYuZZWv+H9ltlQ20IgcN2yDybf2mnZIEd0Sdx?=
 =?us-ascii?Q?F/wqaOZNT9fkUye30C+6qGKZuU1q795uzZzYyLKkmz0hl5nNxzEdQd8RPuSg?=
 =?us-ascii?Q?Id6RB9Rg+08vJiuL2AERXfQCqHgFJ6IjKmpaYFtYYSulOwf+Jn9F50gV5kMi?=
 =?us-ascii?Q?A00UnP89XwugFbQTuzKYgbaRou3gYBF+nuwqqyCA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6b2a0a-19ad-463e-5105-08db82f35c9b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:16:34.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsj+I9qjOsKKcIbNq4C+k1BvlzAk0HSl4j9WHTkNorKWrzeIaE8e5ZdxsQpd9UDGqfTdIgVG3B7kcX1rS6jrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit exposes ULP DDP capability and statistics names to
userspace via netlink.

In order to support future ULP DDP capabilities and statistics without
having to change the netlink protocol (and userspace ethtool) we add
new string sets to let userspace dynamically fetch what the kernel
supports.

* ETH_SS_ULP_DDP_CAPS stores names of ULP DDP capabilities
* ETH_SS_ULP_DDP_STATS stores names of ULP DDP statistics.

These stringsets will be used in later commits when implementing the
new ULP DDP GET/SET netlink messages.

We keep the convention of strset.c of having the static_assert()
right after the array declaration, despite the checkpatch warning.

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/ethtool.h              | 32 ++++++++++++++++++++++++++++
 include/uapi/linux/ethtool.h         |  4 ++++
 include/uapi/linux/ethtool_netlink.h | 22 +++++++++++++++++++
 net/ethtool/common.c                 | 23 ++++++++++++++++++++
 net/ethtool/common.h                 |  2 ++
 net/ethtool/strset.c                 | 11 ++++++++++
 6 files changed, 94 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..61681e064d91 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -594,6 +594,38 @@ struct ethtool_mm_stats {
 	u64 MACMergeHoldCount;
 };
 
+/**
+ * struct ethtool_ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ethtool_ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * - ETHTOOL_ULP_DDP_STATS_* enum in uapi
+	 * - ulp_ddp_stats_name stringset
+	 */
+};
+
 /**
  * struct ethtool_ops - optional netdev operations
  * @cap_link_lanes_supported: indicates if the driver supports lanes
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..8b8585b5fa56 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -681,6 +681,8 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_ULP_DDP_CAPS: names of ULP DDP capabilities
+ * @ETH_SS_ULP_DDP_STATS: names of ULP DDP statistics
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +708,8 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_ULP_DDP_CAPS,
+	ETH_SS_ULP_DDP_STATS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..a9aebbe420c8 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -975,6 +975,28 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+/* ULP DDP */
+
+enum {
+	ETHTOOL_A_ULP_DDP_STATS_UNSPEC,
+	ETHTOOL_A_ULP_DDP_STATS_PAD,
+
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS,
+	ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES,
+
+	/* add new constants above here */
+	__ETHTOOL_A_ULP_DDP_STATS_CNT,
+	ETHTOOL_A_ULP_DDP_STATS_MAX = __ETHTOOL_A_ULP_DDP_STATS_CNT - 1
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fb19050991e..751017dca228 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -5,6 +5,7 @@
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/ulp_ddp_caps.h>
 
 #include "common.h"
 
@@ -465,6 +466,28 @@ const char udp_tunnel_type_names[][ETH_GSTRING_LEN] = {
 static_assert(ARRAY_SIZE(udp_tunnel_type_names) ==
 	      __ETHTOOL_UDP_TUNNEL_TYPE_CNT);
 
+const char ulp_ddp_caps_names[][ETH_GSTRING_LEN] = {
+	[ULP_DDP_C_NVME_TCP_BIT]		= "nvme-tcp-ddp",
+	[ULP_DDP_C_NVME_TCP_DDGST_RX_BIT]	= "nvme-tcp-ddgst-rx-offload",
+};
+static_assert(ARRAY_SIZE(ulp_ddp_caps_names) == ULP_DDP_C_COUNT);
+
+const char ulp_ddp_stats_names[][ETH_GSTRING_LEN] = {
+	[ETHTOOL_A_ULP_DDP_STATS_UNSPEC]			= "unspec",
+	[ETHTOOL_A_ULP_DDP_STATS_PAD]				= "pad",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD]		= "rx_nvmeotcp_sk_add",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL]	= "rx_nvmeotcp_sk_add_fail",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL]		= "rx_nvmeotcp_sk_del",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP]		= "rx_nvmeotcp_ddp_setup",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL]	= "rx_nvmeotcp_ddp_setup_fail",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN]	= "rx_nvmeotcp_ddp_teardown",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP]		= "rx_nvmeotcp_drop",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC]		= "rx_nvmeotcp_resync",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS]		= "rx_nvmeotcp_packets",
+	[ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES]		= "rx_nvmeotcp_bytes",
+};
+static_assert(ARRAY_SIZE(ulp_ddp_stats_names) == __ETHTOOL_A_ULP_DDP_STATS_CNT);
+
 /* return false if legacy contained non-0 deprecated fields
  * maxtxpkt/maxrxpkt. rest of ksettings always updated
  */
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9bcb..ebb0abec04a3 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -36,6 +36,8 @@ extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
 extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
+extern const char ulp_ddp_caps_names[][ETH_GSTRING_LEN];
+extern const char ulp_ddp_stats_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
 
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 3f7de54d85fb..959a1b61e8e7 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -2,6 +2,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <net/ulp_ddp_caps.h>
 #include "netlink.h"
 #include "common.h"
 
@@ -105,6 +106,16 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_RMON_CNT,
 		.strings	= stats_rmon_names,
 	},
+	[ETH_SS_ULP_DDP_CAPS] = {
+		.per_dev	= false,
+		.count		= ULP_DDP_C_COUNT,
+		.strings	= ulp_ddp_caps_names,
+	},
+	[ETH_SS_ULP_DDP_STATS] = {
+		.per_dev	= false,
+		.count		= __ETHTOOL_A_ULP_DDP_STATS_CNT,
+		.strings	= ulp_ddp_stats_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.34.1


