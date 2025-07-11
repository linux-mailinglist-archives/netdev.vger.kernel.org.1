Return-Path: <netdev+bounces-206063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68512B01381
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206561C277A2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71251E98EF;
	Fri, 11 Jul 2025 06:25:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B661E1DFE;
	Fri, 11 Jul 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215114; cv=none; b=UFmJLyhBeL5jph5ueXBzn1zJ1B1nPI9aPVi+pIUYgenj/o8jj4BSbdAINpemKrbM2eTdd0iMaoAtDjnhYRXKYAazTntzAOmZmEH/XSlEI2xv+H8GeEcgkER5foKAqcE++3NHFrg1kfkd+5xhMugYgOuA+ku/IctkLFTW0DS5X0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215114; c=relaxed/simple;
	bh=AVZ60z8dnYKpruiZKL5sJrPKb9kFq415ZVTA9F6Ynzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POQ86Il+whyDwfHZ/gjIBjSBieAvvlMUK1+zfM8ijz1p18RJRRx4Un7egT47ybhmUrQORxOTadsMJCSisjpF9N5NV5WM1hrUYvAb/iN+2ejOePjwlQKJpPpdHMlIGcTpjJgZ/YgQw9r/1BvP/4VqqR8K4WOWFmE5nheUKBQ/EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bdhTJ6yysz13Mkx;
	Fri, 11 Jul 2025 14:22:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 351A3140137;
	Fri, 11 Jul 2025 14:25:10 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 14:25:09 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 11/11] net: hns3: remove the unused code after using seq_file
Date: Fri, 11 Jul 2025 14:17:25 +0800
Message-ID: <20250711061725.225585-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250711061725.225585-1-shaojijie@huawei.com>
References: <20250711061725.225585-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Remove the unused code after using seq_file.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
ChangeLog:
v1 -> v2:
  - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   4 -
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 143 ------------------
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |  16 --
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  23 ---
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   1 -
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 -
 6 files changed, 189 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 5cc20558fe21..3b548f71fa8a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -587,8 +587,6 @@ typedef int (*read_func)(struct seq_file *s, void *data);
  *   Delete clsflower rule
  * cls_flower_active
  *   Check if any cls flower rule exist
- * dbg_read_cmd
- *   Execute debugfs read command.
  * set_tx_hwts_info
  *   Save information for 1588 tx packet
  * get_rx_hwts
