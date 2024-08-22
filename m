Return-Path: <netdev+bounces-120805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69395AC8C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD4A1F224C5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB663A1AC;
	Thu, 22 Aug 2024 04:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736E25779
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300732; cv=none; b=t67/92LvwSvfyrRYU6djxPBI4VjkkA/ZwlX1f4e//UmXEiBpKM4ZBBt2FdiYrpXqI8zSLWa38gGK1+AcIVYBH+wMzsn5VnRIg7CkEKBfaakFDLe86oJ54phOXI4zpWzhevgSY6FX/WxHmzpXso1pL7saq5GWMz4xXahsFONphEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300732; c=relaxed/simple;
	bh=pBECfmK17ma/wh006e2wlp9CSJ8r20xXZ/HqYSJXmrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjUNmVteF0RyLZZHXgHggSg72HEFVt8sSo2xvo1ileljzmqNiTeEZugb0povze/Zdhm3amdvX/B7vPLzqbQs+0HEilvQX8gFmv7zKmzRbyANTLXZSU/2LpZqRM2UpOa0OPpq47+iDwB6ZhUN4NvrcSnB3Ty3qgKUV9ZMsUvAWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wq9736L77z1xvln;
	Thu, 22 Aug 2024 12:23:27 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B6CA51A0188;
	Thu, 22 Aug 2024 12:25:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:21 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 09/10] net/ipv6: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:51 +0800
Message-ID: <20240822043252.3488749-10-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822043252.3488749-1-lizetao1@huawei.com>
References: <20240822043252.3488749-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The initial value of err is -ENOBUFS, and err is guaranteed to be
less than 0 before all goto errout. Therefore, on the error path
of errout, there is no need to repeatedly judge that err is less than 0,
and delete redundant judgments to make the code more concise.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/ipv6/route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 219701caba1e..7e7de29ad05f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6193,8 +6193,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		    info->nlh, gfp_any());
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 
 void fib6_rt_update(struct net *net, struct fib6_info *rt,
@@ -6220,8 +6219,7 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		    info->nlh, gfp_any());
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 
 void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
-- 
2.34.1


