Return-Path: <netdev+bounces-235684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6DC33B92
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7820464CA6
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9651DDC35;
	Wed,  5 Nov 2025 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A/EiWSTd"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10F22D7B9;
	Wed,  5 Nov 2025 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308010; cv=none; b=aujnMq8BrP1uPZbnu7ku1JMdPdzGw/ENJwxbclbuhB+hPhNYsOq2Dx14991SGvp1Rx5q7qWC2J+NEom857RcjWRGViVKoAw4h49hyqAaqF4O0lddvE19xLVkoAo+9snJ0sglnRWEO54K3ARu8zj4e0TGYHjSNT01XHzLogiknL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308010; c=relaxed/simple;
	bh=3kt7N0J6IspO8ZgzfJnnIsQKWxjvDO8QpbGBYBRox4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1e0C+j2m0YUcvsMME/A9l1/5Vud4zBmpRboZozd6zNoe7ODgmDxZlJXmIBaZk4h5hwWw5F8g8UsJOYwzfhSTKnEPCzDK7hkTXHda7YGGVOiKshtX0nsmLNRY6RoJ9MznFvKzRZ+rUPdbgurFGvwdOMEyhq+fptyIpnlEfXs+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A/EiWSTd; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kxoskMR4j+GqhKLlnLSTcpV0pUXxjgv9zK324E17fAU=;
	b=A/EiWSTd2b89EzcWmmELJyb2PQywCfApC63q8RDwYgXhyHihhl1fg25PYKezyhw0EspNaJlNI
	FBFdRXBMPBfVwWlzsEwQFs3yH+vRoUobepyen+GcO24kKiYkvK6qwZHWwoxYj3vVTtyVZyXwazH
	MytrBUk0IWyQLvzB8RQ6hJI=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1T4b1Fg8zKm70;
	Wed,  5 Nov 2025 09:58:23 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id CD5C0180044;
	Wed,  5 Nov 2025 09:59:58 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:59:57 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <pctammela@mojatatu.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH net] net/sched: Fix possible infinite loop in qdisc_tree_reduce_backlog()
Date: Wed, 5 Nov 2025 10:22:13 +0800
Message-ID: <20251105022213.1981982-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)

A soft lockup issue was observed with following log:

  watchdog: BUG: soft lockup - CPU#1 stuck for 104s! [tc:94]
  CPU: 1 UID: 0 PID: 94 Comm: tc Tainted: G L 6.18.0-rc4-00007-gc9cfc122f037 #425 PREEMPT(voluntary)
  RIP: 0010:qdisc_match_from_root+0x0/0x70
  Call Trace:
   <TASK>
   qdisc_tree_reduce_backlog+0xec/0x110
   fq_change+0x2e0/0x6a0
   qdisc_create+0x138/0x4e0
   tc_modify_qdisc+0x5b9/0x9d0
   rtnetlink_rcv_msg+0x15a/0x400
   netlink_rcv_skb+0x55/0x100
   netlink_unicast+0x257/0x380
   netlink_sendmsg+0x1e2/0x420
   ____sys_sendmsg+0x313/0x340
   ___sys_sendmsg+0x82/0xd0
   __sys_sendmsg+0x6c/0xd0
   </TASK>

The issue can be reproduced by:
  tc qdisc add dev eth0 root noqueue
  tc qdisc add dev eth0 handle ffff:0 ingress
  tc qdisc add dev eth0 handle ffe0:0 parent ffff:a fq

A fq qdisc was created in __tc_modify_qdisc(), when the input parent major
'ffff' is equal to the ingress qdisc handle major and the complete parent
handle is not TC_H_ROOT or TC_H_INGRESS, which leads to a infinite loop in
qdisc_tree_reduce_backlog().

The infinite loop scenario:

  qdisc_tree_reduce_backlog

    // init sch is fq qdisc, parent is ffff000a
    while ((parentid = sch->parent)) {

      // query qdisc by handle ffff0000
      sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));

      // return ingress qdisc, sch->parent is fffffff1
      if (sch == NULL) {
      ...
    }

Commit 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on
TC_H_ROOT") break the loop only when parent TC_H_ROOT is reached. However,
qdisc_lookup_rcu() will return the same qdisc when input an ingress qdisc
with major 'ffff'. If the parent TC_H_INGRESS is reached, also break the
loop.

Fixes: 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/sched/sch_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 1e058b46d3e1..b4d6fe6b6812 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -784,7 +784,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (parentid == TC_H_ROOT)
+		if (parentid == TC_H_ROOT || parentid == TC_H_INGRESS)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
-- 
2.34.1


