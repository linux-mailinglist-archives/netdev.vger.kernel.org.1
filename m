Return-Path: <netdev+bounces-22284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEE766DFA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE15282756
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0D134BD;
	Fri, 28 Jul 2023 13:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA699101FE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 13:21:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEB1BC6;
	Fri, 28 Jul 2023 06:21:34 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC7XW3XT3zVjt1;
	Fri, 28 Jul 2023 21:19:55 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:21:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yue Haibing
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] devlink: Remove unused extern declaration devlink_port_region_destroy()
Date: Fri, 28 Jul 2023 21:21:13 +0800
Message-ID: <20230728132113.32888-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

devlink_port_region_destroy() is never implemented since
commit 544e7c33ec2f ("net: devlink: Add support for port regions").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/devlink.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0cdb4b16e5b5..a1a8e1b6e7df 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1790,8 +1790,6 @@ devlink_port_region_create(struct devlink_port *port,
 			   u32 region_max_snapshots, u64 region_size);
 void devl_region_destroy(struct devlink_region *region);
 void devlink_region_destroy(struct devlink_region *region);
-void devlink_port_region_destroy(struct devlink_region *region);
-
 int devlink_region_snapshot_id_get(struct devlink *devlink, u32 *id);
 void devlink_region_snapshot_id_put(struct devlink *devlink, u32 id);
 int devlink_region_snapshot_create(struct devlink_region *region,
-- 
2.34.1


