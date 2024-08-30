Return-Path: <netdev+bounces-123627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771FA965D15
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA18B1C22CEF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73656175D59;
	Fri, 30 Aug 2024 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F516F909;
	Fri, 30 Aug 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010638; cv=none; b=q3W0CTvBjPwTOmpPBAasuvv6ULunTNVyHfUXvOkGiTY3mI5EYs6hlkOG4a++mD6cXlOc5ph38bq1F5txXxWrRIImVM697BhEsygFO6NM2imC8dkk6CBOcHEJeMr2xG2PCHpuqooq7u3VOFNxHOPdMVOHD7tmmy4AYfjF8VH0GwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010638; c=relaxed/simple;
	bh=zGAg0WEyRIuEQITuwgzErdlLFfbKsD3JQ6h5u9pbB+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGMStRibLkaT1WmmkbeiCl9hAu+Oz4f/Nq1vezfPoKtnblcMDkJtdoEZNlsDzE/lVLfYwUNSmlrV13O9pRN3FoTV6V7M8lA3P9yVQAf8pPF9JemIWoLdg/CgYgh4bl6sW/PtWYY/UyBRFnJW0c5H/+9b9bLduFg5lB2yJmPQUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwCg05brQzLr13;
	Fri, 30 Aug 2024 17:35:08 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AD0C180100;
	Fri, 30 Aug 2024 17:37:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 17:37:13 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 2/3] cxgb4: Remove unused declarations
Date: Fri, 30 Aug 2024 17:33:37 +0800
Message-ID: <20240830093338.3742315-3-yuehaibing@huawei.com>
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

Commit e2d14b42c25c ("cxgb4: Remove WOL get/set ethtool support") removed
t4_wol_magic_enable() and t4_wol_pat_enable() but leave declarations.

Commit 02d805dc5fe3 ("cxgb4: use new fw interface to get the VIN and smt
index") leave behind cxgb4_tp_smt_idx().

cxgb4_dcb_set_caps() is never implemented and used since introduction in
commit 76bcb31efc06 ("cxgb4 : Add DCBx support codebase and dcbnl_ops").

Reviewed-by: Simon Horman <horms@kernel.org>
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


