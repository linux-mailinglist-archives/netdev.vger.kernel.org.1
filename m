Return-Path: <netdev+bounces-257311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EoxMc0KhWmj7gMAu9opvQ
	(envelope-from <netdev+bounces-257311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:25:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C28F79C1
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031D0301F4AA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A233065C;
	Thu,  5 Feb 2026 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeUx7F62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF6329E46;
	Thu,  5 Feb 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326516; cv=none; b=VPZ3FEzIkFWVL6g3VQ7+FP1iH9RF31wGA77p4TGfuQh7tn72iaxjOXI/HB6tjDIEsfTTcFJfX5TnJdU+Xq3JLq2KlN9pNwN1bJoNapZ4Nw+hbB2D2UmUsVfGQ4cWuH1zZLcHUjbrPCJyzF+qvmXBbO3SBWsGa3hVU/YXSpQ2IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326516; c=relaxed/simple;
	bh=hlawE1Rk8SE0yVDSQOd24kz8EeDKHifSiZk5vSwKMYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlBucMJCcXA8nFTy20k9TXWzFS2Q5wcdS1kCyRCAldudDmCqy49/UrAFPrGpK0nkYWWrqRPWgTlDxi2EGR8Aq97nj0CuZ8HebuzB8BeSIHZggfd0qhi4GjLIQEXqAGU+GnyluuDfF/ik/urrRXYSudAeGFlWO+G863c5c4PveWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeUx7F62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8371AC4CEF7;
	Thu,  5 Feb 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770326515;
	bh=hlawE1Rk8SE0yVDSQOd24kz8EeDKHifSiZk5vSwKMYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PeUx7F62u1aPGNpFtJPjcguhhyRXcpBHCAOm8bxqhoFchjOqFw/uBAmbEYAUN09hi
	 egRW8rWehhykvXF5l02mlKxNfHQgjJRF7WTSb5782oLF2vESowvS9F87aOiNGYKNMX
	 60XhqcMt/cW62h67iB9YgRbkKgoFTN2p/P72sopDqL+GOs/V9936zQE0txfjJ9c8Jk
	 zTYL2gJrn4/iIrv6bjachC5q45i3+Upc22IdQLy8oMgaYRv0gVt/hLnsz95EkuYfZY
	 vkTvHSroQa2VZG9ILPzG3OCFN/zaI6j9tKQoJ3HWJAzaTZwpQjd79m7xhzQTkWqaxO
	 pCEDATbdeBTdw==
Subject: [PATCH net-next v2 4/6] net: sched: rename QDISC_DROP_CAKE_FLOOD to
 QDISC_DROP_FLOOD_PROTECTION
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 05 Feb 2026 22:21:50 +0100
Message-ID: <177032651050.1975497.1618419942361969764.stgit@firesoul>
In-Reply-To: <177032644012.1975497.16411100029657607833.stgit@firesoul>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257311-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37C28F79C1
X-Rspamd-Action: no action

Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION to use a
generic name without embedding the qdisc name. This follows the
principle that drop reasons should describe the drop mechanism rather
than being tied to a specific qdisc implementation.

The flood protection drop reason is used by qdiscs implementing
probabilistic drop algorithms (like BLUE) that detect unresponsive
flows indicating potential DoS or flood attacks. CAKE uses this via
its Cobalt AQM component.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-qdisc.h |   11 ++++++-----
 net/sched/sch_cake.c           |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index f70fe06213b0..3759a801bddd 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -11,7 +11,7 @@
 	FN(CONGESTED)			\
 	FN(FLOW_LIMIT)			\
 	FN(MAXFLOWS)			\
-	FN(CAKE_FLOOD)			\
+	FN(FLOOD_PROTECTION)		\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
 	FNe(MAX)
@@ -74,11 +74,12 @@ enum qdisc_drop_reason {
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
 	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
 	 * the priority band's packet limit was reached. Each priority band
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index da3c347574d2..b08711fa5f97 100644
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



