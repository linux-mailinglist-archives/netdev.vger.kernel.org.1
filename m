Return-Path: <netdev+bounces-169233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FCA43096
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4463AD322
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E720AF8D;
	Mon, 24 Feb 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="SoNNWGHl"
X-Original-To: netdev@vger.kernel.org
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934F2571AD
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439225; cv=pass; b=tlCB9w3HumFI9FtgoAmm9Q17JtMYMIcD48uU3nN9uAydhTIfrJ9PPnQ3dA4QLwpROS2ZGegnsMfAKgSfOBEor+cGd24DcxC6hVeJRR9fdbJyb3AvM6n4f2SLVPXMl6WsIZNVwkcM7M01BC9VHpIfmik4qguJ87c8XoevCP/GYiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439225; c=relaxed/simple;
	bh=MK0EJ6GGp2AjW25KCYTgdIt/Y8kQJDrscIWhsMhOiC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX3oRtg+iAkVyA8uoGhsWlRn3oJHOVzl3UpDp4rmp3vSAOMh6XPZDNWVBaXIp6jkXtGY/WRAnR6I7uTH+2PoyGZwgIFJLVpsU4PCuc4n1sHW8eXbuOvztsLVe/GaNUoZLAO0xRiyd8RL2bjOPWs42utgqAIqGSnEh7o0Wtt3qJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=SoNNWGHl; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BEC768A39BE
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:20:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.106.229.127])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 70D238A37E2
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:20:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740439214; a=rsa-sha256;
	cv=none;
	b=GZ04Vr2AEFpZY4tSPZZMAD1k7ygsRbexY8jC2R+ug+Zv7znABB3gXYD1CgkHRyz2YL0Tym
	JFZ0bGSTzYPZwz+r2Du+opopnTAW9sWzq0vDWcj2sIFNj8nk9Fi8wpJLGnlFQZHRRQbJTw
	cxNzlbU1myNqSBEyI0mtZICf1XWJI197gGsgmWpWCggDCZ5PEtbKX0yIE/aLWjpFQVu1Zh
	EqrkXein1J4/4ZGVYSAa7uuob3rUnAW8Hn7r6955N6nEFrb9FOq0nPQLxs0qiB+iY61u+h
	J7XbhxUy3z1uJjocT+EI60KZQJHagNnGj00olzT565MvOJopW6blvknLCvqMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740439214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rpubLIYqI2UphHODi3laPhFzWuhz65/4YHEgUa33aEs=;
	b=dJUpD0BN+AphIsPCo8ZWsj7NZOu4rQL86ST6LfDMomlXhsTXPxOZYPgNhQxtmTCttRqW2Y
	PFRuTX6oi+tYS3+ffWderPNlV1Epyu+j87uSQfqVuxjaczeN0WeXi21mfmyr5fbStISf2L
	Zrbtug8JY5tHUIG2c6A8o5kv+Yi2nWBsskoyuFivPWi4qgj+cp74svQfpAvK6PNTqzbCQU
	4uIxno1v7jfgSGJP999AOnWQ2W62DxRd/ObShAyQFinlAUTUnOkZGbH3Zk1uCu+7taYSxR
	smeugbaKifEXxp/V1DDGXPGo2vmWvD8R2ICaOv6XfEMFg/Nt8lUcjZ64sS9j6g==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-sc298;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Spill: 656671755de8bf12_1740439214690_331596743
X-MC-Loop-Signature: 1740439214690:1057265772
X-MC-Ingress-Time: 1740439214690
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.229.127 (trex/7.0.2);
	Mon, 24 Feb 2025 23:20:14 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4Z1xXs5dZXzpP
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1740439213;
	bh=rpubLIYqI2UphHODi3laPhFzWuhz65/4YHEgUa33aEs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SoNNWGHlG+9Y43OReoXRx44AROH4kDxaz8WCf0cTGodSfrGxLiCCCVACOeOvPUfoq
	 Xo4SB/IXI4/PvYUgOCUOxrEwBsFUkmkR06k4cGTTLF8Krft+cMHxj/0XzzSMkS7PSs
	 f3mlmbE/9cZc+cDpszFZH5AKYbdpHHIU+3750VjMHMrdUW0Fn6ECDG2AOTkOIIlPdb
	 CFtk25oA5Jv104j0TH/KneUnS7A/uSP7Zh6rUW7CS+7pMpktFW4F9dIv5mVlxPgWgz
	 k3zJvLpNICItXs0FjFF3vjjRJyS5Cg7QY3UE0QlkYVjO9T4LBQaZbriADLIwDYWUDY
	 ljVcG2ZVmv4Qw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00ec
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 24 Feb 2025 15:20:12 -0800
Date: Mon, 24 Feb 2025 15:20:12 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <20250224232012.GA7359@templeofstupid.com>
References: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>

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

Fix by skipping the replacement of an existing implicit local address if
called via mptcp_pm_nl_get_local_id.

Cc: stable@vger.kernel.org
Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
v2:
  - Switch from call_rcu to skipping replacement if invoked via
    mptcp_pm_nl_get_local_id. (Feedback from Paolo Abeni)
---
 net/mptcp/pm_netlink.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c0e47f4f7b1a..7868207c4e9d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1017,6 +1017,17 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;
 
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1165,7 +1176,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1433,7 +1444,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

base-commit: 384fa1d90d092d36bfe13c0473194120ce28a50e
-- 
2.25.1


