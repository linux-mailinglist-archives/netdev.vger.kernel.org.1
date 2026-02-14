Return-Path: <netdev+bounces-258749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMJ6OlIEkWkTegEAu9opvQ
	(envelope-from <netdev+bounces-258749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 00:25:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207B13DC36
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 00:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DA753004623
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5026A1A7;
	Sat, 14 Feb 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1Zws6BY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cq8jlENK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3B22B8B6
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771111502; cv=none; b=Ue2AqJ0swaobh5a3wF4Lh1Zd39Kpz8yYEtq7z4WTdAvjkL40/40w95U+L8L2aUDSMx58bzCWmjZUn1t6cHBOK7h0KX8Kr9DeGoAopvsFGtkGUCYT5ubgeaaeBQQ5LijIu1ZrcIMOEoBTocq/1wQ0MH/Tt6LKv5WauGgGqs+QlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771111502; c=relaxed/simple;
	bh=DDitMtq4DZWPQqYKyJdKL7TVWl47aqm9aQNXfygrxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EuU96ZKY1c83kUeSsZcul9eVU6thrnnxAl5ViOQB0g7qRXwxdQNWqLtGBqOJ7UFLBFBfQr1dNzJHjjTVHx+YiJb69X5+sPXF7Em7rTIcT8hURPO3FUShCnu5EwfBcbp3RqzssPj7eQJp9HAaMdt06q5X/4t9Z0e6q65iq+ixuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1Zws6BY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cq8jlENK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 15 Feb 2026 00:24:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771111498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UAxI/2XB8Rj6qD2bwk08Tpu3nnZDIzVymTVwLNo6kWI=;
	b=c1Zws6BYCXWnZRM8VmJJAGF/socJNWHkrO0hXqJuNGB5CfTV2A9oio/6lpU2vH/O/b3XI/
	CaRNuEx1hoaSHkzAFaIkCOndDKnjcrJRvQoXAyos1siiXvNandNJhrGDfGb5pbgWau5otv
	XeecC9zrCy2JANlHzih4KpJm7+rh4rICoFabvNhkmGsPdg06/9ZS/py5L0CGmv38/D7mGj
	CQNbdFFiehZLj87pqurjLu3nGEb8EsQNFm753rY/2WC1a+MbFM5KRBrbLycjRQNAuxj90Z
	aDWmlWEjiq/G2X6qNfgFYOpJvzmIcFhC4k4LUgzuC/DnV3Tna8GsgQ0TTQhAzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771111498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UAxI/2XB8Rj6qD2bwk08Tpu3nnZDIzVymTVwLNo6kWI=;
	b=cq8jlENKqXtQ0xkx10mVylDTY9Ehf8UNQI2dvhCtD3gj24SR5RjP/FwKedH1yzpEr4CuUn
	xi/rD79YZ62Z++BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260214232456.A37oV4KQ@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258749-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 1207B13DC36
X-Rspamd-Action: no action

skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
not be taken in IRQ context, only softirq is okay. A few drivers receive
the timestamp via a dedicated interrupt and complete the TX timestamp
from that handler. This will lead to a deadlock if the lock is already
write-locked on the same CPU.

Taking the lock can be avoided. The socket (pointed by the skb) will
remain valid until the skb is released. The ->sk_socket and ->file
member will be set to NULL once the user closes the socket which may
happen before the timestamp arrives.
If we happen to observe the pointer while the socket is closing but
before the pointer is set to NULL then we may use it because both
pointer (and the file's cred member) are RCU freed and the IRQ and
softirq handler qualify as a RCU-read section.

Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 61746c2b95f63..a174010e334a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 
 static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
-	bool ret;
+	struct socket *sock;
+	struct file *file;
 
 	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
 		return true;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	ret = sk->sk_socket && sk->sk_socket->file &&
-	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
-	read_unlock_bh(&sk->sk_callback_lock);
-	return ret;
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	lockdep_assert_in_rcu_reader();
+	sock = READ_ONCE(sk->sk_socket);
+	if (!sock)
+		return false;
+	file = READ_ONCE(sock->file);
+	if (!file)
+		return false;
+	return file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
 }
 
 void skb_complete_tx_timestamp(struct sk_buff *skb,
-- 
2.51.0


