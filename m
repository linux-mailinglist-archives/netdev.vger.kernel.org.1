Return-Path: <netdev+bounces-96344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FD8C55D5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C491F22EB9
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDB2D60A;
	Tue, 14 May 2024 12:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB43320F;
	Tue, 14 May 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688677; cv=none; b=ZV8HW7K3ELJEgymTi+yymMgQYE9U59dusoeoRKDnfSebkN5zT1NEsf3TPTCUrKMHW9HrBHfVMUXRiJfBQsvwery8Xf7xHfWpvBCmK3a5V7+M0L5bzfMOc85Lam5xeHPOopZA0gkLLiT4r8Di6ccKFwYI8WrCkW7751JOzRv+2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688677; c=relaxed/simple;
	bh=LLAcg8dgAcq42TteRCQbf45yE6Bj+8PkBxYFXSDJRvk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LM9irKrSdKmVlyZcVxZ6LUiRstDQ/fDzeXA8/qAM1VJ/gfnRjcsnxhMtn/wsRmrrZpmZZ4LAWjqMUIeEVxlSl4s/M2IfACOkHnx7pPLlpGME8ZMfeDmdbwHheJSE7F4o/iBo7DafWoDR/Zr4WJ6ExpRbssSb1du9QflCWJsPBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VdwDk62y6z8XrX5;
	Tue, 14 May 2024 20:11:02 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl1.zte.com.cn with SMTP id 44ECAwb2004590;
	Tue, 14 May 2024 20:10:58 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 14 May 2024 20:11:02 +0800 (CST)
Date: Tue, 14 May 2024 20:11:02 +0800 (CST)
X-Zmail-TransId: 2af9664354d614f-9c8c9
X-Mailer: Zmail v1.0
Message-ID: <20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dsahern@gmail.com>, <xu.xin16@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <si.hao@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQvaXB2NjogRml4IHJvdXRlIGRlbGV0aW5nIGZhaWx1cmUgd2hlbiBtZXRyaWMgZXF1YWxzIDA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 44ECAwb2004590
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 664354D6.001/4VdwDk62y6z8XrX5

From: xu xin <xu.xin16@zte.com.cn>

Problem
=========
After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
we noticed that the logic of assigning the default value of fc_metirc
changed in the ioctl process. That is, when users use ioctl(fd, SIOCADDRT,
rt) with a non-zero metric to add a route,  then they may fail to delete a
route with passing in a metric value of 0 to the kernel by ioctl(fd,
SIOCDELRT, rt). But iproute can succeed in deleting it.

As a reference, when using iproute tools by netlink to delete routes with
a metric parameter equals 0, like the command as follows:

	ip -6 route del fe80::/64 via fe81::5054:ff:fe11:3451 dev eth0 metric 0

the user can still succeed in deleting the route entry with the smallest
metric.

Root Reason
===========
After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
When ioctl() pass in SIOCDELRT with a zero metric, rtmsg_to_fib6_config()
will set a defalut value (1024) to cfg->fc_metric in kernel, and in
ip6_route_del() and the line 4074 at net/ipv3/route.c, it will check by

	if (cfg->fc_metric && cfg->fc_metric != rt->fib6_metric)
		continue;

and the condition is true and skip the later procedure (deleting route)
because cfg->fc_metric != rt->fib6_metric. But before that commit,
cfg->fc_metric is still zero there, so the condition is false and it
will do the following procedure (deleting).

Solution
========
In order to keep a consistent behaviour across netlink() and ioctl(), we
should allow to delete a route with a metric value of 0. So we only do
the default setting of fc_metric in route adding.

CC: stable@vger.kernel.org # 5.4+
Fixes: 67f695134703 ("ipv6: Move setting default metric for routes")
Co-developed-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 net/ipv6/route.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c43b0616742e..bbc2a0dd9314 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4445,7 +4445,7 @@ static void rtmsg_to_fib6_config(struct net *net,
 		.fc_table = l3mdev_fib_table_by_index(net, rtmsg->rtmsg_ifindex) ?
 			 : RT6_TABLE_MAIN,
 		.fc_ifindex = rtmsg->rtmsg_ifindex,
-		.fc_metric = rtmsg->rtmsg_metric ? : IP6_RT_PRIO_USER,
+		.fc_metric = rtmsg->rtmsg_metric,
 		.fc_expires = rtmsg->rtmsg_info,
 		.fc_dst_len = rtmsg->rtmsg_dst_len,
 		.fc_src_len = rtmsg->rtmsg_src_len,
@@ -4475,6 +4475,9 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 	rtnl_lock();
 	switch (cmd) {
 	case SIOCADDRT:
+		/* Only do the default setting of fc_metric in route adding */
+		if (cfg.fc_metric == 0)
+			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
 		break;
 	case SIOCDELRT:
-- 
2.15.2

