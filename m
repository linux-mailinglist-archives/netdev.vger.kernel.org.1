Return-Path: <netdev+bounces-29668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C5784504
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26784280F08
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9F1D2FE;
	Tue, 22 Aug 2023 15:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAA1D2F4
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C719A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGFVgBu3D++eMEWE0bgQMoueMPul5W+ZUhfSZx5m05rCesfMw0jaN3ozH0KLSjnIL/jyK/8rTf01pfWBsqqhAOP4nhNXNvk8UD3vGSEiASwrTnO8VTcU74PFZlY2SMupK0SmVriCDePphkpCbZBnDTbrQYVVI9Gc+f8gGQjy1hS06vqi+VmyAzy0PDIv2FNHsSq8W1ejz3W/L0jxXpikp1oU10v/sQslWqIqyJcVaptIuq0z4zG53VDt4tgVX7u+KWiea5vJuEYAFuSs/B0REq/ARx0nG9v5nNc2/yHYQHGtItWLyhbpyqMFSkiw1R1cNhWbKjxI+khAQ1RvZdgt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmH3EyI/4LPkkap2U1z1YTQe7M2TWEk8INdMPSeeHWw=;
 b=T2yj+2ON8RQe1iRooSCWfpdqWFIA2frRUCIwpeVoqjOWp18itWF9tluN8zcYrFWJJVpnSTziHXPrbwW2KY6lFjA5D3rQYbsaVxFTzgY1NZuZASzWe+Os2D3r8GNgKcAN1MSBgMkWkLiuedjD0fSRC7WM1ncmhWNvI02txkIlc9QzvOlmAat0IqE6dK/Jy4gNAvYocLO0Pv4h7isO/+LeaHEz+cQxeXDAx8KWWJnyFHdlQSSPt/cU9xmq11catsNNVYCYT1OsbcMkYTDzMCByC7UfApyXYyqNdRfl//phB5Fheh9vUYCm6wSlxMwfrtz1hki1C4r8GhY/SsY5ZYmExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmH3EyI/4LPkkap2U1z1YTQe7M2TWEk8INdMPSeeHWw=;
 b=oyMuijwCx70Q5Xbe9Uwz/bTT19C4L8/LEIZVv5B3d0TV/ZsoYcRT0KCVXNMQ2fgtI7LalqO6mBpDq0L0PYooTzS5MduM3YbeQ8y8xfMCsT0L2G5xRrka4TLjjb8FEWQP/P3K/6mPyb9s5qA07q8aV0mIUcUqPefMS/rPaBXTsM1ueQYmK9o8FlAZdyccCSHJTryZInQY1zW1KZ9Hau2hp8YvYEs/g1zVOe+PKXCVV+0zMcTeVFQygamaKVxulgJeUerx1dIWUyipsBRAnV0dDpmYpEIcgleHuGeXBYylNaWsUlzRzV9szaPsuqMvl8IyawE6Nv4za7An+A7sFYZYKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:39 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:39 +0000
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
Subject: [PATCH v13 09/24] nvme-tcp: RX DDGST offload
Date: Tue, 22 Aug 2023 15:04:10 +0000
Message-Id: <20230822150425.3390-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: b4970125-32e3-4bc5-1528-08dba3213f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mUciKg+G9/y/AIgcyKIEYTOqhlFp5rG9KfbpH6O4KDQUY5235JSEpTwi1Rd3XqGrm1PjJLCntG7FK3t7Y5lg4BNxU2qGhBUjMZqPQDi2x0j4qcuxehgO8kEJT07ANEtmiLYNZCQVBXGHw5yOQdBURDtRRdK/vdnzx2Xtvfe9wnqzoUEDH/RHy5EPrBvS+2ms0w57beLaI6ft7+TMbypWKBgfX5koKTkCCz88N0KxI8mTZEhLeJtrMBvDKqipvCw71/QLmVHczPc1j0aNMaPIib5PhJZv62W+ZCAtLtLDJs60d5gougsM3bozZ4ucbQ/gjcOEHXG0k3AnjdXJzNI0bllGvfoRmz0ypYQfGkzUmN28UjarLRkW1XMLE6VGqcAwIGD8+vkxQOuvwf23b+6AGN81zmPx/unj5B4cx5sjx8MzG/b9o3LAMnDfAZa5dtMe01crk/ekP0AytWRSJgzJP4NEc7iKpWRot9Q6q7k3I0yOimigk32sVIFJHZM1mDhnQe2KPgb6Sakj+mqakukoq3kTl/dE2KOupsoNtujcj11uNjiMA1oJAU1c5LfY7RCk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrUmjDjjkOKSM6+9BfF/wYcTRaN2jnA8vNtu0O+PDOR1eSnucnSaeh8V7bRg?=
 =?us-ascii?Q?qY5Gn8GSATs0FwXtgpxa29n1EwewOpPja94EZbo1RqDQdigYROC1ll+0qOYy?=
 =?us-ascii?Q?ZfpEhekQ15cP0afI9yZHQQAsoCDB5CDtc4MexJVGWxZ/KD6CQX67gI/cySfw?=
 =?us-ascii?Q?PKIjygLMfOr/GIWL8qneMgzZIKVGp69kuOuzWQQ9HsfjjivIjiDOhJC0/WZ9?=
 =?us-ascii?Q?hQtOtk1ORaJvJCMxwSL2In8uSGhEG/1WqbnbxCc14YQHCU1hBcqlxYRO7ZsX?=
 =?us-ascii?Q?FQ8c2qFkp/MD9VVZKg6CVLjUz8QxtTmG4S2BQD83FfPzZdPRR+h1r4Ry0IoQ?=
 =?us-ascii?Q?UR1+MpFmzRU5HwSY7mXFzEalsM967BbH7ZB7NkxxghsXThmccMU+hchhDOsr?=
 =?us-ascii?Q?zK8s7HIayO6pYccpczAbI7xkMkaYV7JmWv7XLK09GWLPRh51oqhzMsb2HL9n?=
 =?us-ascii?Q?6/j/WGdkQvYGnRWQZ1ywUI8xzBn4bpMYyf5LVzq3/Y8v0bA+kPivgu/YxjoZ?=
 =?us-ascii?Q?/lbnRfICEWkUyZ73EMhMGVbm281IaoNOMsYCz8+H7GALX0Kl/3e78mJ7q6G0?=
 =?us-ascii?Q?+FvFz1ADzbai1U8tqRZqzbYNsZ/CrLVNAEp/If3kS0HcbEJLtd5Q2TebYq86?=
 =?us-ascii?Q?0OtUBiFw1vTQ9uHp1Uyi7SwDXDXmu5jwdXiUAB/BhHT662czrSpQpwZgB8/E?=
 =?us-ascii?Q?+IpVbse3WRD2MEvWLopSG6ECXiypO6qTPDLxWdvGfxMjRZEZuFn4koARyd5Z?=
 =?us-ascii?Q?C6KEBRpXtFkqzojfMnudRNFgE0HKL581hMN9dyCgdXX/k53WB+QFTv/bouF8?=
 =?us-ascii?Q?MHoER2xXuVv+Q0EhpjY6ZJWkKAehioo7GN7y+GXgdlVkgfeuzWdICRhS+3xL?=
 =?us-ascii?Q?yoe0TFvhclsYjxb0mAq5/h+r+qr8aFZgY8lK+KTmajdsiOpu/20kOPEqJpBK?=
 =?us-ascii?Q?mzAOE5yBIHMztdFzrYnkqtg6ekbcnRGs1/wLsZlesc34IpZdarXk7K/FmFqe?=
 =?us-ascii?Q?k29AsLua4ooQPzfB/YnTCG75QFMA90i+Xb52rpBrJoER1SbRfzesHjB906Ag?=
 =?us-ascii?Q?zaRC1OAxjyxS4F0PD6I1fULR+jdiQRmYmqIA/KBhTKgymrD8PoIenPNKftv1?=
 =?us-ascii?Q?P2UoWeoUYxdWN9SlEmLBjXrZ9QKVf2lA9C7ZK1YJMgP0RzMkq+z9Q6XbGz8e?=
 =?us-ascii?Q?TtzkqvPnPNe9qTGMn1Uh8K6W7jy1ZOcIUFuN0ZWegCAGlHp4ovEGedIHzeQU?=
 =?us-ascii?Q?kWDB464GWvmG0pIbm1+f8D0IeeL2j7ofODS0pUHi53lsKQMnuu70sdw4Gkus?=
 =?us-ascii?Q?PHR81LbNReC4xEM5Qnu94MPCbLVbuMWVelcYU5HjbSPFssVCE4/zIHgclLro?=
 =?us-ascii?Q?ceQgeICSv6dMV8/E5WdeltgSV4eShN7MLM03T0g3No68B49DyQqabso0+Kf4?=
 =?us-ascii?Q?mX60CaCdIlrZhgsQ8927XyDj0R9eROpUCtrnIgNxuvCcez/4czng1bzesoG+?=
 =?us-ascii?Q?+iOo6v8byGaTINFYyFbWXFX5GHmmA2P3EGvHY10tSR6uFBTRAy8KW6PD9PCY?=
 =?us-ascii?Q?GtkqrGgXy/G1I4eS4tmxSlwIQz5KEKCXrYXcVy5m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4970125-32e3-4bc5-1528-08dba3213f09
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:39.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvlSKO4YsknTTx7rSuEUgdBr6ZFfyvnMQ2recADxP1YRpKPUW81ZL+FGnTsb5fXdSdm5RNPXpKDemZ6E/ODXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 63e64494e257..9253cc826571 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -141,6 +141,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -178,6 +179,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_req;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -343,6 +345,33 @@ static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
 				     ctrl->ctrl.opts->tls);
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
@@ -403,6 +432,8 @@ static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					 queue->ctrl->ddp_netdev->ulp_ddp_caps.active);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -423,6 +454,8 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -430,6 +463,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -510,6 +544,20 @@ static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 	return -EOPNOTSUPP;
 }
 
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
 
@@ -777,6 +825,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1044,6 +1095,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1072,7 +1127,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1114,8 +1170,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1126,9 +1185,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1139,9 +1214,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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


