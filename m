Return-Path: <netdev+bounces-32244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D5793B59
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452B01C20A3A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCB6ADE;
	Wed,  6 Sep 2023 11:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865C6AB4
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:32:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1B1992
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkFfcCKEc/KRGUjIeV3u4v/d3U4fABcFaTUWK4eyflQ887+JNKmZWkhzTHBeL4jSYrvB5/yv3XmPfvXqu3sTIgfz8cpIvOCmwX4isbTEq2HRCDVKHidFuxd1ZZ1HhBHVw2IoVYoEt98m+6XFIAsNR2UWh0LZKAozifmLSk4nInJv2SbByjaj49nKBJLZAAJvQhc7GwyK/yh7NrQEUbWPRL/3gUpkILu0H+IqXta03o81nP/v17lPndcZkKPlTNu5yHToMVwsEm6mF7agF3RGcbwqQ0E5JTh718B34ITg2KyxOffNDWoVNU9vrPIVMWtPfCO5ace0E7TaZvropgQzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWuUDZqny20+lZjfc5EnOzyYvtEQpx4rU8cflfXou80=;
 b=DUWLPK2/yme9Vl+fGEo+HBLt2aE2sB9ZzBLYW9nvOmy+SpAPCy9nCDRo72gnMv+cd7+y6YlsfJJCtxvx8IEp2hQ9Bzj5irsRH31xsES7uLAWsoaxUicRTRPC14C5Mmlfb2rgsuSh11LaBSltwqnR/bnfZQmYOWKeh+zn+KBsDcqlKdPXfB90CUkKpkt/i/GOByh9dMvmzW6QCDmspKSwHqDGc/ZIH/Rn7L7K7CBY9HvtTKsg+Ww3QwU9spQLWpZn7j3uSiQAUs6ExegaImc5KRC4OWi/VcH6FCHP/K5yDm21RUv3rdD9Yjji5YsXN++4xLedaqPFNRva+zrMd34CRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuUDZqny20+lZjfc5EnOzyYvtEQpx4rU8cflfXou80=;
 b=GTmHIRNu6cWmshHq+KeBXmw9uPZaGprvi98Kjq/PFwmz54W+LQ+YRxc0YRn5ng7nF0z6PYaPCYqUw8f9jMlsY3RYH+SihwQ0sFuaNO6WS/otpSPRiBQpfMZleUL4GDR8U7cryeOq6U9O04ov08drux3t0DMjbOqPv08yQ1hT1yl3vltlpfGBT0UZWLBBgo1gFwhFmVbFETif2OUD5Bq+wFq9rphtGVh+YMC5v1NTOAZ8AS7Wk9EKmRULBZbvNc/jw3GXn60r/qrIPt5jJzuaxKefyN5NBcqnuXORYHsbPVJ+unANlmL+1y3I3Pm7Axq1Ed445TzyP0pm1K5oSTXXHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:30:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:30:58 +0000
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
Subject: [PATCH v14 04/20] net/tls,core: export get_netdev_for_sock
Date: Wed,  6 Sep 2023 11:30:02 +0000
Message-Id: <20230906113018.2856-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: f6728e50-5750-4b71-5571-08dbaeccbdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rkUMz7+7cpN+jl/zS6DLdApzLRlzDdd37LL0RbYE90CR9/Vhq1wFfXCY7KbMCG4QhxnHb1dqxLQi8W21cYID2woKoCgam9zr53lmAJMf9KMrqEYXfmUk0Aml9T+QCCrlevy8oeekrwEl0zMpVZKdeXLHWAd5PikCiyBJJOEVeeWLG1GnPojOp4EyRarqfeN/PX1vFO8EZG9PUJJb166ja9qteUnH1BYn0PlbG/cZ75DOcZfsEV5SM895ELNwoQ7Ys8W9JzH9WsmKmgOu1GINqDUno0W3OI3P654SW4B9ZnGuKB9Q/dXGNeROA2bNd/onag/QSfKU4RvLWbTjcigcHWtwEICPKylywJMl0Nag1AKsrN8uqFzWB6ohUd6+U60c2ws49N/4wJOzz6ZYbHrntVvUSIeWChsHBLJ47ybX4lZddRfPyxVLdwgCwN0mjvYwEArQV/Ltmus7nL9slNBIWlV4AYg9UG1Utyf89RPQElcB+10CNeU2zYZ+bT9CyzOBdCV+/4lu6VJS0CymGHK8yNeURPJt3UpaJl7uelAOyn7B0p9yfUyWWttzK7XgnCNj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(6666004)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZHlMhTQ4TfkI6xThM3FVOTdi4KG3EBprPgI8XhuIHeLdr9bS5/bf9C3rSfy?=
 =?us-ascii?Q?msVeT+tlOjy/9NfP04RSSGNUDIUB4Jbnat4ql1GjhqYaGmyfKOh9Kr8wGbor?=
 =?us-ascii?Q?15s6PDQg+4j4FLSFavb6DoDp4Ribj9DNcpbKzVknEbjzf/qKWdZshb1zoIX4?=
 =?us-ascii?Q?GZqgL/UI7m/oH6suzrkmsZI84YPVbL8YcWOTwWi1U6sQrDGmzCQAlBxbWEu/?=
 =?us-ascii?Q?H/epNjFIlCP7ajKXyarO9Elnc7dBzVBlAoEmNYWkrfrzjBljzt24ZuxLlbyx?=
 =?us-ascii?Q?o9raLL6ew0dJKAEqb2seZzvxDA9lxPsbpopSCxChvWx55STbvHv6SxTLAKPx?=
 =?us-ascii?Q?od+FvTuCPeGJXNQHOUcvbbNmEh7c5QRuisP1I9lJ8mB+JmE1iP11zpXr3d/M?=
 =?us-ascii?Q?q2QsvPXEStJVVXD2P38CDrWdRBh6LSPlcP763Nw4pPrpUrvN+aOP9Zfh1ys+?=
 =?us-ascii?Q?al8eKdgvA9RxI2MRbxw3INmzkwTNrgYT7+ltiToKlvYIBV5jCGNHJ30QTcNg?=
 =?us-ascii?Q?VF/T10lctvecrBI5l7L0Mv0pygAJGcguDDgQMq/M2nsNynPg2Y8hiGGiE2Qq?=
 =?us-ascii?Q?j2yEBiQetHavLS3huGeOkhiPIhMbNgFTTS9OYrZqD+vCJAYJCOMVP7GGH+xt?=
 =?us-ascii?Q?FHjsWxHePg8woxiqO0Ada/OomcGQHk+x6EGisAKO6BUIU9AxPNhu5e0gVgEl?=
 =?us-ascii?Q?aZ/Rm1jGyxlIw75XunYN4GnNy7/VfPopAguzvDgWYf3mvchU/IXCCGj2peUy?=
 =?us-ascii?Q?s2dA/mhAoDsfSPLu1VW+e8kAiop12zR4PfCk0+/nQDLznDlI339EATPRbUgg?=
 =?us-ascii?Q?eL92xiLXrrRynA8GHs/tQGQGhfqDK2Y2dJ7/tBARzHNc7ccIeL0g6YsfHwGx?=
 =?us-ascii?Q?DH7I19O9RyKp+kIJIK1OT5XNsbQRcqtysCaD6/seTpFxYBGmKoFN9xkaF9lA?=
 =?us-ascii?Q?av80pKS4V29Uxz9RduYqS+n8J9NfUYwQnkOGzjPTxlziTw/weMWCnu9QsJUI?=
 =?us-ascii?Q?HhqhLdSeSG3z48RB7t9Cvpi7ATLxjU6WsqxiSB3IVydnscax5YwblopiSHGd?=
 =?us-ascii?Q?MddPy4LQRtr4Xwz7kfisn39r5O3139DmHS4g5Gph5y71Ee8I6QQqAiBg1zBm?=
 =?us-ascii?Q?Xnf1jgAF7DAsuu9G+9D4Pk+YYUlxVt2zSnaMaSVXmRuJyjzMaPSZVT/PU0vu?=
 =?us-ascii?Q?2dLAacR+jMLnHuBGtKJ2HF2uRaP6e6A9LzA/QJyDy+WZIzNkKcGNAYTVAJ8R?=
 =?us-ascii?Q?KZOCRtGzEI1J/o87306zL0rUpzGo3eCF8VFk7gUzcRMK5LwYc7wLMeJxRnYA?=
 =?us-ascii?Q?tbef0NyapaXU5+ht3GpKrtoBPYhbRThOFr+5wMi9nFr62amWdMxriOi5ausL?=
 =?us-ascii?Q?sxZQMXgH3SxnVGEB+ov8GVe0YUvNDSOKTbfnOCXPx5lV/fkGud3PFb3zQB9t?=
 =?us-ascii?Q?tYt8p/XsFepC/UXcm3dIS5NL6gmqgfLDJsomM4h/k+k3hdCWtf37AYslXxKw?=
 =?us-ascii?Q?hR5f0M5+gqFIko1PJhlz1Q3IN4i6uQNgomzLZPCGZcwWyJwr3YaeWDM1WNJe?=
 =?us-ascii?Q?RJD6rXOV0pNvMSQqwZwXsYf7vr76ega2QMXmCdXv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6728e50-5750-4b71-5571-08dbaeccbdb6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:30:58.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7vynAVh6O+KMUpZob3DKZ/nB+7o5Q3kyhX0bgb2JCTY/NKRNv/KMfWHOCuOiwnzcjXDHUjfwLk9Io6TLX+6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h |  3 +--
 net/core/dev.c            | 26 +++++++++++++-------------
 net/tls/tls_device.c      | 16 ----------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 04255823079d..9c2ea8b5cc6b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3129,8 +3129,7 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..9ae46fc71ad5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8218,27 +8218,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
-
+	dev_hold(dev);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 8c94c926606a..ae0fde3e6ea7 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -122,22 +122,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
-- 
2.34.1


