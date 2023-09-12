Return-Path: <netdev+bounces-33137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C079CCC8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84656281018
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B1171C8;
	Tue, 12 Sep 2023 10:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2761640C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B46E6D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEPUCXnHwptOIys7yIkW3unjCkh5NHeZiaU6iyTXAnNIT1OnPsFI9d0C/86JFZrwgPflE33Oa/PklPhfnGNBbY/AW2c06rftJv0jIJ8DXuF+1q4yMVe0vO/5Cos1OMtWHwVTrSOk4usiUHPVL5jKlGT0nd8COC3RYEs/e5hWeZYwbwapP+JH3lIXkpuREkp/K94iE5c9se0sv9tSM3nTrkpVkJPGeSnCADZBJko3jAXjtQj6xhysKaHbqjIo+w8gZ+VthGLEw4nIBOn9J2ZJaa3bM2/3YMqkQgRmyZZJivQg+kiyEEobVLr0domQZSpJypWL/ihV3R2h3s5UKFkN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKBP3NFvh1OASCaUrcXtr4VhghyT9tmMSoKDRkXHGAc=;
 b=jRAUKPi368HVcnRHPRnCyB7CJ0EhJC5WqB6xaqwK4V06mv84lgss+Rt9OtcbjvrT0/7iMw3573aKB7KjoCyehAtcNi2VuamA0k3vaiNkZjCOYz9fNxIy2lMWwYbzdj7aHtkPwBcqTfte//+BAA3ePTTflPGrEwrDGE0HmyQQd//suvbF+ofSRuGhkSLE+skr0z7PbTchSq6RpuGTsAo3dyE8IMTTEZ2M34BaGzE4ON1iTg7GZNGYlqkhAvZiwCiQxk4YioOQrjorfpBzNNSSQ3uok5LwHCVZx3vwGYUF7Mey91fwwQosMMzKUf7ysX+lWnTOMuJVUgF5Z0HuCw111A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKBP3NFvh1OASCaUrcXtr4VhghyT9tmMSoKDRkXHGAc=;
 b=kqkVkfPkLRGbHSFzB8WkQxEoT2fAjCFJHUNNPzrnrOoJeZqf3Bq9L8cOH4g9x8bXLnbY5IlzXTYBhdeyk4+CVFUZOk1z7Uo7P/o9bDzys81aznmfxgCjtDemUU6hjHjqF4JaiQGYewyVL8gGPj9lOG5MzaqO2cuoFHhxq2hI97PF6N46tN4BPnyAuOAo7E+rsDDihjSdMHqDwTXbRzP5TeDxZf1LWbGiuXPfCdItqjmP63O8oBN8cKTozfty/se6wlv2LjQLrn90xqbI82do+O571EW5Gw699Ah62xV2kfjfeYFBfHhoUfsJs2bLNGfxMX1kB5Fn2b4Xi9WOZNwYSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:52 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:51 +0000
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
Subject: [PATCH v15 07/20] nvme-tcp: RX DDGST offload
Date: Tue, 12 Sep 2023 09:59:36 +0000
Message-Id: <20230912095949.5474-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f8fab5-a8ed-41b4-b33c-08dbb37725ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qiBD32GvANN6fwUGWo/qWmeNleWj0NIhhy80prAZ5A/Oh0osv1l+pxygvS4opWudAvuwXKuhQpE0k29h/QoGklSgoCQVBbwDCFiwwl+TZyBtWJ+IgD6Am5v7QZ4q9AIq3bhC66gEFl8B378ZKjs4tWngsNBRIp8xqyJZaP55EFs8SeqSQFHiPS/MOCB7YN+KdvKCXPh2KLXUYLXGNN8xCJgl3oJJTt2fUUCwlW1rl6T7CjHKNtuoCcUMDOVdPjHHzBWGYM/+jQDqqRRwEOxz8TWUjigZYA7NeYmqGS6O4EmPrTN4CnYoR2EJ5HtZiO9a3oS9DKD/IsRK2yJw+AfJxn5iZdY7gWZ2VJkVwSQaUo1/G7lrPL4SCCmsdD5LV1P0s/Ve9sdqIXjZ7kCDOhJ6JHJhyLPHkzN1BIKDulH+MRzFzAIIUh8jyc8ta17xIzXkiUGZeHds8u2tJSIVJs21veyccdWloJB59/xuOH6npW8cthZCHzF7MN82kc1toCMIddS53qj1JXf22oOC332bsTJf1dS6kLY3mGOgWfJMzy2qFbdohxkQjBZYEmKb3sG5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N43RaYSSa2bFN7RykQmZS1/OIIhsIrP/Rk8KkKyyoQ6bpRPZx9UEh+SXJz7o?=
 =?us-ascii?Q?0CNVeFJvlGBVOeY/YQHDZkkzThCJFauI4T8jKtY4ZLPeUd0rEyx/UvA2Uiwi?=
 =?us-ascii?Q?uMzRSYGbVKXxjUuWrOiK4MO1TaoF+sE8fZGULGeTcv/2gdUkMS6Pps2Y3+3S?=
 =?us-ascii?Q?jAbKdvGFk1ddgmIKXJNbyuTAm6xal7bzACdeAsx49aM/sCxo88gnoTM7Cndg?=
 =?us-ascii?Q?EXRkRzdxUug9Eil9B/rsg5Ot8ccYSPAOxCki+Q3Vf/JaA/0riH1FJ6Iu62Tr?=
 =?us-ascii?Q?C9VxazbVagIASYFscVad2CED3SLALtDVoT+MnR2pdvB9zATf1CEaFSfyokRR?=
 =?us-ascii?Q?AZAxpFYAOqdx598hybtTQFazqgQE13L9dbclFuIhANPf4RXIQfyjD0XS2M8o?=
 =?us-ascii?Q?KLxH2o1XT92PSvBoYkdYuzqN+GKmvAyju6WDEXh9NxfiPNKQ2lAk6wXVZ+y8?=
 =?us-ascii?Q?HVEM/7qIsK2yswEhVCytfuM+dk19xMfe7Bwxrqb7lnxtwMtJ7gYk6YRr+Es1?=
 =?us-ascii?Q?TVEjL9+YAf2tvl0RCl7sEMvYRKqdx3wl+cyw+t7vXefYj6cOUYJg1IiTaePy?=
 =?us-ascii?Q?gtLJii5mXcsjUB00N0lHkCO+AVBLXLgiRM+VrK87CPHmhFnKLbKVZxqIF+ax?=
 =?us-ascii?Q?ckV+/alZ5ZyK0nOHYzpbl7tnc1QiMKRtwowqWY9+S7PWhhWNLIdZ7Od3ETCx?=
 =?us-ascii?Q?qvEx15Bv1buTzVTyD68+KYNycs3kXqvw7O+PTiTIK55TmlparCSeSo+tvgJ3?=
 =?us-ascii?Q?/wqczaVXExkVmQHEhWhL5EjntDzqUFv6XYE4a+9OCi0I+dEKQ8+e6KBQJEAi?=
 =?us-ascii?Q?V+xvaiUt1j+ga2X7/x/qyYrbi43y1VlaRZt0WE21Fe5Lex7tcxXRMJIWTaBk?=
 =?us-ascii?Q?37oLayGfZQuRFT/UPEfeI2mUrjctAgyXjH828BQjkMDEn38R3bMY9ukfh/Zp?=
 =?us-ascii?Q?OTNET7oWvHZ1zMFlcjEXvCA/6CBLQUORmVYC26SYSsgtiCUiynbKSbJvv7JR?=
 =?us-ascii?Q?5qjTOiKLrdGQ7psKoxDeE1UNOmAj5t66uybgLn0BoyHZ9gd3nW47LgjLUcf4?=
 =?us-ascii?Q?S6FvXC8cg2QImQhY7XRMePtuluRZdHHkmK89LxJgW4ElTRu7RrWmYcUKay7P?=
 =?us-ascii?Q?BMCXvzPhdCxrKW3ikhUPLoedZtff9uT0BWzld8dwc7eMhaaGU2H/Cfqr0epm?=
 =?us-ascii?Q?svdmSeTEf83YnyaxFE5pX84s9ROshTSGyd67O4ZTmrBGk0C9f46NlBmN5+D0?=
 =?us-ascii?Q?I78llFZ8BWHGZb7L8Bf6R2lZCqV1qQX3gvIFCzIMki5PQUeYrP/Eq+ZPzwp8?=
 =?us-ascii?Q?ckBIWzjahQhyxDtKu/mC4kyfEKPeESlqq1Qj0qPY5OGLJMzolaDeXVfH9Hlh?=
 =?us-ascii?Q?4/m+7RqBcwZ8H5mVMDScHTLCUTDxD/fTUvtOO9Ih8FXChtfYexFgDZcXeTbt?=
 =?us-ascii?Q?Hyn+/E1lb5Px4mchaJCIpScSl0PC7/pCcy+J7kB0MOscH8MiO/6JzWwbHS1O?=
 =?us-ascii?Q?7pxS3o00mdWPa7jEeu2YpftwRNAIjzkBhDDH4KM0CCg1UXdFwroUOV6APmFp?=
 =?us-ascii?Q?LvPf0GW2ifyticY0A4wSylhP69im9FPsNmHtY2x6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f8fab5-a8ed-41b4-b33c-08dbb37725ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:51.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baZZfM7f1lovJYrl9i6+vO7+zQ3H8SYafzazdmm5Xmx4522N/6FE3gstiYypTyva7+yT+ZU11UjMhjP7oo8ULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
 drivers/nvme/host/tcp.c | 84 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 48bc8afe272d..6c7edbb78354 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -126,6 +126,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -163,6 +164,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_req;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -325,6 +327,33 @@ static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
 				     false /* tls */);
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
+	if (!rq)
+		return;
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
@@ -395,6 +424,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					 queue->ctrl->ddp_netdev->ulp_ddp_caps.active);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -415,6 +446,8 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -422,6 +455,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -500,6 +534,20 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 			       struct request *rq)
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
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
@@ -767,6 +815,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1034,6 +1085,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1062,7 +1117,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1104,8 +1160,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1116,9 +1175,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1129,9 +1204,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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


