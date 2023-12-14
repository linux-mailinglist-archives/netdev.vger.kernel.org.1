Return-Path: <netdev+bounces-57435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEEB813184
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585DF1F22245
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EB5677A;
	Thu, 14 Dec 2023 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gWRcyMqo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13404138
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4vIG19nlD7oplqaGiFf8ZDwBtbB36g7DGFdsV9FwG6PYP9DQyAjW8hL5EJcXBRghpVtfMldhTCMZSRTAwey/oPgELJKAhOV+sZXY61nMfd03R8rNkpuDYuPXJylcDNjmI9cf+1HPAJcDV9gr5GMn9XcShK+ai5++eJrJPhXbLUdxrHuTOqjwcuxt+5imTrqwR6CyCgd8OvOR8JYmmjSuzkoAMXMAA7MAYAAx5nJTv1atbupnGaErE2XhDskNpg1pNLp9+BLBdqOmP/uLiiNVNaMdtY91oMXpZ25IRL5y5iaQR13xYGbplEeWdr5RQ5P5rEzUtmiMkCP14fGlnUKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXNOoc4wQDmyN0GFYsyDiNyxyWHlBqqmNRhpPgnz1wo=;
 b=P56xNVYxlPbd++44MaXvd1yTAcWEPIZHG8uQr0r12RH58A4NT7bvWi6oKzky8TFaeVoCCF0u/XzQiaP6pAk+4aMp+Uw+Zq20Y+Z29oOLHt34yDpL7Z721yAZyXFQPgTeBpnePsh1BlkBwuVcYiBzf5mDTdURk4XMQkFjQZwdcfQPxDfdj6hZzf8t+KdfF2sG6ecz7fJmMh0By7RJc4j9FXKHtkDzvQSETbI/FR4bIGB9sllHe8sSRR6ZPcPg669qXPWr8AUeUhGnVueEbRW4x3+7dsxmAT+pvkqq0+fXE2UfUhVeXc1HKVXOl474qxvVoA+pQrbGvfXIfAlY6B7x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXNOoc4wQDmyN0GFYsyDiNyxyWHlBqqmNRhpPgnz1wo=;
 b=gWRcyMqo6l2GwXl7S89RTthSj2r1KtlFkQOX9t7m/W5fj76OcncaVxUU/zSQ2n5Gpp+v0GEqbJMmNeTRfQWKvukCQ0c98KmiAEmM3C6qQMovB3PJM94yA818cxgDcUCYe6lnyOd1EltfpJdBgflcSoVfOi5zDndlRf9ZK254eTUy5FBkeiC58egwvaDN/F/3/vz/ltO4MlJ+lpgWwiZbk2+0zm1Ne6qLFkqWG1ta6hzY7knHOhaTj0ispkkIaA28C32AyalCbChg0qSssT7B57cTyC2kTeiN5/YqBY/diOROCuWRN5kg0iI+oVszbGXR/APbMxVKxhxJdy/EW0h5dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:26:56 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:26:56 +0000
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
Subject: [PATCH v21 04/20] net/tls,core: export get_netdev_for_sock
Date: Thu, 14 Dec 2023 13:26:07 +0000
Message-Id: <20231214132623.119227-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 275f66ce-47c3-46a8-83ea-08dbfca857f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yvbRBCJgq6hHKC38xCs1zkZ3ro25ZTo9DXuDfalZ/5es4zzF20vT7HOwOk+L+mC93+/0cDR1wwx/kPjsx+LhTcauTyb090mZeY8nMCw58sgndxnGcS8Vxp9I/G75q9qf1T00kbNmqcreUyIx4mCzPdcv3Bz34E8NhKH41N1qazLVPnHVHmdZ8GlGH8yVFtWrvYm6v5EkQ1tBJf3BNSOfWreCmA/j8kc7YHcD2B85Wne6a24pCkNKxFs0S1KfXbYf2b7wxDHwUzX9UIUHsBmQ2K+7EA+kSkZWPa96FBrx/bxbRezZOVUjyGCGx2KdrTzyKdzgOnosOnstq+XEveA3K9LEH1fMuLJYKyLcvHBiG/Lob6ZXLeTjNaavZexwYyBMRcUBVJmqERoFVW9UoXbt3O1ZYHFDrSK8nmXuBIMpo9dMmVb0QQky4AkX15ucRkdwjPsJu2U0Gmn8c48MDZZOJ57W//0hhND3piL1aIH7iHyaY7Moup2386vRE9mSJgN2ypNFX13ubwJf+uzMhQ4N2XGIrIxDrji6wqj++7KEBkAvrPFd7LFE4gcsTWPknKap
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(6666004)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9CHDlHaSdD2cWSOur0rb0INugHuF442GDLQgTt5RAI6OBdkJGlHSglMd19k?=
 =?us-ascii?Q?22EweraD06EVloKIGxzLHw0sGEhmolkLke+zLlhjAxeqvEJ6HF05/z6khY/G?=
 =?us-ascii?Q?18GaBfemktfblqgiAQeUI4nQqdS4JJHrUGPZYMbubu/GjqDYXi6BK1giW4LD?=
 =?us-ascii?Q?hVNnjCudPG+SOvFk0XTv6hexQwQVM7Vw/8ecTagZUNQ6ZAFytnF+jIHvOhQk?=
 =?us-ascii?Q?V+Xflo6UAw7d1Bfi7ymz15orlA1o+PE0jzehPfinAjQulQS03OfwyDTyvoLP?=
 =?us-ascii?Q?0vWWNrOKloFcN30Z8TRowmyCchXgjbyuu5PhwIt26E4c5b5e9up0pl//Se4T?=
 =?us-ascii?Q?3khTaiwnBMYyTOLjwxJsAIn1b5LPN2/LJgFP3FKUrJCC0IQ0Er301C3NvZ7+?=
 =?us-ascii?Q?N42YY4K8socXfoCEPs3wZGSGMDsoily+4PrQRY91PWN5OIV84Yq2xzoDc+Gn?=
 =?us-ascii?Q?3nBhtGHo5kNDtUpKG9zFWxHjW4VT/NTJ/lTxkNdq/MX8nuoBTfBWYZ0Rs0q3?=
 =?us-ascii?Q?dHZOArNjZi/FpnRH8ca03w5u/u2Q6Iryc1ClUJqBDmTDjM5hLJqzV7s1YbVH?=
 =?us-ascii?Q?EIqhMbdJW42gMzubO3ZhOCOpi4F4RTzMERnwQzADG2c3mzIlSlCk7lJlu58L?=
 =?us-ascii?Q?uoyoiuCKC7ZxsJ0Zh4dbntCi3pjeX1RN/kB3kHcGizaxyMRgFvEGimnDLWyU?=
 =?us-ascii?Q?HcQOZfw0HonNexO5KIzpA8jXdIdWjIBrYB4nCFyFZePdetG8MiWZSOHgJs2T?=
 =?us-ascii?Q?tLEV/tZ39aijuNpoTOvk84z/whHVUOBxnBlo6YSeNJY//Pvi/ocBT1xJh1Nf?=
 =?us-ascii?Q?Z7ECE/tc6lUgCPX7JAJxXYkmCc2pSPoP4avAskTdhMXiPomNkzLIFqwjOaXT?=
 =?us-ascii?Q?Q8K3H8MjGD5mvqrTEpfjMyeTT9q+ond01HiibMEZsVZh/Xd2BOS9Y6ixTiRT?=
 =?us-ascii?Q?vfuE5XrWka7T3BMXlDmv98wztme55oCsOq8ZWiMRvC89n7SJzYHUx3iLK1E+?=
 =?us-ascii?Q?Txwnz6HmaFWYVTUzH2yHp+xtYfNLdZhZeK0WRsjiNqwTJIJP0GGrTyF5327p?=
 =?us-ascii?Q?sfgHJ/AHxxBP/tr70Z9j7GnEy0/3+9JdNTDctdulLQ8Loaw8W/JM8RFXYeo/?=
 =?us-ascii?Q?6poMyNDOBAn7MjwvH93CHC6ixrf7yHUO7EbYtfH/lNTZNuuj/5bbRaT2gj/Q?=
 =?us-ascii?Q?CuswWXyRLxIeZrlsv+eII7KMLoN0lbJCCUz7qegAg6zBbQ5Z6N387E1qyqH4?=
 =?us-ascii?Q?LbXuBqQFVB/mJyb1hkwBZTxcq4vSr+aMRcmG4h39V2r2lU5AOh8P8sMVihRq?=
 =?us-ascii?Q?GpV3+8eSY0El0N8SVZtNbDBkfUmh2ZvG/YYzMs5LAO37CUy+5oXD6PzAG2Om?=
 =?us-ascii?Q?W/kZU5XOKn+3SbwcAwZ2tlhW0UZpCNXeY2MYc0+2XtUio3qouOn0DsKej8hw?=
 =?us-ascii?Q?BS1eTAMl1KdTCmaDBPbLr7fA4cvn5LgyQ/5OSwSlNgtvA8zOHPh9KR4dbwiZ?=
 =?us-ascii?Q?5QVGMWBzoYeoRgTHUrs+P465AVMxGUhBHxexDtZ1rOI7Fgb6+g7bemT05ZfY?=
 =?us-ascii?Q?C7tAlaCTr5jARejzYlwleQR9979enRfZ8qmLnA2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f66ce-47c3-46a8-83ea-08dbfca857f3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:26:56.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+cBGKPO8C3v2AiyAkUTP3ljFBa/Xfc5aur0t8BCcXxXxTAyLmou+M0g7tqpx+cXCZVNdw3/0qWM2oa+vmke7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

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
index 3ddabe42d8c8..52bf095f87fd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3202,8 +3202,7 @@ int init_dummy_netdev(struct net_device *dev);
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
index 0432b04cf9b0..facf3d35aaad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8263,27 +8263,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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
index bf8ed36b1ad6..fb94b3e777aa 100644
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
-- 
2.34.1


