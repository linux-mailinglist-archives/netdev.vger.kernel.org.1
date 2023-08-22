Return-Path: <netdev+bounces-29660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FF7844F2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C41C20A3B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE01D2F5;
	Tue, 22 Aug 2023 15:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B71D2E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:04:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742D3126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLV1kduBLS594fj4A9uraUQlFyBTJ+f7vR0ikT4cvwEMgMPDHj0tb8mZI7OGXiDPbO67kqUmiwbkGoOrygN8dYqAP5hLX8UWGrMRf+0VSVJIWOfmetX+RPfwkuAJuxVoVy3nLw9otjc7Ma/qmu4fju08dwDbErBUNMbfozEzTqSr98BMXkUXfg1yoHXqAZ2An1d5PIIEc8yyxH1RngPqaWHI47WEwl8vZeNk+9Fs89evQhWAIK8fodvkTvp/RHUyUU8XKA4SNjqFBG4PWyMnQ59nIXBzJXbrgg7CTmY8yMuw1zPcshgXRHoISyCyU2QGeb6E0TuDfGaMivDUGrwgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNoWCgEwkncrOue8rFja0CKoXQtmTBjVxyiB/UV1UGc=;
 b=gWlaZ7J7k+C11MXOXStNpODbjqaO+aTkXZaFyawwQ0YNilydKLKVNj8fFp1oNZeWSSyUVKzZVP3XfFO7uwFZQ6VLS6fnclukTuJE+iXGTSHYxKZA+yB0VUUY0M1V+H2fLYzjEC2i69v/n7T1xhquM4FZe+UmQMCIOIaFcxNdNQQDXMI6Qu+4Rg5lAxddslPRHI82mN6pL/UVSmgqHTRdQhlIM/XelIR/QRhJ+F3Bd6bR0ZlFOnp+F5ZK3LmVqknjGdSkTLbFtkd2rB2m4zOJBj1OjKSvQJYe+qWmH7XRQWxtlXID/3BXB4Ces3DxX69h1a96APGZdDIcvqmNeR7OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNoWCgEwkncrOue8rFja0CKoXQtmTBjVxyiB/UV1UGc=;
 b=X84sj38EY5E5F/Rf6NkhPcVgqwBABPQB78LeGuX61wA7mP2RHq5UQ1e9uZjkI0FPscSDpT5thqtA+jc5lRaioZucDGblzgwgywBIUYOV4PfPXFdEHRsDGbUIGfIiqkIuj9Gj55MSJM7tIBeNpQmVsTKh+sKa8I6vunrkh8UNI/9RgNuws7bOccvaJAkFOidjtCrLtT9ZnZqQm0WBK0r6B3H25zIc80AfzNqsS/IXQRiABH0u9f/nnEJ1nUpOJ/oJk+ZX6zUP3q+5SZcdsYJKkMNTwXH2EMkJfq0Kv/ey3mCMKYj/xr+CyEW5bVw4x3wstHH5vQ4DVmP2pwrIpBkbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:04:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:04:51 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v13 01/24] net: Introduce direct data placement tcp offload
