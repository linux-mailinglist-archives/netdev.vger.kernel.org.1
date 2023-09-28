Return-Path: <netdev+bounces-36859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF57B2090
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7E8341C20A8C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC04C87C;
	Thu, 28 Sep 2023 15:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448364CFC5
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ECA1AC
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSJmWdF42TOErErH/4d/4B/PcJ4HPjpF1mrhSSFN+Iqa1OBqnr0DL5pqdPtbWksGd8opI1gh9OwJNWEVO0KLHN9Np8PoPaFuTsfRsvGJ2vZTDqUYtEyZd9+xELefwfT7rdGVUaVjGzJEVMSxzS0oNYEDD6VkwLE8jxTWLR0T9epoXnb0y73akedL2A+EHD6n28z43y1XEJGmSBW3tUyc4HnN37fj+Hr+QOem8MPO8FkddTbpyDDe8nLQ2voPpatyFohVnkCx2vOiXh1WCdjxzhM2Z0mmozMEoyyk1JnzRmzdyZ1ZW92WBUFDpJOhVVJ+Ic1UKTsZH2dSV2Qf59p5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc63BLB8ji7oOQLjQljJsvY1bnTLFPjRcF332owtG4I=;
 b=nH86gv6YvKjzhRcOFX3ccrCTeGN8hZpEHxZxsfigF5o+9UVd+fborJ16mjS/btgcb3GA4vWsBM/XnH/Rgd+EnrJXCgZTh3qe8KEaZQsMAKWs15MvvXzoKUPcjTjg2Y70hfVbZZu9qN/Ja2Vws5st4JAqRdI8qP5amZoMfoCC9knic+uOQd2X8ix9QJ6ygsOXy1+AQsuJIXEUkuyWSswTuIo9owjkYvAxnCclO6OMdRV2Xj464RYJj4FPsS4q8eAIEiI0gNFCEAYBND1TIwa4b07OPoPtx9mJTuxB2rdM+bZhPzY9zXF+W8f46slQ5BBh6spd22d6zyiDqNv/w3uOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc63BLB8ji7oOQLjQljJsvY1bnTLFPjRcF332owtG4I=;
 b=Vpya9ATsBNQwXHUKNT82UcseRTweL8TCzXUJnvGdwZ8HtxomcYCe2ljoP/Ij5v+fvAsStJ+CFly35wx8MWWu3jO5oB7SfjsAypzoiRGnQ6ONJGXvnem1bVe06kDXgWfoED2f2j5d1HH4cq6Pb/Irny5tacGYwjggoPyXf/U50CuwX5+4kknONVwdqt2G/eFgzG7Hn9De5fQg32LhGExR0x8JqyViuuiHr3xpig8V23uEkc/UPnaUzZuC6MIHS+zK42mdyMg5m/UkdiPXfKuGrPvCQuLCdSilUAB7G27IHLlNeyCkJ9KPOBlpXmBCDEUi1nJbyXGNpeVLQlF9u+ABsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 15:10:31 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:31 +0000
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
Subject: [PATCH v16 04/20] net/tls,core: export get_netdev_for_sock
Date: Thu, 28 Sep 2023 15:09:38 +0000
Message-Id: <20230928150954.1684-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 638fe4dd-9309-46b7-c336-08dbc0350e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AHhPIC8KiJ7qdVP7IknIGVuos1OAugD+Rr0+tG8Nqm/VJugeIu/qy8uhZOlBpm/ApNGf7QhWweQebJUe+P0JOiJlsQv+cuXdpWbW04ZpsXfhIc0piFrm8coI1y9pLhO16hvqszob7onexMgmdPonuSORnk6M5BxWbJePxnD6hs/C//JemcRTEAMlBJc88c4KiAKGSwXnPqUIL6vs7ZR/VInMExd7vmuD3veP9CHUMeZ3DNArkfSXBd3UVlk3D5F/xlUZRlkMPTZMaGjgfyerUxVMoAddATjifHseozjjKWb7Wgkb6cfuCO/rwREwuoqZ+CUFp3Ofla2+s3RiC+9TZiHSrUyg0jqw+kpd9s3d8CnqYjeKx7e+Irprg28gODis2kRLrkQbPIeaHlznB4wmKKyKKTP8yadAz7/+BwgFN2SNjTOdHYWGZ8suPK2bRqnFGwUrs+W6iksDssPvBL0/gvaU+1iOYRGDiojRq+VkCP7j/J/1TO6hVptMnDeVFbnYvhgGYG5oxUEpv5CbYVLA8KKCOvVNxS7Y32YMrlWwRZe3gvGDZ6U8ovsVDMw6beat
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(7416002)(1076003)(6506007)(26005)(5660300002)(36756003)(316002)(66556008)(41300700001)(8936002)(4326008)(6512007)(2906002)(8676002)(83380400001)(66946007)(2616005)(6486002)(478600001)(66476007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcPv2w+x3u8JBqyb7HEd3Z8roErZzVelZ75xri9eRaFN9aSTlvMUW2hwUdmB?=
 =?us-ascii?Q?rC5xxk3czeWAx/qtA52yTgUM8hJhVe3TxmMkyfrCpmDDeI/NmQ/7zOFqSlz7?=
 =?us-ascii?Q?QXtBPO9/LA9zMjkfhUI0reiao4PxYNtGPpX0rpBFRuxfcRAqVt5klirXRWqO?=
 =?us-ascii?Q?A5765I6Jo4Qf8pu3nLlAUz63G7hYYlwKj+TZEhdjoWuU4GjpckovSHnSvWMg?=
 =?us-ascii?Q?dy0io/w9/fioyNixW2l9j/XGnl5LPOa/EGENja1MPzUUJ8CXk54bgUiO9QFl?=
 =?us-ascii?Q?RDC7gIMZjMM+YPJsmbff1AfR2UdgzwYX3WW14Uaf3JAbMG0PrCO2Zo3ATL5k?=
 =?us-ascii?Q?LXI9vAVrmVh0luotsRRaNSIndB6l/9Ji5Sr5MIjedCMP8X3smqXc+IfV9c39?=
 =?us-ascii?Q?fB7whAX6MJ6l8nVUY/FQJP9cdJLij8rlUaTuoYLjPMmKmcjbf/3HOHP5U/5j?=
 =?us-ascii?Q?ibO6TjOSCKr5SWDJgHOHD/6A8/ZzZIQLh83iP4QR+fVEEI0z0S8wtaQOChey?=
 =?us-ascii?Q?OEHl1OVKeBAynTkSiMw88VoqeWC1RfWH964ziFQfnS/CHFXvvU+BpTR18r28?=
 =?us-ascii?Q?XdAvLzhXExp/gMxAxEB8qGnFjCdU0zrVDoaUnun/ndDmwFi4kVsSNbcamTeC?=
 =?us-ascii?Q?DlpzcemrXlBDe7LXIIZDTUH1qscwd9dqwxfGcJRbi0vtDVT8sV+xeKshTcy1?=
 =?us-ascii?Q?ydz9UzAVkyc+mXi+hS7hlPqLhLN1DGL6Uy7tHyLNq4+3AubnH7DuvhEJ7jid?=
 =?us-ascii?Q?bidXTiFTbArXFsQqVSN2fJiUoMmacfDba9XGeFJEL5eoDop5yWoDxMBJlyAY?=
 =?us-ascii?Q?gOtQ1Jd1SbXcNmbffOJJOg7XfU7Vdg7ZvQC3i2ozG59fDM7sl+QXrMcZwT2k?=
 =?us-ascii?Q?NHJvpLpL+qrDAI5I2hwfWjKyDxOZ15ew1936TklXHTltNptSvzwmiDgJIbps?=
 =?us-ascii?Q?hRSMLWu+EUt/U+UbKtmWtjXePTcK3A6w/9H2AZoWvrPIKgN1vlVVzqQUHkuP?=
 =?us-ascii?Q?fy07+Tns5ZRYht6WmC+d+zBX2Zdir+V4PC2KwK+pplRJRaD0NJ8ITG003ZM8?=
 =?us-ascii?Q?mm41ptCekFi7R1xzCZn1LR6SRvBKImTq4jQGxbKDlldTa17K40BHysgtwTXi?=
 =?us-ascii?Q?4x9XSHcbyRFXlQSKG/TKsLzwxewWTS/4zycRYi3PtuY+wxjQcIh75m3J5Hil?=
 =?us-ascii?Q?+9rQiBv6b6Z460GCI+O7mR1eDkM+MK2ieH1ZLZ6Gl+J9ZO9cBXGAFNDAYCrL?=
 =?us-ascii?Q?3vxvLlDY34jT7gCGXVrw/3DniUvywmq7ABMV3Qbhf4+3uPuWiqhoeZFRMWS+?=
 =?us-ascii?Q?hYTnVjc+mCohAvlsyP4ZkMjlLwifuO3OwXN9+tC+/0hYVGys4s7RuV+AplHp?=
 =?us-ascii?Q?5Znb27tO5z8dQgigAoUgtBmFAV88loKtZX5Kf2XNdT1vZZkawBdkfgY/i94q?=
 =?us-ascii?Q?26V13RwRrJ2TtV85h3YLr7S3B7415aiH9r5GbhmejVCbKTYyVAtbgaJYA23r?=
 =?us-ascii?Q?P8ZsM4H9bwxik9Dp4nCJx+RsHjfjewbvONJgzYjVvOGeGG9qbFlj3YAjoBoj?=
 =?us-ascii?Q?4riGx+4M+w2neGlZT25sv5pT7euVfP0Hd7OrNENQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638fe4dd-9309-46b7-c336-08dbc0350e93
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:31.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn+KN412R/H5gNjwlWXy+7j66nuu8JsxGitbG6Ufm8+zz3hTW6ISGSN9eJdrxmP5drGCHg/CcG+W6twd6KMGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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
index c4b79629af2a..76432daad334 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3139,8 +3139,7 @@ int init_dummy_netdev(struct net_device *dev);
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
index 606a366cc209..325b3db4f420 100644
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


