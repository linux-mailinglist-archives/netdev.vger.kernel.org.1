Return-Path: <netdev+bounces-44744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6247D9817
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D65B2121D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D41EB37;
	Fri, 27 Oct 2023 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hj7NozoN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93331A733
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887C129
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJyWU52LPT81wBBHzYdpr24wHY0OQmWWWoNh7sJjZ2GLmaP4r7qG/q4JkHxKBYx9oNp544c+WarmvnWIivaJ7jqHWr1DiWr4Zts4tYzhK3TnqjpN8YvqrPLrIw7AiqfI27JsI9V8c73dU4RWu/xT3o1bNJo7w2wzqWVf+MbD+3tt3lzLTPIzcf108b9cjgSJn6SLwK/evm5oyeWlXB6oaSs2g4TZbyd8pzO5JXiPS3NVm9dWUFmO9XGMXEULs/M4ZCr6lLKMlr1XlaFsmSn+zWeTekFxwTepKtxqGU6e1KeYc2eMSlmd5c6vNgQmmGAfrWVHZR3gqqNVY6T19aVOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tR0NkbS4z8C43ysp0u8ejQej+LPxbT1VZEnq5vO/DY=;
 b=du3yZTWcuOfwyWbBOqQJeTx+yQjdgzAPVPmUh3QWg6ff4VYAgv2WRrVNku0Hyl3chFe+MDfdI0M1tPMzXPd77HIFaRBVlelrG/4scAxSyBgizuH+uYgvJ2BE0WPkeesqyIJGoyRgHgcIdf2H1eA5DW7kXNEUgwR5LK9PFgv61sH3qYS4jV48oXmkc9GP2pSdsp+zZmVSeN8spPVLOXiyadh4FrOCEusezmYdMHmx3aB2xvLoUaRpky9RCErNrs4j17TWSENeLIawemlSMFjlqm65qcoS9rQHC7wFsE70p8q0o74/jUiExQjP7sd+mw54x83zD/pify9i2TistgTHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tR0NkbS4z8C43ysp0u8ejQej+LPxbT1VZEnq5vO/DY=;
 b=hj7NozoNUf1TN/iHfTcNP1GQ+5DWqc4bMVREbzWMMOLW6JCGa9mhtMSKO0UeHCaFa4/vg1skGLp28AHZ7xJdiejY9Y8kaHf8oSSL/IEzbQMOvvd+Cwwrun92nbAdWHd8xtF6FruzqjZTeHFWYCgl8tyq94OwweZgXL8KF7NYI5/XpoMEmDahsE4eBno6GrEQbVDvfHJ8gwfTRco2G4yb2CLX7q+EKg1Kqg+ZybysYqNhV9c26rFMXz9re+VbId3SM9Ahr72zoPrsEpFRmD9aFhHlr9S0EpEGv6QVl0x7BJwVYoMOt5lYi6UqvvUuiDr/4Q7Bo1DJBcIH6xhbDVKmdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 12:28:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:21 +0000
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
Subject: [PATCH v18 04/20] net/tls,core: export get_netdev_for_sock
Date: Fri, 27 Oct 2023 12:27:39 +0000
Message-Id: <20231027122755.205334-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: fce77ced-ebd5-46c9-4b37-08dbd6e834d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O7AmGZ45epf2cOVpCnY6gANIVwm3pymN8teO8Urj8LTauteOpxsTmN+StGCCVq3ozSIAOBYUZcyNOF9EJwYGhL552v/mRSS4tcFQ89m8Eve1rRURTd58cPVS/XOpPkjucFD9GfRKHGlF+Tb2USKhfYLosXJqUcvUT4AF9zekMBhMxjwJ2OfhFlwIianhsXRU6Pab7nlLI+/VPd3n4toq3GlQVilEuc2bBa3PXdcUhahYSCB/D+XB1Q9uq4W9qw+Biaq1cHS4PZhWW1tCzUq7jadVPCh+nVEPoDnBDsT1k0oHVVExUtn12beK5eSXNdsi7mAV6G+ccAfNGlBrwTEf327CImOF9a0VnQPRCg/JCep7IE/+ikqIqTYP6WjtTiS8F19R2EySaBde8aoUrl+kEyr4tMWcAhy/RJ6pAaxzeSXPSBvR0N60V8yLQNuEJZGQdOqbjD1+iPx1f+5Rb3HOKdfsE3lfRMWIc1Mv+ex8E3oFG5OVqq6KOEvpOrvsSNzrucS4qyMTV9bnz6/RcSvye9nhh3Vik9vzMimB9lti0n63AnFC823VFjK+coNmKAhI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(38100700002)(478600001)(2906002)(7416002)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olw4vtEuOr267f1V+Chr619thIQQ5MuyZFx/2eP5p8fxmvQ5SmOdW2voPWTI?=
 =?us-ascii?Q?vB+s/rD03LevaIzvklAmr6yoIEcNOG77N+WoKP448eFoZ1w/P8LSGDUyvkle?=
 =?us-ascii?Q?Fn6O6L68hQVsQNUk/ehjx1qr5tH9tSR/Gl1F4QbdJPwTu1stC0pxaIRYlECY?=
 =?us-ascii?Q?0R2QZe6hkC6//lHASW/I2lXF64SxVc8yiL2Zbb7twMXdsIYwCEXnHLiHG4Wl?=
 =?us-ascii?Q?xS6dDIRxz8+QaU5R9U+rrsfeU89OnXrleROWgR+pY43Ae2avc+nKhyhzlMkJ?=
 =?us-ascii?Q?amcL1duuP220qEEm/pPxEi4o74LjhjBxxV+O2z4ZrBRoteLr2seFNPccCjsU?=
 =?us-ascii?Q?aj3UCf9mT7iONhpm3ZNVK+Gck2Aa5pF6hjj2hx9l/kRjcE25M39ZHt11fEHD?=
 =?us-ascii?Q?HGmnHkXz40wkPEhDkVpUNhiR6BZ0HelLFybC78g5y+skMZnkq73cUCqTz0oo?=
 =?us-ascii?Q?/N5xUP/4h9Sb//msRIb1Hzuve9a6IJsALuxrEr+le+B9nyMmY610j6ehH4Gc?=
 =?us-ascii?Q?lPAGAANpsAeoweFBK7uoBPiQOD+VOZgQJziCWU/imx5edAGSYQhv/KhEY1YH?=
 =?us-ascii?Q?8tQ0hOW+ykcu6yA2JDJuiVHVwvFMN70c/n29iRfaEctUfeoGpaXi/5qgh7lF?=
 =?us-ascii?Q?PGoduUFSixzOepQvdXGTDxq9ocgCy4jOzgyw0Ep5Bd1MeVDhzbRclWYlrvie?=
 =?us-ascii?Q?JPSraDg4joh6BqIDzEM7zwlnkqAtozutN9yXA9Lo8FTCm+Qit0/ygkdsf/dR?=
 =?us-ascii?Q?awlUDO/iBEx1WsW5acCrFdCBX03g4RnLxl3AhSrQUcHD3itj838JaTN7WlmG?=
 =?us-ascii?Q?QfFiogUJMf1ADOdkN/IcTGQjX1PmIgDRf18iOi5l9zgLnRlnF7wFIuidP919?=
 =?us-ascii?Q?Lk6Cas3tc1rbgWbzTONSAkU3q7kaGURoaEU9CDxbOKFVOpMaMk+jcNElaGHK?=
 =?us-ascii?Q?yxZWcvtbCPkF90hZr7bViRo3yot6jwnTnkuQQD31P69PjQN9aS3BOrb3PV4O?=
 =?us-ascii?Q?6fTrKOsTEXOsKyajd4O1aNOZ8OhUZ0780PUZ354w18dzY3oO3GCSXJGl0l5s?=
 =?us-ascii?Q?aM9OzSHvIaSEh3vXCXAkHH+Up5wv0lvV4W7+QW6X4TXf9x8LUD1jEc8sjum2?=
 =?us-ascii?Q?hwFKIXDagLcT9QoNV+q8y52iQzZ40kWLfVOWGMTAcXTRPixRKRQYNJXiJBim?=
 =?us-ascii?Q?WPNFZUDfMz+LJ7GD3tRXJY4dI4EciaBVMtI4s6d7rbUqJC04S3xzZfiKaQeO?=
 =?us-ascii?Q?3rFU0wuNS3+02PZQWeIIoFHmDUPmXI7S2XCNo3KlH7P3lSPrwXjNFUDbUPeu?=
 =?us-ascii?Q?0XlkSu3R1KPG8tjAADyR69LVGZDs5eW5g6g0/End7nscqCy7SEHjQxieRsPN?=
 =?us-ascii?Q?3V+pSQHmENUZ8bsUnYm6hZcmblxqF1iqmHbqvRQgnE7F5qP6u5jLGrFfCBZF?=
 =?us-ascii?Q?RPp4I/Z14NwYlZtETRuceGqymuEVOBPP/0x65XOJFvL7WgFMJCmEBjS0T6a8?=
 =?us-ascii?Q?ik7ikCFsZbxDL91U2mgTpqvnGFX7fHiq2o7H+ulMMqlFaMaGFABAUSiyF6Dy?=
 =?us-ascii?Q?t4Vb+eHvudkPcBMkjFDCwzeyNonfPjO6tNFGQm7+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce77ced-ebd5-46c9-4b37-08dbd6e834d4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:21.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjN1y9f9ySXSamzzAXfMWFfrvEz/ITnVonpPlQplpBWFADznAPPMCLMbwDqoSxaUvY8N90dv9xK5Ed++uNboVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
index 91ecb76cd9d6..848051f20d68 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3148,8 +3148,7 @@ int init_dummy_netdev(struct net_device *dev);
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
index 1025dc79bc49..6762431e4bd1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8252,27 +8252,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
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


