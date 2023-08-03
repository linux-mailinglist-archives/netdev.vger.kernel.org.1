Return-Path: <netdev+bounces-23855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674776DDF2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3882819CC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563514C69;
	Thu,  3 Aug 2023 02:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461A7F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:20:51 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2082e.outbound.protection.outlook.com [IPv6:2a01:111:f403:7005::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E4B2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS1r3iDHNbjmooHDFessOb4LDEsZ5ex+g/9244wsrm4beXILXrD5yrTm1jgLL5pNCaRqqc1LO6uMoo7EaOP174X4zBz3VZfgv3RBPUoVQagEaqd0aSWqv7xq+paZsLzvZcUzGd+2++OXRNF8fGuH1AReG7NJQW0niOrpfK2DfjW5kKnTzYiatJY+mE2jixmVs/VIjfyBCLKdNY3x29kOh+E4MUNELffODN6PG1DYXRebTlMsKoWHrGMhFJl9v6luRlm8nCWUIwe4dU5VOIS9mYWhGxhiIqbbeLIGEUJGnDbxQRwLOstr8dyFt3bQL7TTBb10LbuYOk6ajJKIl160yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJkq9TdfJHEB/arnnzC9HSQCxCmHEh3bIPilpw9CSOs=;
 b=QvT9gCW4fe73TxOrJIjMcVISO8vU1WulD71noMbC2afU1gzRGQPgip6hc8R4MXHV9JGgmrRuE37hTUZqOdTPfFCKFy2/TteEjU5MaiTazwrHsxej8JFArhbCMwznfq7XO4IbY5fKMNMkefaxl3fiStMOwBsn5rEIrk/giMe8+ZI53hRiVHwzS/8mq76fqBEmdpi1surAiOJYihAK7Y6vt4A6Mn2djxAk0k7Hok2q45ox1T34ov6/vGpMtawH8UVGytjR1rlyWwRfzRd2L5mtXfjZ4e7Y8YzeqrhO4Y9Mmv9Js6oV1iGb8VmSUrtim8/HUGOBlZuPD6rfg2AJOuJg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJkq9TdfJHEB/arnnzC9HSQCxCmHEh3bIPilpw9CSOs=;
 b=fYD7voDsCXYdttW8CCbLjIZ5PouF7JROBhP14/RQ/dvU1oArA/sg33OdX4NU/4hYi/x+F17mMmN4pV4ZEWjJm0F/8F2wSW3pGixNiQC5vb2ROCcigVUWUysiaOTmpDyRMnReBG7Dmf1G3X9qR9RNNL16XEjjXSHMvwGu80ajhQtrv15s0e2bgy8L498iIizVHzU7s9veFBJfLZDmhZJ6tULhllLKUBSTs5u+TdJBKPbHi9KKjkA39u42FAOfLntSkcR5MIL67Ojl9DJrHtjYaNzLXbdhC2bvLNqTEp4tdoE4WMMYLwCH3S+zittQ2T1/LiueRoFLIxiZP42bJ7ZSvQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB2245.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 02:20:38 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:20:38 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	johannes@sipsolutions.net,
	ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	edumazet@google.com,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com,
	jesse.brandeburg@intel.com,
	danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next 1/6] net: wwan: t7xx: Infrastructure for early port configuration