@@ -757,8 +755,6 @@ struct hnae3_ae_ops {
 	void (*enable_fd)(struct hnae3_handle *handle, bool enable);
 	int (*add_arfs_entry)(struct hnae3_handle *handle, u16 queue_id,
 			      u16 flow_id, struct flow_keys *fkeys);
-	int (*dbg_read_cmd)(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
-			    char *buf, int len);
 	pci_ers_result_t (*handle_hw_ras_error)(struct hnae3_ae_dev *ae_dev);
 	bool (*get_hw_reset_stat)(struct hnae3_handle *handle);
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bdc2319d9969..0255c8acb744 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -49,315 +49,270 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tm_nodes",
 		.cmd = HNAE3_DBG_CMD_TM_NODES,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_priority",
 		.cmd = HNAE3_DBG_CMD_TM_PRI,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_map",
 		.cmd = HNAE3_DBG_CMD_TM_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_pg",
 		.cmd = HNAE3_DBG_CMD_TM_PG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_port",
 		.cmd = HNAE3_DBG_CMD_TM_PORT,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tc_sch_info",
 		.cmd = HNAE3_DBG_CMD_TC_SCH_INFO,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pause_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_PAUSE_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pri_map",
 		.cmd = HNAE3_DBG_CMD_QOS_PRI_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_dscp_map",
 		.cmd = HNAE3_DBG_CMD_QOS_DSCP_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_buf_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_BUF_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dev_info",
 		.cmd = HNAE3_DBG_CMD_DEV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_TX_BD,
 		.dentry = HNS3_DBG_DENTRY_TX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_5MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
 		.name = "rx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_RX_BD,
 		.dentry = HNS3_DBG_DENTRY_RX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_4MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
 		.name = "uc",
 		.cmd = HNAE3_DBG_CMD_MAC_UC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mc",
 		.cmd = HNAE3_DBG_CMD_MAC_MC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mng_tbl",
 		.cmd = HNAE3_DBG_CMD_MNG_TBL,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "loopback",
 		.cmd = HNAE3_DBG_CMD_LOOPBACK,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "interrupt_info",
 		.cmd = HNAE3_DBG_CMD_INTERRUPT_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "reset_info",
 		.cmd = HNAE3_DBG_CMD_RESET_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "imp_info",
 		.cmd = HNAE3_DBG_CMD_IMP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncl_config",
 		.cmd = HNAE3_DBG_CMD_NCL_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac_tnl_status",
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "bios_common",
 		.cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ssu",
 		.cmd = HNAE3_DBG_CMD_REG_SSU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "igu_egu",
 		.cmd = HNAE3_DBG_CMD_REG_IGU_EGU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rpu",
 		.cmd = HNAE3_DBG_CMD_REG_RPU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncsi",
 		.cmd = HNAE3_DBG_CMD_REG_NCSI,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rtc",
 		.cmd = HNAE3_DBG_CMD_REG_RTC,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ppp",
 		.cmd = HNAE3_DBG_CMD_REG_PPP,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rcb",
 		.cmd = HNAE3_DBG_CMD_REG_RCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tqp",
 		.cmd = HNAE3_DBG_CMD_REG_TQP,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac",
 		.cmd = HNAE3_DBG_CMD_REG_MAC,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dcb",
 		.cmd = HNAE3_DBG_CMD_REG_DCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "queue_map",
 		.cmd = HNAE3_DBG_CMD_QUEUE_MAP,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "rx_queue_info",
 		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_queue_info",
 		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "fd_tcam",
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
 		.dentry = HNS3_DBG_DENTRY_FD,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "service_task_info",
 		.cmd = HNAE3_DBG_CMD_SERV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "vlan_config",
 		.cmd = HNAE3_DBG_CMD_VLAN_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ptp_info",
 		.cmd = HNAE3_DBG_CMD_PTP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "fd_counter",
 		.cmd = HNAE3_DBG_CMD_FD_COUNTER,
 		.dentry = HNS3_DBG_DENTRY_FD,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "umv_info",
 		.cmd = HNAE3_DBG_CMD_UMV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "page_pool_info",
 		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "coalesce_info",
 		.cmd = HNAE3_DBG_CMD_COAL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 };
