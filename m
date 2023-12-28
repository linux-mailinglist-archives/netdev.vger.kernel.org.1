Return-Path: <netdev+bounces-60457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDDC81F670
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA3AB214F7
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062163AB;
	Thu, 28 Dec 2023 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="McqDAkT3"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2152.outbound.protection.outlook.com [40.92.63.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F563C9
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSClAkULO4aYOuCchD8P6hDAwnbVg5rfHdw+ybVLhCQI54NQJjeN93NuQFtSYUV3Wur+YJEhWXeZCGo7/ZrJFXUbmKtzqKRceKFhTMaGF4MBtwavFhd5yCInwTlWajFv2oEimO5QmZ/gVceu0pz7E2StZ3jtbUakGMQefNoiFjkWEavTRvoU/6UlGJXHRb+rDU8wfpVDZRoeusBNaeYC/j8Kek/72kvPKRkqUKpFiEYStk/ULoPgfTcKepkMqwS7aB1ZDwPVmF3VbY+0lzcyxbYrxiWnJwcQCrrEqPpKGRycKy+w4BSBw6s2FTpFENm3HtAU0R29TGWsBxrRBBiOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qwCLxcmLCZFk3DVwJprdDb2PaFbPL3xyzYdTNxudPM=;
 b=fujKUCmsTbPAUWMtmPXDyg7ZPYOv77kBUdj88CmReRVpfnXNIroBIONqLP4QTPcj/CfWsP+ZKCGu5VSWz8Uesgsi79xUUzuCRojReve1GbJZ0nQwzcl5xRnwt8CgBFp0LpFmV6SUmwnsUl2GRHmn6ZlCuXzHVJHbIs4+PfNAUPkBl1PMi4iBbSf/VlBADVBzBj25Zk4oo/XIQHLxA5qU6GmoQcpFL1yIu26OMEtzQapnNuqu2j5bdyE5+06y3FfsozzQdHTVt5JBgVxw2M3p95QZ7UNBnfp3Zg2uYW8zT5FfEnwUyb/KnXAo8zgmApMcqnWE9+jS7HllkWxweQA9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwCLxcmLCZFk3DVwJprdDb2PaFbPL3xyzYdTNxudPM=;
 b=McqDAkT3OM9zi2ZdsOCesD2FaLgCgqQsFs0vAcMULt6Fu16Ds8XvCLW8NKQcHV6GLx/4emwFq0WuWFKQGJDFUJSqtKkwVPsawU68WWB3WLNeIkOX0K05vgahR/bTGDqZwg0qU0x1lhh8ebteEUSOLqhU6LOPkH8AN4QUbWTloNGqrmnfINltRGty3kGo3dXYJL2ItBOyVGiTXK4Bi4n2TzycxKUDn6IxEm0R6FGn5CZ2XSix1OJAL8jITX8c01iLrq/hR/Z/PGDgCrc9wMnlq+RkbtniBBLNq6hUtbbk5CfcPWldjuXBQYrfFLgboqv+8i/u3pxGXUZlcW2uqfXQyA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1497.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 09:45:05 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:45:05 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v3 3/3] net: wwan: t7xx: Add fastboot WWAN port
