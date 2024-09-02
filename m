Return-Path: <netdev+bounces-124176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE1968643
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF11C21866
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404351D2F69;
	Mon,  2 Sep 2024 11:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290B13B59B;
	Mon,  2 Sep 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276749; cv=none; b=XEVgYICF54Sna3k8691mD+BM5fudprSDCt1Zszyz19ssmvcW7SgBYysMs5Z2c7HNT2oERUSLfsuSzeEeRennJAe/s9QOmAsjopg3LUMFhMKb8Q4HPRJdeuauK1gEB2h36XhmVhmwL4BSye11QCOOWockibx8zLth/WuBlTebNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276749; c=relaxed/simple;
	bh=Zk1PeHncF6tcsRQC18kf6d+RE/h3SNvp3NFfzRgu/7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpRqfn32Kr/4FSZSeJiFMD6LorFy8bFybELjZY0K+QmcQVwwoiETFXHDJnBWgPDADfzh3gSg99IPRN1a7SwdmF8kG7C/QMPRr/qsGQIFByOE9ktEPFdS5sGovbvLHGK6vk/hr7cIgkFrmWI2XYN74FqQOjf/uLhqoUEGOtljfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy64S5jkNzgYfm;
	Mon,  2 Sep 2024 19:30:16 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8AE14022D;
	Mon,  2 Sep 2024 19:32:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 19:32:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <shshaikh@marvell.com>, <manishc@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] qlcnic: Remove unused declarations
Date: Mon, 2 Sep 2024 19:29:04 +0800
Message-ID: <20240902112904.556577-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

There is no caller and implementation in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h         |  1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
index b25102fded7b..3d0b5cd978cb 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -1608,7 +1608,6 @@ void qlcnic_release_tx_buffers(struct qlcnic_adapter *,
 			       struct qlcnic_host_tx_ring *);
 
 int qlcnic_check_fw_status(struct qlcnic_adapter *adapter);
-void qlcnic_watchdog_task(struct work_struct *work);
 void qlcnic_post_rx_buffers(struct qlcnic_adapter *adapter,
 		struct qlcnic_host_rds_ring *rds_ring, u8 ring_id);
 void qlcnic_set_multi(struct net_device *netdev);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index 23cd47d588e5..a55fe6ac06c7 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -539,7 +539,6 @@ int qlcnic_83xx_setup_intr(struct qlcnic_adapter *);
 void qlcnic_83xx_get_func_no(struct qlcnic_adapter *);
 int qlcnic_83xx_cam_lock(struct qlcnic_adapter *);
 void qlcnic_83xx_cam_unlock(struct qlcnic_adapter *);
-int qlcnic_send_ctrl_op(struct qlcnic_adapter *, struct qlcnic_cmd_args *, u32);
 void qlcnic_83xx_add_sysfs(struct qlcnic_adapter *);
 void qlcnic_83xx_remove_sysfs(struct qlcnic_adapter *);
 void qlcnic_83xx_write_crb(struct qlcnic_adapter *, char *, loff_t, size_t);
@@ -577,8 +576,6 @@ int qlcnic_83xx_get_mac_address(struct qlcnic_adapter *, u8 *, u8);
 int qlcnic_83xx_alloc_mbx_args(struct qlcnic_cmd_args *,
 			       struct qlcnic_adapter *, u32);
 void qlcnic_free_mbx_args(struct qlcnic_cmd_args *);
-void qlcnic_set_npar_data(struct qlcnic_adapter *, const struct qlcnic_info *,
-			  struct qlcnic_info *);
 int qlcnic_83xx_config_intr_coal(struct qlcnic_adapter *,
 				 struct ethtool_coalesce *);
 int qlcnic_83xx_set_rx_tx_intr_coal(struct qlcnic_adapter *);
@@ -590,7 +587,6 @@ irqreturn_t qlcnic_83xx_intr(int, void *);
 irqreturn_t qlcnic_83xx_tmp_intr(int, void *);
 void qlcnic_83xx_check_vf(struct qlcnic_adapter *,
 			  const struct pci_device_id *);
-int qlcnic_83xx_config_default_opmode(struct qlcnic_adapter *);
 int qlcnic_83xx_setup_mbx_intr(struct qlcnic_adapter *);
 void qlcnic_83xx_free_mbx_intr(struct qlcnic_adapter *);
 void qlcnic_83xx_register_map(struct qlcnic_hardware_context *);
@@ -602,8 +598,6 @@ int qlcnic_83xx_flash_bulk_write(struct qlcnic_adapter *, u32, u32 *, int);
 int qlcnic_83xx_flash_write32(struct qlcnic_adapter *, u32, u32 *);
 int qlcnic_83xx_lock_flash(struct qlcnic_adapter *);
 void qlcnic_83xx_unlock_flash(struct qlcnic_adapter *);
-int qlcnic_83xx_save_flash_status(struct qlcnic_adapter *);
-int qlcnic_83xx_restore_flash_status(struct qlcnic_adapter *, int);
 int qlcnic_83xx_read_flash_mfg_id(struct qlcnic_adapter *);
 int qlcnic_83xx_read_flash_descriptor_table(struct qlcnic_adapter *);
 int qlcnic_83xx_flash_read32(struct qlcnic_adapter *, u32, u8 *, int);
@@ -616,13 +610,9 @@ void qlcnic_83xx_idc_exit(struct qlcnic_adapter *);
 void qlcnic_83xx_idc_request_reset(struct qlcnic_adapter *, u32);
 int qlcnic_83xx_lock_driver(struct qlcnic_adapter *);
 void qlcnic_83xx_unlock_driver(struct qlcnic_adapter *);
-int qlcnic_83xx_set_default_offload_settings(struct qlcnic_adapter *);
 int qlcnic_83xx_idc_vnic_pf_entry(struct qlcnic_adapter *);
 int qlcnic_83xx_disable_vnic_mode(struct qlcnic_adapter *, int);
 int qlcnic_83xx_config_vnic_opmode(struct qlcnic_adapter *);
-int qlcnic_83xx_get_vnic_vport_info(struct qlcnic_adapter *,
-				    struct qlcnic_info *, u8);
-int qlcnic_83xx_get_vnic_pf_info(struct qlcnic_adapter *, struct qlcnic_info *);
 int qlcnic_83xx_set_port_eswitch_status(struct qlcnic_adapter *, int, int *);
 
 void qlcnic_83xx_get_minidump_template(struct qlcnic_adapter *);
-- 
2.34.1


