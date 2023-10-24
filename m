Return-Path: <netdev+bounces-43855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD77D5064
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8765AB20D60
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E2273F1;
	Tue, 24 Oct 2023 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VV8g+4b5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C8273CB
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0C129
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW9oaMh0jP3xKLT6TK52g5hsUNjHta3N+uBUXOim+tD6qi0Kd8hNUzfzgrKRCQz5Zh3XL2TIA3fihiXXJAqlWPw2e3dLg6OeNT5r/c5J+fmy6O8PFEtOIdThG9Vda9pD/6lMEUWWi+JMc3zJG5YfcKazJDZp/lNpJlWPdrA6mQiabcP8ryFRwpuyfGFaWoGErpqxt/oESVFQff8heWbKFZ6K1f6hTWtxvIyYQQTTqTxibTg+XAvYNQerW5+NLuW72XABJjrgpjNqNp90Ak2Hz4gRC/nBpToC2rc8u2BOsED0SGarc8uEsSd+8o0dxScCUAV1OqSbtQroPBIkvSV+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa9+cdC27N2pGSCrNVNXIGAIXNRrg1vQcIexNlWOGsk=;
 b=Tj5pMnlNtjxDAIH2XaHddP4tV8O3SCpDIg8QkeOvwnhd45M+YnXE3Z3WhKkhu5UaQGhnlrBW8HxOHrso/DenA6tc/HfDZvp0PvAdsavInUN0xJc/IU8kVMO8pv0hN36WZxyovTHTHeJ9emZRktZP/zMHomweydHUfjGb8grt8Sn/J80pigwAw+Zg9v8OQf6iEmnhEYO0X1SRleqygdYYks/bPt20zJSfEev4WvW5nNXZdDODY84gpbAMpD2WgjJ+Sdi0TE/1xqEY1B24Ln2CpuI4FXhJ8JcvuK26icdgg2x9Wo8Ty0YKchtjg+XTKnWN6+7czL+Lbhy75nCTXYBLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa9+cdC27N2pGSCrNVNXIGAIXNRrg1vQcIexNlWOGsk=;
 b=VV8g+4b5pESytMOOGQNNslKxawgjumnjv5LahFo06I2iTi+I8LSmkK3jH7l9M6WO8eOUZzC/BnQMUQ6GOiOR1QY8pHkx+oWJx9AAr/gpM9pnulAouZndIXJM0+e3fcNuOBze0Z0csmwnzF+b1LF+ESs8GFRD6dfCGwnIqHlUl9ZPcQit/vQKSPU7yNbh9nhX4BoYkKOCcqPU+gp9oIGqBvOdRCRvvE6BJFMaK/mZe/6X2TCccWuSenUWfel1Kbzant15DVZBZXEBcwCBw83vMTUQk57IxM9a9kbrUCcRL0o6bePoPGHJGDzVAFqcM0iFCAALDbxAbgKYTv44prsnPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:34 +0000
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
Subject: [PATCH v17 07/20] nvme-tcp: RX DDGST offload
Date: Tue, 24 Oct 2023 12:54:32 +0000
Message-Id: <20231024125445.2632-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d58096e-6361-48cc-b795-08dbd4908356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TWjg0qzCM3gQB1Ut9NIC4sLvjlD6jgzglMDEUsBSbAXSVOj53p6gCCpABO1gmvHyNLhiu/Am0uizyBz8SqhHkujTckK7+M84Nls0MAF8mimfip5Z3poeOcvexCrPh/yrBrK5k3qjk4yOztSKyvLZ/brd02wxlZ/fd/HMObNJbuqJ5oLpthJjdVMrX4IYkzXksOyO6BgNa1hl0KYAQOxPI5g87joCM1jTVviIIOuXPoFAs9fsbm22x7jIRS8c6KaCbIJiU2kx9FOL3VAJsShI27XL0dyEHzHNSttBzohHm3C1zrLazxiv69W0zTq8he8QamMSUXR56IxEmDwMID/adD0KEI9PDn77FrsoxpRzI6sPxY4bB+3tP3sj/gkNYu8bSPRo/PFmvY1LOPo4z0VU37fz2FRJoP/8u3DXx7o3eVEYUM2Vdmr/VVeCMOIpulJwVLvivluMsjSyC00b35gYT+Kr1K1Lo6cynVgd+UPrwzWLdLQu6ulPD+cwgGlKWvgTtcIT2IME7V2jr1fZqD3rW1FXueV7OS0H/mwtKLcyMYkQNpBJF4vjMTL/Ya31VBg2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZW+/DiWY3JF1O093otpWJ2Hp/Env1l1WP/vBXCCcRfv4qSWuDL6egZIYZ8Ip?=
 =?us-ascii?Q?SP3zBinxUWEZSeFOQ+QXu4idNCEYAkH5tNqDHwmEDl2uzCaNwK5KLsLgtd/h?=
 =?us-ascii?Q?7e1BSXVGCwR2U1q29CH+OMfuTrAequdQRDsy+4En4/uONy4RInLJjkHBbkqP?=
 =?us-ascii?Q?dHcIZb8DwloSE1BisQ58iL440aCldRM7T5T0e4Uo1mlZbvx0w2+P4nGPkMtA?=
 =?us-ascii?Q?4TrG69eCiQ+aCbET8DdHWKO4kOVG8yeHIYMETdqCNU3hV9/TB6zHyR/phMIe?=
 =?us-ascii?Q?iZATUKpSG0faSHQcPret+LIFkUpcMXqeZllZC1De+IweJXKOmFymrxAehXi4?=
 =?us-ascii?Q?YALbjVHskenbzA2+gADHSS8gbc2WVHx6PdbNPc+fS8aKzFIk20Yqq+PMRYST?=
 =?us-ascii?Q?l73ukwyXpDu6ubLvdxaTkOgPVvGw2A/qDMSs3DpcPBe4B8Tapj6oxHpvbzB+?=
 =?us-ascii?Q?aZyTW8PyjSwjzALpxGuUHSXxYgVMiqJ8XJWjrjAvC3VP9ZELDbxp0LuCQZuH?=
 =?us-ascii?Q?imfo/E9w/CTuXK5So3sMInEQ7pwstQyWTxVTHpsndLLmxCOByHUYYsKvsmke?=
 =?us-ascii?Q?MOs2145A/OZgzdzltggg8o/Iy+BXOT7mA1o14eaUlkT7bolXoSCHroF/ln2/?=
 =?us-ascii?Q?lgDCBXYBCmf9aKlX4LPmhkPptz4c25agpIRWo5oolfHTK3ByQmouRarz+Plr?=
 =?us-ascii?Q?SY8zMXe/ZjgWWXhIryYkdXSNXGCjsVogaP7hyKDJeo6ZFSarxo7Y2Om5mauq?=
 =?us-ascii?Q?5kHYWXTtZ5BfFVtufMyUGY++dqt0z3Z0oC6WKVLZR/9XSC5KE4TqsHPRvPn6?=
 =?us-ascii?Q?vAfKHiv22WaLvJhf/P5Ti4jU/xmoArJHCfFZDQYmz1JQvuRxcVeepD7SEONP?=
 =?us-ascii?Q?hnBrP7EExbIxhZXd7CwAjzy54f9PUa/d8HR6e32DwU65PM2GQMv6Mb9SPbos?=
 =?us-ascii?Q?MGR5lflaVhItKiRPaogIw483Y7E9DcoJaxa6GHI6efzPT6a8YWRLPaboIGEk?=
 =?us-ascii?Q?lbMyUiCBPim+qF+541hc7Udvy5sbL5OF9MGc1tbYeM5MSO/+U/xIIiGZT5El?=
 =?us-ascii?Q?B9NXUS3V2lTTqWUs3JQELj+MU1NwrUrZjt4+BWD9Mg0hqKc8X3gWpuwIvF8l?=
 =?us-ascii?Q?W8SrBi0wZHgVmqs4xQXRBmhnRkMw5kcSXY8Tw/BQ+JV8irahqhfHiParcv2s?=
 =?us-ascii?Q?W8SuflsJB83zkeM0rV9NhH4cS4MWIgViVfjNE77HeErsGRxukN0o+R/nmXmI?=
 =?us-ascii?Q?HGkSgTPoHUBEUwgM8TLKdbom+LKSnFeRN7QNQ1Jv2VE2kpz7S7aP865i9drE?=
 =?us-ascii?Q?UihKvXA0hfTe3VnSWe4fiAAIW5U3j89tgIhWSJkS7k50ePoNcBcuX9MQvKSA?=
 =?us-ascii?Q?6rChaDQ9Ayy6tOPZxYQlpDD37ROVcc2yfZ+r3y2onHHfmbIxaLEWm9jXct3f?=
 =?us-ascii?Q?vuitYfGatRtBlugS2C/HOXrX7fSGQ72EVVtDqd5uVW5bnU9pt4S5sczLjE7/?=
 =?us-ascii?Q?6W5cBh7GkfNGW/n0IWsLfkZyv23M/zUM9J0duVfejn6eIu/Cl39UoOAcGbyM?=
 =?us-ascii?Q?/VpTvSOfrIaB14VQEj9QRSuHecHH2uRfmW8Wm8FX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58096e-6361-48cc-b795-08dbd4908356
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:34.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxhd/SgV1ELfXmF+lO1dHO0vFGrTjVQYLI3pB3L6nU9GcUxweNn/2Rlkpf5Sx9oz/UZKpAir8dBOLKYUa6sxsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
index 8ad03670eeb5..97fdb2d83208 100644
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
+	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					 queue->ctrl->ddp_netdev->ulp_ddp_caps.active);
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