Date: Thu,  3 Aug 2023 10:18:07 +0800
Message-ID:
 <MEYP282MB26978F4F43B113BD7178E52EBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803021812.6126-1-songjinjian@hotmail.com>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kP9leQP3OprltlK7gykVybRtoo6ncZ0i]
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803021812.6126-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec9f983-645d-41c5-d1dc-08db93c83875
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r1Q4+rrVlyayRmtDCi2wkj0LGNrk5Mch62IQOjCw6SB5vTklWTqqiJoY3SeiGm0FO0ZzJcM5bLaTFuT/LJT2FyiW5NG+k5T8RgAoE73wiGlAqEbKYhXHNx/GXFfzXn6u9lXY7IddkjxUNV3C0sdInJmJjNkZWKV68yLEWNydYz3Zibq9z6GtNxgj/YHxvMsPUcHp3E+C4I6SxPyPovi7d0bL5Cx2iV81dXnfNyRgk5/2H/hymrBOa91jZOAn1r75BgvzFDUbeDYJNRveW3rOKZkyVkCAt6d2roRx//jNhXnKMtgbIZR2zV7hW+nDQoORE2fy8HNyDEsooJnG3R7cmaUln5J+tHTh4oTFOYKhymPvwew86gKERE6243sttTwpfODUcyWCXD1NMWbOQPFYbFqahiNwJTZjtFlTaHodtRW5nMZoKzYyzt7+nJ3N1A6qP9cA4QxqFVGfaNh7Ti6hh+oGVMj2BvrLhZY4veavZWkk9ZKUHmcg5Md+iN7uCy9EqdNb+aUpfXjRuspBrFXAqefMBwHNdNx0zrpPmTOZzHI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hlnVQx96FoIy6mFf/5SKhXBOEHDziigJFa0kAIrSKrEz7D1uU0KaxXfgbTI?=
 =?us-ascii?Q?hdxNmxmek9zIGw622NwN/FoRa5cxdTcM6n9L64TrfkHiFlczCOjNa8ep8eB3?=
 =?us-ascii?Q?P4AJzAPbEhcwZzHLi7SW3dRNeGDwiPTe10zXTDUyI/sEQL2Kyr3T0D/DKX3Z?=
 =?us-ascii?Q?DFZu7xOxVhzXB9BKEAynDE/TkBHGBAGMg+CJdsib3z2wj1fMBUKrB9reC5wH?=
 =?us-ascii?Q?yN9k5lBxpe4K9kMfQYnfgQ388CLFyiMJa7Fd4+5KniNjrmkA6/7oNlDkEGL9?=
 =?us-ascii?Q?q5h5dXrUta0DARrXPa88ldsRDl6A0ZP2ES/HSx1LgQBbu6I+AfBsM62OLd/v?=
 =?us-ascii?Q?6Z9pmXc6F4cnKLOK6lz7pGd1ExVOaL9G0io0OMceED0tyob344p8JHq/Vaq1?=
 =?us-ascii?Q?tDMov9lYmaCVOlwzxBOp39rruQFGnDB08rMlS+QraoVPgXKFQ1SsLMQpdsDW?=
 =?us-ascii?Q?d0TZp9eGksBJlDFkOBi5MkfZJzxX3UA4e5MEX8H5aNipMEb5clgrjCY0joMu?=
 =?us-ascii?Q?tAsx26AaS6t/537SAXnw2iWWBxQ0F+yrBY/vw6nqFfawzGgKUJeIoE20rx4a?=
 =?us-ascii?Q?qH9ds5peJNaP9JKUOYPB9QZmechGbe2Yygdx30q5qK6+RSw1yo4PgJVSfpfE?=
 =?us-ascii?Q?VCWIpMW6tDJ8s0nTaBFWjIdOWMW5wDzEsnn4QVaOjcwGwFuRm5sruUXvd+2t?=
 =?us-ascii?Q?PjoBMivuWi6eQuH3CxVU1vkVXaCs2x8OK9GucSFWatqk7kC7ysT0t6biipyI?=
 =?us-ascii?Q?scgIsPiH2LhKSOvDHtRXO1WmsL5Yiyp49sNF5V7GWr0tEt0oeCsipJ1rBax8?=
 =?us-ascii?Q?3at9k1D5zmp39yBEYjHPAUmtic6VjnU0Oaqv8VKRl30qcXjKSMwO82rkPIB4?=
 =?us-ascii?Q?eXmpeUtjYq91Qj9M/b4o+NVhhXm9OKKB94eQCFg4POQtLbsVAEK4jx6Sf3oQ?=
 =?us-ascii?Q?PxICYE0lnHIwX9USnJiJxd/CWW11dHnXqfBRgnV9zGBntMtCs7ENlMTGiTms?=
 =?us-ascii?Q?2d/4IEFIcKbHbb46/vL/Dj3667dJwrPaud30+ZglT1NA7xAt0wQN3RLoEj7V?=
 =?us-ascii?Q?aS3grIs4e2bqwTF1JI1nfzmCSws3HDPpuuvXj/F0l7OBLNdRkhVLob0YkOv2?=
 =?us-ascii?Q?YaqNgiij91ij313/85Nj1UBKjWk2DYkrVVuLR1ixXGGRLRQzefPBR88h5SXE?=
 =?us-ascii?Q?vCq+AbTUkVRBrGU2r8oMtRqL+tGjs50Monxp7L3xjYE4yTnFVr77BaOP3Eo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec9f983-645d-41c5-d1dc-08db93c83875
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:20:38.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

