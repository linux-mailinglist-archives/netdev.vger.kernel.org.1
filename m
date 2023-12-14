Return-Path: <netdev+bounces-57438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5981318A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874121C21AFE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA25644D;
	Thu, 14 Dec 2023 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqvzJUwl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665911D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSZNU0eOIQEtYgcubwrQvUVuARzf0MxapZ4w1KJOeWFX/t17eNlEivxrFY90O/4ZxKWDQwwZrftoCB9FCGjUno49rbiU3445+80yFyGQqgzazJ/5S4CG7cE+YXbDMeu44lpcJSctkSeQ6tq0i2uBTJqoVwv74eLSRMaKwWFN6s/6mw4obvj3z1UAR7mPJsJuS5/CUMl9OalSmq1dLrgqQITHRC9C/xVX5T0aK7JFX0Kuy6x/UhdKj0uaOEGHHNz1fqssJGgvoS9+evY79Vgx+gst6p0xDGAjazk+/mFfgTwLo6tzX8Pr4W1UqJOb5RPehHKwQqEnXUAsM9KNrdYLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW9jBb6wegwDS2vVLzzqTrNCVr6kMm2sXwm5fuKeEco=;
 b=e7OWjYEyWQR1T8GnSmvcVoaOEuCvjhFw3HsP6v0T/d/edZ5hmcuRQJdbynj1lmlqYxuYqXvq+dZKN/8xA7MlicfmPlAdXAN6W66kksC+B1FRvJ99cusOY8dn7tek2hfHaBnnyafdwzcxFoz3+Y4HCLpZ9yJfv5k+JdstNHiRLtNPePTNLOkceDBgwbQcbD4MbL0dWIpEx/74ZsayChcQxu9C7Bb28k0HJKG3e18nI5Ajo8KCpdRdMqDeWjEzdeuiMcx9xshjTeoDmRu1XB3MHsFWlIzpnL6xbYSjRjkUgsaQSvkJyZHzpDQnaIFruUfWWME4xIQWEb+Nytu1j1ThJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW9jBb6wegwDS2vVLzzqTrNCVr6kMm2sXwm5fuKeEco=;
 b=jqvzJUwlJABw2mCOUb+02RjFzXrthYIr0LXSuSD+tGHnzgJ9QzuCsjJqhy+VunTuI6PSBMMrzWfiJfxQ9jzgId5Q6FkxG3Y0UcTwGU1394k0q28L78FEigZ20OK8SphCISPoFpQtvesDL/MJFrsmTpyrhykPD+w16mJt7dGrU9ASTFQvDoyg9aY0efpxEa36TN9TnHd4f91ZWeSiqDSayhz/bUxrNdJi+Q+1VTcndyI6r7zq6l7X97oy/vcjegmeIL5hXMn/QZEQK69RlbwreDp5RuplUtNsOo34yRmJ0FvYlwiHtu5RT4bA2lG0TSCNsJeNyBMAr+DuA9rl9yZZ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:11 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v21 07/20] nvme-tcp: RX DDGST offload
