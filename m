Return-Path: <netdev+bounces-295751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ArIiEaeYImrIagEAu9opvQ
	(envelope-from <netdev+bounces-295751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:36:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14E646E8F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:36:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oo1RsT6Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295751-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A05D309F74A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C73B71C5;
	Fri,  5 Jun 2026 09:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9013B71BA;
	Fri,  5 Jun 2026 09:22:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651366; cv=none; b=XKAZG3uUIzamJ7ZSERoMvNbfxi+xGN8FzojSa8mnUi+Wk2jHwR8a/RbGLuFRmYHvHbLgQ8Ave5+4j3iIKUnEhFzF8RYZOM+6l/niz/gOdt/4TC6zfCE36FvKi31xpFuAgfTqZINgNUSc1rJPvlUXCYr5UxO1Xv200O43wSXruwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651366; c=relaxed/simple;
	bh=/gOW798p9PbuZvLJxhjikWf4dkHbOBBv+JzfTgGjaVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpBcKAy9jTtDIo+tNsvN7uOyOOUyIkMkEvJleVVc6rDr6suxQLP5ToYavV+Spfn9qMGyrsbq31VIYPdAw/U/2DqAsDlPJoysBpZ7Vn6r5Jla+kC7+yN4eXz5lnj+RCHWsjXLMEIO3NEZkQt4oFrExgzNYFhKH9MOJNYRiWtL54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo1RsT6Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFD31F00893;
	Fri,  5 Jun 2026 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651365;
	bh=E+f/zWvvwskd/11hn8AAfbKTGP8q2boPvdlgsuM5EcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Oo1RsT6QkUNIn9WVuN7D3vcbOF9NeQRJQ+sIE/8ElOcTlfxuotzL5BAnAS4UmVel9
	 9kpFmArvaEq8eb3keHqOBYv2+pNUiGjN0Jtwy8EYyIf+ersfY8jhc6w2BWqegikCD7
	 MYH2RM9+gQL/f1adLK7I0I68RZZpQSrtXd6GLeny86csi/PYDJcZOp1jX+Fn3qFbdI
	 X1XYYRlZqb/Tg5BNGsRkJpEYX3FWmKHN3s85lwFmAYUUsUFG1WyCbp7FTtUzs+nCSF
	 7rpJW5GnkNIQyX7gwN80dGIAG1Lbc38sw+UCvNxIPZ50STha029372n/LvrJsX4zm9
	 2rShaxLp/NNNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:57 +1000
Subject: [PATCH net-next v2 13/15] mptcp: pm: make
 mptcp_pm_add_addr_send_ack static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-13-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/gOW798p9PbuZvLJxhjikWf4dkHbOBBv+JzfTgGjaVs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxAMQr711w4wM36Vswi235hcCtr1yJpc6tr
 DNrosKc6AGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c/b3EACChjwcs/4f/EwAtro1WimzmS2k+c/9uMf6lby2ZSZjnMttxWK+rluNH7S+XCVPCzJzhC0
 B85ayKMfLynUm0Uozk/CjdSqosu4jCA+kTCL0viFOJ6b8azGJg80eqBfJAUjzeoIM/LXCOIWUJt
 r61PAQ5DZpNSeBP5P/3fr/nl0X7lh9zc+bPtkP/YcaujSG3XOFrvULx04iY77/4+2Z0RlSJJAi3
 +VZ1sQp2xQ8eFt4cMZklNOFD9Lr8XGaeLeP/EIyNUmORpQH0S4oSuE0uoF01u/sr1t+VlrHSZWU
 Ny1v8oxZolsVOjekHoX9rVQkJZ7au1dBJ8L0XWVThytV5hlXlDa0LB92LONxmFgXqW/z2dqpSgC
 AXyqjcrZMgCtaM8D4EQ86cxUAJX2qCqNZnGvNeQ8VmfFqrDp/zNCO1vG9VEl9HkUSTbmxNSDJCF
 zGuRY+q0o0g72GwKjApfa1Btbotxd5UwudzXi4FkidSGUCcB0ygriq6TxEpGMhwnwwDieQvSH0T
 OuH0+mn3GegwRpzRJo9/u2XhCnp7PVO33YjY+KGsgM7obZXAYpDeo9cAoEgt7TiNF8Fjq7szhD8
 Hxa/9/pDbpEGoqzOOKoQ49thxaZSdCfquEXZE4VgLCt65mW2YyWLw/M4twveISQOATQKsRCGVzQ
 eSqKisKb4RL/YAw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD14E646E8F

Only used in pm.c.

Note that the signature is added above: it is easier than moving the
code around, because this helper depends on mptcp_pm_schedule_work which
is declared below.

While at it, explicitly mark it as to be called while pm->lock is held.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 4 +++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 684ae8650c19..f4604611f10f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,6 +226,7 @@ static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
 	return false;
 }
 
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 static void
 mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 				  const struct mptcp_rm_list *rm_list)
@@ -743,7 +744,8 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+/* To be called while pm->lock is held */
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8bfb351c6257..7bc8fd486e81 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1114,7 +1114,6 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);

-- 
2.53.0


