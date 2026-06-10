Return-Path: <netdev+bounces-297534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvXAEzUhKWqgRAMAu9opvQ
	(envelope-from <netdev+bounces-297534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:32:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CF667333
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=kYxEj0z1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6856230B3C75
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE123AD51F;
	Wed, 10 Jun 2026 08:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DD399358;
	Wed, 10 Jun 2026 08:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080288; cv=none; b=W/iHTro/w5HVvc74O3Fi1hcJp0N3NWGFvswiSkGGo9KLTpfLrXc6Z9M5d2a9FCgzA7hN/JVxW7JfW7yHLb1dzlHizCikMdEkS8rLrULscFQLDMK/Che1cPr4lqBxUhXogBiuRclCjdI6tq7AXta5lm0g+d3RYhhk52qOox0Wtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080288; c=relaxed/simple;
	bh=v4HBoDWj3r6sBM7g0mxyX4dQ6EzByot+RLtUfjmPW1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M8/txTnvspXHstrb1n0q8hdaD4qQMvi9ldq7dsB+3kbLxF7XP5Cgy9NnZeo6l/0ktOz1UJ2rb2zb8/ur741QWHi0l5L7jARrn1bCSA/h2JJpwzcGcw9JCFnUvqgHcgTTE8KgRx1hynixaGZGDtvnGJyURJsAOJlOW67Z0q8gd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYxEj0z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99DE9C2BCB9;
	Wed, 10 Jun 2026 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781080288;
	bh=v4HBoDWj3r6sBM7g0mxyX4dQ6EzByot+RLtUfjmPW1I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kYxEj0z1VZPQBj7ZgGIGjEcn8VcgGlpQh7AuTe0HZS0Kj4N/gOmj8COtR4kmYtrIJ
	 ribsK1uEZwTy80jOoxtCs+YjBCz75kyYVT3ajkUeIbklZaJOqZw3ZeKh3YqCrYLK8A
	 5yQ/1XBnj+U0UtjFnvVf6DWcp6R54l2O0zKjzJdI1JEswl8W5P8ozRjPPZZWgexs0H
	 TX/UKd4jlKl726Q/Mc84aAT1cjI8kmj3nMLfBWEys38hK6eDtBDJPliHCcFhrwRZRf
	 MGj7SITNhbJxbuxqhruOrOBosKKRDjD2wVmCp9RA0i5Zb/rkJe/mtL5iUy6gYELkTQ
	 Rlf3A3M/YgLFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54FCD8CB9;
	Wed, 10 Jun 2026 08:31:28 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Wed, 10 Jun 2026 10:31:23 +0200
Subject: [PATCH RFC] net: bridge: mcast: don't clear L2 host_joined on port
 group deletion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mdb_l2_host_joined_fix-v1-1-19746b0b8a5d@luminex.be>
X-B4-Tracking: v=1; b=H4sIANogKWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3dyUpPgco/iM/OKS+Kz8zLzUlPi0zArdtCSjlFQjQ1MLg2RzJaD
 mgqJUoDDY4GilIDdnpdjaWgDkt+kAbQAAAA==
X-Change-ID: 20260609-mdb_l2_host_joined_fix-fb2de21580c7
To: Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781080287; l=4075;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=Nc7ftwi5FCk1zbALrXN+jcXd41GY2T6GIvI9xkrpbyI=;
 b=RibYAWjSHhDpRl4wwKOTGtVn2IwvM9Jw1n97jKA3elr9UsKpNIBvxLOjg/+skCn4QwVhywZJ3
 a/yHESXt1GWDh5keWxvxnazzZKzdVDZHT+KvQ9hrQixTHvJhFJFZwBV
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297534-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,luminex.be];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,luminex.be:replyto,luminex.be:email,luminex.be:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71CF667333

From: Cedric Jehasse <cedric.jehasse@luminex.be>

For a static L2 multicast group that has both a host entry and a port
entry, deleting the port entry also removes the host entry, and the
whole group then disappears from "bridge mdb show".

To reproduce:
  bridge mdb add dev br0 port br0  grp 01:02:03:04:05:06 permanent
  bridge mdb add dev br0 port swp1 grp 01:02:03:04:05:06 permanent
  bridge mdb del dev br0 port swp1 grp 01:02:03:04:05:06 permanent
  bridge mdb show # the "port br0" host entry is gone, too

br_multicast_del_pg() processes every non-(*,G) entry through the S,G
path, which removes the port group from br->sg_port_tbl and then calls
br_multicast_sg_del_exclude_ports(). L2 entries are stored in
sg_port_tbl as well, so they take this path too.

When the last port is removed in br_multicast_sg_del_exclude_ports it
sets "sgmp->host_joined = false", clearing the host membership directly
and bypassing br_multicast_host_leave(). With host_joined now false and
no ports left, br_multicast_del_pg() arms the group timer and
br_multicast_group_expired() tears down the whole mdb entry -- even
though the host membership was explicitly and permanently configured
from user space.

Keep removing L2 port groups from sg_port_tbl, but skip the S,G
EXCLUDE-mode handling for them. The host membership of an L2 group is
managed solely via br_multicast_host_join() / br_multicast_host_leave().

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
For a static L2 multicast group that has both a host entry and a port
entry, deleting the port entry also removes the host entry, and the
whole group then disappears from "bridge mdb show".

To reproduce:
  bridge mdb add dev br0 port br0  grp 01:02:03:04:05:06 permanent
  bridge mdb add dev br0 port swp1 grp 01:02:03:04:05:06 permanent
  bridge mdb del dev br0 port swp1 grp 01:02:03:04:05:06 permanent
  bridge mdb show # the "port br0" host entry is gone, too

br_multicast_del_pg() processes every non-(*,G) entry through the S,G
path, which removes the port group from br->sg_port_tbl and then calls
br_multicast_sg_del_exclude_ports(). L2 entries are stored in
sg_port_tbl as well, so they take this path too.

When the last port is removed in br_multicast_sg_del_exclude_ports it
sets "sgmp->host_joined = false", clearing the host membership directly
and bypassing br_multicast_host_leave(). With host_joined now false and
no ports left, br_multicast_del_pg() arms the group timer and
br_multicast_group_expired() tears down the whole mdb entry -- even
though the host membership was explicitly and permanently configured
from user space.

Keep removing L2 port groups from sg_port_tbl, but skip the S,G
EXCLUDE-mode handling for them. The host membership of an L2 group is
managed solely via br_multicast_host_join() / br_multicast_host_leave().

This fixes the issue, but i'd like a second opinion on if this is the
correct way to fix it.
---
 net/bridge/br_multicast.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..d718a6d1ddb1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -816,7 +816,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		/* L2 entries share sg_port_tbl with S,G entries but have no
+		 * *,G/S,G EXCLUDE-mode semantics; their host membership is
+		 * managed explicitly via br_multicast_host_join()/leave() and
+		 * must not be cleared here when the last port group is removed.
+		 */
+		if (!br_group_is_l2(&mp->addr))
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}

---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260609-mdb_l2_host_joined_fix-fb2de21580c7

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