@@ -860,104 +815,6 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hns3_dbg_get_cmd_index(struct hns3_dbg_data *dbg_data, u32 *index)
-{
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++) {
-		if (hns3_dbg_cmd[i].cmd == dbg_data->cmd) {
-			*index = i;
-			return 0;
-		}
-	}
-
-	dev_err(&dbg_data->handle->pdev->dev, "unknown command(%d)\n",
-		dbg_data->cmd);
-	return -EINVAL;
-}
-
-static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
-};
-
-static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
-			     enum hnae3_dbg_cmd cmd, char *buf, int len)
-{
-	const struct hnae3_ae_ops *ops = hns3_get_ops(dbg_data->handle);
-	const struct hns3_dbg_func *cmd_func;
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd_func); i++) {
-		if (cmd == hns3_dbg_cmd_func[i].cmd) {
-			cmd_func = &hns3_dbg_cmd_func[i];
-			if (cmd_func->dbg_dump)
-				return cmd_func->dbg_dump(dbg_data->handle, buf,
-							  len);
-			else
-				return cmd_func->dbg_dump_bd(dbg_data, buf,
-							     len);
-		}
-	}
-
-	if (!ops->dbg_read_cmd)
-		return -EOPNOTSUPP;
-
-	return ops->dbg_read_cmd(dbg_data->handle, cmd, buf, len);
-}
-
-static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
-			     size_t count, loff_t *ppos)
-{
-	char *buf = filp->private_data;
-
-	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
-}
-
-static int hns3_dbg_open(struct inode *inode, struct file *filp)
-{
-	struct hns3_dbg_data *dbg_data = inode->i_private;
-	struct hnae3_handle *handle = dbg_data->handle;
-	struct hns3_nic_priv *priv = handle->priv;
-	u32 index;
-	char *buf;
-	int ret;
-
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-		return -EBUSY;
-
-	ret = hns3_dbg_get_cmd_index(dbg_data, &index);
-	if (ret)
-		return ret;
-
-	buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
-				buf, hns3_dbg_cmd[index].buf_len);
-	if (ret) {
-		kvfree(buf);
-		return ret;
-	}
-
-	filp->private_data = buf;
-	return 0;
-}
-
-static int hns3_dbg_release(struct inode *inode, struct file *filp)
-{
-	kvfree(filp->private_data);
-	filp->private_data = NULL;
-	return 0;
-}
-
-static const struct file_operations hns3_dbg_fops = {
-	.owner = THIS_MODULE,
-	.open  = hns3_dbg_open,
-	.read  = hns3_dbg_read,
-	.release = hns3_dbg_release,
-};
-
 static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
 {
 	struct hns3_dbg_data *data = s->private;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
index 4a5ef8a90a10..57c9d3fc1b27 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
@@ -6,15 +6,6 @@
 
 #include "hnae3.h"
 
-#define HNS3_DBG_READ_LEN	65536
-#define HNS3_DBG_READ_LEN_128KB	0x20000
-#define HNS3_DBG_READ_LEN_1MB	0x100000
-#define HNS3_DBG_READ_LEN_4MB	0x400000
-#define HNS3_DBG_READ_LEN_5MB	0x500000
-#define HNS3_DBG_WRITE_LEN	1024
-
-#define HNS3_DBG_DATA_STR_LEN	32
-#define HNS3_DBG_INFO_LEN	256
 #define HNS3_DBG_ITEM_NAME_LEN	32
 #define HNS3_DBG_FILE_NAME_LEN	16
 
@@ -49,16 +40,9 @@ struct hns3_dbg_cmd_info {
 	const char *name;
 	enum hnae3_dbg_cmd cmd;
 	enum hns3_dbg_dentry_type dentry;
-	u32 buf_len;
 	int (*init)(struct hnae3_handle *handle, unsigned int cmd);
 };
 
-struct hns3_dbg_func {
-	enum hnae3_dbg_cmd cmd;
-	int (*dbg_dump)(struct hnae3_handle *handle, char *buf, int len);
-	int (*dbg_dump_bd)(struct hns3_dbg_data *data, char *buf, int len);
-};
-
 struct hns3_dbg_cap_info {
 	const char *name;
 	enum HNAE3_DEV_CAP_BITS cap_bit;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 03218d1b5c60..b76d25074e99 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2935,29 +2935,6 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 };
 
-int hclge_dbg_read_cmd(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
-		       char *buf, int len)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	const struct hclge_dbg_func *cmd_func;
-	struct hclge_dev *hdev = vport->back;
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(hclge_dbg_cmd_func); i++) {
-		if (cmd == hclge_dbg_cmd_func[i].cmd) {
-			cmd_func = &hclge_dbg_cmd_func[i];
-			if (cmd_func->dbg_dump)
-				return cmd_func->dbg_dump(hdev, buf, len);
-			else
-				return cmd_func->dbg_dump_reg(hdev, cmd, buf,
-							      len);
-		}
-	}
-
-	dev_err(&hdev->pdev->dev, "invalid command(%d)\n", cmd);
-	return -EINVAL;
-}
-
 int hclge_dbg_get_read_func(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
 			    read_func *func)
 {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9c9e87c22b80..d3c71bc1855d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12864,7 +12864,6 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_fd_all_rules = hclge_get_all_rules,
 	.enable_fd = hclge_enable_fd,
 	.add_arfs_entry = hclge_add_fd_entry_by_arfs,
-	.dbg_read_cmd = hclge_dbg_read_cmd,
 	.dbg_get_read_func = hclge_dbg_get_read_func,
 	.handle_hw_ras_error = hclge_handle_hw_ras_error,
 	.get_hw_reset_stat = hclge_get_hw_reset_stat,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 57c09e8fd583..032b472d2368 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -1142,8 +1142,6 @@ int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
 int hclge_vport_start(struct hclge_vport *vport);
 void hclge_vport_stop(struct hclge_vport *vport);
 int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
-int hclge_dbg_read_cmd(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
-		       char *buf, int len);
 int hclge_dbg_get_read_func(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
 			    read_func *func);
 u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id);
-- 
2.33.0


