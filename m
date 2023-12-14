Return-Path: <netdev+bounces-57432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08E81317F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B1B2184D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC755C23;
	Thu, 14 Dec 2023 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rhl2Q5uN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB63181
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:26:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvgRzXwq65YWfCadmXU1BvlRqXg7dZJVfepP96/fxsLNBchqB8i5AhNLixPsoauSXUhbluxVze9l5Q9w0Mvg+TAKF3057/g1lS0Im8jjEy1yKRzQugiP1gTMKRMVxqdTApsh290SARo5kujWj8ZhC+PLTYbtuvtrNQ3BXh5ujZB22aiPUitmnfqDo3Hl5mYGIl9Bt9M6YZZY0QcIBEm2yBdAX5wqxwZI0KCm7WR/XUqoxGl2Dywue+TzLLPBz/3nld5HK4MpnvpOpu0E89388zqUqY+sPLTJwQFgtyFE4TtwzV08fpVwJiHidLBhBpkysvkSB0brVF5zadfOYMJjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpbITRh8Oo5kQw0fMIuj35fMfC/RlkDt/f+lNYtysg8=;
 b=VLoC4wHUSO/r6iQg9oFiFlfLOaF/g4CosFDdDnMqiIvcWB3IFKRUnQCkPJyAxptOxOKF2yybDOMm4pGS1esaZabuEop6KdH2aaIfsY1sM4QpGPyHkQUd6Tk3mDYlLjMVWRUYvGOY8FPT4HHZPDdVLcajWU8VGVUbEcPEIYRNDsBcyUNaHftBtfX0g/eAV5so2NCigWj2nzhxZpYOWqesrGXm0mgeBByRSOSjQbn+bbHd6YAmbqD52E36iuCr3mlYBlRCK33Lfnjy1/HM7ijVy/Xl4Q3DAUhC89jB6QY0Hy05Piqj49NpNkgXJPhB/xJHzmg18WhnCU/3CTUSsYzE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpbITRh8Oo5kQw0fMIuj35fMfC/RlkDt/f+lNYtysg8=;
 b=rhl2Q5uNawOQCbWyRK2oWnewXwmJK1W8SNtp/U/8vhzhFj/V9PPrAmjuzLj1aI+vo80XMCryxj6EWAD1peMf7AW/KnsdUXGoYvucHz7IWbwKUB7lidf8Qb3jl+Ae92m6eCOY2JBQyvXDdbTZOub+zIKbFqmnCP0rxoVXxK3M2fbm66CX00yO4Lp5PZyqejn5V9uDbVA9id6tpR2N7GI9ic0OGgFVtqPPAT8n4mt8h89tpN4GlyDOPzYG4EKaugtG00kD/X/zEncgVmWuTcMS27PMy3DLEFzzyjadylN6Jgq8YvNWmwoQOv3CLX6inx3CzMKkpZcxR1aG+fOen39w9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:26:42 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:26:42 +0000
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
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v21 01/20] net: Introduce direct data placement tcp offload
Date: Thu, 14 Dec 2023 13:26:04 +0000
Message-Id: <20231214132623.119227-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: d695a1c6-b7e2-4079-b943-08dbfca84f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W/BCQPu2VNt4Y+MtsIVjOWgkHjlueHDbZR38vdKFVf95Beshb+0i2/4YcZGOUnVHDNC5loHhnZ2lX+BII0M3QFTjCh08GgV9ReubUV1NgSXTTeaQTwH10TbOlDNetUGD/X0XujBjRvu2o/YFvS9KWKIwctGvyVXYNGIq4A0/EqGhaP872K+cWKoxaoUIE18apLDt7roQjq4PxNdVht8UCJcuVbNaluLNzSUe2/MdUG56GvTsoyXwVVYg95sxMM/lH7lm5Sye0nlPLuro+UAGwNF3XSXUJ9Yiju0lmITtt7bhnKApInU/DOB5iOKC1XVprWN4gTbYk8jAYK0d5qb6YT7YZGw+VNHULrPUymf0/KqAFVg4c0FUi/zM7OQHCP+ZLiYdErwvFSb4khxsfHE9zNXjRDf1iLQ8oJj8jkmAQo+hO7zpKzm5A5TIr7/VohaquVyrCYOMlIC7mSjTytI9mDNOyZyO+aO/QrpOyVcjpLx0EqNfHd2bsfgnDgWdCmKDPgK2Ttmxl1iZlLYAgBD8OC/HrUF9i7Yb8EmuUCDP82f5BwI8YHEo41IQLQ1MSNRH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(30864003)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(6666004)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9JyWQ0mb0ZJXe6tehu2hcqXN7o10uBk3Epd7Ge73pf8zU0+KWUAO2GETY8k?=
 =?us-ascii?Q?/8OQ2k/gQIP2HI5u4qPOmRKe5kz29Bizt41T+C17tL8AMgyiAtw7wHOw3tGI?=
 =?us-ascii?Q?hWgFGy+1Uqd69HAIsPQyJQkhmitrSXwpA09qPBxW1Wv/5OU7j/lJHDI7C6Ne?=
 =?us-ascii?Q?RQUOtJFsyCCBt8zkzWNUvJvMlEeZKCBQvXNs8LEdFG1jpChxm0bY7E1BWh81?=
 =?us-ascii?Q?tL1FL53N6rm1tI2YUoY2bNoceSrecQP9XiSI324inxr57ocVaz8m1SIjeDn4?=
 =?us-ascii?Q?/zeEKgPS+wkmt0stt5uXXtc411b3rVjfv9TAQDfpaNGr+h5SApsD/hUfactU?=
 =?us-ascii?Q?j9J41eZkWkX5z8fHJE5+lofmtev4y1pP55XtLZpvZsdHXr8+5LpQ+fkDAwas?=
 =?us-ascii?Q?b0w0KuDwevTYANHOqREeoHPBiSZlAXuX/E1F3sbBX18bIDPWPbkGZssf2AWh?=
 =?us-ascii?Q?O6Q5mkjyMruAVKLKWbkXImVG7X+q1h9bCmc2Mrlb/W6QcSqhZB6N5fCZkeos?=
 =?us-ascii?Q?+a+oOFkJR9RkB2yfUHa8Rk20HkVMbMk0OO88W9sZZ8cAAhNXWdDgROtThUN3?=
 =?us-ascii?Q?nCz+CWOe27kMayxXT1S8sKr0mV9xM+2na3dLb0jGG3ShzWay+n1kGY4H22yI?=
 =?us-ascii?Q?SLp+hW+np4S5S925K/j852kEy4KzsL2ToWHq4u7r+mUHoL41X0wTOa5RSGT0?=
 =?us-ascii?Q?Uuurl7UPjmbpPT3Yg2aZLNyreq6nGhNUGD/cQi8ecCkGhWy7BJlb1EAmpfrP?=
 =?us-ascii?Q?dXsisROSIFUHuS+En8BiAXzQYMm6YfT4ctBIgCOHIFpTwYWTEBvHHCQXrH3g?=
 =?us-ascii?Q?5WtGcPPBHu6oLokF3G05xF3iSxdc3+22lZVfyjFhz857x6o+T90Cn/uf9rpD?=
 =?us-ascii?Q?nBZkBvDyjyxJH6pWWAmoFO3hyeNNfQEWORbl8kTX5h0JNeqDqHvQPWZyFugg?=
 =?us-ascii?Q?KT3gv0ef5FpgNq6+JaWIX9Kuv9qIrP/UWKut7Wg2xJrn0bSzOe3M4kfmBheQ?=
 =?us-ascii?Q?MrP3X/bKh69mMOjFXSxhrxMwee0ICLGd5tdEwIRKfMioEkgP5fgN72lVX/lw?=
 =?us-ascii?Q?4OZ7H2TLGXaHIddMjEl3fpaDqJQDrfsBLgJu+C3b+Z+DP0qZmRMam4QiGZPY?=
 =?us-ascii?Q?DaKCEiiodvtV9+legumAxgkV67aW22CCPtwhzDekv6rmG2k7YSb026/ShgIi?=
 =?us-ascii?Q?hknugoyFMfmg5kOlKdaNOokASYGvTSV8qX4MbsAZyQAvpIx0YB7/R/QJr7+r?=
 =?us-ascii?Q?zzr7j7hErC4Ca8BH8lzF5TlFTLcYsoazI9WAt/xNnMAZt74rWU4S4ctp78mY?=
 =?us-ascii?Q?+XfZuBGLmvqU7PLMuLl7qn/16XygfR3GrpbsQ9Cf6Z6bhSvP3VpQ/0ej/857?=
 =?us-ascii?Q?fuIKv6OKkdR3iB4NTm66tPxivDl5C1jgeMP2zY1X3GHu8YpHoLR13UXL8xWW?=
 =?us-ascii?Q?k82vEWfIshAY/hsyrvQF67gstMuPSR+PK9LgsPzvdPA1Vf1mlHVef+agL+hb?=
 =?us-ascii?Q?soHbZM7y0pNTXsqy0AlUpssE1NzPB9luk7CwB6R0j63eElhoSAnsiwhH5Qlz?=
 =?us-ascii?Q?o+lYl9VswduWdklZsr/F7z9ZksnUQf/a4phs+RrJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d695a1c6-b7e2-4079-b943-08dbfca84f91
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:26:42.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AyzTvCjz7NKqE1gU4ztcoDAFLK8DGXq96yr02W8L/4MYghnY2ztkp8TyyTkniQpvHcTCKFnLnpdziOT0FX7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

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
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

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
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  25 ++-
 include/net/inet_connection_sock.h |   6 +
 include/net/ulp_ddp.h              | 322 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  52 +++++
 net/ipv4/tcp_input.c               |  13 +-
 net/ipv4/tcp_ipv4.c                |   3 +
 net/ipv4/tcp_offload.c             |   3 +
 11 files changed, 450 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b935ee341b4..3ddabe42d8c8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1432,6 +1432,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1673,6 +1675,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b370eb8d70f7..f3c8ffbcbf45 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -822,6 +822,8 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1001,7 +1003,10 @@ struct sk_buff {
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
@@ -5078,5 +5083,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
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
index d0a2f827d5f2..583b7272112f 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -97,6 +99,10 @@ struct inet_connection_sock {
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
index 000000000000..5be527332799
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,322 @@
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
+ * struct ulp_ddp_stats - ULP DDP offload statistics
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
+struct ulp_ddp_stats {
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
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
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
+ * @get_caps:  get device ULP DDP capabilities.
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
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
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
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
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
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
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
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3ec6bc98fa05..0ecb5c1fa942 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -517,4 +517,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
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
index 821aec06abf1..c135195005f5 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,6 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..0b5561f2ef9e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -76,6 +76,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6606,7 +6607,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..658e67620c0f
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
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
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops->get_caps)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7990f4939e8d..ff211976bb37 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4789,7 +4789,10 @@ static bool tcp_try_coalesce(struct sock *sk,
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
 
@@ -5359,6 +5362,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
@@ -5392,6 +5399,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
index 4bac6e319aca..3c169094004f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2054,6 +2054,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    tail->decrypted != skb->decrypted ||
 #endif
 	    !mptcp_skb_can_collapse(tail, skb) ||
+#ifdef CONFIG_ULP_DDP
+	    skb_is_ulp_crc(tail) != skb_is_ulp_crc(skb) ||
+#endif
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
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


