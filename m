Return-Path: <netdev+bounces-123628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04730965D16
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6929280D37
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83463178397;
	Fri, 30 Aug 2024 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D6170A31;
	Fri, 30 Aug 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010638; cv=none; b=gtr1g63xpnrofLSLNypF/iD/xD7HFVHOENiokovzxxq4f7VYZAi1aq0ZaDbhg0UBKgPMyZRr6yJqyW4GnMhkpPnfywJUUxJiy/R2GzTdfruKnfO3kN4iuVQ10cp4ol5qjT+NSJyIY34fHCrf3jiRXAMdjS3CQw8kpHzkaJL3MVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010638; c=relaxed/simple;
	bh=L6EnThQPVgTp7aBA4Dx2VuDyO+rHdLI04A00nRQqYXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9asWRU8sZ2MgqgZ5qOVndDjku3DcRgk2oEit7s+4QoKs+1KyzWBrYJXKCxHDBmZneYumujmkOtG6YcjHdmSvdP2oA94iN0h3Hr+kDdbGWxvEBEGAiKHiAc3IceTsT4B/MD7YWXDlZk2EOxqIGy2dBttMtfEN9ugHct3a/rJa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwCg74JQCz1xvjj;
	Fri, 30 Aug 2024 17:35:15 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 221EF180042;
	Fri, 30 Aug 2024 17:37:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 17:37:13 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 3/3] cxgb: Remove unused declarations
Date: Fri, 30 Aug 2024 17:33:38 +0800
Message-ID: <20240830093338.3742315-4-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830093338.3742315-1-yuehaibing@huawei.com>
References: <20240830093338.3742315-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

These functions were never implenmented since introduction in
commit 8199d3a79c22 ("[PATCH] A new 10GB Ethernet Driver by Chelsio
Communications")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb/common.h | 2 --
 drivers/net/ethernet/chelsio/cxgb/tp.h     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/common.h b/drivers/net/ethernet/chelsio/cxgb/common.h
index e56eff701395..304bb282ab03 100644
--- a/drivers/net/ethernet/chelsio/cxgb/common.h
+++ b/drivers/net/ethernet/chelsio/cxgb/common.h
@@ -329,8 +329,6 @@ irqreturn_t t1_slow_intr_handler(adapter_t *adapter);
 
 int t1_link_start(struct cphy *phy, struct cmac *mac, struct link_config *lc);
 const struct board_info *t1_get_board_info(unsigned int board_id);
-const struct board_info *t1_get_board_info_from_ids(unsigned int devid,
-						    unsigned short ssid);
 int t1_seeprom_read(adapter_t *adapter, u32 addr, __le32 *data);
 int t1_get_board_rev(adapter_t *adapter, const struct board_info *bi,
 		     struct adapter_params *p);
diff --git a/drivers/net/ethernet/chelsio/cxgb/tp.h b/drivers/net/ethernet/chelsio/cxgb/tp.h
index ba15675d56df..64f93dcc676b 100644
--- a/drivers/net/ethernet/chelsio/cxgb/tp.h
+++ b/drivers/net/ethernet/chelsio/cxgb/tp.h
@@ -65,9 +65,7 @@ void t1_tp_intr_enable(struct petp *tp);
 void t1_tp_intr_clear(struct petp *tp);
 int t1_tp_intr_handler(struct petp *tp);
 
-void t1_tp_get_mib_statistics(adapter_t *adap, struct tp_mib_statistics *tps);
 void t1_tp_set_tcp_checksum_offload(struct petp *tp, int enable);
 void t1_tp_set_ip_checksum_offload(struct petp *tp, int enable);
-int t1_tp_set_coalescing_size(struct petp *tp, unsigned int size);
 int t1_tp_reset(struct petp *tp, struct tp_params *p, unsigned int tp_clk);
 #endif
-- 
2.34.1


