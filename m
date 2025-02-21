Return-Path: <netdev+bounces-168685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDFA402E7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B0B18959A0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282A20F083;
	Fri, 21 Feb 2025 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="VHjwrsTL"
X-Original-To: netdev@vger.kernel.org
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1852397BF
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177517; cv=pass; b=JNjrPyvZz6GvfXuVawrFTl9CsZif1AbijTjNij68h0uvzgjsZzOASDsQzPxdNWmbzxhtbqvH6dm7fhbbzEcw2BNOEC7E+h4GbKMk2k4KrRQ9H5uCM2AaFbEIJh/TCD1C2x3keNkS619kjuSbKmrilXaROVnJ/2AIe7wJuGTrt54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177517; c=relaxed/simple;
	bh=9AiURpy5+R8gJDma4ZT4sR33rNzMijv+iTmDFgc4Sxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eQgN3NqL/vrbJywNeum8syy3yTkFC+dv5ZW8XD1SGvr5cMv72Hq282BADRidCudCU7LP71Yjwfpe1or04UDi9w4VyblMyVh+0FMj+uNyW6+X+g08nsCgc4PFw4sw/M+zSfT6DdLmYu8Z4Ybxo8wxoo1Yt/s5ZT8bGnydn2mVF7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=VHjwrsTL; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C0210844A3F
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 22:21:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-105-11-97.trex-nlb.outbound.svc.cluster.local [100.105.11.97])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 749A58448E1
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 22:21:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740176508; a=rsa-sha256;
	cv=none;
	b=4+zPv/Yn0LsAHsHEzKbWRU4Kq8VOttfayUf4lgnmQbFB1SNXiySWe/ttpL3Hj9zm2QLimy
	C03EjM36HsivBpy0xioKQFqgNVt6DqyPa4gCBL+eCWPj1kim3f8PGFytLDKID7/LnZh2ya
	Va2xtbmL6+OwQ79XIMXpEGUdD56rH7IvGadgqafxrEnxNmEsydJWBUo2la5ls6fHDEaKT7
	o8VXxPKS1//5FIRcgdwAXQKaw40EiRzhsA6BgecwHnuLVsDyLeFQArvPlQLNGRJNeUaJ8y
	9I1ju/bNnyQx1HJbUZEhvnSU7o5jrHgUbzgcLlqDh5+b1x3UJ6BuEZBy88/OMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740176508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=SLywbHCLFlDtyJM4PIS4UgxATDmGldjtWxcXN7vCIu4=;
	b=3c0o1uJ9lM87O6TiYMuIyvu0wsn8TJB8651GuekcmXzOxaFi2ttkcI/B6K5rhTlHIHyCaC
	YmGhuDqbo3/ix6pROTzppd7Q1dS39t0gqIhdHkinHrLkWgQDi7NWRkxp4iirnN2elWsPWZ
	tfkYZwwO6idGPEwLQ97WZH/jrYmgd3Wiza9T8zhvyIBb3i9RAEtVHSpk4XhdCJ2Vi8KOOa
	CbHnPOKMn02544eacGjifI3DO+XswZXY+FzU67FiqcAoqO2bhAE6J/b1W2RonKcPZ2yLgo
	n5zkPy+QQBu9kx2SBPjSQs8l5CtWozdsVznGk0koeVeDSUZ6+hCx6FkilFwpLQ==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-w9rnd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Juvenile: 0d726792692c29f9_1740176508682_4090014334
X-MC-Loop-Signature: 1740176508682:1043141164
X-MC-Ingress-Time: 1740176508682
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.11.97 (trex/7.0.2);
	Fri, 21 Feb 2025 22:21:48 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4Z04Nr0ycyzmv
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1740176508;
	bh=SLywbHCLFlDtyJM4PIS4UgxATDmGldjtWxcXN7vCIu4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VHjwrsTLU5Uob/P46sOlEdEUBaYhu6habDOgD8IYpPWhBqcJY/Z3MsTw0E9mgHo/i
	 z4TIdpIQbkCIl7IvnA6STE/YepIA5eo4dxNoVQfwcNKOD+NE1M39Nc/ipkhDyuTYOU
	 soNuNxG1HAl+ns5rDabPgGScfD+bFatge7JpQogsZlvETltcv/iD/VZU/miSQoBeLl
	 tZQq7uOfcV4gyCzV3TyTRJhnaxVO9fQQVwp+D840r3A69mMIEdZ1pShIf5kS1a6Gy3
	 nHAYjHB3peOUUt5Ngp3/ECIObPudxL4bxRRC7Ev+c9zzZz5CwzqRPsiJPfd+QHQCJf
	 XrNppiU/uNW+w==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0047
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 21 Feb 2025 14:21:46 -0800
Date: Fri, 21 Feb 2025 14:21:46 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <20250221222146.GA1896@templeofstupid.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If multiple connection requests attempt to create an implicit mptcp
endpoint in parallel, more than one caller may end up in
mptcp_pm_nl_append_new_local_addr because none found the address in
local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
case, the concurrent new_local_addr calls may delete the address entry
created by the previous caller.  These deletes use synchronize_rcu, but
this is not permitted in some of the contexts where this function may be
called.  During packet recv, the caller may be in a rcu read critical
section and have preemption disabled.

