Return-Path: <netdev+bounces-121640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6195DCEE
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 10:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07186B222E5
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED641C72;
	Sat, 24 Aug 2024 08:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E55680;
	Sat, 24 Aug 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724488269; cv=none; b=p4Tx1JZL31oxwjSG5TV+PcTM2xy3Fee3qi6pv5ryorHw8Q10bc6fCm+tWYnnaXVUXpmGrxsn+5yMDvkFhHYrjnAwEYIOq0OsJTFr5CaFGv9hnlpjEN+AY2JqOR2XscspoeVcgSumGCm1huUjVl9IJBWpfn38PVt+BApH1bF5WLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724488269; c=relaxed/simple;
	bh=LrqFDkUmIvFFNaapSpHMCwzY7Fe3ubWkf37HbR3qqrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLAIl1PzAK7mFPmXMS6/7oCzq0vhQCa5jR2Qa57UxpOtBm8OhOa+o3z2hqp2CzHzqBf0Yf/NoXxGN9UagFcFdtIWgRGB9PqNiaGQro4SQJJ+ILlUSOBnrxXTy3230esvNQmCIA4s7I9LP4HaEkrt1xyQ22sP0k38tjpDP9EHw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WrVVv3GLbz13RfZ;
	Sat, 24 Aug 2024 16:30:15 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D7181800D2;
	Sat, 24 Aug 2024 16:30:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 16:30:57 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: thunderx: Remove unused declarations
Date: Sat, 24 Aug 2024 16:27:54 +0800
Message-ID: <20240824082754.3637963-1-yuehaibing@huawei.com>
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

Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
controller") declared nicvf_qset_reg_{write,read}() but never implemented.

Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
controller") declared bgx_add_dmac_addr() but no implementation.

After commit 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
octeon_mdiobus_force_mod_depencency() is not used any more.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h | 2 --
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 8453defc296c..b7531041c56d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -359,8 +359,6 @@ int nicvf_is_intr_enabled(struct nicvf *nic, int int_type, int q_idx);
 /* Register access APIs */
 void nicvf_reg_write(struct nicvf *nic, u64 offset, u64 val);
 u64  nicvf_reg_read(struct nicvf *nic, u64 offset);
-void nicvf_qset_reg_write(struct nicvf *nic, u64 offset, u64 val);
-u64 nicvf_qset_reg_read(struct nicvf *nic, u64 offset);
 void nicvf_queue_reg_write(struct nicvf *nic, u64 offset,
 			   u64 qidx, u64 val);
 u64  nicvf_queue_reg_read(struct nicvf *nic,
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index cdea49392185..84f16ababaee 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -219,9 +219,7 @@
 void bgx_set_dmac_cam_filter(int node, int bgx_idx, int lmacid, u64 mac, u8 vf);
 void bgx_reset_xcast_mode(int node, int bgx_idx, int lmacid, u8 vf);
 void bgx_set_xcast_mode(int node, int bgx_idx, int lmacid, u8 mode);
-void octeon_mdiobus_force_mod_depencency(void);
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable);
-void bgx_add_dmac_addr(u64 dmac, int node, int bgx_idx, int lmac);
 unsigned bgx_get_map(int node);
 int bgx_get_lmac_count(int node, int bgx);
 const u8 *bgx_get_lmac_mac(int node, int bgx_idx, int lmacid);
-- 
2.34.1