To support cases such as FW update or Core dump, the t7xx
device is capable of signaling the host that a special port
needs to be created before the handshake phase.

Adds the infrastructure required to create the early ports
which also requires a different configuration of CLDMA queues.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/3777bb382f4b0395cb594a602c5c79dbab86c9e0.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     | 47 ++++++++----
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     | 18 +++--
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |  4 +-
 drivers/net/wwan/t7xx/t7xx_port.h          |  4 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c   | 78 ++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h   | 11 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 86 +++++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    | 10 +++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |  5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           | 22 +++++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 86 +++++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |  1 +
 12 files changed, 324 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index cc70360364b7..abc41a7089fa 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -57,8 +57,6 @@
 #define CHECK_Q_STOP_TIMEOUT_US		1000000
 #define CHECK_Q_STOP_STEP_US		10000
 
-#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
-
 static void md_cd_queue_struct_reset(struct cldma_queue *queue, struct cldma_ctrl *md_ctrl,
 				     enum mtk_txrx tx_rx, unsigned int index)
 {
@@ -161,7 +159,7 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queue *queue, int budget, bool
 		skb_reset_tail_pointer(skb);
 		skb_put(skb, le16_to_cpu(gpd->data_buff_len));
 
-		ret = md_ctrl->recv_skb(queue, skb);
+		ret = queue->recv_skb(queue, skb);
 		/* Break processing, will try again later */
 		if (ret < 0)
 			return ret;
@@ -897,13 +895,13 @@ static void t7xx_cldma_hw_start_send(struct cldma_ctrl *md_ctrl, int qno,
 
 /**
  * t7xx_cldma_set_recv_skb() - Set the callback to handle RX packets.
- * @md_ctrl: CLDMA context structure.
+ * @queue: CLDMA queue.
  * @recv_skb: Receiving skb callback.
  */
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb))
 {
-	md_ctrl->recv_skb = recv_skb;
+	queue->recv_skb = recv_skb;
 }
 
 /**
@@ -993,6 +991,28 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 	return ret;
 }
 
+static void t7xx_cldma_adjust_config(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
+{
+	int qno;
+
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++) {
+		md_ctrl->rx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[qno], t7xx_port_proxy_recv_skb);
+	}
+
+	md_ctrl->rx_ring[CLDMA_RXQ_NUM - 1].pkt_size = CLDMA_JUMBO_BUFF_SZ;
+
+	for (qno = 0; qno < CLDMA_TXQ_NUM; qno++)
+		md_ctrl->tx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+
+	if (cfg_id == CLDMA_DEDICATED_Q_CFG) {
+		md_ctrl->tx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		md_ctrl->rx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[CLDMA_Q_IDX_DUMP],
+					t7xx_port_proxy_recv_skb_from_dedicated_queue);
+	}
+}
+
 static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 {
 	char dma_pool_name[32];
@@ -1018,16 +1038,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 			dev_err(md_ctrl->dev, "control TX ring init fail\n");
 			goto err_free_tx_ring;
 		}
-
-		md_ctrl->tx_ring[i].pkt_size = CLDMA_MTU;
 	}
 
 	for (j = 0; j < CLDMA_RXQ_NUM; j++) {
-		md_ctrl->rx_ring[j].pkt_size = CLDMA_MTU;
-
-		if (j == CLDMA_RXQ_NUM - 1)
-			md_ctrl->rx_ring[j].pkt_size = CLDMA_JUMBO_BUFF_SZ;
-
 		ret = t7xx_cldma_rx_ring_init(md_ctrl, &md_ctrl->rx_ring[j]);
 		if (ret) {
 			dev_err(md_ctrl->dev, "Control RX ring init fail\n");
@@ -1094,6 +1107,7 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 {
 	struct device *dev = &t7xx_dev->pdev->dev;
 	struct cldma_ctrl *md_ctrl;
+	int qno;
 
 	md_ctrl = devm_kzalloc(dev, sizeof(*md_ctrl), GFP_KERNEL);
 	if (!md_ctrl)
@@ -1102,7 +1116,9 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 	md_ctrl->t7xx_dev = t7xx_dev;
 	md_ctrl->dev = dev;
 	md_ctrl->hif_id = hif_id;
-	md_ctrl->recv_skb = t7xx_cldma_default_recv_skb;
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++)
+		md_ctrl->rxq[qno].recv_skb = t7xx_cldma_default_recv_skb;
+
 	t7xx_hw_info_init(md_ctrl);
 	t7xx_dev->md->md_ctrl[hif_id] = md_ctrl;
 	return 0;
@@ -1332,9 +1348,10 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 	return -ENOMEM;
 }
 
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl)
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
 {
 	t7xx_cldma_late_release(md_ctrl);
+	t7xx_cldma_adjust_config(md_ctrl, cfg_id);
 	t7xx_cldma_late_init(md_ctrl);
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index 4410bac6993a..5453cfecbe19 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -31,6 +31,10 @@
 #include "t7xx_cldma.h"
 #include "t7xx_pci.h"
 
+#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
+#define CLDMA_SHARED_Q_BUFF_SZ		3584
+#define CLDMA_DEDICATED_Q_BUFF_SZ	2048
+
 /**
  * enum cldma_id - Identifiers for CLDMA HW units.
  * @CLDMA_ID_MD: Modem control channel.
@@ -55,6 +59,11 @@ struct cldma_gpd {
 	__le16 not_used2;
 };
 
+enum cldma_cfg {
+	CLDMA_SHARED_Q_CFG,
+	CLDMA_DEDICATED_Q_CFG,
+};
+
 struct cldma_request {
 	struct cldma_gpd *gpd;	/* Virtual address for CPU */
 	dma_addr_t gpd_addr;	/* Physical address for DMA */
