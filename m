Return-Path: <netdev+bounces-200112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1BAE3391
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA04B7A6AC5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4E1F94A;
	Mon, 23 Jun 2025 02:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F87C13B;
	Mon, 23 Jun 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750645829; cv=none; b=ElMBdspeeZXLDurfm+RnOntWApXuET8DsWCPSPIQhSWERvWTsAlDFwzXULoxDRdSW2s8VxCxNWn3jSOrcXqEVmWb/GFkOP3Teo3sAm7QP+ylQgy4R5orSv6UpNkB7RXR5yOJRgptzke/S4aKGtsaLLhfR8Yh1mqX7ntE99d8ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750645829; c=relaxed/simple;
	bh=x46zMLpgkFgCgXQdkY5l0zpiFjPG/u2s3X3tD8SHzMY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TD//nf1jG8PYcswUpnlHILMlbcdecjPucOsCg/8NoWAJ/Bbe/n+suBXQdXu9dk8SJKBKVlqu4jLO4mYyx/jJCVnsqN+EF/OgmEEM3SVvNDMMG677pmV/ejDQR16DcHwZ6RV8+Fh6B0tOp+94RjUJhPt1Y8mUkflamOCLFUOp17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bQX80514Jz29dlb;
	Mon, 23 Jun 2025 10:28:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AFA4C140276;
	Mon, 23 Jun 2025 10:30:23 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 10:30:22 +0800
Message-ID: <61e4ff4a-019d-452a-bd12-9c4b0b2a95ef@huawei.com>
Date: Mon, 23 Jun 2025 10:30:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann
	<arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Hao Lan
	<lanhao@huawei.com>, Guangwei Zhang <zhangwangwei6@huawei.com>, Netdev
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
To: Jakub Kicinski <kuba@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612083309.7402a42e@kernel.org>
 <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/13 13:59, Jijie Shao wrote:
>
> on 2025/6/12 23:33, Jakub Kicinski wrote:
>> On Thu, 12 Jun 2025 21:09:40 +0800 Jijie Shao wrote:
>>> seq_file is good. But the change is quite big.
>>> I need to discuss it internally, and it may not be completed so 
>>> quickly.
>>> I will also need consider the maintainer's suggestion.
>> Please work on the seq_file conversion, given that the merge window
>> just closed you have around 6 weeks to get it done, so hopefully plenty
>> of time.
>
> Ok
>
> I will try to send patch as soon as possible to complete this conversion
>
>
> Thanks
> Jijie Shao
>
>
We tried modifying the relevant debugfs files,
and both compilation and tests passed.
Please help us check if the solution is OK.
If it is OK, we will modify all the debugfs files in this way.

====================

 From c62568f3e91eb5725211fde8e63d44f68452b4e3 Mon Sep 17 00:00:00 2001
From: Jian Shen <shenjian15@huawei.com>
Date: Thu, 19 Jun 2025 16:21:17 +0800
Subject: [PATCH  net-next] net: hns3: clean up the build warning in debugfs by
  use seq file

Arnd reported that there are two build warning for on-stasck
buffer oversize[1]. As Arnd's suggestion, using seq file way
to avoid the stack buffer or kmalloc buffer allocating.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/20250610092113.2639248-1-arnd@kernel.org/
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
  drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   3 +
  .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 160 ++++++++----------
  .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   2 +
  3 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 8dc7d6fae224..58a63d2eb69b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -434,8 +434,11 @@ struct hnae3_ae_dev {
  	u32 dev_version;
  	DECLARE_BITMAP(caps, HNAE3_DEV_CAPS_MAX_NUM);
  	void *priv;
+	struct hnae3_handle *handle;
  };
  
