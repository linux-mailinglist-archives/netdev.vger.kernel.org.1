Return-Path: <netdev+bounces-23508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C876C3C8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F36C1C211B2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B610F8;
	Wed,  2 Aug 2023 03:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357A10E2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:53:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93DEA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:53:42 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFyhr18dKzVjxw;
	Wed,  2 Aug 2023 11:51:56 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 11:53:40 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: Space.h: Remove unused function declarations
Date: Wed, 2 Aug 2023 11:52:59 +0800
Message-ID: <20230802035259.34076-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 5aa83a4c0a15 ("  [PATCH] remove two obsolete net drivers") remove fmv18x_probe().
And commmit 01f4685797a5 ("eth: amd: remove NI6510 support (ni65)") leave ni65_probe().
Commit a10079c66290 ("staging: remove hp100 driver") remove hp100 driver and hp100_probe()
declaration is not used anymore.

sonic_probe() and iph5526_probe() are never implemented since the beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/Space.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/net/Space.h b/include/net/Space.h
index 08ca9cef0213..c29f3d51c078 100644
--- a/include/net/Space.h
+++ b/include/net/Space.h
@@ -3,18 +3,11 @@
  * ethernet adaptor have the name "eth[0123...]".
  */
 
-struct net_device *hp100_probe(int unit);
 struct net_device *ultra_probe(int unit);
 struct net_device *wd_probe(int unit);
 struct net_device *ne_probe(int unit);
-struct net_device *fmv18x_probe(int unit);
-struct net_device *ni65_probe(int unit);
-struct net_device *sonic_probe(int unit);
 struct net_device *smc_init(int unit);
 struct net_device *cs89x0_probe(int unit);
 struct net_device *tc515_probe(int unit);
 struct net_device *lance_probe(int unit);
 struct net_device *cops_probe(int unit);
-
-/* Fibre Channel adapters */
-int iph5526_probe(struct net_device *dev);
-- 
2.34.1


