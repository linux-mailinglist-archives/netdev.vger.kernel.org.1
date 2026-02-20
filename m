Return-Path: <netdev+bounces-259751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEBPL2mqmGn5KgMAu9opvQ
	(envelope-from <netdev+bounces-259751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:39:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7E16A21A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F7A306B4D6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C436681B;
	Fri, 20 Feb 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfOuCk8N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsC15xh5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D52EDD7D
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612742; cv=none; b=T0VJqchpDBzr9AhslpZYyVPC3DFx8UMGa+8mcz+mRZ/n7bcLWnmeDA657U4fwgHAemtPoNKsrA+Ma4jpNKKH36BcOuE3Rts5C9gZoh2neV56R+N93Qqc8+ZEN+FEY4fsVmMbfgyvM82iHrpa6brMroORqaKANoxvKD/kJbjxyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612742; c=relaxed/simple;
	bh=WlKNvIqaKbweM9fECdaUANs8Aj8XdHnRDOZXjozAff8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FilkPDrYRSmbU02N9PvXLB0gy5v62Uy63W0DjhBT19L0NnZxRvQSOVLUpVWzUWho278ep5ejG3wT+x2ula9dKITXn1hTeDEjapLiRrByANdHKAwvrjLGZrkf7BsmdfZw1zjUST+Z4gN0qtb4O2+pzpTZ6NU20oyu8jxNxZQZn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfOuCk8N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsC15xh5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Feb 2026 19:38:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771612739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wP8xzvqN3A40VPZSmAm4RelqqJjST2AaJuC+daRjRao=;
	b=dfOuCk8NOJM4HDnSUJcfouxO47AFeVAwP8oTVXE4xupLcWKu1qswTiJvZA+AubXITwEcH+
	KuXt4oN1cxNSwmzWK1J6UM4h7NLfJDjc3N5tUlCnbZitMT4w+1R1PiDQeA578r1KbkBZpG
	9b/MuSC4RGvBcWzcnuL2Dl1UXDAQt6AQPHsYUZiO0Do5Ucz6bYyIpcR2LmBVEXQANEC96I
	Z1zCukhtXYZQFMDzXlu+OPa4PIfLN+oiJCQ1OG+oac59/gV8i3Rt3oT0eWFt4hqcB7D7bq
	/zsD+XUK42tVhvwDdbE7eKFCgIf7Q5m2tVYnUjC4MXpYZfoy+oazMpaE19mqaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771612739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wP8xzvqN3A40VPZSmAm4RelqqJjST2AaJuC+daRjRao=;
	b=rsC15xh5xpSEw/fkz2tkTlqcYh3ktwQrdgzRBmNtm2jhVz4AQ7ElFt77Ld9T1USnFRBxGe
	jciaC8NMrviImoBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260220183858.N4ERjFW6@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-259751-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 19A7E16A21A
X-Rspamd-Action: no action

skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
not be taken in IRQ context, only softirq is okay. A few drivers receive
the timestamp via a dedicated interrupt and complete the TX timestamp
=66rom that handler. This will lead to a deadlock if the lock is already
write-locked on the same CPU.

Taking the lock can be avoided. The socket (pointed by the skb) will
remain valid until the skb is released. The ->sk_socket and ->file
member will be set to NULL once the user closes the socket which may
happen before the timestamp arrives.
If we happen to observe the pointer while the socket is closing but
before the pointer is set to NULL then we may use it because both
pointer (and the file's cred member) are RCU freed.

Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
matching WRITE_ONCE() where the pointer are cleared.

Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A62: https://lore.kernel.org/all/20260214232456.A37oV4KQ@linutroni=
x.de/
  - Added matching WRITE_ONCE() as per Eric.
  - Added a RCU read section. There are users from preemptible
    context.
  - Added a Link: to the original thread as per Willem de Bruijn

 include/net/sock.h |  2 +-
 net/core/skbuff.c  | 23 ++++++++++++++++++-----
 net/socket.c       |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index aafe8bdb2c0f9..ff65c3a67efa2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2089,7 +2089,7 @@ static inline int sk_rx_queue_get(const struct sock *=
sk)
=20
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-	sk->sk_socket =3D sock;
+	WRITE_ONCE(sk->sk_socket, sock);
 	if (sock) {
 		WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
 		WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 61746c2b95f63..a01fb7c053bfa 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5555,15 +5555,28 @@ static void __skb_complete_tx_timestamp(struct sk_b=
uff *skb,
=20
 static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
-	bool ret;
+	struct socket *sock;
+	struct file *file;
+	bool ret =3D false;
=20
 	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_dat=
a)))
 		return true;
=20
-	read_lock_bh(&sk->sk_callback_lock);
-	ret =3D sk->sk_socket && sk->sk_socket->file &&
-	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
-	read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	rcu_read_lock();
+	sock =3D READ_ONCE(sk->sk_socket);
+	if (!sock)
+		goto out;
+	file =3D READ_ONCE(sock->file);
+	if (!file)
+		goto out;
+	ret =3D file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
+out:
+	rcu_read_unlock();
 	return ret;
 }
=20
diff --git a/net/socket.c b/net/socket.c
index 136b98c54fb37..05952188127f5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -674,7 +674,7 @@ static void __sock_release(struct socket *sock, struct =
inode *inode)
 		iput(SOCK_INODE(sock));
 		return;
 	}
-	sock->file =3D NULL;
+	WRITE_ONCE(sock->file, NULL);
 }
=20
 /**
--=20
2.51.0


