Return-Path: <netdev+bounces-257607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIM+KtYVhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3510037A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60A073003BD8
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9EB328614;
	Fri,  6 Feb 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thhbvgg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25F1C84C0;
	Fri,  6 Feb 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395088; cv=none; b=WCamrOkPhJVF7sa5uURSfUDu+fOKXr70eWA67zl4aFXNYJa9/JYfQg60b5dYcdUTzhtXZfjTzi3bbW3DW4RnPUiZ+J2WCIPjRu0RjCiGz//1loRugqUmqTSrqI7WuoeNtTor9OgKVYA/aW3wPsrXKPSGPbikPSn9ceWmCx/24kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395088; c=relaxed/simple;
	bh=PiDIWeZlkeDsu6cTqGUK9dbfTqkzek8Pux4/zZHNWi0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0ah7fFA/Px+R4xtgjqwWBiLe8C7/2eQaz0Ak4vC6jtcRXy/fXX3FgJJuPZpiRyLzaSskmLfAlHNa+SqzmRW6319Rc5AH64GX9ia3Tde3Mw3R3qGk77Va42WyBOHHQsZEWpO5pH5tvxH13RrOloAyGiT0dDqPLDIhBnTZBxCf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thhbvgg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B38C116C6;
	Fri,  6 Feb 2026 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395087;
	bh=PiDIWeZlkeDsu6cTqGUK9dbfTqkzek8Pux4/zZHNWi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Thhbvgg5qRGd0hzkpMg14HlY/mke8C2jytA9NcuNtWib0Ppz9ZlfJyjvuX1f+Mer0
	 yFCmH8hyHUkPuDfTyOgDcA/53PAtOiRzzCQrW0tYlg6ugGdIvRuDCrU7DZjt2TuPCc
	 zGxE1aPlRK5JZ7FXSSm17iroW7uRzNK849pE1BIvLTguAk5OdCPxpwkwM7FC5ghi5g
	 vlpogLTmbxyBDzUBKqW24L7pWhASOgaEZXQ+nm4QIz55jzoJykxgSwct2pIfb4qG67
	 7tvlStEBSXqK6+1SpbegZGxewHttnC0UiRYQZq5t5tySE2+pD//ApBMIawPVBYp/Zq
	 Bv26gYIi43zcQ==
Subject: [PATCH net-next v3 4/6] net: sched: rename QDISC_DROP_CAKE_FLOOD to
 QDISC_DROP_FLOOD_PROTECTION
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Fri, 06 Feb 2026 17:24:42 +0100
Message-ID: <177039508262.2258217.13751577312338706877.stgit@firesoul>
In-Reply-To: <177039500964.2258217.2989656069254156812.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257607-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2A3510037A
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
index b019a3a0a59b..2e2f4fc36e0d 100644
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
@@ -75,11 +75,12 @@ enum qdisc_drop_reason {
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



