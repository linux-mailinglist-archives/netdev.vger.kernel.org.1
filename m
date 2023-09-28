Return-Path: <netdev+bounces-36856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7F7B208D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BD519281B98
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5D4C853;
	Thu, 28 Sep 2023 15:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B84BDD8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D8F9
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur2a+BIjEj3GiN93Wa6FXFeoelx9oMRPU+ONQ+cw5C07nQTQAbUsdJ+Sa1A4Uv5VBNc6pUayFwx+pQEkL3BH5hJDwPQv5KI27jnhPPK3+UCKJuLURhDYrO1jRxI6wbLm1dMD0+WXnS7eBG48dy1/xJGECVgnoA4Gwu9KTNca8+p2Eo8A5hNU462AVhpV3Y1YZCIjcpgEC2oKoQmXnVYq58WlXOJemxlQ801V+7JrmTIA30ayOWNYyAjnRQwDap0MOZgropaBOpZ+buEneDPbURQbsiL0bj+SHeX0KCP8WDndOlsh0iBaZsK8esXXP3gO9K4fCCq5ecRjybp1vrLiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPBkWtHhL4JxqndJd7mnXs0w2/zR7npCoTnp2rHL0Ls=;
 b=E0qQAxFhIuoXd8XEVq0VKMr164aYmcHRTJF0dRaYbYyKTjF/Tped+g1bpD48JLvph98wVjLgGkrTpY9/rHJ3lpGwbarQ9Ij7huIFPC9MP1Knn5vYVmfy9cFV25uMm7A5V0uIRjTwki2CbnYvVokqptIH+MCH51zbYoPwLf0VzUMGp/YDKpj4liNHV0xrRnMoEBQ7Fulzd6/TDW1ym9/z329+L7wdmsAiLDgMjTaI/s8AfxcpqH0isNLmajO1GYcTkO/McZGM81+Tl1Ib4CT8usj6kY0Dwah9aoLNr7ZMOqlMicdqHimUg8p9lLpNpgCTR7gcQj3wWaoR4ePp952XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPBkWtHhL4JxqndJd7mnXs0w2/zR7npCoTnp2rHL0Ls=;
 b=c5ZVWCRdwwcFVXYbLGNn0Gq3WZGCR2ZJa9r5c56ztMzyFIu40vVLQUsSGKIFt256KusqnIeAxEycWzA6/JVCkRll93CAz7mNKUUIeVQ5dhFwzWo3QOwp1w2rQGcDQ3WOXcYeNTqIcaeRu6+6c0/Hs63Tc/lYeonIxKsrWbrO43ciyIiIoGQYhVQlY+xqBGBBLjlhlZKq8IrcVj/SsvjY7Rp3tvzt3EJz6BcQfRwZ0wQ/l40xRKakdA0y+YBgDXeljszujjQ/ID4y4ZL5c+WfEEEKp4x2ACLU2uZW7d/jBeKWq8IiFoZh7IZsqemPEXhGgxoA8hQ0ZjWkFe4HTqePxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 15:10:12 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:12 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	imagedong@tencent.com
