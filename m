Return-Path: <netdev+bounces-279485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPwGGBpR42njEwEAu9opvQ
	(envelope-from <netdev+bounces-279485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2347420956
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088C23026A8F
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7033E35B;
	Sat, 18 Apr 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GrTgxmv5"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5843358B0;
	Sat, 18 Apr 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776505084; cv=none; b=P2ty1ph9xIObVQ3CAYPxzuKKMJgobPSk6rlqyHH3Z0K/WcmPERY0PxEVohFPjnq0aCyP8GntLUGRfCUCX2xgpBU9vHMTWK8vtchPTon2k2K1I+ixXhJHOzM1mHzWWWbVcTfIvecBOXUWuwhSDdn4ji/Znf3zrrRemt/NuUvMyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776505084; c=relaxed/simple;
	bh=qbdpTmviNKQu9uGaS/FOU7Lxhbq6Nv5eTgL9/1CIMuQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=naonlvZRUiApzjvK9paN8BTN/NBdUVQJZ9pDhwUE6jSybRRGTyktyRQvnr7QMR6lqVGruE0+uuCg+nt2vedDGOX0ZMEPWBymOOfb4wfWXA7M3YNS4ZSFaTYNs0AMR9P6T5kyv9uUFB699LyLB7oeMMCwrLRMC0p3W+oEmhTQN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GrTgxmv5; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/LuDX7dTR/T6ZicW0wxZOd0IZ9ZolIpDU6m296Bo570=;
	b=GrTgxmv5gXcCAJEs2Npo/UICfj4EGrwpIXWzYL9eFedp8iglxfocmPi8h6guCopX6ihHLzh4y
	B3Lx1BUzmCBocZai9PaqYkZoK81bq4A9MIZTwBp7dxGLVWils+4ZXtKS6Hhf/0EQhFUkXo4Dz8l
	wFAQnWfn83PmImGRPBv4caM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fyRMq2NxVzpSvH;
	Sat, 18 Apr 2026 17:31:35 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F9AE4048F;
	Sat, 18 Apr 2026 17:37:53 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 18 Apr
 2026 17:37:52 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
Subject: [RFC PATCH net] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
Date: Sat, 18 Apr 2026 18:00:18 +0800
Message-ID: <20260418100018.2219500-1-lixiasong1@huawei.com>
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
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279485-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2347420956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When TCP option space is insufficient (e.g., IPv6 with tcp_timestamps
enabled), the original code jumped to out_unlock without clearing the
addr_signal flag. This caused mptcp_pm_add_timer to keep rescheduling
indefinitely without sending ADD_ADDR, preventing the endpoint list from
being traversed.

In a pure ACK scenario (indicated by drop_other_suboptions=true), if
the option space is insufficient to carry the ADD_ADDR suboption, it
is appropriate to drop this address signal to allow the timer handler
to move on to other addresses.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---

Seeking feedback on:

When announcing addresses to the peer, MPTCP sends a pure ACK packet
to carry MPTCP options (ADD_ADDR). In this scenario, if the option space
is insufficient for ADD_ADDR, clearing addr_signal would:

  - Prevent the timer from retrying infinitely
  - Allow the timer to continue traversing and processing other addresses
  - Not block other subflow creation or address announcement operations

Is there any scenario where we should retry later instead of clearing
the address signal/echo flag? However, if a pure ACK doesn't have
enough space for the flag, subsequent packets won't either.

---
 net/mptcp/pm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57a456690406..1d49779c6a1f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -881,19 +881,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
+	add_addr = msk->pm.addr_signal &
+		~(*echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL));
 	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
-
 	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
-		goto out_unlock;
 
-	if (*echo) {
-		*addr = msk->pm.remote;
-		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
-	} else {
-		*addr = msk->pm.local;
-		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+		if (*drop_other_suboptions)
+			WRITE_ONCE(msk->pm.addr_signal, add_addr);
+		goto out_unlock;
 	}
+
+	*addr = *echo ? msk->pm.remote : msk->pm.local;
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
-- 
2.34.1


