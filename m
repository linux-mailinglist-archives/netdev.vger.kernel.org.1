Return-Path: <netdev+bounces-24071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEB76EAEA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C892821BD
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54D1F92F;
	Thu,  3 Aug 2023 13:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD1D1F195
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:42:55 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B213E;
	Thu,  3 Aug 2023 06:42:54 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGqj50yKpzJrBM;
	Thu,  3 Aug 2023 21:40:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:42:52 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] wifi: iw_handler.h: Remove unused declaration dev_get_wireless_info()
Date: Thu, 3 Aug 2023 21:42:48 +0800
Message-ID: <20230803134248.42652-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
declared but never implemented this, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/iw_handler.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index d2ea5863eedc..99f46f521aa7 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -432,9 +432,6 @@ struct iw_public_data {
 
 /* First : function strictly used inside the kernel */
 
-/* Handle /proc/net/wireless, called in net/code/dev.c */
-int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
-
 /* Second : functions that may be called by driver modules */
 
 /* Send a single event to user space */
-- 
2.34.1


