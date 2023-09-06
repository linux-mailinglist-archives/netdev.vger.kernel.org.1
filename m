Return-Path: <netdev+bounces-32253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF9793B73
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57AF281370
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67377107AB;
	Wed,  6 Sep 2023 11:33:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D45107A8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE7E45
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7AdBks4e1CS2ebdjYTFuhMTB2iaj1KPL1g/uLzwQO90NacnV6Yts50xVzjeAzqG1k7ZQalMXQeChoVncKvwTjRJGNkR8XEouoFodZw3pYackIckxlRMJhgcybOyQjmAMf0Ph1ayEc8La66jTc55DgJa8cN7GhWwimf2yxBrpXLB7RIebGhGF0ai2chyV/wpFRZJy4kqR9CYwP3essn1oG2rnvnGEW6wbob2UTKir2StZFkwwprBn1cap/98D/7pP0htIMpSrzfv3J8LQlolOvWZSzhyub/XnS5xyw3d7hXkWugFA+gJzvSdrJBgR8kju8DgdAIj2oM5kFu45KPnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKBP3NFvh1OASCaUrcXtr4VhghyT9tmMSoKDRkXHGAc=;
 b=iVGNAjkhHqfiy484Hpj83Y8jdSIXp/jNHyFbDwAnBOwx0fgDsg67rVGMUA6LBU2p0XH2yrDyUub1SenXrnFvggEEHv5oiSuCPTgRwZATAkXq1D41MQ8dx/qw/WHVJtT54EHt9st4USDRc6iF0+fKhVnj5Mk1oz3PXEGiIYGqSLFf0oYd9IKigDkC3U9X5FDh+TyTXZO6M3i7V0c9aTtfXX9efpq0aTEnO+bjC/kNCvZs4MGiLO8nIS6dAnOJk4aNbyQSNfp6fTy1q32BYWIJkvCBF9EmEExw9vpx4GMbBwszBFdo98BDBqNELt52Auilm2jMBPcopiI7fAX7ZGZNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKBP3NFvh1OASCaUrcXtr4VhghyT9tmMSoKDRkXHGAc=;
 b=YKwrb+/deueTZdRGXAMIDvsajTP9CwsDQwexioiZlR4Jy0E01V5MMjNCDc0Y3KpYCB9VbqQWXVYppChXTLebILMfUtxliosa5+S+XMmZen60JKP1A29vXDD16tS1RQJk8ov0RaqN7wkYtDSFdOTZ/I0WMvUrvsTvB4UMRRQLE4rHyx06bZMnb89RqHDXnH3eu9aMlJFLbInx5VgKOKWp8IZj23qbRHS4pXAiZlgftftjCI9UtVi1rJuVJTopY+HJLSMN8pfgZJsZ6xC1qUs8I0vGh9fSrNZlnwFP6pRiFtWF+Tdwjb8PduY7JAxOSpHIBvOLbk8VO8vPOZX1QT10qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:31:18 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:18 +0000
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
Subject: [PATCH v14 07/20] nvme-tcp: RX DDGST offload
Date: Wed,  6 Sep 2023 11:30:05 +0000
Message-Id: <20230906113018.2856-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eec1b17-ec62-4469-aea5-08dbaeccc989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JN0dA7sAKKIMRexAkhX0QKR7fxvDs7OZGAFU4y6yeTFK7ku6NH/UDZysN67BKZ2f+cJVULNyUDgS9cFmJa1vEJXxYR+wPGbDAoTsVe+NhVtilFBW638y/JmUpaUgIKmGlqmlWG/h6d0uiUHGXz7AyarqZDj2EoNruklcAEPVAvJiVDvE17xKVFUAgS3Vyfl0h1AoTbt3bdIV0OniD/0xiCC31o2t6QEMmW+cuWscNJ0+9huGEvyDa7+lNWvW25aamfyL796QO/LR2eo/HeVMHWcCZM+Fi9w8KmnkG9Yp8Eio0Au+lLwB//t4xg/hdV6Q1XAoNO2lDIX4Dp/s5PAxTEGe5jzNIaU/JtK8VRz38xmiyeZ3RIiUpebN2MaJeymPpwcdnQWFEgExXNscnWLHr0yfpZpDFv4SndHiNycDBu4m0RpFTH3b/2ngR5EsUaXZNw1yWdxJf1/bj+s/ccHnBZIYgki1lKbXNHwn9/Xl6c2UzbCDtmtg22XS8KDNJ8OheS0PuAEHuGJazm02HgYCEPOQTj74Jzc8ebJkjnfl/9jW1zkiExc90+BXsi1hp6at
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(6666004)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9AcGwtjMCycLrHuw7BW6842VtlqnE16rKiezzCLw+mC13IW+do3ghkkD/K3?=
 =?us-ascii?Q?XD/mcLpOGP474O96XPtk2O/MPLd+lpJuEgN1d9h79gASAZiA+4QBcM+LDIOu?=
 =?us-ascii?Q?ivQERdQ/DnP638uupw/Ef8Xf+2TLqygEVuhAzooR3m/zfS4AbaCXsqZKRhj+?=
 =?us-ascii?Q?qI55rTdFxNcSaYHwp8Y4vzYmSCa7Svn5aNTMBuK8k7iVeJoUoxgoA+j201ua?=
 =?us-ascii?Q?IJdEEQhgzRb9E8SezS0hcBZltT+jerAyky2inuUd45G4ad+f0n4OwvCFq8go?=
 =?us-ascii?Q?9zrWBXIepETRAI8RZI8UbD3XoncbA2w+FN6cQsG0KLcp7AGxw32t5zyfmb1r?=
 =?us-ascii?Q?gOGNSmnnNqnZwaUegenKW7BpsIj0HMEzAT/h8hmvdmouYbo9AuP4i5YMP0U5?=
 =?us-ascii?Q?FtBsKDWR9Gtb9izlwljCA1rZVx93QEyirb+Gymnxr5grvTTFSKHCswvSZXed?=
 =?us-ascii?Q?V5PHQp+irJzNbmszVOdX2GsBxYj6wCavnJI3rD6fT2vgUy9M7mPx748Ca3zY?=
 =?us-ascii?Q?OSnah+Ihn6EjI//Qu9QQljpVNfDrdd33nJ9P3IDM6HsNw22VkwnwsdjKM6mw?=
 =?us-ascii?Q?1VWNykbD2NA7GqIFsnFHnIcjZcLqQiFZ5aCsEQWSydOpYOoedWbaawLDrTvb?=
 =?us-ascii?Q?G7vLH+RpdlR+1pABREmAg3r0abR0jQ9oYgZNGMItj40Wm+Ud1s6dTb2t3C1o?=
 =?us-ascii?Q?kVyMgfx0wkGEQMJ4TQaQdRPBQdtkBYBWbQv6lgoHbhb9l3FOK5Pa8G0T3ef7?=
 =?us-ascii?Q?Y6Bb0E7MEf8p++r/T5HBC8COLWC1a9e56WRiLUrnge00nHmbbD3lY0sWMrue?=
 =?us-ascii?Q?oehVTMifpATw11o1vQyFRzeRde2Mmt1ljKkOL/uKD/9/iDsHO9db7vOBbUfV?=
 =?us-ascii?Q?29oHSpiWrpHWxRXw2BB/buWizzFjbhneh6rq6/GudHAGHyMNF9NE7x0mlXJR?=
 =?us-ascii?Q?AAIMIIvE/KmR/cBS/OcbJZWDNC9yY4c7plZrJ4IDHlqKH9sMPsAL7PiYPPe0?=
 =?us-ascii?Q?cm6foE6OmngFShWjbB/joQkjXfes0gp3CCEL8n8IJov2rhwfBZ8QcSxOjl0f?=
 =?us-ascii?Q?bY2L8Lg35Ytv8sgGVT6XII6l+HFZf+IfadoKCF3aytuaZk/TiuCKgsMxxoeZ?=
 =?us-ascii?Q?+hG5tCIyIDXva0e64D/QsoO1XtGwiXE7CUon1a3v7IPFGuFr3MOXTmkU8NXK?=
 =?us-ascii?Q?MTWc83Wh+ZFXMA0M6zOPSeyrvxIYur4jpqoLy5CTnQnsXWrc6lrPvb/slVcu?=
 =?us-ascii?Q?/t+CN4ATcN04STljOb1QssllnQ4EhKwKh4A3N/d2pyvzHYAKNX730uof9rg8?=
 =?us-ascii?Q?wbSUQVH8hlJ96XeE2nqKTpiZM6Z0Cdp7G2+4GatTjqOL0VzIfcVoKNHMHeHe?=
 =?us-ascii?Q?hErvuEuo1OHz+8MPm92T5KzT/SGTn8vK75Vbc9E6sUtp3Tcs+QoZNyFzSxpB?=
 =?us-ascii?Q?cK1I8EABNq4IXX+vTG9PR5GLMuaup/pqhcy1qC3BPbSp5ZMS6ylfBwjkBncv?=
 =?us-ascii?Q?+FQn91MrO5ZMj9j0/J0KzDTFG3fb8oTj89i0nmgXpr0arxd/oI7aEJeTaJNw?=
 =?us-ascii?Q?jfHp3zXnvbcrzTrP+BKrimz3bklUoE6T9jh14sok?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eec1b17-ec62-4469-aea5-08dbaeccc989
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:18.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk83rZWLrxVzSyFIPsPKgqofvnlxnYmhRG4IbGxFNSlItazqCx+lWJOCeMZm7sFG84gHKNrrx8q12gk6mQXsrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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


