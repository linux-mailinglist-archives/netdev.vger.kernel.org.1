Return-Path: <netdev+bounces-301917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vcoTAJX6PGoxvQgAu9opvQ
	(envelope-from <netdev+bounces-301917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBAE6C4698
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Zby0xdjJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301917-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301917-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885483004F64
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F093C0A1D;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F701C3318;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381079; cv=none; b=iFfc4itULrD94NtVuzUqWpjLhN0y53c9Hi8GWxK0/QUkn9Nq+a7qCMxJmDP3dQOkVAlH7couGqkLSp/w3WqeiL8MUZN4K0C5HYx3WHMzzBsnraGczih3dmHZsIVtgHIzHjj5HtHXK5THGek2BiNVQMIUev3sOGtjtAtAjxnVvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381079; c=relaxed/simple;
	bh=3ddgQfLkuEXFWzCfXbLrEe7g1KrOicWxKW1/OfJxceo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQLyTShEsqgzlYtnTruPn2wO/78lxwcIQ3ZSh6wWoPt2sr72d1waByq9219jg5vuyondGhG/vJ+kP6NDI+v1meu62mIUmXLQHY48jazK75umuLO3p3UX8AyXD7IbnESBWk9poU1NCp+yQdKTjuoZeeRFm6eZhXChh5pHyz4OFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zby0xdjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7208CC2BCC9;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782381079;
	bh=3ddgQfLkuEXFWzCfXbLrEe7g1KrOicWxKW1/OfJxceo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zby0xdjJa+4zneVMEOT+kMURPOzBWKeIziA3CjT8NNodirnfzVE+4xCDQXWWkS5VQ
	 iE88VFXeq+HHsBP7bDN6P2dBuqnUw1FIlrJC6yowvR2VDfsT7XjpgRvIoZcAh7Rouz
	 98n1MN/YxHd6JsLtN5PvT8Vtp6G3wlQkuxQBChque8lmRwGzM3zCu6C1BxfH2tckKv
	 s+W3Cg5mAHBC7z1QK68ht1USGBLJIklw72Q42vEbEmFN4q+IpPKwDm6Fp/73WwrMal
	 KeeFsHUy3aQNBGPGt3xU2rNcbw+jmiToziG/AhuhrugLcui7ESMbqmk5XfjMwo0qSi
	 qEFqGAV/aCfVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A08CDE007;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 25 Jun 2026 04:51:20 -0500
Subject: [PATCH 2/2] net/sched: sch_multiq: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-disp-31bcb279-v1-2-85c40b83c529@proton.me>
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 Jarek Poplawski <jarkao2@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782381078; l=1511;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=w7wRNrInJ6R59lQnmw33WI/qx8pFQzfYwnA3wVu2g3I=;
 b=oHcZfonzbWyvjEJ/9reY7m8sV1mXVgFCQwYOBjtHIu0+V+ehrqN115C5tJeykZedL1y9JlU0I
 T7Dr2ZwHnJ+AlQmpGjtYP5sN9xSpDZJzoG31ugsp/2FgeeBv26O6+rl
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jarkao2@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301917-lists,netdev=lfdr.de,hexlabsecurity.proton.me];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,nxp.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:replyto,proton.me:email,proton.me:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BBAE6C4698

From: Bryam Vargas <hexlabsecurity@proton.me>

multiq_dequeue() takes a packet from a band's child with a direct
->dequeue() call after multiq_peek() peeked it. When the child is
non-work-conserving the peek stashes the skb in the child's gso_skb, so
the direct dequeue returns a different skb and orphans the stash,
desyncing the child's qlen/backlog. With a qfq child reached through a
peeking parent (e.g. tbf) this re-enters the child on an emptied list and
dereferences NULL, panicking the kernel from softirq on ordinary egress.

Take the packet through qdisc_dequeue_peeked(), as sch_prio already does
and as sch_red and sch_sfb were just fixed to do. The helper is a no-op
when the child has no stash, so a work-conserving child is unaffected.

Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conserving qdiscs.")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/sched/sch_multiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 4e465d11e3d7..a467dd122369 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -103,7 +103,7 @@ static struct sk_buff *multiq_dequeue(struct Qdisc *sch)
 		if (!netif_xmit_stopped(
 		    netdev_get_tx_queue(qdisc_dev(sch), q->curband))) {
 			qdisc = q->queues[q->curband];
-			skb = qdisc->dequeue(qdisc);
+			skb = qdisc_dequeue_peeked(qdisc);
 			if (skb) {
 				qdisc_bstats_update(sch, skb);
 				qdisc_qlen_dec(sch);

-- 
2.43.0



