Return-Path: <netdev+bounces-29665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CD7844FF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335792810A0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873ED1D2F7;
	Tue, 22 Aug 2023 15:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C688464
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF4CC6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui2hjMg8Ta4er69C+dmhTv5yqYOF4lTJ57xIgNBW5oOw0DRcrqNsxZpVUSWDrNTJz3j80rR5yoklgdAXHHhWKCP3uv0X+vDWeroPznXuX7oPA4ftwhNEuINGSiGRWcoXW0zMK9waIlbfe0LlWrNB+5K5SxKV/sR6ekbtcnJ1hGIWnMLC8mm8bpKj29QIs6E8PQ85Aqv3w0jSH7hLCg9BwtIdu56/MUsg5EweECgYFBoxOMK1WoqTtjj5hD03xunDXjEOt3LzXXxtADVHADujKzJBAx61JQt+oybZnIyx5COPljXIS69ObOeHDVTu9ukkybd+Um05nrc8d4M444yW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nctS7YrZXoLux3Ty/kJxjtoU8iakB2fV8Knkky/yvW8=;
 b=ESRyeqey+wfoJ6zC00UDu9NLkf25n+5pYeA0TUh3JlB8E0AwJeL0SlkJcDXpHKNjFFsq9618L/D21uqyOjh5xzwLDJQakulOFkQRYlPdw6q4rDkzdgoXeTXOIVnwsmVERT/LCsp3ESZj3SbRAwae4fHKf342W1vX4xRzhrW9CEl9s0VqgNsOxj7r7vivhvMywQP3JbJ0M709Qp6cet29YAo1ZDeUR+dVQt+ZaqTvAMrFbAIlLpvYPUkUeFFaGEgBwh5TZMzA9SXgvYYkX3kSnttQXGh/tXN6Gi3WrSQdSm14ISsgb5nlTw7yMywui1QJaZBbt9GaBve88V4nOJz13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nctS7YrZXoLux3Ty/kJxjtoU8iakB2fV8Knkky/yvW8=;
 b=CIzNQtllqLtgM8ifPvi6Q59p2Jl2UjLD3vuhmoLSlGV6goRhy1azOFmkic8mCmwi7wHPXGdcrRI+7lskyK09HYqC3EKIPkuyWFNCyucRzPyeE5yICPn8bszG85dZQ77tocqdwMnfVmIHww38EyG9+M7roV2dskLI6odWTdSUbbzgfwjqgDeKtU3v14eqY4hgrb/wcuJytqXBLmNuHcjZito5V1G/e8SO97DRmEdK815Uaj123Lyfms8TdSJhxa3sP3dFufKmS9rwf24lN/7DUqBy7xAmlhtglrHkIRb1qx0p3oBLKq6/ZzZuERpiXk01Ihjm1HLkciX8+BoROKXrsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:22 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:22 +0000
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
Subject: [PATCH v13 06/24] net/tls,core: export get_netdev_for_sock
Date: Tue, 22 Aug 2023 15:04:07 +0000
Message-Id: <20230822150425.3390-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c79dfb-92e9-4686-cfd1-08dba32134e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W6uX/g2IMBWIOlrrbo44EbSndKJO1FYsL6qoN+pzkZ3/pTHe/eQcsOh/2/LISHfqjjRQq2ZD9S/1ySaf3eST8VqTSJpv4Nh7h7HGo7zaye8shlPf6sNomvoTN2y9MBscR13A+jTq3l5tjMsYbT+TGAOJbR+9B3LZvUhp6gzNh4zjtakKyL/2ccenAM9ThTAkMxCb9Lj2RqES2QAAGOUuMlME6wq4bDc9twGF5CeUpgVNbZrHXj3vx8hfoaDbbR488NUDFRSnrPSbHVSCPXQZCBHOdNPIP9XASZxgI+AB3K1f6bU0HIKn/wRCh7h8jY712M2pUxpD1BtuShDZCriA9N4th5oJo4yeGKcE/QzuPTAOfNaISKA8pLfcui+sG199gjrF98kuDoKkLaWao+2EpK5Il7ZDvpVER/mmZA5XO3xHsPHL1BRdeHE7iAhfM4gMcI0QChyZ/wSIlmy6kotj6xEjYSUHv1ZuqSltfFcKsqU5+rCnaPL4nbSZbdQe/SGJ3yM4MBYz9Yh3S+UM7NHkReWZknOs/tOd4gi1/A+w1m43bu2pKgnfMAcAv3kzSeVU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89k/D0Lw1sEbGijFZkFzBrRlYHsh9PTmaz95Ynk2MVIXs2+//yLDQVbxmEsr?=
 =?us-ascii?Q?pYUmEZQglmSN4FgJHLrrt9hnIjS1DyV7WyPkukrGJBaBJd8QOXA1CnNmQhcl?=
 =?us-ascii?Q?mYBd/flg5srPuAsBUJBUq9FBYaRuOvXM6gFlcwEvroerJE/vH+sC7zu5lMSs?=
 =?us-ascii?Q?ILNTaJNelw8RqcQsTWkLdRuBJCZ0QLx0qmy0O8uuhai3QFTtgP7/qBU71zDJ?=
 =?us-ascii?Q?D3NE1phCxWpJVY9QzMYV7qQBsa7EUwE8TXLHiTkYOpE2atVVHl/yrmrF7WS5?=
 =?us-ascii?Q?BOEA39Gt6jSfRg4iq8cIEJoNZIkra+WFgU3RDqMw9n38qkZQrAIwOc3b/Cnd?=
 =?us-ascii?Q?LOtGMw33nfb5JR0daiioXlqwZKtc8bu6Wzt26Qevlhgj59e6NomoI6ahpWQn?=
 =?us-ascii?Q?b+HN7eyGTwBFEi342Aho2LUGfOXZmVnhttjwVke3VTNd8jeBqSmL/D3HdRK6?=
 =?us-ascii?Q?T8/MZhubg0z9RIJ8fcwd5RRWv4HA1HFk6FM7yz68083U7aLgGe7NLyu3a4Id?=
 =?us-ascii?Q?MR2CcanaT/7R72lm6vUvXgBgWk2e6V1PE4/yNXAzo2+bqU7FyQr0EskLVnFF?=
 =?us-ascii?Q?UsWLKgjOdfzU+4B57MXWE9AMtvW8LqjsZsBpQxHdxWp1GVdBvrmDIdmKB+9l?=
 =?us-ascii?Q?GnL2JEOJgyCIkdPo9qohH4N71X3TtN9MDznFyknGsRiBAMdHHFUciX3uUTai?=
 =?us-ascii?Q?btlGgcKsEBmonZFKsueDaFXijIzD0CHx6KXDAcpRzVvBAWT9qfyoY5rZHIeK?=
 =?us-ascii?Q?9FLAhGc/fBVk8a6OiabXvvTPUWerlj5Mag1+KVVtrSrOKzZBGCGIFIA12ys9?=
 =?us-ascii?Q?O7k0hgEPzdSBkPkoBniyrnPPiL1PjkkSI6gUiZJMXt4IgoeGE7ABkl7JwV50?=
 =?us-ascii?Q?R/FJJ6k8vugdZAK3jKQzfAQOj+yJ+bFwYu7nfZlvDmgrYeAb6OC0Aaeeq26o?=
 =?us-ascii?Q?cV4S5NUInekczqBf6xEXGR1a8j9KR63MNikNdoFACsXbfyTwH2OO+OFJWj9d?=
 =?us-ascii?Q?/Fn6nOFpeWMb0aOi2L/ujUBhEwPWemwxNLisvoce8hsLfJn+vSXYArvYWSGg?=
 =?us-ascii?Q?e2i9VJfmbrBxTOKQL2FVJXGU8RanW5V9FYUcZoxQIwwkisSPJGnoJa9K01F8?=
 =?us-ascii?Q?iN8kQxLiq/ecogd7WgoR6cfa0clUY0b3XK+Bdx0j+T7Hdd4+XbXVf3GyEVvy?=
 =?us-ascii?Q?e60YZL1dm5n6nLVDM9rgF1Oj5QlLOnqyhKfHqoicBfnjme8BIVg13W3PmVX3?=
 =?us-ascii?Q?vOxqq0Y9ZoNcTWX6tGXw0L00m7KdLr5MVzWZ8qU+XNs/kCpJftRgZ4j1SgfU?=
 =?us-ascii?Q?fOaxb1Ragwe74vXWkWKvtUhTUTcn2kE/ax2qEkftDAIe3sL/LNjlYJdbl/FD?=
 =?us-ascii?Q?hmDzejO1IksrsklD6yUWMcSGT0/xGDQDCf0xwUgniHy65+1CBk1keoZzsdqg?=
 =?us-ascii?Q?ivsxiIWfKE916CnVOctbF0OR3tezJeGnC830EHikNdB1ooW0hV6UdX2TupSU?=
 =?us-ascii?Q?V2DWqn27WwLL0KjhvD2FAFnN0Orptsc0koxEcCTEQ8rfcmZeh2uwCKJAgia+?=
 =?us-ascii?Q?rPIcp0Kj8jy3MiZXR+TNrFCYJNeMdToVczqDmP7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c79dfb-92e9-4686-cfd1-08dba32134e2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:22.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a7FN2Zn3GiqO7V8bVA+6CleNpgIdS8UGXlysgAqWlT24RixUErmVNQ5cc8wvfpoQ9BcIexQvGJG9lrJNx2ETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 17e6281e408c..3c62985d9073 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8215,27 +8215,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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
index 2392d06845aa..44fe5e37b689 100644
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


