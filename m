Return-Path: <netdev+bounces-23234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DC76B61D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1529A1C208B8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548622EEB;
	Tue,  1 Aug 2023 13:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF95111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:43:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77031ED;
	Tue,  1 Aug 2023 06:43:43 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RFbpz2hYzzLnw6;
	Tue,  1 Aug 2023 21:40:59 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 21:43:40 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, Yue Haibing
	<yuehaibing@huawei.com>
Subject: [PATCH] wifi: mac80211: Remove unused function declarations
Date: Tue, 1 Aug 2023 21:43:37 +0800
Message-ID: <20230801134337.24452-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 685429623f88 ("mac80211: Fix circular locking dependency in ARP filter handling")
leave ieee80211_set_arp_filter() declaration unused.
And 164eb02d070a ("mac80211: add radar detection command/event") introducted
ieee80211_dfs_cac_timer() declaration but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/mac80211/ieee80211_i.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 91633a0b723e..06bd406846d2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1872,7 +1872,6 @@ void ieee80211_send_pspoll(struct ieee80211_local *local,
 			   struct ieee80211_sub_if_data *sdata);
 void ieee80211_recalc_ps(struct ieee80211_local *local);
 void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata);
-int ieee80211_set_arp_filter(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
@@ -2564,7 +2563,6 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_link_data *rsvd_for);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
-void ieee80211_dfs_cac_timer(unsigned long data);
 void ieee80211_dfs_cac_timer_work(struct work_struct *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local);
 void ieee80211_dfs_radar_detected_work(struct work_struct *work);
-- 
2.34.1