@@ -82,6 +91,7 @@ struct cldma_queue {
 	wait_queue_head_t req_wq;	/* Only for TX */
 	struct workqueue_struct *worker;
 	struct work_struct cldma_work;
+	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
 struct cldma_ctrl {
@@ -101,24 +111,22 @@ struct cldma_ctrl {
 	struct md_pm_entity *pm_entity;
 	struct t7xx_cldma_hw hw_info;
 	bool is_late_init;
-	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
+#define CLDMA_Q_IDX_DUMP 1
 #define GPD_FLAGS_HWO		BIT(0)
 #define GPD_FLAGS_IOC		BIT(7)
 #define GPD_DMAPOOL_ALIGN	16
 
-#define CLDMA_MTU		3584	/* 3.5kB */
-
 int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev);
 void t7xx_cldma_hif_hw_init(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_init(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_exit(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl);
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id);
 void t7xx_cldma_start(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_stop(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_reset(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb));
 int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb);
 void t7xx_cldma_stop_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx_rx);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 24e7d491468e..cbd65aa48721 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -529,7 +529,7 @@ static void t7xx_md_hk_wq(struct work_struct *work)
 
 	/* Clear the HS2 EXIT event appended in core_reset() */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_MD_HS2_EXIT);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS2);
 	md->core_md.handshake_ongoing = true;
@@ -544,7 +544,7 @@ static void t7xx_ap_hk_wq(struct work_struct *work)
 	 /* Clear the HS2 EXIT event appended in t7xx_core_reset(). */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_AP_HS2_EXIT);
 	t7xx_cldma_stop(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_AP]);
 	md->core_ap.handshake_ongoing = true;
 	t7xx_core_hk_handler(md, &md->core_ap, ctl, FSM_EVENT_AP_HS2, FSM_EVENT_AP_HS2_EXIT);
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 4ae8a00a8532..09acb1ef144d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -75,6 +75,8 @@ enum port_ch {
 	PORT_CH_DSS6_TX = 0x20df,
 	PORT_CH_DSS7_RX = 0x20e0,
 	PORT_CH_DSS7_TX = 0x20e1,
+
+	PORT_CH_ID_UNIMPORTANT = 0xffff,
 };
 
 struct t7xx_port;
@@ -135,9 +137,11 @@ struct t7xx_port {
 	};
 };
 
