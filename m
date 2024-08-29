Return-Path: <netdev+bounces-123261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15238964539
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB55B24C04
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE01B531C;
	Thu, 29 Aug 2024 12:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52401AED28;
	Thu, 29 Aug 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935354; cv=none; b=ZzOKeI5JFIwD0ZdUzgcr3sCw6DsXRslMV59AkLj3fUAeCE6uD5EJ4/6CNOnxtzE4RPZ0bor9LJtLtGWc/pF8LQr4Vnp7NH/q2ZMPmqVw58rzrThDOXkNffIyVe/CBbpAWhZCwoxuySDJLmrbp5+6LxQvNqRy4Dz4GWXvjQEw2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935354; c=relaxed/simple;
	bh=Ed/MyHZY4l9fvuOb6lA/D4niy7B3PKVg/wRRSDmPjvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQAE50Lu6NB9nyU1kFTlwRcOTKEDouft1SioURAz6O7X+qHsCawXDBZ7e04S/LD9loJ8dzB/E3XwJKdTTHXgr8rlOCV6POZ/uYtkSjBkJzzX3CbWW8TUhNX5Hxa9plmecR1setC14rrHtdILQR8ffkrL6ge9OHvOmglSeXP/eQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvgsP3rPpz1j7k2;
	Thu, 29 Aug 2024 20:42:17 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 160CB1A016C;
	Thu, 29 Aug 2024 20:42:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 20:42:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/3] cxgb: Remove unused declarations
Date: Thu, 29 Aug 2024 20:37:07 +0800
Message-ID: <20240829123707.2276148-4-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829123707.2276148-1-yuehaibing@huawei.com>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
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

These were never implenmented since introduction in commit 4d22de3e6cc4
("Add support for the latest 1G/10G Chelsio adapter, T3.").

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