Subject: [PATCH v16 01/20] net: Introduce direct data placement tcp offload
Date: Thu, 28 Sep 2023 15:09:35 +0000
Message-Id: <20230928150954.1684-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f23f95-fa76-4e81-1b42-08dbc03502d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0KHWWjMaq61dS/34KI7PxJjoXiy4eOTo81fv7aNa1RnnhnPpJGiaVhNbgIHkTPrnm891OGCdOQkNLqd23aHXVcEmdAPCrIGOtxgpEPSCXCDo+DMlzqeDuc+/SoWjwhHcU4XnRmYvgPFo0uXsBdaTeOwPgyOXy8toYgjmhINTjZg7/4UCoBmSgWjTYJx0I1pW37E/PnayRQZw44zo+QcBWKuJAwiMJxhJCbpNcEm42Y35q4+D3eMajLVYrdCMb6Bmwi1tQppY2pNPUyeUb/yUpgDQUDy7HkuVciQ8l6Emp3x8bYt/keoT4XntiMyjoW5wpnGrKH3TCwaqP0Ad8ulWkmVeAGyAKw4I51U5jpsotHPhUAI4NRkU3sa+tC4Vb0KRqsXNMhQnXCQhubJxh7LUQkKIC5UJzx+zfHlVtdivbhs03e7TNf74lepwNbDn2dvRiZYfOL7lNfPfq0Q/yuXlIC50aHm0RqiBKfuXjc3u9ZHeFJmo4BhbX7cM/oFDJ11rKx4CBtMjztIqynvda2pH14JIgMSUq/2PaBJhYHV8XLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(86362001)(30864003)(6512007)(1076003)(2616005)(36756003)(478600001)(6666004)(6486002)(6506007)(38100700002)(83380400001)(26005)(7416002)(8676002)(8936002)(4326008)(5660300002)(66476007)(41300700001)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7X59IKuPIAm1HvszT9W4vx7RmFCg2r+6qqjTOM9OJZ1lBBKh2WAV8GIYTDgo?=
 =?us-ascii?Q?QGJOkUh9n2XiW4ZQ3U2G6eDYiT0nXIDY1r7+6l0HmNlq2I30/jvPB5qwpyTF?=
 =?us-ascii?Q?NQ5qeff+BpRT1WYR+kvuugio0kS5spcN0Ruow8mMmS30qMETjMMUqsg5Pl/k?=
 =?us-ascii?Q?Uz4Y2hPcBuCqmqYnxcK66Atcs0OrA96Nv64FR6GcfoHY+T/vMKFNprRuPrBv?=
 =?us-ascii?Q?JHzBwhr5wRU7n0yeAQrLGTCTYw9IPuXhjsUkFgntlOCDBkfj7ZjlSSp7k5KD?=
 =?us-ascii?Q?YE0oiqPjh3GX8SJd5UxrkgC7d46Vpz1ynjgWxVO0AlfWK3/aPXtZ87Rgsa7m?=
 =?us-ascii?Q?oYVrKh6KnleqOegb8ddjQJN6/XWQYU8ISxG86mZOT6StV0n5DqAF0EXqaKly?=
 =?us-ascii?Q?CgzWVAPo6UwDz7HKO9gw/vrH2bTlOHKJBwGMppvjJFgDa+5vR8gmI2aqQgQB?=
 =?us-ascii?Q?Fvoqt/ITG0BdTKYRYh/0cg2OdnKy+VG8tJFmdPJWcCeW0XgYDyZprJxZ8uUv?=
 =?us-ascii?Q?lp0gUg2hQXvD0P2eTn3TPyW8CZDu2GoXVZqqoFxRV+D2WD7V8ObVc1rJS1Yp?=
 =?us-ascii?Q?PxWx6GJAmKMGBV8lnnQ4evQyUca+SrIwF7cPJuDR00uOEQpWkekWGh0cDkhY?=
 =?us-ascii?Q?ZBN7KhvJRJIDnh6eEkU7pdu5KCofRY91LCuudCF1l021oOHloUEqtTCyy4LC?=
 =?us-ascii?Q?Qqn5VnvmEwKIBkUXiwh4ulE0nWpkM9v3LEreXrjtu8EU0o+iQHSXs1NWRUub?=
 =?us-ascii?Q?/FkwWZqAxkJWuTrQGbnogSBXbPXHmYyQEBwm/LIngpqW1dLfvZoHCRjhiQZM?=
 =?us-ascii?Q?Dk4U+8KYgWGYL0w87ck+VWEeYKRqBtJsDir7TrPTDYiLy0K2woEF88V8IxMF?=
 =?us-ascii?Q?btcBNyQ8MSM65BMX2jlyARAa3U6u3w7XjJDSs+mYN68A0JV2hsCq5Dpf6/FM?=
 =?us-ascii?Q?ECS4OfQoPiUHb1w5Jk6puhcfMHneNs59Ao4CjohJU5DEt2GfUwRLDPCesR6B?=
 =?us-ascii?Q?3ckrwBUoaDiemafjAgNFHlt/KY61ndb1XPD1808ONxja9M15sjDiBmL/XQQj?=
 =?us-ascii?Q?dku+azungI0razSrKo/o3iTlDUY2bXKAsYssOSDHUly8M7jUvs/KlI/0WLCA?=
 =?us-ascii?Q?QKjNIw8KWJfDPEUp3eC3Jkn1ARaJ1m8ZMc6u7nLFbvclQVYhudeaBR0A2QWC?=
 =?us-ascii?Q?QVHJilGbcS3GxKURW4NAz3K6K4O+ZPIcOg4PDeZ380sFrRI32BX1hdAULiws?=
 =?us-ascii?Q?mSPMQ/xfaTTD2mQQR/1l+4MQnluXqEGL61S6zIubmreFiwC8zw4kx8NtrBvG?=
 =?us-ascii?Q?0evoGsHtvM53BhZuIPobsBhea+L78EcCUBaMbUtmAxF/CZYjkEI5FRy4Kltb?=
 =?us-ascii?Q?qNDR5/OL6o9ml25Py+WfDPD37jjYkbfYMWf1YXCIsGBEXly3UmhRS79zGr9p?=
 =?us-ascii?Q?N1vtDGs7ijuEuTw04iLo7lnYoHEvORf2xtcInu04+ZgNOS2IDny2m1zCzvSS?=
 =?us-ascii?Q?/vGX2SoK35qyTRVU+GbwGDaPelVPNtr0nnEL2DHyZIb9K4dgfiBDfC0SGGdv?=
 =?us-ascii?Q?bhaRA8Trx1nPOokO4k+GCvUtvO7d5NfT7pZF3HGa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f23f95-fa76-4e81-1b42-08dbc03502d1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:11.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BQ1Oe/YORomTUOoxisF0vYB3UcSJ+FSFOjxe6aOcvQkJtW/PLMGfeJ5TpP2cNVfkcYmsIbfGGb2M7SttjRZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |  15 ++
 include/linux/skbuff.h             |  25 ++-
 include/net/inet_connection_sock.h |   6 +
 include/net/ulp_ddp.h              | 295 +++++++++++++++++++++++++++++
 include/net/ulp_ddp_caps.h         |  42 ++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  71 +++++++
 net/ipv4/tcp_input.c               |  13 +-
 net/ipv4/tcp_ipv4.c                |   3 +
 net/ipv4/tcp_offload.c             |   3 +
 12 files changed, 494 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/net/ulp_ddp_caps.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c..c4b79629af2a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -53,6 +53,10 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp_caps.h>
