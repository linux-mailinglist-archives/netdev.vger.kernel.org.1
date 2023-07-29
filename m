Return-Path: <netdev+bounces-22538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B14767F0E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0545D1C20A8D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B23156F2;
	Sat, 29 Jul 2023 12:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FE3C20
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:17:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1212B;
	Sat, 29 Jul 2023 05:17:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCk1k5dVSzNmSQ;
	Sat, 29 Jul 2023 20:13:46 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:17:10 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] wifi: nl80211: Remove unused declaration nl80211_pmsr_dump_results()
Date: Sat, 29 Jul 2023 20:16:51 +0800
Message-ID: <20230729121651.36836-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

nl80211_pmsr_dump_results() is never implemented since introducted in
commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/wireless/nl80211.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 0278d817bb02..b4af53f9b227 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -120,6 +120,5 @@ void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev);
 
 /* peer measurement */
 int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info);
-int nl80211_pmsr_dump_results(struct sk_buff *skb, struct netlink_callback *cb);
 
 #endif /* __NET_WIRELESS_NL80211_H */
-- 
2.34.1