Date: Thu, 14 Dec 2023 13:26:10 +0000
Message-Id: <20231214132623.119227-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a143c8-3af8-46ff-f9c6-08dbfca860e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Khx+4JKybct1yviECtq3lojv6Bckb6AAjny0HSBtg9cedTNfVp86KkwFkg6Ui9fCxqB/RVrlXFSEBZm8xSqQJR67XRX5Mo79RSioTPpbD5PD0U2JwvkttS7+RUV7M2CON9C5oQeZUY0Zsn/C/GtF7J6YhuYpHJ4cVAZYNGEtfihzqhFf/0X/tFfvoKURHLZ/SuqbOa/q8diP9C5c+viqBgh2+OQ+EgUxzytSdoHVRlYGngCAWLKytL2+RhYRuZBUwCm7gM95BEFKCNy90lMb2X2AKcAiBXZ7XWE6xTgOtqwbo/lN5yIGc3PByxfmYlDhek4psFEKr76re5XiGJb6JHmWp1OcZLM/OXxBHioHVA4hhUsc8iW6SVkjcxlX6a5/KMDwTsc/k93UwY9lMcKJRVWevvJNX1vYQDmQeKFWVTbA3Cc2wcgM2uAg+N6rpDtD6reEtoBLbYfa7rI1toAZ8Zhk5kQ3cTQXqETDZeDVweQq3W4gqQo63SZeT4lP3kJtGyXLNVq6nioP1bvZ603q2zVidC7u4pP/UjhAO4bOTNXiX3vPU3WOYZeHov9iHAfZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5YwcpvseencvQykc7NIuq2iM1pzWYn2zQVGgfKq+YoXDj03g0Bwdndo0xpF?=
 =?us-ascii?Q?RDhOE2KxVi3W1uD553RBDO5xr1YU40JhX5fNoHCucT8ZqfryxwA5ViOSEP6s?=
 =?us-ascii?Q?vM+QkCH6GmDsR0p93GhdR2HjzegiSuQK+lpspQuQ3JRKX8UZXlmTDWi+QTZw?=
 =?us-ascii?Q?jSZaKPt6HEYs8NMM58P6vYgPl1yFwtqfmyXVJv5/Iyr1gmqftN+jF8mpuSn4?=
 =?us-ascii?Q?79BsQ0b4G78oplmTOwybPUeTQxBPJqhxOpX6UxaKsOYbwfV4CdK9+Rw96uhF?=
 =?us-ascii?Q?6jBS444LiAnyPNWcb44ChCrzf93uuOU86HcWtlSeuFMZ3WTMFh2H/wL2k05Y?=
 =?us-ascii?Q?9/Hq7sjQCOLY2Qkv2vYgDpFc3dqJGyA5fXW5cVUbl1AyksMs2i49yTRl/oVy?=
 =?us-ascii?Q?V7kQBpkmuFWzsF8MwVgwFHR1afSHYNqyujL/BoFWfZsClu/o2NExniBQep3v?=
 =?us-ascii?Q?0aQ8cBdZBNhwHsgMPAL4s8mYjysVhS37lO8DGzD/yxJC/UpUlJgvOTzBpgkG?=
 =?us-ascii?Q?sOh7ZT2Sw7yCykvUvqMtzEbU8PFnbPK0cAc43wTfXP4BtYAnSOiMr4Dz261l?=
 =?us-ascii?Q?7PzmpkjQqXsgRvdWfmrq/LgfxAzAvQn4v+BH/8ls3COmFgVI3rHLdoEqXf45?=
 =?us-ascii?Q?D2v8OShPQf2QKF0YQxbe2SnA8vBOV4DXXQyow+BFnHR/bGeY5lTadksbfHpM?=
 =?us-ascii?Q?KFJ9jzTnODdTIiZd8V12dnSYG2Ffo8rituAaVWgRnnQo1dpM89YsA7bbBsg5?=
 =?us-ascii?Q?LJV4xTCJkOoib2kX7xFoB7VHShSaP+Q0/WwwcIr+ZNnN7vPbu90a+YT9jaAw?=
 =?us-ascii?Q?mL0GRp4gGosx/5dRnha9OcKdlFaFy6XAeJDu18pswggV/xXw93uMCLKkuE1r?=
 =?us-ascii?Q?Er/wyCFXwFT0uxgDakHhZ8GGCKbGYdPPbQSeWtzXtizCE2Njm3m1QrFQ2oiQ?=
 =?us-ascii?Q?Qf/8Te7QMxiukeGEbGrQ222dtMpDXasnxWANLduTbdMtzIYTedKAUvivewAW?=
 =?us-ascii?Q?msuKTALhGff0kZSHb+GprzBQpMPPXqeIAEiG8sR4+bBdLRG908lrAIQyDgGm?=
 =?us-ascii?Q?HjR6dmknzXIaXxS2/HjshPVdof/b6nUmziylIgKSetvFiomkljabOZAFdQ0H?=
 =?us-ascii?Q?ktDxi2oV/mQ43KBtYzTdltqxRSBValZBABM+Wst4XBYfwN3hciKak9sZjzCU?=
 =?us-ascii?Q?JO9/V5nFyKRKiOvWlJNkyHBuJHmwGavtrOoRJwGt/ZzwvGD+OfCklSK3l9/Z?=
 =?us-ascii?Q?ilTZZeskA8NYBoQzAabrXSbS81J+Ia9OOQuPZ6yBZkgj2uN33X31i6EBL+Zl?=
 =?us-ascii?Q?+O2CrSNVb5EaB4MjrNFJwTgVKKC6tfOv/2ZUcEpvP293Lcd19c43lzR9geMm?=
 =?us-ascii?Q?mqKNwY/MCcnbXPTsWPOP6Wqk8gRVMYXTJIKNcnpvEkNSb+7k18lTvoUxwfYO?=
 =?us-ascii?Q?wt0znhLRk1SY+9gy0OlCSSKsulwSQMMPEFeBldgrwJTtZvDpkmEtFwK6AKF5?=
 =?us-ascii?Q?RR8FYb8kEOdRzC7ASkmD1oClb0ufIxTiOG+aNMkl1/n9uu6tNXGi9zLayu85?=
 =?us-ascii?Q?3NmrgKA34FxmApS05SyAPD3giHTE5BgI8cuTloc6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a143c8-3af8-46ff-f9c6-08dbfca860e1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:11.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rAeL/daokrUGVLlvz6XGhUhA4jgYKPnT37G5WI81+v+HJvxBbM6Ap1e6qtOE35+Pzls0Do2UiGvAWJpA/W9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 81 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 09ffa8ba7e72..a7591eb90b96 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -180,6 +181,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -378,6 +380,30 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	req = blk_mq_rq_to_pdu(rq);
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -467,6 +493,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -474,6 +504,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -582,6 +613,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -842,6 +887,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1107,6 +1155,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1135,7 +1187,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1177,8 +1230,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1189,9 +1245,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto out;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1202,9 +1274,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