An example stack:

   BUG: scheduling while atomic: swapper/2/0/0x00000302

   Call Trace:
   <IRQ>
   dump_stack_lvl+0x76/0xa0
   dump_stack+0x10/0x20
   __schedule_bug+0x64/0x80
   schedule_debug.constprop.0+0xdb/0x130
   __schedule+0x69/0x6a0
   schedule+0x33/0x110
   schedule_timeout+0x157/0x170
   wait_for_completion+0x88/0x150
   __wait_rcu_gp+0x150/0x160
   synchronize_rcu+0x12d/0x140
   mptcp_pm_nl_append_new_local_addr+0x1bd/0x280
   mptcp_pm_nl_get_local_id+0x121/0x160
   mptcp_pm_get_local_id+0x9d/0xe0
   subflow_check_req+0x1a8/0x460
   subflow_v4_route_req+0xb5/0x110
   tcp_conn_request+0x3a4/0xd00
   subflow_v4_conn_request+0x42/0xa0
   tcp_rcv_state_process+0x1e3/0x7e0
   tcp_v4_do_rcv+0xd3/0x2a0
   tcp_v4_rcv+0xbb8/0xbf0
   ip_protocol_deliver_rcu+0x3c/0x210
   ip_local_deliver_finish+0x77/0xa0
   ip_local_deliver+0x6e/0x120
   ip_sublist_rcv_finish+0x6f/0x80
   ip_sublist_rcv+0x178/0x230
   ip_list_rcv+0x102/0x140
   __netif_receive_skb_list_core+0x22d/0x250
   netif_receive_skb_list_internal+0x1a3/0x2d0
   napi_complete_done+0x74/0x1c0
   igb_poll+0x6c/0xe0 [igb]
   __napi_poll+0x30/0x200
   net_rx_action+0x181/0x2e0
   handle_softirqs+0xd8/0x340
   __irq_exit_rcu+0xd9/0x100
   irq_exit_rcu+0xe/0x20
   common_interrupt+0xa4/0xb0
   </IRQ>

This problem seems particularly prevalent if the user advertises an
endpoint that has a different external vs internal address.  In the case
where the external address is advertised and multiple connections
already exist, multiple subflow SYNs arrive in parallel which tends to
trigger the race during creation of the first local_addr_list entries
which have the internal address instead.

Fix this problem by switching mptcp_pm_nl_append_new_local_addr to use
call_rcu .  As part of plumbing this up, make
__mptcp_pm_release_addr_entry take a rcu_head which is used by all
callers regardless of cleanup method.

Cc: stable@vger.kernel.org
Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 net/mptcp/pm_netlink.c | 19 ++++++++++++-------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c0e47f4f7b1a..4115b83cc2c3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -967,9 +967,15 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
 }
 
-/* caller must ensure the RCU grace period is already elapsed */
-static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
+/*
+ * Caller must ensure the RCU grace period is already elapsed or call this
+ * via a RCU callback.
+ */
+static void __mptcp_pm_release_addr_entry(struct rcu_head *head)
 {
+	struct mptcp_pm_addr_entry *entry;
+
+	entry = container_of(head, struct mptcp_pm_addr_entry, rcu_head);
 	if (entry->lsk)
 		sock_release(entry->lsk);
 	kfree(entry);
@@ -1064,8 +1070,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	/* just replaced an existing entry, free it */
 	if (del_entry) {
-		synchronize_rcu();
-		__mptcp_pm_release_addr_entry(del_entry);
+		call_rcu(&del_entry->rcu_head, __mptcp_pm_release_addr_entry);
 	}
 	return ret;
 }
@@ -1443,7 +1448,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 
 out_free:
-	__mptcp_pm_release_addr_entry(entry);
+	__mptcp_pm_release_addr_entry(&entry->rcu_head);
 	return ret;
 }
 
@@ -1623,7 +1628,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
 	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
+	__mptcp_pm_release_addr_entry(&entry->rcu_head);
 
 	return ret;
 }
@@ -1689,7 +1694,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		__mptcp_pm_release_addr_entry(cur);
+		__mptcp_pm_release_addr_entry(&cur->rcu_head);
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad21925af061..29c4ee64cd0b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	struct rcu_head		rcu_head;
 };
 
 struct mptcp_data_frag {
-- 
2.25.1


