Return-Path: <netdev+bounces-24363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E876FF75
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F91C203DC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8BBA23;
	Fri,  4 Aug 2023 11:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6470A959
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:25:48 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640F411B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 04:25:47 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RHNfJ3qVXz1KCFN;
	Fri,  4 Aug 2023 19:24:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 19:25:44 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] team: remove unreferenced header in activebackup/broadcast/roundrobin files
Date: Fri, 4 Aug 2023 19:30:35 +0800
Message-ID: <20230804113035.1698118-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because linux/errno.h is unreferenced in activebackup/broadcast/roundrobin
files, so remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/team/team_mode_activebackup.c | 1 -
 drivers/net/team/team_mode_broadcast.c    | 1 -
 drivers/net/team/team_mode_roundrobin.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index e0f599e2a51d..419b9083515e 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <net/rtnetlink.h>
 #include <linux/if_team.h>
diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
index 313a3e2d68bf..61d7d79f0c36 100644
--- a/drivers/net/team/team_mode_broadcast.c
+++ b/drivers/net/team/team_mode_broadcast.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/if_team.h>
 
diff --git a/drivers/net/team/team_mode_roundrobin.c b/drivers/net/team/team_mode_roundrobin.c
index 3ec63de97ae3..dd405d82c6ac 100644
--- a/drivers/net/team/team_mode_roundrobin.c
+++ b/drivers/net/team/team_mode_roundrobin.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/if_team.h>
 
-- 
2.34.1


