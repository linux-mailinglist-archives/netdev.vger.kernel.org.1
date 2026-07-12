Return-Path: <netdev+bounces-306976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JHgZDBjrU2rPgAMAu9opvQ
	(envelope-from <netdev+bounces-306976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8455745C0E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=odHs2vLg;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306976-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65912300D901
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2B3B4E80;
	Sun, 12 Jul 2026 19:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5837475B
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884558; cv=none; b=nTi3Umt2rHWRD3ndCmvHJiw5HMBs3b9quSrMFLzAhbDzNzWBLP6zvjgrl84U5VSlPXoVqoJ0tiTNMvZGOzdU1LDVNpMEiBpouuUzn8qWAccb9pi8wQDyokucwNvxbjwv1wtsXKhTns/2nb0IIutZOVA+57kH7bz5SP8OMwvbs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884558; c=relaxed/simple;
	bh=/hwMuqFPbV2RXCxBKoN/ZEHNqijXQT8Lwh9RVoeAq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVp7POrC81ycfbEKFDdO1vsccv7TNt67e1clZVqYl2xh+jFiUE8X0ZXBFDh9d6pknHy96FsGGuJPeUfVAURU1qmjqrO+QoF1oTg4yUhX163iu6R6oCIIyZmCLGm8gSGtfrAdMI2kmJsJOWc1jKQlIMVctcKfNAXglz1qxqQ3rlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=odHs2vLg; arc=none smtp.client-ip=195.121.94.184
X-KPN-MessageId: f6b53a40-7e27-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f6b53a40-7e27-11f1-a59f-005056994fde;
	Sun, 12 Jul 2026 21:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=x7uJpPkF3ZQUrVWrgYFqwWsVpOjT67/X4ytnP1oLCCo=;
	b=odHs2vLgRLPOqLbKwyekwuvOqYahbKcL+JC65XHkWeAIM0Y0hgqya7YQAoRyV99weSkYZnjEYslyL
	 ZFGankDxkO5LbgcmvUfaRJqecVAE788dMFPbkSZ5rooGV2McHnx7s7plh7UPShzQ+xz7pEa9wK6ZuD
	 mouaZ4GZmpVq4yzUA38NjeYzF9pY+3Sr/GrQ9wVHN+zX8bXOzJpzADx3Yk6l/VEQyjo0fw5sKDR4tX
	 PAN+OQ5Ytubh8eGsvWZgT0oWkNyXaFv6N1LkSPGcYH0Q6ad0SDr8mQE1jn6z3RoPF8FRSoFIX3/P0d
	 +uypT3d65g29wao4T+WYvWMgznhiQgg==
X-KPN-MID: 33|aCmUk9DR42MJvYEnNg0Xnbr6u00Xeqlc/Tdp34eeaQa8IIp64EU9sbHhMeiG2xO
 r7yi8bYDYCCzm6sdMbu1pWbo95qSfEMna1AuwxTxxLGw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hch6RI3T8pEZhkRaOvP0IjHnMogfJP0PF8nk8jIHnZM6qrB+mgTlOC+83Uc670Z
 Pj9ZBYjWhSCx3VmwHCrsPHQ==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f6757dc1-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:13 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all socket types
Date: Sun, 12 Jul 2026 21:29:55 +0200
Message-ID: <20260712192958.1631672-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-306976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:from_mime,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8455745C0E

unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
for SOCK_STREAM (introduced along with the stream-only SO_INQ).
Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
fall through to the generic sock_setsockopt(), failing with
-ENOPROTOOPT.

Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), and
also for accepted sockets in unix_accept() (reachable for stream and
seqpacket).

This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UNIX
socket types.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..3d256255085b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case SO_INQ:
 		if (sk->sk_type != SOCK_STREAM)
-			return -EINVAL;
+			return -ENOPROTOOPT;
 
 		if (val > 1 || val < 0)
 			return -EINVAL;
@@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops = {
 #endif
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_dgram_sendmsg,
 	.read_skb =	unix_read_skb,
 	.recvmsg =	unix_dgram_recvmsg,
@@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 #endif
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_seqpacket_recvmsg,
 	.mmap =		sock_no_mmap,
@@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol && protocol != PF_UNIX)
 		return -EPROTONOSUPPORT;
 
+	set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
+
 	switch (sock->type) {
 	case SOCK_STREAM:
-		set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 		sock->ops = &unix_stream_ops;
 		break;
 		/*
@@ -1864,8 +1867,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-	if (tsk->sk_type == SOCK_STREAM)
-		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
-- 
2.55.0


