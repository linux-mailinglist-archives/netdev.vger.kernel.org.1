Return-Path: <netdev+bounces-29661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74277844F5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E333D1C20AE4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE51D2FE;
	Tue, 22 Aug 2023 15:05:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC371D2E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E2126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik4wjWiZULEvsfwZ/FeWHMASpoDfVzVVKXGfqmuvT3ur2MuKxW/dvI0HN+6y9sXKq6DohuvZB8rz0Aw0FruCWO5LyMZa2lx1+E3YCVpL86c4TZdtgs6ioHRXOj2Sn7aLWcSngFXUpS1qL2H7M7HvMeChPzIbvGvweBpCwD3DrlUj7dXz120VFXIIqjtkS//UbtI7RIGGh9RqOQ4Al6JtM3m6N//SpYlgROszSJFewq50jfV+usRZFm0JEfrdpI0R98jBogFU+Adue6kx1qo4mKM0hp7AoRcNHVOxZ4f5XyLOsAnJgi6sdGxv2hxVYGsIvJiGgItdLSD+E0TXyOrbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Chsi96R3spsIKwfaWtP7CAblprNCPnaI1rt8GY+7E=;
 b=d9yV7LFXRskizrRdm2ktSFqrKz1DyymQYTFki3O3WG0virmCxhN3k/6uw+KlI4WrzqVp9G9KIT5fEhm1LQO9looF6dx6dtjGxq2F8qvKL1jQLRGatqn8bnsCu2YqBPBopJNFDmmZ58RdwKSCByLRVPeVxPcm6wzg9tlIT7TsGcMpIzqvPsclTySI0CaxZ+bJGYiEB98FgGR+I7+6NTh5ttv2nK/2MxqxEKSmDmfVSITXPmk4E67/B1t6b9hd/eJlzII2M0XJr+VJJZlDA3kUyBvIcFbvqLo67dB9Y/ChTE3QEqlthzRHXPT7GtVwGQTqtbOHynslxZPLSQQOXSkSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3Chsi96R3spsIKwfaWtP7CAblprNCPnaI1rt8GY+7E=;
 b=YAMZAWa+NrJTgOwNeGHCDprbd2AVaNxwIW+RP6qGPKF8Z8kWmb774/y5MYEN0tCB+oEq5uLI8J9SWe54Sg0SXv7KfpFWQI8zXxjIY/XATB0rfkSBK/0hBgoEqTbmT0H6+k41yy9vSpogQw1+dgwj/WH5uWyYkuVEZKtkD0IVFM11K8OhMfKHsW2ETR392yf6nnEmVrBRXUPu9zGP7riWEt648EQzGLNQzW5BEpS/xkKyoYtaOI46H7YWQ/WIwgXV2RJ0nTUZo9oIbwbXlyhDfiSCLgrzgJ+ZXgpohZVRvuarcx6lqTBVOZubujGE2FQIVVNDlVN6vMG7uGf2ROaFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:04:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:04:58 +0000
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
Subject: [PATCH v13 02/24] net/ethtool: add new stringset ETH_SS_ULP_DDP_{CAPS,STATS}
Date: Tue, 22 Aug 2023 15:04:03 +0000
Message-Id: <20230822150425.3390-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4360e223-4d63-4fd9-af6a-08dba32126c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1eZjVoE442ymRY6ZHy4Vbwt1rBYZuUmsr2vLSHuK4r6/4zlNq1cIBad46mMbcZYYpVTSviEVB44jOJ3RhjJBOthefg1jN/7DB2+Lx+u0Qu+YXd5uCbS2VShkbPu/xJMzH0ZPB1IdEgl9A9UFkZ46tQM48unEksMSHiwBAgo0w91GUJfczKaps+Rb7lLHP6Ml0rJYBdNeI2Vq93zQDA0vqEDXzbeJBjlHXErlJnw96nkJ33fRaDiOKYWJ710BTgUM7NCVwUhnRz2jJsOfY+jOCk8TcisZyHgLKpqYysIb4SETtnXYUh4MOAc2tLQJH1G4MspMrV/MK7067dzM8zKQ7Ig54w4AlB+mohdbHhSMsntv5seF+dFkQwb5hOoH42VFiyfoZ9/r8j3yoHepNNjvoHKMpi7Ht9YCP8xMoWIgaXwbYzu15sIpIW5N578xeJ+eMecSb3viEPSh7uAB+mi6FyJ6omDi7RVesZqrbeyLH9gGdYV8WO1WKwe22HsXxOT4q4kjDBhYqhAdEr3GzkfWESfACf2pC2rsPw9TXCmMi9P8CF49xkUTesVaKw6iFjgZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(83380400001)(7416002)(6506007)(6486002)(38100700002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(4326008)(107886003)(316002)(6512007)(66556008)(66476007)(478600001)(66946007)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSg6AK6AEBMwLxSKtUog7YJD+OELs3855OwPonmNfwGCrPHozJ/wvUjczHtZ?=
 =?us-ascii?Q?2G4BTZON5cPnTshrSdZ4Hq+sWnkIA4V5PFNjmC/SG2rQFp9fhKnrjHaedND3?=
 =?us-ascii?Q?dM7Mf+P5/gsfk52sPtfFHcTJbi4D+wf+spf9OKgQSAZB474Y3HghLPs+7yY7?=
 =?us-ascii?Q?xKnpdnEZ0tW5PewQyAmvG9vvAkIr2WhzyGWkbdSQdx7lqup8x4HoXdjliDq4?=
 =?us-ascii?Q?S8EIxilvzOSeFpjkYeo+VD1rBMf5W+L5tb8gXMyTHBsVA0PUbjCgMRBc3Oi4?=
 =?us-ascii?Q?PceWJJhoc6NmAyKHQ8OqX+rbiaDWhjQTEKDJ9wgVYgMwz//JLOnUfkG9hGbQ?=
 =?us-ascii?Q?GU+BolLRikeWppZ7EHl98j4d/j8sTXmsgyi6fiAzgdNG+kUL4k/DSq+9fNCB?=
 =?us-ascii?Q?PxLRtO4kN+bnHK7TeHKrXb3pFiZth8KIh4302QA6vh5JDam4zLnBDohAy+s0?=
 =?us-ascii?Q?ekOseo/Cljid6S3OyQKg8A+33YKn1E2/bOKsh6X+fGmi5thFe4zHfOnjj1c/?=
 =?us-ascii?Q?faCqwWXGY6CjKV6MbCIEpbcvK6/UliGe8dqaADilAi/mXMVAEhTiEGw9SQtq?=
 =?us-ascii?Q?Wad4lMLAo4uHs9QgY6njckVlD44mr6K+AmI2xDolECBYXxLhgozU4Tk5R6MW?=
 =?us-ascii?Q?+12lTvtWVcQLBcIhfmGmhCXT5xMlyyTXCf0kMFrlzomrZ+0HQXR5f4ZQIIwR?=
 =?us-ascii?Q?xd86ERWwuImol0An/erg4jSa0hvabo+7Xi2ctNrYfetvYBD89i2SR8qGqRn0?=
 =?us-ascii?Q?9WqnXUvdsHuG78g0cuCZwZbSDvEU9ddlyJ1O0IMkagSJWVSfgC7Yen8mpXZd?=
 =?us-ascii?Q?V9cgdnkkf+C0fiONPo7sL7OzXD6lW/tPQXtnYGkDJz7XPrc1KIo1CZYAlUv+?=
 =?us-ascii?Q?HrKNIxetJJZIY0rdYSoDHRvH220ZRK/BpVXqyOQMPIunrY02Z8w2sjNzydN+?=
 =?us-ascii?Q?+wUNksstVskapadw1l7+f4CxqHJnSWDTfvrF/JS7GyCz7BRylibeNua1SDUl?=
 =?us-ascii?Q?e3MISsVHGwVpns0fxyD9vgRnaOavhCCRQ86stJbSljv5geUKizViaiYS0RCW?=
 =?us-ascii?Q?YyiZxGZc9Xi2CkG7uyq//i9ebo0rY1QBaa2Xh8Pg/S60PJoqlOJ6DbFaG6UV?=
 =?us-ascii?Q?31LaHKZ2Nxgn62mZBSulWVfJJufmvYNUGU7DSK6XZlGNRuppeyVnJcnyDd7N?=
 =?us-ascii?Q?DaQNXHPc8s5IbovtfMtM/tUN+xz1xRKzpw0886BEMfsKkhFfVp/DnEXzdJJl?=
 =?us-ascii?Q?yfnY31CI1dyFswYD3NxIpqNvMrqeimZ2/pU7GI5Enpegak7qEuXk8WLqNzkZ?=
 =?us-ascii?Q?SC91zmwS6LbdhjXiD73Un+lcBsFwFiaLbUtD21bDiJxbueQEnVhpo/cKhd/u?=
 =?us-ascii?Q?AgMUa2QhuxTpMPyVe0Fz3JI9Y7vsi9ifmqU4mFjgo4dmj2G9O4Qxn23Q4GLj?=
 =?us-ascii?Q?0YKpszsw5Eqs2L/ZB8IlYlgCyC42p9Pno3U7N8YBDxVW8GMtiGDsO/m6Q88/?=
 =?us-ascii?Q?txLpJ1c7g/SyksPPxSbHCHJ6qQdIcV6VjEXTR8EVw93jikJTUnEFtwPfMq9c?=
 =?us-ascii?Q?HuQE2iVODoXwx41nG/ze/aa2U5wgWX9w2xvS8ahM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360e223-4d63-4fd9-af6a-08dba32126c2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:04:58.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFQ3QdGK9I2PDTgsIHjjM1O0H+Lcca1cKUPGv/oqaM0QjCpiQn9ilKm0A8LJNygG6+aTp7UJCgSi4IobclTGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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
index f5598c5f50de..abd396ca0068 100644
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
index c678b484a079..7ebc2f87accc 100644
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


