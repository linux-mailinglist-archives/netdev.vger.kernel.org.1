Return-Path: <netdev+bounces-24656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91661770F60
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890D81C20AA4
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39BA920;
	Sat,  5 Aug 2023 10:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8658F6F
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:53:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B110CF
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:53:57 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHzv45LzCzrSBr;
	Sat,  5 Aug 2023 18:52:48 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 18:53:55 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] ndisc: Remove unused ndisc_ifinfo_sysctl_strategy() declaration
Date: Sat, 5 Aug 2023 18:53:54 +0800
Message-ID: <20230805105354.35008-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit f8572d8f2a2b ("sysctl net: Remove unused binary sysctl code")
left behind this declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/ndisc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 52eae0943433..9bbdf6eaa942 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -488,9 +488,6 @@ void igmp6_event_report(struct sk_buff *skb);
 #ifdef CONFIG_SYSCTL
 int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos);
-int ndisc_ifinfo_sysctl_strategy(struct ctl_table *ctl,
-				 void __user *oldval, size_t __user *oldlenp,
-				 void __user *newval, size_t newlen);
 #endif
 
 void inet6_ifinfo_notify(int event, struct inet6_dev *idev);
-- 
2.34.1


