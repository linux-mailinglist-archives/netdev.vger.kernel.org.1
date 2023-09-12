Return-Path: <netdev+bounces-33134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA479CCBD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B8E281C37
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA1171C1;
	Tue, 12 Sep 2023 10:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C81640A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B510F4
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1g62KFH6F9pvMmFwpBNuywaJcNCqloHKBmfeaTQQejac6hJG0cXEn3zr/qNpEhVwAGGsl+j6oNG1ub6aXLJDO6oGJkC2W5+uguvXOrPtmqOXDnhTqBt+L+a+WvYf2vvjyg+XImlGI053Lb9yeFumK+PcxUqVP4Qv0hVlTy7BzHxUmFLhQTXAhb7FZJfNgmLT3pqUmEPWA31fXkHUST5bMTp0tEGfivKw67/p72WqIhrGHRnpdQx6OzocxI6MmKKD7fVrwAAF5Op8MCLwuqsjxMMlQLSpY0rCdiA3oAZKlw0ov0q9y+vwys3zUBDeVcKX1Sk3Trv3bthep/bP8TYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWuUDZqny20+lZjfc5EnOzyYvtEQpx4rU8cflfXou80=;
 b=WgVOkIR3tVLnYa9AvBgL7ij8S9k/Wf97zyZ7sJMbd8Xtvlzowxj/GbNU7iGOcFRBdo2B9pIb6GGIThL5y61D86DiTaeTMTJd32j5i2dpnJNRkl2ZEne/KyS+G4DxiIfcF5JMjF/c7nLklxr2JQlyJ20pt8o73mWGJEarv2GzbOWKoiBlyVe8yPGzZHwiIUtUIDz/2J6SN7ypPpOTF3XLEFaoZdx+Vj1jsnkvi5z2H4SzvEs34LRIFWDLw3Dm/1AE6ilDDqGRe2I+9meVK/E6at3UO4S7fKHaBBFdwMnRhYqt8k5TLGAQUTmQ2yHI8FWcf2XotKSlrJkkQHHBUf4I1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuUDZqny20+lZjfc5EnOzyYvtEQpx4rU8cflfXou80=;
 b=L2Cgc4GaG+Q4NaAXCxrrmn7NHsyVmyA1iSxXMr7ffkxKj5Uc+1gwBKquS1fclF0zwSDfB8WaQXnNuOspfkegBYKPOBx9QEAIzCuImdS25tjqKv0gh3HBkIzSHhC9x3CDuqPd9kVhUeDZ5pbgM9XqjUd7TSwrlfwDDDo/FvC3mqO/k4kCgi5f0pYyW2UjG96lhoSszAJCSU6ISgw1RBRFFsqpyY00uDjVHgDdAKH+9b5/Sg//C5CilFlWs1S/cpG50WwHDGMgYv4b4cHWmyXyuDGhHARYoxKWBPTFURMvHLfMqslc8jF6mxKJbTYhYU4izAOLvq+iWmwm/dJX2f762A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:36 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:35 +0000
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
Subject: [PATCH v15 04/20] net/tls,core: export get_netdev_for_sock
Date: Tue, 12 Sep 2023 09:59:33 +0000
Message-Id: <20230912095949.5474-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: f386461a-7944-4721-a56d-08dbb3771c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MB99W6XpMXFkAeXR8tkCj2I9zT9Cs2/0nEpekr3+uuMHAqadNeiKWwl+FFi4QmWnmNMgsPoErFK/iEAbAdgun/B0Mn30oJIYAwb8f5NLOtBoFIGOgzB8BIu5AHDIeSZr3+g13nKqu2F8RuOnMYs7oBzHt0AQ6fnvLwBlrJy4VRWc/hYebsBzsn9m5a1xpiHqeCMf5PggHrYOxX9yyLKsLqh/idB+8aKR6+V1wzAYth8XSodOZ4xWL2FaiB9hwvuVgomXxNcgpxmIHp64JqikRXkOXQDboSoFvn0TOvq4r4CepqvzgSfaJgPydtQ9LC4WPT7E3TO+LLv5zliGpbd+geeCzoghLHZVJVMpW3AOrIiqLz/AGtkuhVkheEwLpTTNF7y2jd/2W17D6/ugCe0nyN09/vTQjZzt4Yv1ydjGWjAm/CKzUJOBaSb7LEspN7LJz5RFByjSlgqbaj2pxHDwOaEZOaZ6bOQixku3yCNyUqCMM6N2RUhmN6J/Lhq3Luc1gfeiG5SKXeaUnTXPuVYHmz0TLgkSVKHcnSx99Q44H4zcEEGBwZ0chQe+baDRA9I5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBAUJLEF0tGUY644XwXzT7kqcI0y+rKC4Fc+RQ2aMto2YSjIaZGwoCw6trVo?=
 =?us-ascii?Q?dxaBjp5WXhuxX3ZGE2+9XXkDeEf6CVHb/8LSYWYGPujcfsBu4yr8eK3RPXyS?=
 =?us-ascii?Q?rK0fsePcfpsYMvgfUFJEFAQ6BOjV1r647HW72ZFtZCNeDyzDd7NXgTrHuhKc?=
 =?us-ascii?Q?Yu7Oc0eQ/enWeHqzQE+3el7MmVM7dYoN/r8bPFCIMg+DH3YhN3tNZGE2+5nf?=
 =?us-ascii?Q?ENCOmyFgyfLULz73aoprvdNcXsGvFz42LYtWBbw3Qp5qVZ/AIUuX4RF0JuEP?=
 =?us-ascii?Q?KCsE2tordWj4kAFKLVXS6WciSfufTwwkmVmDZ2QyBuiO7zAP6k4ftW8e502r?=
 =?us-ascii?Q?8g8JqkiXka3zTRipzkAWbbUygthqm9ORxkbJYhDFHZDzK2TrO/zTVLJaTto9?=
 =?us-ascii?Q?RlZ2FOK/thX05Tos4KVQtBX/5MDYwH6OG37nDgFu5Fm2SCb0OIAQT6j+GNSh?=
 =?us-ascii?Q?TLAG1LR0ZHuiJP6f0NRRXKEXgQfJoEh7IrDKVlLh5doiXw9GiUXRLRmLDri8?=
 =?us-ascii?Q?ieqQp7T4IfLVf5naR5IfYHNeN+yVIZLeuJXxpfeJfi7fyVkQIUpjwEWKd4x/?=
 =?us-ascii?Q?TnpDhpFtwZmYIMNLQ/c3oQFYbjBA+vBlsNT9UreD/BGIaUbb0LNZzKxC1zUP?=
 =?us-ascii?Q?er0uxACHu5S3qU9riRZ1g9QJ4czWQ3HnReSqxd+vjo/nDb8K3C/8h0CFKfwh?=
 =?us-ascii?Q?837WEteWPSMYgOOZeKIvT+G4ziAVD0BD0E4jNI2oawVsn5ayXBaz77nvdqNS?=
 =?us-ascii?Q?iAWFem7hQRERKY3Lq9ZkPIwJnZU5vXXID+daqaiJ4rDRxolGiD1p8TC/8HWS?=
 =?us-ascii?Q?b6NJ48t0+GlTj3tUik4GF5Ep6JGZFM8tv7Vv8vyksKdthDcBe310pKljoITq?=
 =?us-ascii?Q?O/CiTz8oUJDE57nT9aoe7W4RV5kCgN/+EXXNM89zyx72g2Y7YLKzgqb3tjmw?=
 =?us-ascii?Q?uYD1G6/nAUOlEi1L8QgXZDq6ohwwrQ316YYuXZmCYfzlt3Hoy+PlXNFuVuEb?=
 =?us-ascii?Q?dUWXkBKShJ507UAEG15g5FKIKvLECEr758vqlHVSDh0KijJUv10cu2+BBAJJ?=
 =?us-ascii?Q?/aUsKu7p7g0FFOIY8whMhEdx8wiF0jNV4KGW4NbnJVo3V/G2n1D0X3IP1EAY?=
 =?us-ascii?Q?TQAE5wCN8WuQv5WC00nszgo7OwZ7J3t5tETWYLqQUyr7xB+vmgEbmwTL92hm?=
 =?us-ascii?Q?IScFlUOTUOrkkzdfMnfGQa9CrL4dXJ3aRcFjjcSEJxODJARBR2I+k7PKZlGM?=
 =?us-ascii?Q?o61uE2FGcxfQws9+ytRF8IQTF5Zg+ZqSMFjK5Q96gBT+Ik0IfAhYV9ti0DK2?=
 =?us-ascii?Q?cdtwLmAyjeZnDbHcHG1Dome3HjiC7ZVNTShE+3M+cKSH5Krw5I2Y5jyOZPbA?=
 =?us-ascii?Q?Mqs5ZSs0XKWM9/MmcaAUdvVC74vz7NH2+O1CmkD01bxggCVZsQtvg4FLnq6O?=
 =?us-ascii?Q?U9j21RQL+XOvCkTOA8VqQddsyN94B9/TWH4V4R1DNCeN0ciSmEdiFf4PNzBP?=
 =?us-ascii?Q?dqHDmadgIvUb7tWM+7AnoHX/aWwV32yvFcEsL7MDaxM60gxbVTWtp8A4ZjXI?=
 =?us-ascii?Q?v+r8SHeWQu9LcszZSoTcv6vkyrCMyglicZSFFx5b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f386461a-7944-4721-a56d-08dbb3771c2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:35.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlK7Gc7CoyIPDszv34otxmpwqxPu4GxFweJ4yiQwNg63yWNQ5sm+FNKcgCcugarjjX7+IZhfFdYux+hak/wLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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