+int t7xx_get_port_mtu(struct t7xx_port *port);
 struct sk_buff *t7xx_port_alloc_skb(int payload);
 struct sk_buff *t7xx_ctrl_alloc_skb(int payload);
 int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb);
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb);
 int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int pkt_header,
 		       unsigned int ex_msg);
 int t7xx_port_send_ctl_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int msg,
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
new file mode 100644
index 000000000000..599fb09912de
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_devlink.h"
+#include "t7xx_state_monitor.h"
+#include "t7xx_port_ap_msg.h"
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len)
+{
+	const struct t7xx_port_conf *port_conf;
+	size_t offset, chunk_len = 0, txq_mtu;
+	struct t7xx_fsm_ctl *ctl;
+	struct sk_buff *skb_ccci;
+	enum md_state md_state;
+	int ret;
+
+	if (!len || !port->chan_enable)
+		return -EINVAL;
+
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
+	md_state = t7xx_fsm_get_md_state(ctl);
+	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
+			 port_conf->name, md_state);
+		return -ENODEV;
+	}
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	for (offset = 0; offset < len; offset += chunk_len) {
+		chunk_len = min(len - offset, txq_mtu - sizeof(struct ccci_header));
+		skb_ccci = t7xx_port_alloc_skb(chunk_len);
+		if (!skb_ccci)
+			return -ENOMEM;
+
+		skb_put_data(skb_ccci, buff + offset, chunk_len);
+		ret = t7xx_port_send_skb(port, skb_ccci, 0, 0);
+		if (ret) {
+			dev_kfree_skb_any(skb_ccci);
+			dev_err(port->dev, "Write error on %s port, %d\n",
+				port_conf->name, ret);
+			return ret;
+		}
+	}
+
+	return len;
+}
+
+static int t7xx_port_ap_msg_init(struct t7xx_port *port)
+{
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+	dl->status = T7XX_DEVLINK_IDLE;
+	dl->port = port;
+
+	return 0;
+}
+
+static void t7xx_port_ap_msg_uninit(struct t7xx_port *port)
+{
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+
+	dl->mode = T7XX_NORMAL_MODE;
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+struct port_ops ap_msg_port_ops = {
+	.init = &t7xx_port_ap_msg_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_port_ap_msg_uninit,
+	.enable_chl = &t7xx_port_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
new file mode 100644
index 000000000000..4838d87d86cf
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_AP_MSG_H__
+#define __T7XX_PORT_AP_MSG_H__
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len);
+
+#endif /* __T7XX_PORT_AP_MSG_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 274846d39fbf..bdfeb10e0c51 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -100,6 +100,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 	},
 };
 
+static struct t7xx_port_conf t7xx_early_port_conf[] = {
+	{
+		.tx_ch = PORT_CH_ID_UNIMPORTANT,
+		.rx_ch = PORT_CH_ID_UNIMPORTANT,
+		.txq_index = CLDMA_Q_IDX_DUMP,
+		.rxq_index = CLDMA_Q_IDX_DUMP,
+		.txq_exp_index = CLDMA_Q_IDX_DUMP,
+		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
+		.path_id = CLDMA_ID_AP,
+	},
+};
+
 static struct t7xx_port *t7xx_proxy_get_port_by_ch(struct port_proxy *port_prox, enum port_ch ch)
 {
 	const struct t7xx_port_conf *port_conf;
@@ -214,7 +226,17 @@ int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb)
 	return 0;
 }
 
