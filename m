Return-Path: <netdev+bounces-124178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A6968653
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4211C1F239C0
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F2187847;
	Mon,  2 Sep 2024 11:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4913B58D;
	Mon,  2 Sep 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276969; cv=none; b=nmUHmR3AenB5BrWGdllVwxiBGybSzo51i/TunlOeJX0PfuL0bY2qvKQDoNsdVKK7SFe+mke/aYxGT6WQhyxW5GtkH7VpoQl/ejfwaQu2A8yrfA04kM+01euMsa1FpLyjQ0J7dk1q+T6uMnLWJhbNswvx93gOH3htUMNr/OCilgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276969; c=relaxed/simple;
	bh=TUPedZajoDS3q6PnHER7/XYy3rrwzlsklEjE9FSVSm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RrAgAcsD9Z1a/ptqfe7ShluYF6j2r7XeiKSo4IAEQNt5Y4KdSDZvhTkVWoCwpfOyxEzzzJ9Qq2Lu4mWz6jFgwemRDMgqHGrwljpBn74xiCmzEjeJBcb8CWmjLGr1FfPCXmydv+a1YejXtOm7mYLnvGDyX3LXWAAjfJfCmx+f0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy68l0t04zgYvY;
	Mon,  2 Sep 2024 19:33:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BA5814022D;
	Mon,  2 Sep 2024 19:36:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 19:36:04 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <ajit.khaparde@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
	<somnath.kotur@broadcom.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] be2net: Remove unused declarations
Date: Mon, 2 Sep 2024 19:32:38 +0800
Message-ID: <20240902113238.557515-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 6b7c5b947c67 ("net: Add be2net driver.") declared be_pci_fnum_get()
and be_cmd_reset() but never implemented. And commit 9fa465c0ce0d ("be2net:
remove code duplication relating to Lancer reset sequence") removed
lancer_test_and_set_rdy_state() but leave declaration.

Commit 76a9e08e33ce ("be2net: cleanup wake-on-lan code") left behind
be_is_wol_supported() declaration.
Commit baaa08d148ac ("be2net: do not call be_set/get_fw_log_level() on
Skyhawk-R") removed be_get_fw_log_level() but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/emulex/benet/be.h      | 2 --
 drivers/net/ethernet/emulex/benet/be_cmds.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 61fe9625bed1..e48b861e4ce1 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -966,9 +966,7 @@ void be_cq_notify(struct be_adapter *adapter, u16 qid, bool arm,
 void be_link_status_update(struct be_adapter *adapter, u8 link_status);
 void be_parse_stats(struct be_adapter *adapter);
 int be_load_fw(struct be_adapter *adapter, u8 *func);
-bool be_is_wol_supported(struct be_adapter *adapter);
 bool be_pause_supported(struct be_adapter *adapter);
-u32 be_get_fw_log_level(struct be_adapter *adapter);
 int be_update_queues(struct be_adapter *adapter);
 int be_poll(struct napi_struct *napi, int budget);
 void be_eqd_update(struct be_adapter *adapter, bool force_update);
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index e2085c68c0ee..d70818f06be7 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -2381,7 +2381,6 @@ struct be_cmd_req_manage_iface_filters {
 } __packed;
 
 u16 be_POST_stage_get(struct be_adapter *adapter);
-int be_pci_fnum_get(struct be_adapter *adapter);
 int be_fw_wait_ready(struct be_adapter *adapter);
 int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 			  bool permanent, u32 if_handle, u32 pmac_id);
@@ -2406,7 +2405,6 @@ int be_cmd_q_destroy(struct be_adapter *adapter, struct be_queue_info *q,
 int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q);
 int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 			     u8 *link_status, u32 dom);
-int be_cmd_reset(struct be_adapter *adapter);
 int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd);
 int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 			       struct be_dma_mem *nonemb_cmd);
@@ -2488,7 +2486,6 @@ int lancer_physdev_ctrl(struct be_adapter *adapter, u32 mask);
 int lancer_initiate_dump(struct be_adapter *adapter);
 int lancer_delete_dump(struct be_adapter *adapter);
 bool dump_present(struct be_adapter *adapter);
-int lancer_test_and_set_rdy_state(struct be_adapter *adapter);
 int be_cmd_query_port_name(struct be_adapter *adapter);
 int be_cmd_get_func_config(struct be_adapter *adapter,
 			   struct be_resources *res);
-- 
2.34.1


