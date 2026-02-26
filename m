Return-Path: <netdev+bounces-261358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMHtLMBPoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:50:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11821A6FB0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 039963003507
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B936C5B0;
	Thu, 26 Feb 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D28RORzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EB36C5AC;
	Thu, 26 Feb 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113518; cv=none; b=N8yJUmEThB/P6BCvHcnTUC0meKyO/nCxS3SqfmXIPrQlwTngl4IpvUGS2xJNcH2hzM0p3LtMDqqTDS9ze5yrgQQoZP2g4Y/jvlxhiBvVgMTdmwgtL9elzS25n7MC7D4HqsC+wqtnxM6ScTxKcYghXfDGgOwjqGIRoY43pl2ZG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113518; c=relaxed/simple;
	bh=t+zM723yOVl8wJo+gvpjQk3fWYOWbxrp8pqks2LXr1g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm/ViqhRV7tIBJ3AgE5P/fOp2QF32x12Nb8ibtsYh5nLL19KCEmcT/7yqDPKKsK+70LdBGws4mGk6ldhgiHSvVKiW+kTFO7CDilSCdTP116qg+K/9Bk4c/R3/cy0TQ+hwjxPv0ibBHYmtigKE/obN5KRBG+hC/9WnYYB/NBveSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D28RORzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E7DC116C6;
	Thu, 26 Feb 2026 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113518;
	bh=t+zM723yOVl8wJo+gvpjQk3fWYOWbxrp8pqks2LXr1g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D28RORzZ8BrPo4fgUv4a/eaBSdxXva6naxo8vAoJsCpUu9w/4mb0vfWZtCPAovdUQ
	 wk1dzuvXdDBbhLbxQ1EYwlsXzTrcBTpQisvAZoyMIKrvKXHaZ0ep8MCKOUJgP7LCXP
	 KHSeFK6zFxbo3k0msBXEF68dUbYJZIr6X29mhU1Cvwjn6YXYU+XmEU2bGFTmXMTxt5
	 6tVDlvzyzyjp94eXz63t5tpLOB/55XBq3rH+BIuQd2LG/CthMYx43vBFCaVkJH+7Xt
	 trfVvefS0EBdSRxeRXEEDln6Of+czOw68B4w7kjrRyRBfNHxAPBbbuPZi0fHGAoQLJ
	 H7kXX1L3lGyyw==
Subject: [PATCH net-next v5 4/5] net: sched: rename QDISC_DROP_CAKE_FLOOD to
 QDISC_DROP_FLOOD_PROTECTION
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 26 Feb 2026 14:44:35 +0100
Message-ID: <177211347537.3011628.13759059534638729639.stgit@firesoul>
In-Reply-To: <177211325634.3011628.9343837509740374154.stgit@firesoul>
References: <177211325634.3011628.9343837509740374154.stgit@firesoul>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261358-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E11821A6FB0
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



