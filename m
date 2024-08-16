Return-Path: <netdev+bounces-119162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FF9546A0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509D11F21470
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C417BEB5;
	Fri, 16 Aug 2024 10:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5286AE3;
	Fri, 16 Aug 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803559; cv=none; b=QaecSNcOFRVqE1ZeAgtbHgQ46P7OPBOiO9aArPEsnzzp+oGkSxpuB/8OGNOtj5oPuLpjQy7fDSzmfjAqao++oRhPueu3eVl5Cn7C1kd4wYeOoU51qyfVSvWxV0bc5Ih6IIwp8FjuDX9C/f0KnpHy+mQ4+PhLIaF6GZ5Utsn6Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803559; c=relaxed/simple;
	bh=lHvh/TYydCQsGfepag95UKf9lGjJV8D5KrJ6gGluzUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z0b+U8Go7guBrHism1L4a5HBmFUUCHxryCRsQmxFFvr6FW38hpyIsLfMYuSX6A4ZQefaTwLzGVfrrDG1ya68q4Nus4v+bWbngTbqZFFIpWJP1QNO7LG4oiD2Z0TaF+Lun45N6CgYq9Bj9nYUWFNMSsn45mdw1lxlAix4aBELaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WldG32Y6FzhY0l;
	Fri, 16 Aug 2024 18:17:15 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 846511401E9;
	Fri, 16 Aug 2024 18:19:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:19:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olga.zaborska@intel.com>, <yuehaibing@huawei.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] igbvf: Remove two unused declarations
Date: Fri, 16 Aug 2024 18:16:38 +0800
Message-ID: <20240816101638.882072-1-yuehaibing@huawei.com>
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

There is no caller and implementations in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h | 1 -
 drivers/net/ethernet/intel/igbvf/mbx.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index 7b83678ba83a..6ad35a00a287 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -282,7 +282,6 @@ enum igbvf_state_t {
 
 extern char igbvf_driver_name[];
 
-void igbvf_check_options(struct igbvf_adapter *);
 void igbvf_set_ethtool_ops(struct net_device *);
 
 int igbvf_up(struct igbvf_adapter *);
diff --git a/drivers/net/ethernet/intel/igbvf/mbx.h b/drivers/net/ethernet/intel/igbvf/mbx.h
index e5b31818d565..7637d21445bf 100644
--- a/drivers/net/ethernet/intel/igbvf/mbx.h
+++ b/drivers/net/ethernet/intel/igbvf/mbx.h
@@ -49,7 +49,6 @@
 
 #define E1000_PF_CONTROL_MSG	0x0100 /* PF control message */
 
-void e1000_init_mbx_ops_generic(struct e1000_hw *hw);
 s32 e1000_init_mbx_params_vf(struct e1000_hw *);
 
 #endif /* _E1000_MBX_H_ */
-- 
2.34.1