Date: Tue, 22 Aug 2023 15:04:02 +0000
Message-Id: <20230822150425.3390-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f167e16-e023-4708-2482-08dba32122b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SfcCyDOgDDn2WfrQuLwcseOKoZdJHJjiLFq4UGoI41de6UtvJTZfH4yxDtXsuh0HUCqpG/OZtv0/eJxp/xXpdIAyadQZeFzUk1cJh95ngYaqbdtMddShakx7v0Vud1IYPCmAmt+SRfvKKYbyNyW5FyJNjkvAQPKpY2BTEHEav81z9smq7LkDxSMe79JUwo9zybsTSMc4CI27za1djem1DYJPUgoxX4dNFCsq1jLe417rSXTkQoEng602OaSMlURVdXba7XMdU72HYRLC2aedvNwCS5lx7t2Xqf4ePWr8F8mx4/WlSgxW0mRiB71YWqvbILkKnkOWRCKAOdkKvjN+GOE1KhHvj08wgLFzSDkdgiVpy75iq9nhAhEcrseNBd+Kr6HBBFNEFmtsDrMYuG1TbjiZIF2xwLuhngpk5yDkj1p6rDanv4KzOtqzmS6Ep3ITq+DAaJiifbwcP0fu7oAFKGXBUZvTwsm4U/UnKru2aZxJrxrmlr9TtKudlvoZLdejjfLl5gSgCMi/KH8HsYpI8E1ZNfEMt0ZrXogxUlUQBWcxS8Ih/zcBzLTsb8pBrKaC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(83380400001)(7416002)(6506007)(6486002)(38100700002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(4326008)(107886003)(316002)(6512007)(66556008)(66476007)(478600001)(66946007)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+y6LcJo/IiTsQziHJ5mVZUtPNDVEDIwQteM5af6NKMh62EkKXyvyv6H3l4w?=
 =?us-ascii?Q?Q0WTljdwF2zphFb7gQIj+qMr6xZlcOEW/puwuf39REZyooWoZRcdilYEWapb?=
 =?us-ascii?Q?cjw6eT/zeBe4gXalSru/ay9x099RWwX3YPDEbPQCQPTsL05r9nkwzCK5yrZu?=
 =?us-ascii?Q?eZf3wEzlZt5VuMNJohCScS7hJ0KrrvIpZjsuZoIoTQ23wkQpdcdqXQVNezRC?=
 =?us-ascii?Q?00UqlsbjDJvGEZ6fQI64HYdxCgOviZhgHylVMhcIl49bsxNBGisE7d1C08c9?=
 =?us-ascii?Q?4anCkax3t9sYInGVWFWyOnqSX3NplDMEVEWwe4U0U8PL27ytECl+5bUr6j92?=
 =?us-ascii?Q?RCVA/bKYSjiujMHDKBn1x2nkJkuZQXJzeGEuoMZ0jFZ8xqdNUUyEQHVM0CfX?=
 =?us-ascii?Q?L1Jgw3iObWyrNtdHu5c5XGXT6fiIKBM9UatnL2B/rm76Yfso7t9KyFp2/q2S?=
 =?us-ascii?Q?SI2yw/XIdsHsr5Hp6ThPCjiO1b6oUMkQ92STWK91Xq+pHRc2GYyUrIHuIEPO?=
 =?us-ascii?Q?F9EqysrGtIGI4ZKufZT5Qo4ssc7jRrg2cJYncb4X31aeo5L6vFwf/BcPlp7J?=
 =?us-ascii?Q?uAgpGZbz/4t9OCmvBqr1q4Qpxe/VzsJ+dwB/nXDu6rMihfxwjE/79BzASWgo?=
 =?us-ascii?Q?2dwzH/PnIdFvKWWuopiCZEL+4XAAfzREzPIRgbLbzVbjVGImoOqCNVPxzAtj?=
 =?us-ascii?Q?sU0y5vBaqbhMoq2lJcAoeuOTxl6aiKudOwa8Sue7+FCohYEOeYwicBkdkFPb?=
 =?us-ascii?Q?jcJMr/iu10O7TwrDyAKE/l+VhJboEsAi3drN4n/Xh0ES+mjO2vh/rNQNhzaC?=
 =?us-ascii?Q?o2HXmPxNqohHkAQAhzJzik8o/xpMbMcusCeHiwB+ZKSihh0hTgtqDIiBAXwa?=
 =?us-ascii?Q?24Fkw3EG59KFLho8B7a9LvhQQTh3cdj7qydN88I2jXOQRSgTJGi1q+YrFoNv?=
 =?us-ascii?Q?5a2DTQSlImnKtyKfNehCmceCpLWlvMEhlcThuhuWSv2Vt+3cSRi4YACthJ4j?=
 =?us-ascii?Q?yeuSxZpIrQIO0ePF/77o++ESQV8ZjdQYs/dlFH9VjPsMTk4ePLITmW2tA1Li?=
 =?us-ascii?Q?Yh8Sq691kgT6u+fyt5WrxeoCHfU28o6z4nul+lF0ae8XArO3xnfOF3zPBANe?=
 =?us-ascii?Q?+QcTBR4GmEjf2I36y3V9kg2pBJPR2oKe666Ar/x3dtjvu2r1B0m63BnQaZLg?=
 =?us-ascii?Q?VWh3rhoJTJcU9I3zFy0fINdJRDLRFir1nbAxequmtfurGZJg3YDMWRKZc1dY?=
 =?us-ascii?Q?lUjr9uWaIKVBjFSq8ikhz72knxQjUUB+aoNF25QCa78gX59luA/E9vRv8y5t?=
 =?us-ascii?Q?jtiPUFySyDHbM/J0a6LgfC4yg+e3kRp1QENBxGhSNZDckP7PtoYLd2gCx16g?=
 =?us-ascii?Q?fdxc3EBnIFpFWihNfAM70gyuSaeRqDu5NkIH9k+CBLNCfZsOHI22WXOWKbf+?=
 =?us-ascii?Q?r9AE6LnBnFxCF3jOyIT62I0/tfiKOwE2/MMFCSje9fT4gUdIndNRssD1/EJd?=
 =?us-ascii?Q?tQN12r2OKDN9Zio/NcfmZ0oCjF3AfF8uVHtHNMIeiIyosg3uMoQrba+5CVk7?=
 =?us-ascii?Q?W3k82zniVcM1g41UzGSLtgkuDSUxuTA2TZnDm+6a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f167e16-e023-4708-2482-08dba32122b8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:04:51.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJ6u4fRS71HI55g0JXnXN6ITPy0FgMRGUbtygWqK+ivL2/LdRD/TC7MCN7OS6+/6618GN2PHpLaZmpxMFy0H4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
skb_condense, we mark the skb->ulp_ddp bit.
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
 include/net/ulp_ddp.h              | 262 +++++++++++++++++++++++++++++
 include/net/ulp_ddp_caps.h         |  35 ++++
 net/Kconfig                        |  20 +++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  70 ++++++++
 net/ipv4/tcp_input.c               |  13 +-
 net/ipv4/tcp_ipv4.c                |   3 +
 net/ipv4/tcp_offload.c             |   3 +
 12 files changed, 453 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/net/ulp_ddp_caps.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..04255823079d 100644
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
@@ -1406,6 +1410,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1645,6 +1651,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
@@ -1816,6 +1825,9 @@ enum netdev_ml_priv_type {
  *	@mpls_features:	Mask of features inheritable by MPLS
  *	@gso_partial_features: value(s) from NETIF_F_GSO\*
  *
+ *	@ulp_ddp_caps:	Bitflags keeping track of supported and enabled
+ *			ULP DDP capabilities.
+ *
  *	@ifindex:	interface index
  *	@group:		The group the device belongs to
  *
@@ -2112,6 +2124,9 @@ struct net_device {
 	netdev_features_t	mpls_features;
 	netdev_features_t	gso_partial_features;
 
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_netdev_caps ulp_ddp_caps;
+#endif
 	unsigned int		min_mtu;
 	unsigned int		max_mtu;
 	unsigned short		type;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..75558f0ddde8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -810,6 +810,8 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *	@ulp_ddp: DDP offloaded
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
+	__u8                    ulp_ddp:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5063,5 +5068,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_ulp_ddp(struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_ddp;
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
index 000000000000..e162ac9c3d18
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *	Author:	Boris Pismenny <borisp@nvidia.com>
+ *	Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
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
+ * @dgst:	digest types enabled (header or data, see enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ * @queue_id:	queue identifier
+ * @io_cpu:	cpu core running the IO thread for this queue
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+	int			io_cpu;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
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
+struct ethtool_ulp_ddp_stats;
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
+			 struct ethtool_ulp_ddp_stats *stats);
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
index 000000000000..8ee964a4df78
--- /dev/null
+++ b/include/net/ulp_ddp_caps.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *	Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *	Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
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
+	/* add capabilities above */
+	ULP_DDP_C_COUNT,
+};
+
+struct ulp_ddp_netdev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_C_COUNT);
+};
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old, unsigned long *new, int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old, unsigned long *new, int bit_nr)
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
index faa6c86da2a5..9fb81e6ebc29 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -75,6 +75,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6584,7 +6585,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_ulp_ddp(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..de016d1aa5e1
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.h
+ *	Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *	Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
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
index 06fe1cf645d5..e7d395d02682 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4686,7 +4686,10 @@ static bool tcp_try_coalesce(struct sock *sk,
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
 
@@ -5255,6 +5258,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
+#endif
+#ifdef CONFIG_ULP_DDP
+		nskb->ulp_ddp = skb->ulp_ddp;
+		nskb->ulp_crc = skb->ulp_crc;
 #endif
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5288,6 +5295,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
index 2a662d5f3072..286e2988b797 100644
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