+#endif
+
 struct netpoll_info;
 struct device;
 struct ethtool_ops;
@@ -1409,6 +1413,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1648,6 +1654,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
@@ -1819,6 +1828,9 @@ enum netdev_ml_priv_type {
  *	@mpls_features:	Mask of features inheritable by MPLS
  *	@gso_partial_features: value(s) from NETIF_F_GSO\*
  *
+ *	@ulp_ddp_caps:	Bitflags keeping track of supported and enabled
+ *			ULP DDP capabilities.
+ *
  *	@ifindex:	interface index
  *	@group:		The group the device belongs to
  *
@@ -2118,6 +2130,9 @@ struct net_device {
 	netdev_features_t	mpls_features;
 	netdev_features_t	gso_partial_features;
 
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_netdev_caps ulp_ddp_caps;
+#endif
 	unsigned int		min_mtu;
 	unsigned int		max_mtu;
 	unsigned short		type;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..700b2096d0d9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -810,6 +810,8 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -989,7 +991,10 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5063,5 +5068,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 5d2fcc137b88..daefa3771b66 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -68,6 +68,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -98,6 +100,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..68a849727ccf
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+#include "ulp_ddp_caps.h"
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ * @queue_id:	queue identifier
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @io_cpu:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     io_cpu;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct netlink_ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct netlink_ulp_ddp_stats {
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
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	int (*get_stats)(struct net_device *dev,
+			 struct netlink_ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(const struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk);
+
+bool ulp_ddp_query_limits(struct net_device *netdev,
+			  struct ulp_ddp_limits *limits,
+			  enum ulp_ddp_type type,
+			  int cap_bit_nr,
+			  bool tls);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_query_limits(struct net_device *netdev,
+					struct ulp_ddp_limits *limits,
+					enum ulp_ddp_type type,
+					int cap_bit_nr,
+					bool tls)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/include/net/ulp_ddp_caps.h b/include/net/ulp_ddp_caps.h
new file mode 100644
index 000000000000..a41200cf6664
--- /dev/null
+++ b/include/net/ulp_ddp_caps.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *  Author: Aurelien Aptel <aaptel@nvidia.com>
+ *  Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_CAPS_H
+#define _ULP_DDP_CAPS_H
+
+#include <linux/types.h>
+
+enum {
+	ULP_DDP_C_NVME_TCP_BIT,
+	ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+
+	/*
+	 * add capabilities above and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+	ULP_DDP_C_COUNT,
+};
+
+struct ulp_ddp_netdev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_C_COUNT);
+};
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#endif
diff --git a/net/Kconfig b/net/Kconfig
index d532ec33f1fe..17ebb9b6f5b7 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -508,4 +508,24 @@ config NETDEV_ADDR_LIST_TEST
 	default KUNIT_ALL_TESTS
 	depends on KUNIT
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 731db2eaa610..09da9ed3f9ff 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,6 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2198979470ec..e7d568a4f57c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -75,6 +75,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6592,7 +6593,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..61bc3e73c1dd
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.h
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	dev_hold(netdev);
+
+	config->io_cpu = sk->sk_incoming_cpu;
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_query_limits(struct net_device *netdev,
+			  struct ulp_ddp_limits *limits,
+			  enum ulp_ddp_type type,
+			  int cap_bit_nr,
+			  bool tls)
+{
+	int ret;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops->limits)
+		return false;
+
+	limits->type = type;
+	ret = netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+	if (ret == -EOPNOTSUPP ||
+	    !test_bit(cap_bit_nr, netdev->ulp_ddp_caps.active) ||
+	    (tls && !limits->tls)) {
+		return false;
+	} else if (ret) {
+		WARN_ONCE(ret, "ddp limits failed (ret=%d)", ret);
+		return false;
+	}
+
+	dev_dbg_ratelimited(&netdev->dev,
+			    "netdev %s offload limits: max_ddp_sgl_len %d\n",
+			    netdev->name, limits->max_ddp_sgl_len);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_query_limits);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 584825ddd0a0..3bf1daff2c80 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4700,7 +4700,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (from->decrypted != to->decrypted)
 		return false;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	if (skb_is_ulp_crc(from) != skb_is_ulp_crc(to))
+		return false;
+#endif
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
@@ -5269,6 +5272,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
+#endif
+#ifdef CONFIG_ULP_DDP
+		nskb->no_condense = skb->no_condense;
+		nskb->ulp_crc = skb->ulp_crc;
 #endif
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5302,6 +5309,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
 					goto end;
+#endif
+#ifdef CONFIG_ULP_DDP
+				if (skb_is_ulp_crc(skb) != skb_is_ulp_crc(nskb))
+					goto end;
 #endif
 			}
 		}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03..fb6ce5c7d073 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1868,6 +1868,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
+#endif
+#ifdef CONFIG_ULP_DDP
+	    skb_is_ulp_crc(tail) != skb_is_ulp_crc(skb) ||
 #endif
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b5..56705fbe6ce4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -268,6 +268,9 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	flush |= p->decrypted ^ skb->decrypted;
 #endif
+#ifdef CONFIG_ULP_DDP
+	flush |= skb_is_ulp_crc(p) ^ skb_is_ulp_crc(skb);
+#endif
 
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
-- 
2.34.1