Date: Thu, 28 Dec 2023 17:44:11 +0800
Message-ID:
 <MEYP282MB2697BEA4E763368E567E909FBB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228094411.13224-1-songjinjian@hotmail.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZYyslJpQq+DeRqypI0nzSPqhFWf6/eWc]
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231228094411.13224-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e7c7fa-4316-4787-14a5-08dc0789ab47
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pWQKDkB8E7vrGBh/dcgb8/5opdZh9RZnqIo0SFT3k2eN+P2IXacXKxq5CNCvfmZFHVF6ya0WAjVWQvFARYxF1fpheJoHqhc3BaQxr78MYdVjZcwEsz3kPTy/RETs0Nz4zeDhUTBHklY61ljyxSjrTujnP2HV9JBu4FWIGUW3bJc+EH8dC+Zhwn3rjeShjpZTqNgItfLqpNwVO5EW9PAW0BOA1fhJo4WG2LliHi0shZ5CkDqGat+Tag5zhGQ9BzX+O2gIqB71qwEG5SZypk4c5h0BeKhnh20jAYnWBztq26RMFrZreJroTxiULVf6QA9pUtOxlm+41QABFlhPcmIoKRZS3qccLiQwGGtPNssSLigtdlEYoCV9ZxZGNAqcWlQ0XaSvm5GaA6IOB2VQ4pMMJ9pjlTOFSUFSXrM/8+SCT4nsqlWsU52e5/D+kJHN2wIJZoiOSnNdowxQzv5MlbLdG2rvx+kspyx1qU9Xwdz/k0C/QMI29OS3OsDR6cFu0Ulk1jk02/ujrdrLwtUAF1a//VuNgjDH+4908b39nGZwsCyOhWkQd0UVT+h/03JctZay
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgcJ1MU1nUVP2crcpYvmVBODdyqxdCRUrne79y+BRnMPqCBGVKvwes6hHAa1?=
 =?us-ascii?Q?S/1lMlRFyK7lvPrcMHmT6eOdr/GkUQp/nia+21Koks1iXhKrcWMHnZ1oYgmo?=
 =?us-ascii?Q?0pkJ3aT8JoSXe2H+n2SnSOc9pX+lLlkCLsuOu4aNYKnB8kn7rpqAlvNupUjH?=
 =?us-ascii?Q?wE0lcro7gVuryM7eGx9bmib8Ac5bbEVI9tky8nbiJuwD+rqq7nLQmD2j3OsT?=
 =?us-ascii?Q?YaoTeRlq4t7DdSwvNkINwFAmrILcICM6xBXURAXuHyIpJhDfZI4i/Zo53NBO?=
 =?us-ascii?Q?Bkqoo3pkZrGzylI/r7UfEkp5/e2SbF1B9NdsyuwS8mJFpdjVboqGhv8Fgz/E?=
 =?us-ascii?Q?/SOtkmqpvOqfsTg/Xam7Jto/Ydsu9Oo+MapyOYzefQZwe3a3zsswSrzB1Vuu?=
 =?us-ascii?Q?OaircpyINJQYlUl7YnP0ohiVenW7UMBcg0mCj1puAtFxdNV4mpEwavDXra2x?=
 =?us-ascii?Q?Uh/73OVWuDVOfHb0uyUd1lWZ/ya2NS5lbJjQIpTkwPpJzhCjnbNUSaGbXFE5?=
 =?us-ascii?Q?IZIhrnxNTxgaKHAVCuh7+4z+GIFuteixyPsFNvPfgb/kceqVXTtPBpOP1/mW?=
 =?us-ascii?Q?FBD0h8V6W+4K72b3fL+HCg3OLcIJxT/roZHlsuoOqNf0hzR2GoF6rhsueR9g?=
 =?us-ascii?Q?BFwF6eEaRWwgn9xNVVwNyB+Q7Xlza5+CgKTANbmhXUxrufO+BukARUuMq/sx?=
 =?us-ascii?Q?j8Q7Ry3wf15wARxtkuraRs/n5Sb5w58HdKDO+Wxr+NhA9kYhq4NfyGHrzzhF?=
 =?us-ascii?Q?ilvMYofCHExuo8q+V8jlblXrggopxBNU9WQTsunVp98tOJHc+KHZys3hA870?=
 =?us-ascii?Q?7Rlfj7UjEn7g+saMAIg+0gli3wZ0OvJXW9yGMk+FrbeX/Vubw1vLaLWvbMGU?=
 =?us-ascii?Q?O8iO3aSRax7gofew1H1EiZupdHY/j6BWee6CSMPGPQfMBxSJMZ6mBm9GdIK2?=
 =?us-ascii?Q?m6oKlCDnBz3axNuz0BMkoP6Xh8W8xDLkWdVISy4JNbNjFIxkz62UFDam7eoW?=
 =?us-ascii?Q?RsnfPWkK5UnGcIKOczBEFg1UUdIk04C1jMMuSguKEphwbmtHGm2zMyJLzwwk?=
 =?us-ascii?Q?hYNk6A5DXBmNxWzqTY2d007Y3BOVoC8/EKfWxYDNpu+pc7XqBEUlir27w7ZA?=
 =?us-ascii?Q?KIUKW+nLm/kai6gWX8GatJOB1JKNFD7VPa27zl4Sx4W3SqU4emC22h9TKh2E?=
 =?us-ascii?Q?CbLmtU02qd8gVCyHCnwq9kJxPHHs6CeObzDf/psPEvlX26rJg2/8JIqpZp0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e7c7fa-4316-4787-14a5-08dc0789ab47
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:45:05.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1497

From: Jinjian Song <jinjian.song@fibocom.com>

To support cases such as firmware update or core dump, the t7xx
device is capable of signaling the host that a special port needs
to be created before the handshake phase.

Add the infrastructure required to create the early ports which
also requires a different configuration of CLDMA queues.

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v3:
 * no change
v2:
 * no change
