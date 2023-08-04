Return-Path: <netdev+bounces-24396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66CB7700AA
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEE1C20AD4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFFBE50;
	Fri,  4 Aug 2023 13:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C3A929
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:01:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3813D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 06:00:59 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHQjQ0TY6zGpnN;
	Fri,  4 Aug 2023 20:57:30 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 21:00:56 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: hns: Remove unused function declaration mac_adjust_link()
Date: Fri, 4 Aug 2023 21:00:48 +0800
Message-ID: <20230804130048.39808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 511e6bc071db ("net: add Hisilicon Network Subsystem DSAF support")
declared but never implemented this, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
index e3bb05959ba9..edf0bcf76ac9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -422,7 +422,6 @@ void *hns_xgmac_config(struct hns_mac_cb *mac_cb,
 		       struct mac_params *mac_param);
 
 int hns_mac_init(struct dsaf_device *dsaf_dev);
-void mac_adjust_link(struct net_device *net_dev);
 bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex);
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb,	u32 *link_status);
 int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb, u32 vmid,
-- 
2.34.1


