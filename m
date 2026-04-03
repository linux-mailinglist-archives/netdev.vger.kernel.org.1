Return-Path: <netdev+bounces-274936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBGsBkF5z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DA3920EB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3509303EA95
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3431F9B0;
	Fri,  3 Apr 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t77A2NQe"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDD2ECEB9;
	Fri,  3 Apr 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204458; cv=none; b=ar7WcgN3WF/LiKWU3jNLgAD4eWB8gBs6XnsceaT8BxG+oab/FqxwWr9lbByg559vXE+Hrq/zvpgXk/PMWyoul4NvY8QtZvuNQumRcgRcsaL8zFi2dl3Tw1fmXfOhIqeMp+goGdlj3LcaKtwSSCsf56hrcT9w8/X523FPtfx5Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204458; c=relaxed/simple;
	bh=nuyrldVUaJQ+o3pdM8UmnI+kY/UpDuetnlq7MoRs2qU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MB/x/PjuBjAFCgZnXpgSROuZs33tMpH85Gx61iZgmvBML3hDI2IzPQMKhH0hM7fDMcg2qZdcK/vulCRdpes1D/w/eOaKaxSZ5n93i/ku7TYaWHrZ+3GsT3mkygq4UECqzW5hDQ46jj1zx4/Wgnd+o+uoTq6+M5gGo4zjXxiYt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t77A2NQe; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6lYLsbuofPGGGeTn7gADTPD20r38npJYPElI2A3h0yw=;
	b=t77A2NQea5IihuDbDJU2Y6ae0UEUta4KtOdvHOzmnQk62YKXf00yq7TjBk7N6XkDWUaun9iC/
	49K9VR6oF9YPMQ12cmgnUKtV/AvJAeq36JrYKZmvz7rSIp5BeeOorIFSJnaKLcLEk8m9RPMuX6y
	+F1NQ7JGqlxYIAvc7KlwU4w=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fnBMx3DQTz1K9Wt;
	Fri,  3 Apr 2026 16:14:37 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 344B84056C;
	Fri,  3 Apr 2026 16:20:46 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 16:20:45 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
Date: Fri, 3 Apr 2026 16:44:02 +0800
Message-ID: <20260403084402.4105936-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yuehaibing@huawei.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 4F5DA3920EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable ret is initialized to 0 when it is defined
and is not modified before copy_to_user().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/sit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ef2e5111fb3a..09c0a01d44f4 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -359,7 +359,6 @@ static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __u
 	rcu_read_unlock();
 
 	len = sizeof(*kp) * c;
-	ret = 0;
 	if ((len && copy_to_user(a + 1, kp, len)) || put_user(len, &a->datalen))
 		ret = -EFAULT;
 
-- 
2.34.1