-static int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
+int t7xx_get_port_mtu(struct t7xx_port *port)
+{
+	enum cldma_id path_id = port->port_conf->path_id;
+	int tx_qno = t7xx_port_get_queue_no(port);
+	struct cldma_ctrl *md_ctrl;
+
+	md_ctrl = port->t7xx_dev->md->md_ctrl[path_id];
+	return md_ctrl->tx_ring[tx_qno].pkt_size;
+}
+
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
 {
 	enum cldma_id path_id = port->port_conf->path_id;
 	struct cldma_ctrl *md_ctrl;
@@ -329,6 +351,30 @@ static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
 	}
 }
 
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb)
+{
+	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	struct t7xx_port *port;
+	int ret;
+
+	port = &port_prox->ports[0];
+	if (WARN_ON_ONCE(port->port_conf->rxq_index != queue->index)) {
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	port_conf = port->port_conf;
+	ret = port_conf->ops->recv_skb(port, skb);
+	if (ret < 0 && ret != -ENOBUFS) {
+		dev_err(port->dev, "drop on RX ch %d, %d\n", port_conf->rx_ch, ret);
+		dev_kfree_skb_any(skb);
+	}
+
+	return ret;
+}
+
 static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev,
 						   struct cldma_queue *queue, u16 channel)
 {
@@ -359,7 +405,7 @@ static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev
  ** 0		- Packet consumed.
  ** -ERROR	- Failed to process skb.
  */
-static int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
 {
 	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
 	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
@@ -451,13 +497,39 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
+{
+	struct port_proxy *port_prox = md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	u32 port_count;
+	int i;
+
+	t7xx_port_proxy_uninit(port_prox);
+
+	if (cfg_id == PORT_CFG_ID_EARLY) {
+		port_conf = t7xx_early_port_conf;
+		port_count = ARRAY_SIZE(t7xx_early_port_conf);
+	} else {
+		port_conf = t7xx_port_conf;
+		port_count = ARRAY_SIZE(t7xx_port_conf);
+	}
+
+	for (i = 0; i < port_count; i++)
+		port_prox->ports[i].port_conf = &port_conf[i];
+
+	port_prox->cfg_id = cfg_id;
+	port_prox->port_count = port_count;
+	t7xx_proxy_init_all_ports(md);
+}
+
 static int t7xx_proxy_alloc(struct t7xx_modem *md)
 {
+	unsigned int early_port_count = ARRAY_SIZE(t7xx_early_port_conf);
 	unsigned int port_count = ARRAY_SIZE(t7xx_port_conf);
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	struct port_proxy *port_prox;
-	int i;
 
+	port_count = max(port_count, early_port_count);
 	port_prox = devm_kzalloc(dev, sizeof(*port_prox) + sizeof(struct t7xx_port) * port_count,
 				 GFP_KERNEL);
 	if (!port_prox)
@@ -465,12 +537,8 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
+	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
-	for (i = 0; i < port_count; i++)
-		port_prox->ports[i].port_conf = &t7xx_port_conf[i];
-
-	port_prox->port_count = port_count;
-	t7xx_proxy_init_all_ports(md);
 	return 0;
 }
 
@@ -492,8 +560,6 @@ int t7xx_port_proxy_init(struct t7xx_modem *md)
 	if (ret)
 		return ret;
 
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_AP], t7xx_port_proxy_recv_skb);
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 81d059fbc0fb..7f5706811445 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -31,11 +31,18 @@
 #define RX_QUEUE_MAXLEN		32
 #define CTRL_QUEUE_MAXLEN	16
 
+enum port_cfg_id {
+	PORT_CFG_ID_INVALID,
+	PORT_CFG_ID_NORMAL,
+	PORT_CFG_ID_EARLY,
+};
+
 struct port_proxy {
 	int			port_count;
 	struct list_head	rx_ch_ports[PORT_CH_ID_MASK + 1];
 	struct list_head	queue_ports[CLDMA_NUM][MTK_QUEUES];
 	struct device		*dev;
+	enum port_cfg_id	cfg_id;
 	struct t7xx_port	ports[];
 };
 
@@ -98,5 +105,8 @@ void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int
 int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 17389c8f6600..ddc20ddfa734 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -152,14 +152,15 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header);
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
 	struct wwan_port_caps caps;
 
 	if (state != MD_STATE_READY)
 		return;
 
 	if (!port->wwan.wwan_port) {
-		caps.frag_len = CLDMA_MTU - header_len;
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
 		caps.headroom_len = header_len;
 		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
 							&wwan_ops, &caps, port);
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index c41d7d094c08..3b665c6116fe 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -102,10 +102,26 @@ enum t7xx_pm_resume_state {
 };
 
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
-#define MISC_STAGE_MASK				GENMASK(2, 0)
-#define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_RESET_TYPE_FLDR			BIT(27)
-#define LINUX_STAGE				4
+#define MISC_RESET_TYPE_PLDR			BIT(26)
+#define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+
+enum lk_event_id {
+	LK_EVENT_NORMAL = 0,
+	LK_EVENT_CREATE_PD_PORT = 1,
+	LK_EVENT_CREATE_POST_DL_PORT = 2,
+	LK_EVENT_RESET = 7,
+};
+
+#define MISC_STAGE_MASK				GENMASK(2, 0)
+
+enum t7xx_device_stage {
+	T7XX_DEV_STAGE_INIT = 0,
+	T7XX_DEV_STAGE_BROM_PRE = 1,
+	T7XX_DEV_STAGE_BROM_POST = 2,
+	T7XX_DEV_STAGE_LK = 3,
+	T7XX_DEV_STAGE_LINUX = 4,
+};
 
 #define T7XX_PCIE_RESOURCE_STATUS		0x0d28
 #define T7XX_PCIE_RESOURCE_STS_MSK		GENMASK(4, 0)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 80edb8e75a6a..9c51e332e7c5 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -206,6 +206,34 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