+typedef int (*read_func)(struct seq_file *s, void *data);
+
  /* This struct defines the operation on the handle.
   *
   * init_ae_dev(): (mandatory)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4e5d8bc39a1b..458a2944ee3c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -3,6 +3,7 @@
  
  #include <linux/debugfs.h>
  #include <linux/device.h>
+#include <linux/seq_file.h>
  #include <linux/string_choices.h>
  
  #include "hnae3.h"
@@ -41,6 +42,7 @@ static struct hns3_dbg_dentry_info hns3_dbg_dentry[] = {
  
  static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd);
  static int hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd);
+static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd);
  
  static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
  	{
@@ -300,7 +302,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
  		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
  		.dentry = HNS3_DBG_DENTRY_QUEUE,
  		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
  	},
  	{
  		.name = "fd_tcam",
@@ -580,44 +582,29 @@ static const struct hns3_dbg_item tx_spare_info_items[] = {
  	{ "DMA", 17 },
  };
  
-static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
-				   int len, u32 ring_num, int *pos)
+static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring,
+				   struct seq_file *s, u32 ring_num)
  {
-	char data_str[ARRAY_SIZE(tx_spare_info_items)][HNS3_DBG_DATA_STR_LEN];
  	struct hns3_tx_spare *tx_spare = ring->tx_spare;
-	char *result[ARRAY_SIZE(tx_spare_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
-	u32 i, j;
+	u32 i;
  
  	if (!tx_spare) {
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "tx spare buffer is not enabled\n");
+		seq_puts(s, "tx spare buffer is not enabled\n");
  		return;
  	}
  
-	for (i = 0; i < ARRAY_SIZE(tx_spare_info_items); i++)
-		result[i] = &data_str[i][0];
-
-	*pos += scnprintf(buf + *pos, len - *pos, "tx spare buffer info\n");
-	hns3_dbg_fill_content(content, sizeof(content), tx_spare_info_items,
-			      NULL, ARRAY_SIZE(tx_spare_info_items));
-	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+	seq_puts(s, "tx spare buffer info\n");
  
-	for (i = 0; i < ring_num; i++) {
-		j = 0;
-		sprintf(result[j++], "%u", i);
-		sprintf(result[j++], "%u", ring->tx_copybreak);
-		sprintf(result[j++], "%u", tx_spare->len);
-		sprintf(result[j++], "%u", tx_spare->next_to_use);
-		sprintf(result[j++], "%u", tx_spare->next_to_clean);
-		sprintf(result[j++], "%u", tx_spare->last_to_clean);
-		sprintf(result[j++], "%pad", &tx_spare->dma);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_spare_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_spare_info_items));
-		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
-	}
+	for (i = 0; i < ARRAY_SIZE(tx_spare_info_items); i++)
+		seq_printf(s, "%s%*s", tx_spare_info_items[i].name,
+			   tx_spare_info_items[i].interval, " ");
+	seq_puts(s, "\n");
+
+	for (i = 0; i < ring_num; i++)
+		seq_printf(s, "%-4u%6s%-5u%6s%-8u%2s%-5u%2s%-5u%2s%-5u%2s%pad\n",
+			   i, " ", ring->tx_copybreak, " ", tx_spare->len, " ",
+			   tx_spare->next_to_use, " ", tx_spare->next_to_clean,
+			   " ", tx_spare->last_to_clean, " ", &tx_spare->dma);
  }
  
  static const struct hns3_dbg_item rx_queue_info_items[] = {
@@ -739,62 +726,52 @@ static const struct hns3_dbg_item tx_queue_info_items[] = {
  };
  
  static void hns3_dump_tx_queue_info(struct hns3_enet_ring *ring,
-				    struct hnae3_ae_dev *ae_dev, char **result,
-				    u32 index)
+				    struct hnae3_ae_dev *ae_dev,
+				    struct seq_file *s, u32 index)
  {
+	void __iomem *base = ring->tqp->io_base;
  	u32 base_add_l, base_add_h;
-	u32 j = 0;
-
-	sprintf(result[j++], "%u", index);
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_BD_NUM_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_TC_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_TAIL_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_HEAD_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_FBDNUM_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_OFFSET_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_PKTNUM_RECORD_REG));
  
-	sprintf(result[j++], "%s",
-		str_on_off(readl_relaxed(ring->tqp->io_base +
-					 HNS3_RING_EN_REG)));
+	seq_printf(s, "%-4u%6s", index, " ");
+	seq_printf(s, "%-5u%3s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_BD_NUM_REG), " ");
+	seq_printf(s, "%u%3s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_TC_REG), " ");
+	seq_printf(s, "%-4u%2s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_TAIL_REG), " ");
+	seq_printf(s, "%-4u%2s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_HEAD_REG), " ");
+	seq_printf(s, "%-4u%4s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_FBDNUM_REG), " ");
+	seq_printf(s, "%-4u%4s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_OFFSET_REG), " ");
+	seq_printf(s, "%-9u%2s",
+		   readl_relaxed(base + HNS3_RING_TX_RING_PKTNUM_RECORD_REG),
+		   " ");
+	seq_printf(s, "%-3s%6s",
+		   str_on_off(readl_relaxed(base + HNS3_RING_EN_REG)), " ");
  
  	if (hnae3_ae_dev_tqp_txrx_indep_supported(ae_dev))
-		sprintf(result[j++], "%s",
-			str_on_off(readl_relaxed(ring->tqp->io_base +
-						 HNS3_RING_TX_EN_REG)));
+		seq_printf(s, "%-3s%9s",
+			   str_on_off(readl_relaxed(base +
+						    HNS3_RING_TX_EN_REG)),
+			   " ");
  	else
-		sprintf(result[j++], "%s", "NA");
+		seq_printf(s, "%-3s%9s", "NA", " ");
  
  	base_add_h = readl_relaxed(ring->tqp->io_base +
  					HNS3_RING_TX_RING_BASEADDR_H_REG);
  	base_add_l = readl_relaxed(ring->tqp->io_base +
  					HNS3_RING_TX_RING_BASEADDR_L_REG);
-	sprintf(result[j++], "0x%08x%08x", base_add_h, base_add_l);
+	seq_printf(s, "0x%08x%08x\n", base_add_h, base_add_l);
  }
  
-static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
-				  char *buf, int len)
+static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
  {
-	char data_str[ARRAY_SIZE(tx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
-	char *result[ARRAY_SIZE(tx_queue_info_items)];
+	struct hnae3_ae_dev *ae_dev = dev_get_drvdata(s->private);
+	struct hnae3_handle *h = ae_dev->handle;
  	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
  	struct hns3_enet_ring *ring;
-	int pos = 0;
  	u32 i;
  
  	if (!priv->ring) {
@@ -803,11 +780,10 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
  	}
  
  	for (i = 0; i < ARRAY_SIZE(tx_queue_info_items); i++)
-		result[i] = &data_str[i][0];
+		seq_printf(s, "%s%*s", tx_queue_info_items[i].name,
+			   tx_queue_info_items[i].interval, " ");
  
-	hns3_dbg_fill_content(content, sizeof(content), tx_queue_info_items,
-			      NULL, ARRAY_SIZE(tx_queue_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
+	seq_puts(s, "\n");
  
  	for (i = 0; i < h->kinfo.num_tqps; i++) {
  		/* Each cycle needs to determine whether the instance is reset,
@@ -819,15 +795,10 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
  			return -EPERM;
  
  		ring = &priv->ring[i];
-		hns3_dump_tx_queue_info(ring, ae_dev, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_queue_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_queue_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_tx_queue_info(ring, ae_dev, s, i);
  	}
  
-	hns3_dbg_tx_spare_info(ring, buf, len, h->kinfo.num_tqps, &pos);
+	hns3_dbg_tx_spare_info(ring, s, h->kinfo.num_tqps);
  
  	return 0;
  }
@@ -1222,10 +1193,6 @@ static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
  		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
  		.dbg_dump = hns3_dbg_rx_queue_info,
  	},
-	{
-		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
-		.dbg_dump = hns3_dbg_tx_queue_info,
-	},
  	{
  		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
  		.dbg_dump = hns3_dbg_page_pool_info,
@@ -1362,6 +1329,27 @@ hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd)
  	return 0;
  }
  
+static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd)
+{
+	struct device *dev = &handle->pdev->dev;
+	struct dentry *entry_dir;
+	read_func func = NULL;
+
+	switch (hns3_dbg_cmd[cmd].cmd) {
+	case HNAE3_DBG_CMD_TX_QUEUE_INFO:
+		func = hns3_dbg_tx_queue_info;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	entry_dir = hns3_dbg_dentry[hns3_dbg_cmd[cmd].dentry].dentry;
+	debugfs_create_devm_seqfile(dev, hns3_dbg_cmd[cmd].name, entry_dir,
+				    func);
+
+	return 0;
+}
+
  int hns3_dbg_init(struct hnae3_handle *handle)
  {
  	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 5c8c62ea6ac0..f01c7e45e674 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5299,6 +5299,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
  	struct net_device *netdev;
  	int ret;
  
+	ae_dev->handle = handle;
+
  	handle->ae_algo->ops->get_tqps_and_rss_info(handle, &alloc_tqps,
  						    &max_rss_size);
  	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv), alloc_tqps);
-- 
2.33.0




