Return-Path: <netdev+bounces-120801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68A95AC88
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE01F22254
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57D55E48;
	Thu, 22 Aug 2024 04:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542B4D8B0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300727; cv=none; b=gmeBn8hK48Gsh5NIU1alsgGrpavoOTRmTZKC1NUG9gMH5E7gZK2GaPjSo2TMZt6ZYzXZZJhg1FTko4onVYtjob70uVNm4uiwaAUBXWFrutnWMMm+RHmYquhN/XGrFbN1XsmtHCy6bMbaBtUx72Ixb+0vCK1pzGvgmD1pzmIENNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300727; c=relaxed/simple;
	bh=zqJJwBVf5HwFBlIb1NLKcxKl9NGpt1mtdfa2ITi1SHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyAj/RPpcBBwrKxWBr7Qbx1m4yqIKrruEmrUDnRjVu6/VsanrwPlHynRRgt2NZF0jghwr3KsB8YnTa8+JnpB9X0bEzTcpp/WCnpRb51IsX31FEV5LeT1q16Rii/YgLuKdervL0sNh/23ocHcVzGqQBNFdbHZ9yUCWfyjZ8d7IKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wq95Z4Q2jz1HH3v;
	Thu, 22 Aug 2024 12:22:10 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7786D180019;
	Thu, 22 Aug 2024 12:25:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:22 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 10/10] net: mpls: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:52 +0800
Message-ID: <20240822043252.3488749-11-lizetao1@huawei.com>
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
 net/mpls/af_mpls.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 0e6c94a8c2bc..aba983531ed3 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1201,8 +1201,7 @@ static void mpls_netconf_notify_devconf(struct net *net, int event,
 	rtnl_notify(skb, net, 0, RTNLGRP_MPLS_NETCONF, NULL, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_MPLS_NETCONF, err);
+	rtnl_set_sk_err(net, RTNLGRP_MPLS_NETCONF, err);
 }
 
 static const struct nla_policy devconf_mpls_policy[NETCONFA_MAX + 1] = {
@@ -2278,8 +2277,7 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
 
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_MPLS_ROUTE, err);
+	rtnl_set_sk_err(net, RTNLGRP_MPLS_ROUTE, err);
 }
 
 static int mpls_valid_getroute_req(struct sk_buff *skb,
-- 
2.34.1


