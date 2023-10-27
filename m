Return-Path: <netdev+bounces-44745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C37D981C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7FBB2144C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED91A726;
	Fri, 27 Oct 2023 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uHlopX0b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3D1EB2C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C2FA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYDM4a+HJEK/Z0w/qYu2uyedGyvrULoJvBa+nnuV+BRmRmjb0irF57e0ENL0Sj3lIg5XIAr5Z7btSDParbKqbE+Or4SVAcZBeENKkSdpu/8rjBAEPOZMbMldrqlsVRKmFZIdF5hnYalMUOKuoSfFunoEJKC6y4qLaYHaJua0uwYZ9pS0XIMGEBTyt6tiIVQIZir/Zr+iF+5uwCf0bkg57VZXuohI1iWK/38T3V8eVa33ep1XHo1kLnjrxM/o2ww2i2xTw44DzCLQGkCW2R48BuRLXbIQxds2ZVGyof9hTtz1MB0rOjrLbOlMqxuXz0NB3vXcUWUglokjwhYHl1rYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KUU7A+9Rv98WSZZ30oT27Fr0T9gt8+3yI0PGq3Bw7w=;
 b=NEQ0At984THLKUxM40cK4oU1wsz6hJQ/DZcXtm7CW46p+pjtDjbC+2tOOOHayuG1HHcrrzN1ZHDO7VRm/m3JThZbawdJOmmkVhkxHHQgMn6AgBiV41jT6ZoQF5j9hL/IMYzydKawMZ/HqcRJlvaqejNcNL5hL1sQLbG2xd5KZG47Y5sDQ2kzC/Z+RmEdIVCxlKRSuDSYI5ufTM55jRqr7l58G2ilHgJHkaRA645+ryxc3CVDYTYACrzo1r7u4cJRW5YDd0F6ji7oKEMPciveXnTaapGLGBP7LF5KlgghROqyxI57gHe48zzlJ1ZjEco3T1w6B0eXLT+GqMfB0PIDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KUU7A+9Rv98WSZZ30oT27Fr0T9gt8+3yI0PGq3Bw7w=;
 b=uHlopX0btTktp1R3RvHjsbXrbN1CmZ5HLW0k7j2pugMaPb/bHXtncvQZoKoi7qutNmm1irHXPU+Ramc0DGk9T+Kq7egkegcB+hh32n8w89ZBsd2659ttdBIj1NXygOZwM7D+4wuaKP4GS3zgHuFQBhd0cSd7yEvPNdARPAsov6LUymH0MMtLNe7ZBjsmWfQVOqCV00SxPyocd8sTdnMDBjp9VAQgoEPywyywtvrp/qC1w/URW8yjC7mxl+D5ivfkaqyJCqElMxYDkIGF4m2lh4bIx4XBKf60o6YfiKDlMPcgSLA5Pa72Lvtj/2BrYmDDdMO/KIxaHsRAMnMF65Isdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 12:28:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:34 +0000
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
Subject: [PATCH v18 07/20] nvme-tcp: RX DDGST offload
Date: Fri, 27 Oct 2023 12:27:42 +0000
Message-Id: <20231027122755.205334-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aef5c5-2bee-4f1d-a22c-08dbd6e83cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+aWLZitGif2WVDOdRgg4HW1/T2bwuMcYXRXiAZkewsHHco/5B9CKsHgJC7dZI4GDkEMbEh8IUGMYTTCElk7BbEOLsKECclxEAU/S4TawgaxR8w2RBm8OtmrITK33QzkkdYX9ityXpOoRxxUVwmS5Nr6Wigh4XmdMzvnajqcm8ime0uhHQCNAa6v3OfxaFKDpVJRF3d2onEXUW91EA8pu1pjrkjTQ0io0F5zZjlySJ2lIjPUtkWtxOJOVuRcLmXHAP2XaNeO+qdS+EIVu6j5SDsH4QJQ7CqaRQxKCvwHgh2/uz8NRoCk3B6OS2k6rsiyC2/ikebci+wY89tS2KwJcHufLiKHS9lXjD+Xz8nBPz6cNyL3B0B6Vu0orULP/zyXkMe3iHRG6Getg0Dv+DsabwkCNG7i8RYMqTunLKrlTfKGoGCqyYHBn1ZldE2e8at6joWSXu6h0fPZlURbIjruYKnXs4TnNVLyXzBKgERZLWMIQUx6ae0F4M8sDUOKOLLcfTkZ+39erEWNWD9M/jNP27NlP40xUJbg9Ps75pS+neoLjrsiwabthDgiueVS1//XP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(107886003)(38100700002)(478600001)(2906002)(7416002)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WzycEu588TZ8IDHLZxc85rJcoQXpdmji9vGNmxSVBQkeVGo30fxMrXavRR+2?=
 =?us-ascii?Q?AxNZHJVXbPLC+gEUiqSRMSlY6Q6NNskpdA+2w35IE/unwPQ9yQ1dBU8+pZit?=
 =?us-ascii?Q?b+rs0ztxismWZwX4JiceAH+I5t5vGd1YrjF9QZCOmsz5hCr7sGh/LXDZALqC?=
 =?us-ascii?Q?gdC5DndB8fKZ8X95V319Gwf05Wbohayjs1pyo+aGkYdY4vtS9vPUxek4iK1B?=
 =?us-ascii?Q?lFE2l5MCRhOHBDbaEWzlMGRzFLvqVWtUei11+wUQdcmBeUmyuzEtGix4td2U?=
 =?us-ascii?Q?irldS4N273A0SvsyCwsgTRS78ixigI9eL3qtExJCj789U+7y9WfU5YQ8EOIz?=
 =?us-ascii?Q?HgZQTCtJXTOHRQ5HavzY09bgFm/UnhXe1AxiUTgEQnNWvmrP94229nn6Wewa?=
 =?us-ascii?Q?gPEqjfIORtxvJfag1SBOXNBV/yySGE8T3sCFNqZ1844x6l5DEgZ95tsw+CEp?=
 =?us-ascii?Q?yPCx6PY24ZA+SFBhVJo9QZH2w5CJ4MtR2p1iphl9gWeqAdwFJDQwO4WsAmbf?=
 =?us-ascii?Q?djf9Tk6ejEYMvVCQT94vOSjKbGTJVqKfRLtijV4y+tVvCmc30Ux3PXCPGIq1?=
 =?us-ascii?Q?zy5Cohh2B8JA52C1pwSlHwbSob5zlXChsGeu2hAA40WPxZT7UM9f5amHBqvF?=
 =?us-ascii?Q?jh6MeIrU33GE3PAvpaKHQuPzOBODr7t9rP1gzmmPpxMZh18W+KvB1xZeZvq9?=
 =?us-ascii?Q?8SmNh381Re/uwmUEaWvvodwXOKadGNEw+01BWP1K4cuwNmcQdPQuoEMwSCIl?=
 =?us-ascii?Q?Jcn4LuAHW5N+qBv/5C/08hRBUOdgs2TZqXCBQFIpVTC0B4CKpgtLmDrncGcH?=
 =?us-ascii?Q?BRVtcxKHdIr4MCw25/76bWISnU4ufXCZn/EJljx9FriaqOTfJ6BIvrJU+o/v?=
 =?us-ascii?Q?WCtEt8jpC8Q++a5XQVRr1e71h/nwA4gd6RfPNWfOGYmcOPziuTZG5jUN+DV5?=
 =?us-ascii?Q?P/6eP7OTuigtaucuVDCEX1Pi7tDtRAKRA8yDuFkngN3ZBdFMsv9q+My1mSQQ?=
 =?us-ascii?Q?NW2lHt0sKG2efdTVKtmNxGd20vvXFGmVGxYHS3GRP0QGebi+8mEStXBkTMfJ?=
 =?us-ascii?Q?29XOlMlzMek8plyZm69wDzDFEGwQpEVxfiJlIsfrh73EmfbMvZaBtDSjYGq4?=
 =?us-ascii?Q?+toN5yklxWKVGkFef/LCDsuI1cWAK/pdDUiTThoFjaCxaXpXclDQudQzrU7U?=
 =?us-ascii?Q?bPL3xsfY3RBLKuuNqnyxeqM4SmajKX1wOq78AOS8+6PP4M6N1Rqj1/lZeY3Q?=
 =?us-ascii?Q?/t/yl+X/O2NRiRoyi+HhH7Ccj+SRMq1wB+2srwdm4f7pCD1lk+rXYn45ESsb?=
 =?us-ascii?Q?4nr64eFjSLL9RJewGtLje9ow7zQ54gIIvX4T9j92nt83X+Rnqjr9cVBJyuS+?=
 =?us-ascii?Q?pTyR1Qfy3FsbFAA+POBRcphDch1/fisQhsnvIk17XPETw735i+eFKADu64b1?=
 =?us-ascii?Q?6nsGxXETfQZsctcCZSgmcGsfg6ABNmSQcl/vZejwxjGsfB6nhzqSqdvYlllR?=
 =?us-ascii?Q?Y0g23oN27IjcabvOQIlp3jHKhRaez54/29FGt6leNpSqA/pm/b2S7EkSOhAo?=
 =?us-ascii?Q?Sr9QE3tCAQRyUWi/pz3I4CGXS9pG4nAIqhHf6VdT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aef5c5-2bee-4f1d-a22c-08dbd6e83cc3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:34.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAAVmjl9Frz3zCBIBFbDy5k4vE2FWbViTZKeAlwwVjDHh6Wg+Ioppe1REUocHbuUAoqjZfI/o9IhtRt1DKaYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
index 5c80ee089ee1..5c20f53b8002 100644
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
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -342,6 +344,33 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return netdev;
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
@@ -412,6 +441,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddgst_rx = ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+						      ULP_DDP_CAP_NVME_TCP_DDGST_RX);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -431,6 +462,8 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -438,6 +471,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -537,6 +571,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
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
@@ -797,6 +845,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1064,6 +1115,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1092,7 +1147,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1134,8 +1190,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1146,9 +1205,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1159,9 +1234,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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


