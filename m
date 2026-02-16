Return-Path: <netdev+bounces-258913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGtDGjc5k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:35:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E42145A8B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3B3306759D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC934330B30;
	Mon, 16 Feb 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er2VUUog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7001330670;
	Mon, 16 Feb 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255853; cv=none; b=dgf98Dis0g9C1ZpGtisYpywEcrJLM7a+iNA1YWdixcrR6c0bO01Awb8AghkN9lx1Bdkl4wxHrh30OcU4D78XhQukDZt+J9uSA/Kz3pG7bDvaWnUyjbRWI+s5OQUOWxk+iimCO2XJ/HSIa19PBxAG1auRx3yo8JQNbtYyxV/lw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255853; c=relaxed/simple;
	bh=t+zM723yOVl8wJo+gvpjQk3fWYOWbxrp8pqks2LXr1g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEMcZL2Vcg9Fzule0TV4xr1C6pK1yUeFGrWTZ0a9SpukLcgrFFBRe44yLDCzMreAFIyOpMlwlQB2UZ18MuxSOeQ5LOFcAMHy7hN312hI7cSHJkAdiBBme5euR4KvimKrE1moDaOMJ5m5yNqliAp+y8DznAfxAJVUn6Z7+zt/LkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er2VUUog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81722C116C6;
	Mon, 16 Feb 2026 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771255853;
	bh=t+zM723yOVl8wJo+gvpjQk3fWYOWbxrp8pqks2LXr1g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Er2VUUog58kZCPhLZAPMhZMQ6mIqwGwo3ALyuLnx4rV2EDrMqss7taMakoHGgCz0z
	 lAWArXs8EHSd7jdWbUzCCO3v8KItwTEelOv4WU8ddqFlVq7LiJtW9ML/1PYJlz4wLH
	 TMfRgEBu3yrC1qelUgCP9v2tBX8+L8Rl4VYfWWC3lf+21fGeN1H1dM9jwvXhF4cqlo
	 s1zXjGT/U29Eok88mygdjjdIjdpzp4vmMAnuP9WadMmUlhMuGjwAJ30kP6R8VA5tnO
	 iWrPkZLKjA/V5cy+mPIS7sIGoAonAdBAyTwM8r2QtbHQkvJfhcyVGGyAwXclwLinyK
	 ZsP/NTLdVY7NA==
Subject: [PATCH net-next v4 4/5] net: sched: rename QDISC_DROP_CAKE_FLOOD to
 QDISC_DROP_FLOOD_PROTECTION
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Mon, 16 Feb 2026 16:30:48 +0100
Message-ID: <177125584868.2500844.8245974613372519090.stgit@firesoul>
In-Reply-To: <177125575993.2500844.8718737675156179479.stgit@firesoul>
References: <177125575993.2500844.8718737675156179479.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258913-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10E42145A8B
X-Rspamd-Action: no action

Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION to use a
generic name without embedding the qdisc name. This follows the
principle that drop reasons should describe the drop mechanism rather
than being tied to a specific qdisc implementation.

The flood protection drop reason is used by qdiscs implementing
probabilistic drop algorithms (like BLUE) that detect unresponsive
flows indicating potential DoS or flood attacks. CAKE uses this via
its Cobalt AQM component.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/dropreason-qdisc.h |   11 ++++++-----
 net/sched/sch_cake.c           |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index a167302e79e5..84f19a51382c 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -10,7 +10,7 @@
 	FN(OVERLIMIT)			\
 	FN(CONGESTED)			\
 	FN(MAXFLOWS)			\
-	FN(CAKE_FLOOD)			\
+	FN(FLOOD_PROTECTION)		\
 	FN(BAND_LIMIT)		\
 	FN(HORIZON_LIMIT)		\
 	FN(FLOW_LIMIT)			\
@@ -68,11 +68,12 @@ enum qdisc_drop_reason {
 	 */
 	QDISC_DROP_MAXFLOWS,
 	/**
-	 * @QDISC_DROP_CAKE_FLOOD: CAKE qdisc dropped packet due to flood
-	 * protection mechanism (BLUE algorithm). This indicates potential
-	 * DoS/flood attack or unresponsive flow behavior.
+	 * @QDISC_DROP_FLOOD_PROTECTION: packet dropped by flood protection
+	 * mechanism detecting unresponsive flows (potential DoS/flood).
+	 * Used by qdiscs implementing probabilistic drop algorithms like
+	 * BLUE (e.g., CAKE's Cobalt AQM).
 	 */
-	QDISC_DROP_CAKE_FLOOD,
+	QDISC_DROP_FLOOD_PROTECTION,
 	/**
 	 * @QDISC_DROP_BAND_LIMIT: packet dropped because the priority band's
 	 * limit was reached. Used by qdiscs with priority bands that have
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 6e1d3be76201..5394d967c554 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -573,7 +573,7 @@ static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
 	if (vars->p_drop && reason == QDISC_DROP_UNSPEC &&
 	    get_random_u32() < vars->p_drop)
-		reason = QDISC_DROP_CAKE_FLOOD;
+		reason = QDISC_DROP_FLOOD_PROTECTION;
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)



