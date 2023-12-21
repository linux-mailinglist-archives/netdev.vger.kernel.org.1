Return-Path: <netdev+bounces-59766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B294681C036
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413F31F249F5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D176DD6;
	Thu, 21 Dec 2023 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qd42czAz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B276DAE
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxtQt4zs0/cRCZuu49f08NIFjobZ8DAxt9T0TC6oRl8vjz9rCJ4alITQcG30PFeMKNhHrr+efkCUf8XZCSh2anjo++iLlBZpdmHX1vdaoYZf5ZVG4RRR/DCgaMvFcgNT7hjg1y03ZOuuLFs/sWpAZm40OINKSfCEgjexABhze16PK7EMiOPTzEAhiH8UimQk4P5hw7qQ0iKkFAjQs9RT7+dpJ/Sd3x2oE9muVnSIbGWmGTo8EqydrYS3QUPYmi7kIRa0KaQRI7aGqh0t6SbmypT1JdTAkz9w6u2ZZbx/X5EcCsNLS97Djy0B+HxdR2xZUApDKc7d8rawSkGkadk0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rW4AhJ3LY/vB6IQX5dFyBUQfqTxa39/Olh+y8dPl3M=;
 b=csdcbAH05OTfcCZ048NWYrq59DX7WHD5OieUuRzEC8PW8BpeC1FoREwk8jEgF261FdAdazI37P9QwXxCHcPCwiMZjOTApk7MrMHwD2ctX5oVJSiKcvnKc9yjL560gUMJXa8HF6Hxpo21Q7YiP804jXt3CTSI4VP4JM33pT7fIQA+SQBa0nS6vcJ8Lkvy6Z595D24CCmmm0ii3Aug8ZH1EqLe4hBuslqjRXyIOzZl7AV2BSYiYrBWqgH5SkNlMHBDgVttdbGPp3CGedlQ+qHYGj6TY40bJrECivRoqCOBoJ1Ht98M7QcTDzcefB1/Oks1kyBDUVti0pGk1lKC+2SmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rW4AhJ3LY/vB6IQX5dFyBUQfqTxa39/Olh+y8dPl3M=;
 b=Qd42czAzTqqqp0askpSMoJTVGc5+M6RrZh+JuKUMRwhWsvX5mZIONsTAuiumsL4H7tQFbK45RIog3eEn1nXkNK5L+UTYCNnb2Jd2kzCQLBB0FH8eElsqLQ6fSvKWYFBeJZlqNpAWGBbURAggmOjLuu7v1tmpsklCQCrHc4g0N5mcYD4KYDNLa1Np/9h5WMcVt+q6IONhoc1VrLmG1j0WfgIguEtPyrbu1JcQHTumBHE9fAoGnhIpG1bAqvc+ef8C+vOGfQi5pIA4HRbT231I1XkCIwWRp/Knp3phku6vCDcb3zqWO8VIUqvRkrJTIYPX31gRRM9rUdrmJEfo/2XVkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 21:34:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:25 +0000
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
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v22 04/20] net/tls,core: export get_netdev_for_sock
Date: Thu, 21 Dec 2023 21:33:42 +0000
Message-Id: <20231221213358.105704-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f21411-c541-4e63-1290-08dc026c9a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J6FkhKfwQYuy8Qj0BwlAMNbIYdhMzYKgO1HVA2A4T1k74a1NoMCjuKa5g13585Q3KhkiVhuWPKhl5kCJAda4ZGfMoDkque5PkkIhvb+URFQtFARYqkcDowclTfHA1GRryM+lIxsECONVe3ZjkqnG4ghwbk3qiOcuxiOhvoG0pOUOhmMmoOxGQ9irQMEobBav5vkS4oabG2XKSnx/82FLWdknzxP8YzGGY8DfIoZLLzNOP8++p+3yrHepPS1lxIQK1QQNm7Rm8dFAXMTNWfVLJUK20wUlrXQm7y3wejEoKKuNU2IIk6/PWAiuI8dKfS813JYjd/FMjuq57NkHAfYydljDztEKcOxWNxnUU5ZfPk2dr9wZg8UjiEG6BwMt5EWIefPLmMOT4ONli1AeqVOrhfKxfEYLAMADmm3UMstSzfWnobLePwIskpTT+f9/zfCv9PskyPLhLmIzb/zGWbKMYJR4S16KWRB2Ey0FRQeilTAbuFs6ycNVeFCEv94aVpd+93vlUM0FZcJjYGl3GBsjivsZ830/Fua7U/4IVwy00sj9kBTLp8pri0FgTfun8lgo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6512007)(6506007)(478600001)(26005)(6486002)(2616005)(1076003)(41300700001)(66946007)(83380400001)(66556008)(66476007)(6666004)(316002)(86362001)(36756003)(8676002)(8936002)(38100700002)(2906002)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwiIjTkMz5d2dvNgT523UI+TQIJToXqbH4wtlKKR9TD7rTNFzzfpw0b80mOv?=
 =?us-ascii?Q?3X83EcJ3x++1LOc2D6h3PONq17cb8Zo3M2aFdX4tVk3zc7aCZ1Av68Qdy5PJ?=
 =?us-ascii?Q?hOWYyGP6bV/TvqUycwq2/99kSodwZcSi36B7r8rtyoWhK/RFRQM7rbWDG7Z9?=
 =?us-ascii?Q?NTfbIEu3fPxGDTOqYxNdEbeAP0N6WINedloEVTsYZGF2X1OmVIslgV3AUMfE?=
 =?us-ascii?Q?z39G3qhU9oP5L27l5tEwLI6OVRdwa+hDclCtMOxBm6/EN8ZFKhumrH1C3V2c?=
 =?us-ascii?Q?jkyKBurHPt9uOxLidKwDE1MOFfZojWT2McRyBGrqwcYYZB4eyyCEhNsvTmZY?=
 =?us-ascii?Q?z6WfUmgz0ZXXx3WJ94z96pjYgzthkEhBRHZbVCK4QA+RmNwQTa1r02sISx2Z?=
 =?us-ascii?Q?KjzMvyQB9jEJAxzIhxMmshGz1oG5co0Os8lAIoQ/2chQ37JwRwloJG3KzObL?=
 =?us-ascii?Q?Ns1ZdOjo4ZuHG/gATB5J8Fd58bLiSP8oY+hyrkhDwKA1Enq42aCa9fg5ZFfz?=
 =?us-ascii?Q?isp3z2llCBK3W4Nkj/Yriz1QX3p2jJTmHvC7ZqOrN5W+TcmNdl1G+/ZhjX6U?=
 =?us-ascii?Q?M0HAxRKV+pGt5/gQaAAruYR6KmlSEzABj5T1CAfjlgoF/sV+KlaL0+5zdvQB?=
 =?us-ascii?Q?Gu0evj5G5Q126zhOFfUgONQdLKLpUF/GHHs1h0dre4Stb/juHA3dUJe8FXRS?=
 =?us-ascii?Q?ec3BBbtgB2X3bgiAJvYx0N+HnOFZvGKObGd6IIoxhT66bCmj+W28fFmpMd9j?=
 =?us-ascii?Q?m9LODRaO0QTerA1JHrzJllbkPxNMgU1a5svIP83CtGqXjW8mBSAH+H4Ox4np?=
 =?us-ascii?Q?klPiRgM80DwYSvGekWuy0yZvB4SL6JFm6pIWM+3k3Z71Ya50zdYHIsy8B37a?=
 =?us-ascii?Q?FzvVZA7DgOUa0AXsbYWw+QYmiX7zEQQ8nrGrz1zd9Qj4g5VmfFn6f3mgKNJF?=
 =?us-ascii?Q?NTRYX5t0PU0Cu35Oku4Q49Beb4UC7HF98oT6PwqgKRDkVLEyy9UMXJjA40dp?=
 =?us-ascii?Q?ZX9LhJfYFIzS1xlAQp8WKowFKRl1SX174xjGLQKLIpvYEzv/6QLg9/832lwk?=
 =?us-ascii?Q?1j8uzcT0A6O77IM0sDSQOOVpmEG+Z/uATV3Teg3n+HvnTNSzSyxB1ltspTQt?=
 =?us-ascii?Q?vG+Kg/nKLCEUrJkm6hzeMRX6G1WX9/ptxvNXK5i/dew+WbzYbfxvCODFFi6m?=
 =?us-ascii?Q?8jBqxlvjRiw994CdtygNG+7iWZ4GBrQbobwkWj3cS0VyC/Are1asZToNhE+G?=
 =?us-ascii?Q?UzWVi0mAqmqIap7QzenDeKQGwGL+E9ZsqAch4PD7H5iRHzrGYPn5ge5b+NQg?=
 =?us-ascii?Q?h2Sn7g/VtQxdhef1RRJA4yao5iOKY/5KOmM+elZTxmZu2jiRFd9i2jskujb9?=
 =?us-ascii?Q?y9hA5Op6JQoL/sFkfe7cE7L1NbXcy35dVw0t51kYiHNURHN9sgFpiZLpssSs?=
 =?us-ascii?Q?UcGgsYwTgilOcDJDOP/NG9EMardiMJOrLQwinqfdUsW8ifjQeja2uDnWNHBO?=
 =?us-ascii?Q?a+DdjFot7WnJ91ci9v0gNWo2lKsHTY05Io5Z0syfwCujoGPBwn0JMdHPbALv?=
 =?us-ascii?Q?Q4aA/oVfWCoQ3Zouz1K123pThTogDxmr0MGD+ClQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f21411-c541-4e63-1290-08dc026c9a8a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:25.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGXB6xpEOkRfeHcfRDoxcDULbHyoi0mL1bkRSLqLla5B6ybe+mmkddOELNjEZ4KuUit8bKkRUV37Apn6KvKd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core
* update exising users in net/tls/tls_device.c

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 30 +++++++++++++++++-------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3ddabe42d8c8..0359a1b58fa0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3202,8 +3202,9 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b0..11a21e7d2217 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8263,27 +8263,31 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
+ * @tracker: tracking object for the acquired reference
+ * @gfp: allocation flags for the tracker
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp)
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
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..5868daf36ae2 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -119,22 +119,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
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
@@ -1063,6 +1047,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1076,7 +1061,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1172,7 +1157,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1186,7 +1171,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1194,13 +1179,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls12_crypto_info_aes_gcm_128 *info;
 	struct tls_offload_context_rx *context;
+	netdevice_tracker netdev_tracker;
 	struct net_device *netdev;
+
 	int rc = 0;
 
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1249,7 +1236,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1262,7 +1249,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