---
 drivers/net/wwan/t7xx/Makefile             |   1 +
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |   3 +-
 drivers/net/wwan/t7xx/t7xx_port.h          |   4 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c | 155 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  89 ++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  12 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  28 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 124 ++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
 13 files changed, 437 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..ddf03efe388a 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -11,6 +11,7 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_port_proxy.o  \
 		t7xx_port_ctrl_msg.o \
 		t7xx_port_wwan.o \
+		t7xx_port_fastboot.o \
 		t7xx_hif_dpmaif.o  \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
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
index ae4578905a8d..fd2e9d085bea 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -530,7 +530,7 @@ static void t7xx_md_hk_wq(struct work_struct *work)
 
 	/* Clear the HS2 EXIT event appended in core_reset() */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_MD_HS2_EXIT);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS2);
 	md->core_md.handshake_ongoing = true;
@@ -545,7 +545,7 @@ static void t7xx_ap_hk_wq(struct work_struct *work)
 	 /* Clear the HS2 EXIT event appended in t7xx_core_reset(). */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_AP_HS2_EXIT);
 	t7xx_cldma_stop(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_AP]);
 	md->core_ap.handshake_ongoing = true;
 	t7xx_core_hk_handler(md, &md->core_ap, ctl, FSM_EVENT_AP_HS2, FSM_EVENT_AP_HS2_EXIT);
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index d5f6a8638aba..f51e5e2b41e1 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -170,7 +170,8 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	return t7xx_wait_pm_config(t7xx_dev);
+	t7xx_wait_pm_config(t7xx_dev);
+	return 0;
 }
 
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
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
diff --git a/drivers/net/wwan/t7xx/t7xx_port_fastboot.c b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
new file mode 100644
index 000000000000..1b7936b8eef0
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Fibocom Wireless Inc.
+ *
+ * Authors:
+ *  Jinjian Song <jinjian.song@fibocom.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/wwan.h>
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_state_monitor.h"
+
+static int t7xx_port_ctrl_start(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	if (atomic_read(&port_mtk->usage_cnt))
+		return -EBUSY;
+
+	atomic_inc(&port_mtk->usage_cnt);
+	return 0;
+}
+
+static void t7xx_port_ctrl_stop(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	atomic_dec(&port_mtk->usage_cnt);
+}
+
+static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	struct sk_buff *cur = skb, *cloned;
+	size_t actual, len, offset = 0;
+	int ret;
+	int txq_mtu;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	txq_mtu = t7xx_get_port_mtu(port_private);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		cloned = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!cloned)
+			return -ENOMEM;
+
+		skb_put_data(cloned, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port_private, cloned);
+		if (ret) {
+			dev_kfree_skb(cloned);
+			dev_err(port_private->dev, "Write error on fastboot port, %d\n", ret);
+			break;
+		}
+		offset += len;
+		actual -= len;
+	}
+
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static const struct wwan_port_ops wwan_ops = {
+	.start = t7xx_port_ctrl_start,
+	.stop = t7xx_port_ctrl_stop,
+	.tx = t7xx_port_ctrl_tx,
+};
+
+static int t7xx_port_fastboot_init(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	port->rx_length_th = RX_QUEUE_MAXLEN;
+
+	if (!port->wwan.wwan_port) {
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
+		caps.headroom_len = header_len;
+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
+							&wwan_ops, &caps, port);
+		if (IS_ERR(port->wwan.wwan_port))
+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
+	}
+
+	return 0;
+}
+
+static void t7xx_port_fastboot_uninit(struct t7xx_port *port)
+{
+	if (!port->wwan.wwan_port)
+		return;
+
+	port->rx_length_th = 0;
+	wwan_remove_port(port->wwan.wwan_port);
+	port->wwan.wwan_port = NULL;
+}
+
+static int t7xx_port_fastboot_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		dev_kfree_skb_any(skb);
+		dev_err_ratelimited(port->dev, "Port %s is not opened, drop packets\n",
+				    port_conf->name);
+		/* Dropping skb, caller should not access skb.*/
+		return 0;
+	}
+
+	wwan_port_rx(port->wwan.wwan_port, skb);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+struct port_ops fastboot_port_ops = {
+	.init = t7xx_port_fastboot_init,
+	.recv_skb = t7xx_port_fastboot_recv_skb,
+	.uninit = t7xx_port_fastboot_uninit,
+	.enable_chl = t7xx_port_fastboot_enable_chl,
+	.disable_chl = t7xx_port_fastboot_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 274846d39fbf..0525a70acc81 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -100,6 +100,21 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
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
+		.ops = &fastboot_port_ops,
+		.name = "FASTBOOT",
+		.port_type = WWAN_PORT_FASTBOOT,
+	},
+};
+
 static struct t7xx_port *t7xx_proxy_get_port_by_ch(struct port_proxy *port_prox, enum port_ch ch)
 {
 	const struct t7xx_port_conf *port_conf;
@@ -214,7 +229,17 @@ int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb)
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
@@ -329,6 +354,30 @@ static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
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
@@ -359,7 +408,7 @@ static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev
  ** 0		- Packet consumed.
  ** -ERROR	- Failed to process skb.
  */
