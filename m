Return-Path: <netdev+bounces-21425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD476393B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE74F281F8D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378A1DA21;
	Wed, 26 Jul 2023 14:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F81DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:34:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F5188;
	Wed, 26 Jul 2023 07:34:27 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9xCc2drqztRdv;
	Wed, 26 Jul 2023 22:31:08 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:34:22 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jon.toppins+linux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuhangbin@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 27/29] bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
Date: Wed, 26 Jul 2023 22:34:19 +0800
Message-ID: <20230726143419.19392-1-yuehaibing@huawei.com>
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

This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/net/bond_3ad.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index a016f275cb01..c5e57c6bd873 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -301,7 +301,6 @@ int  __bond_3ad_get_active_agg_info(struct bonding *bond,
 int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
-void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
-- 
2.34.1


