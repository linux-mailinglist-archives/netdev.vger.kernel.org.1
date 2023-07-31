Return-Path: <netdev+bounces-22843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045737698F9
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F247C1C20C03
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FA18AFE;
	Mon, 31 Jul 2023 14:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B514F92
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 14:07:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04379268A;
	Mon, 31 Jul 2023 07:07:19 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RF0My0zYlztQwm;
	Mon, 31 Jul 2023 22:03:58 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 22:07:17 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nbd@nbd.name>,
	<pagadala.yesu.anjaneyulu@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] mac80211: mesh: Remove unused function declaration mesh_ids_set_default()
Date: Mon, 31 Jul 2023 22:07:12 +0800
Message-ID: <20230731140712.1204-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
introducted this but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/mac80211/mesh.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 6c94222a9df5..ad8469293d71 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -212,7 +212,6 @@ int mesh_rmc_check(struct ieee80211_sub_if_data *sdata,
 		   const u8 *addr, struct ieee80211s_hdr *mesh_hdr);
 bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 			struct ieee802_11_elems *ie);
-void mesh_ids_set_default(struct ieee80211_if_mesh *mesh);
 int mesh_add_meshconf_ie(struct ieee80211_sub_if_data *sdata,
 			 struct sk_buff *skb);
 int mesh_add_meshid_ie(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


