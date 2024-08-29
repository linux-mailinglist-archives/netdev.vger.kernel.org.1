Return-Path: <netdev+bounces-123260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01519964533
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8664A1F2696B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB71B3F1E;
	Thu, 29 Aug 2024 12:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FA1B3F09;
	Thu, 29 Aug 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935353; cv=none; b=hfGGH06Hu8iRJ1bKt5OmJFy/J1ByauXIa//ZXCpbP2BfmtHtg7FLSUJ7nqcEQpALt1+iAtzvfvgXIhdeonYHuUwwcc/9lI6Ep2yH7GmVbOw0tMQycGMh8oOpCKSlGrN3V8raM0X15Vk7oCFa/0Vj4/OqWUDFGZnqhnBRddHpq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935353; c=relaxed/simple;
	bh=mkfkbKVpNc8Nj4NQFrrQokhWEF+1VxvKtqocDnelJrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRTj7FsrDDYMTr5z6m0QWDRAJASsPqnqEdKcGRb1Ly+/sRg9+zulOBTTzgdatv3xeEjC3wBODbaqXGviPc+YOgkgiFEASdUAcsej64cZP12IYvlo7zoikANzsrmQL3TjzkhI80Tn8l+XrooFni4zhKc5XGGlulRQU4t6KYobIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wvgrg5FXGzyQmd;
	Thu, 29 Aug 2024 20:41:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C035180AE6;
	Thu, 29 Aug 2024 20:42:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 20:42:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/3] cxgb4: Remove unused declarations
Date: Thu, 29 Aug 2024 20:37:06 +0800
Message-ID: <20240829123707.2276148-3-yuehaibing@huawei.com>
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

Commit e2d14b42c25c ("cxgb4: Remove WOL get/set ethtool support") removed
t4_wol_magic_enable() and t4_wol_pat_enable() but leave declarations.

Commit 02d805dc5fe3 ("cxgb4: use new fw interface to get the VIN and smt
index") leave behind cxgb4_tp_smt_idx().

cxgb4_dcb_set_caps() is never implemented and used since introduction in
commit 76bcb31efc06 ("cxgb4 : Add DCBx support codebase and dcbnl_ops").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h     | 5 -----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h | 1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index fca9533bc011..bbf7641a0fc7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1958,11 +1958,6 @@ void t4_ulprx_read_la(struct adapter *adap, u32 *la_buf);
 void t4_get_chan_txrate(struct adapter *adap, u64 *nic_rate, u64 *ofld_rate);
 void t4_mk_filtdelwr(unsigned int ftid, struct fw_filter_wr *wr, int qid);
 
-void t4_wol_magic_enable(struct adapter *adap, unsigned int port,
-			 const u8 *addr);
-int t4_wol_pat_enable(struct adapter *adap, unsigned int port, unsigned int map,
-		      u64 mask0, u64 mask1, unsigned int crc, bool enable);
-
 int t4_fw_hello(struct adapter *adap, unsigned int mbox, unsigned int evt_mbox,
 		enum dev_master master, enum dev_state *state);
 int t4_fw_bye(struct adapter *adap, unsigned int mbox);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
index 80c6627fe981..c80a93347a8c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
@@ -122,7 +122,6 @@ void cxgb4_dcb_version_init(struct net_device *);
 void cxgb4_dcb_reset(struct net_device *dev);
 void cxgb4_dcb_state_fsm(struct net_device *, enum cxgb4_dcb_state_input);
 void cxgb4_dcb_handle_fw_update(struct adapter *, const struct fw_port_cmd *);
-void cxgb4_dcb_set_caps(struct adapter *, const struct fw_port_cmd *);
 extern const struct dcbnl_rtnl_ops cxgb4_dcb_ops;
 
 static inline __u8 bitswap_1(unsigned char val)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
index a9599ba26975..d8cafaa7ddb4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
@@ -508,7 +508,6 @@ unsigned int cxgb4_dbfifo_count(const struct net_device *dev, int lpfifo);
 unsigned int cxgb4_port_chan(const struct net_device *dev);
 unsigned int cxgb4_port_e2cchan(const struct net_device *dev);
 unsigned int cxgb4_port_viid(const struct net_device *dev);
-unsigned int cxgb4_tp_smt_idx(enum chip_type chip, unsigned int viid);
 unsigned int cxgb4_port_idx(const struct net_device *dev);
 unsigned int cxgb4_best_mtu(const unsigned short *mtus, unsigned short mtu,
 			    unsigned int *idx);
-- 
2.34.1