-static int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
 {
 	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
 	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
@@ -451,13 +500,39 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
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
@@ -465,12 +540,8 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 
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
 
@@ -492,8 +563,6 @@ int t7xx_port_proxy_init(struct t7xx_modem *md)
 	if (ret)
 		return ret;
 
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_AP], t7xx_port_proxy_recv_skb);
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 81d059fbc0fb..0f40b4884dc0 100644
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
 
@@ -91,6 +98,8 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+extern struct port_ops fastboot_port_ops;
+
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
@@ -98,5 +107,8 @@ void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int
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
index c41d7d094c08..c76d2b3c162d 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -101,11 +101,33 @@ enum t7xx_pm_resume_state {
 	PM_RESUME_REG_STATE_L2_EXP,
 };
 
+enum host_event_e {
+	HOST_EVENT_INIT = 0,
+	FASTBOOT_DL_NOTIFY = 0x3,
+};
+
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
-#define MISC_STAGE_MASK				GENMASK(2, 0)
-#define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_RESET_TYPE_FLDR			BIT(27)
-#define LINUX_STAGE				4
+#define MISC_RESET_TYPE_PLDR			BIT(26)
+#define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+#define HOST_EVENT_MASK				GENMASK(31, 28)
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
index 23f54226aba0..a168bac1f40d 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -206,6 +206,55 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
+{
+	u32 value;
+
+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+}
+
+static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
+{
+	struct t7xx_modem *md = ctl->md;
+	struct cldma_ctrl *md_ctrl;
+	enum lk_event_id lk_event;
+	struct device *dev;
+	struct t7xx_port *port;
+
+	dev = &md->t7xx_dev->pdev->dev;
+	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
+	switch (lk_event) {
+	case LK_EVENT_NORMAL:
+	case LK_EVENT_RESET:
+		break;
+
+	case LK_EVENT_CREATE_PD_PORT:
+	case LK_EVENT_CREATE_POST_DL_PORT:
+		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
+		t7xx_cldma_hif_hw_init(md_ctrl);
+		t7xx_cldma_stop(md_ctrl);
+		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+
+		port = &ctl->md->port_prox->ports[0];
+		port->port_conf->ops->enable_chl(port);
+
+		t7xx_cldma_start(md_ctrl);
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			atomic_set(&md->t7xx_dev->mode, T7XX_FASTBOOT_DL_MODE);
+		else
+			atomic_set(&md->t7xx_dev->mode, T7XX_FASTBOOT_DUMP_MODE);
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
@@ -230,7 +279,9 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	struct cldma_ctrl *md_ctrl;
 	int err;
 
-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
+	if (ctl->curr_state == FSM_STATE_STOPPED ||
+	    ctl->curr_state == FSM_STATE_STOPPING ||
+	    ctl->md->rgu_irq_asserted) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
 		return;
 	}
@@ -242,11 +293,16 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (!ctl->md->rgu_irq_asserted) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
-		/* Wait for the DRM disable to take effect */
-		msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (atomic_read(&t7xx_dev->mode) == T7XX_FASTBOOT_DL_SWITCHING)
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
 
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
+
+	if (atomic_read(&t7xx_dev->mode) == T7XX_FASTBOOT_DL_SWITCHING) {
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+	} else {
 		err = t7xx_acpi_fldr_func(t7xx_dev);
 		if (err)
 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
@@ -318,7 +374,8 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
 	struct t7xx_modem *md = ctl->md;
-	u32 dev_status;
+	struct device *dev;
+	u32 status;
 	int ret;
 
 	if (!md)
@@ -330,23 +387,57 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
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
@@ -518,6 +609,7 @@ void t7xx_fsm_reset(struct t7xx_modem *md)
 	fsm_flush_event_cmd_qs(ctl);
 	ctl->curr_state = FSM_STATE_STOPPED;
 	ctl->exp_flg = false;
+	ctl->prev_status = 0;
 }
 
 int t7xx_fsm_init(struct t7xx_modem *md)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b0b3662ae6d7..9421bbd2f117 100644
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