+{
+	struct t7xx_modem *md = ctl->md;
+	struct cldma_ctrl *md_ctrl;
+	enum lk_event_id lk_event;
+	struct device *dev;
+
+	dev = &md->t7xx_dev->pdev->dev;
+	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
+	switch (lk_event) {
+	case LK_EVENT_NORMAL:
+	case LK_EVENT_RESET:
+		break;
+
+	case LK_EVENT_CREATE_PD_PORT:
+		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
+		t7xx_cldma_hif_hw_init(md_ctrl);
+		t7xx_cldma_stop(md_ctrl);
+		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+		t7xx_cldma_start(md_ctrl);
+		break;
+
+	default:
+		dev_err(dev, "Invalid LK event %d\n", lk_event);
+		break;
+	}
+}
+
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
 	ctl->curr_state = FSM_STATE_STOPPED;
@@ -317,7 +345,8 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
 	struct t7xx_modem *md = ctl->md;
-	u32 dev_status;
+	struct device *dev;
+	u32 status;
 	int ret;
 
 	if (!md)
@@ -329,23 +358,57 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 		return;
 	}
 
+	dev = &md->t7xx_dev->pdev->dev;
 	ctl->curr_state = FSM_STATE_PRE_START;
 	t7xx_md_event_notify(md, FSM_PRE_START);
 
-	ret = read_poll_timeout(ioread32, dev_status,
-				(dev_status & MISC_STAGE_MASK) == LINUX_STAGE, 20000, 2000000,
-				false, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	ret = read_poll_timeout(ioread32, status,
+				((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LINUX) ||
+				((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LK), 100000,
+				20000000, false, IREG_BASE(md->t7xx_dev) +
+				T7XX_PCIE_MISC_DEV_STATUS);
+
 	if (ret) {
-		struct device *dev = &md->t7xx_dev->pdev->dev;
+		dev_err(dev, "read poll timeout %d\n", ret);
+		goto finish_command;
+	}
 
-		fsm_finish_command(ctl, cmd, -ETIMEDOUT);
-		dev_err(dev, "Invalid device status 0x%lx\n", dev_status & MISC_STAGE_MASK);
-		return;
+	if (status != ctl->prev_status || cmd->flag != 0) {
+		u32 stage = FIELD_GET(MISC_STAGE_MASK, status);
+
+		switch (stage) {
+		case T7XX_DEV_STAGE_INIT:
+		case T7XX_DEV_STAGE_BROM_PRE:
+		case T7XX_DEV_STAGE_BROM_POST:
+			dev_dbg(dev, "BROM_STAGE Entered\n");
+			ret = t7xx_fsm_append_cmd(ctl, FSM_CMD_START, 0);
+			break;
+
+		case T7XX_DEV_STAGE_LK:
+			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_lk_stage_event_handling(ctl, status);
+			break;
+
+		case T7XX_DEV_STAGE_LINUX:
+			dev_dbg(dev, "LINUX_STAGE Entered\n");
+			t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_PORT_ENUM |
+					     D2H_INT_ASYNC_MD_HK | D2H_INT_ASYNC_AP_HK);
+			if (cmd->flag == 0)
+				break;
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_NORMAL);
+			ret = fsm_routine_starting(ctl);
+			break;
+
+		default:
+			break;
+		}
+		ctl->prev_status = status;
 	}
 
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
-	fsm_finish_command(ctl, cmd, fsm_routine_starting(ctl));
+finish_command:
+	fsm_finish_command(ctl, cmd, ret);
 }
 
 static int fsm_main_thread(void *data)
@@ -516,6 +579,7 @@ void t7xx_fsm_reset(struct t7xx_modem *md)
 	fsm_flush_event_cmd_qs(ctl);
 	ctl->curr_state = FSM_STATE_STOPPED;
 	ctl->exp_flg = false;
+	ctl->prev_status = 0;
 }
 
 int t7xx_fsm_init(struct t7xx_modem *md)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b6e76f3903c8..5e8012567ba1 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -96,6 +96,7 @@ struct t7xx_fsm_ctl {
 	bool			exp_flg;
 	spinlock_t		notifier_lock;		/* Protects notifier list */
 	struct list_head	notifier_list;
+	u32                     prev_status;
 };
 
 struct t7xx_fsm_event {
-- 
2.34.1


