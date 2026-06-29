Return-Path: <netdev+bounces-302820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C9usAFzLQmqzCQoAu9opvQ
	(envelope-from <netdev+bounces-302820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B066DE7BF
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=CjGwNIew;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302820-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E217306DAB7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468140E8F9;
	Mon, 29 Jun 2026 19:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5213C060E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:42:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762155; cv=none; b=Y3uH4L8TSba+mOSloYHUeN3/B9VD3pUX6UaJKQG0+DtTXYUffFg34HZtpNj7dZz9xLpn37QM1A8lI2Bh8In83/NJV2Z51FAlwu0B7XsfaYixvlYcbtWocB6hCyqhZexPxICIpgVP8FJhhWEoVlXxs3U+AyLcvfxC1ScqD9UiKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762155; c=relaxed/simple;
	bh=6HxhrJ3s6jzh7LxWKMz4u1OGg1G7VNFBTPw64VBy6ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNd62viWmjKUO+Z1X7FmZOc59cMl5wUJ3obIvExapVSr0qIjSSATqNeIRzdga9FxJN9jNdtlOVfV3V/qkGI7BdHPc1V3u2GskMAdzlyj4sSFFTMKrCdOgiC1UXElNjpxt5GyLlbXwatAbkd/0w0YNtzJRw/CxRPauKBSsBWFtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=CjGwNIew; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: aaf3ec02-73f2-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aaf3ec02-73f2-11f1-9e8e-005056999439;
	Mon, 29 Jun 2026 21:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=/co0IKteg897VqpbxfJ42h9pVaWfek6rO+RfmPyvCNk=;
	b=CjGwNIew/Hhcm4Dew2Cd2s/Mf+30yYMl3txoQmfPXaiMME6vpaz2q4AJTZq8xH27BB1u2YUQaVQed
	 z5a6B2FJ0+BkjueXk3CuUAvnuYsHtAUoqyRxWlpMkdVcfEkfCUkQutby4jdeesew+y3wKgHXbnEenO
	 1vwWm/Ksgq4avARNSWyh6SMcrrlipwez3GqgcFbRReLZNSb48oOnom2+FaojIXjA9ja0307QhYPkQl
	 bg66IRMuBeBKuO48FjcGfnG1Mb9LamQ+mulrmNUQRQmfIM7UmM3TptMWZb8s94AXY9Qie/MgR5PHjr
	 8XFmMPV25kFDYAa/n1EnYkGxfHDVjpg==
X-KPN-MID: 33|yBMHtVgmwgAiKw2MGxWtLSNitFju2oi5yQ9WlXN1RFrlAnlNt7hMSAt5WFmf+Sn
 UNNKoTw1murj0f1LGYQgHHA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uG4uivt+qGGEGlsifpFK4veea6OGEmWeyO9CP348wnRzcB2u5vW5+nejWar3KBA
 9MAw5R1oY+QCj/ndFmpeIOQ==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id aaa7ec3a-73f2-11f1-8076-005056998788;
	Mon, 29 Jun 2026 21:42:31 +0200 (CEST)
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
Subject: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Mon, 29 Jun 2026 21:43:25 +0200
Message-ID: <20260629194327.2270798-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-302820-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51B066DE7BF

Right now if some LSM such as Smack denies an AF_UNIX socket peer to
receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
handling of LSM denials when receiving SCM_RIGHTS messages: instead of
truncating the message at the first blocked fd, keep every fd slot
and store the LSM errno in the blocked slot.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 include/net/af_unix.h             |  1 +
 include/net/scm.h                 | 15 +++++++++++----
 include/uapi/asm-generic/socket.h |  3 +++
 net/compat.c                      |  4 ++--
 net/core/scm.c                    | 16 +++++++++++-----
 net/unix/af_unix.c                |  9 +++++++++
 6 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 34f53dde65ce..bb1b3dee02e8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -49,6 +49,7 @@ struct unix_sock {
 	struct scm_stat		scm_stat;
 	int			inq_len;
 	bool			recvmsg_inq;
+	bool			scm_rights_notrunc;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/include/net/scm.h b/include/net/scm.h
index c52519669349..761cda0803fb 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -50,8 +50,8 @@ struct scm_cookie {
 #endif
 };
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
 void __scm_destroy(struct scm_cookie *scm);
 struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
@@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		   struct scm_cookie *scm, int flags);
 
 static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
-				  unsigned int flags)
+				  unsigned int flags, bool notrunc)
 {
+	bool filtered;
+	int error;
+
 	if (!ufd)
 		return -EFAULT;
-	return receive_fd(f, ufd, flags);
+
+	error = receive_fd_filtered(f, ufd, flags, &filtered);
+	if (filtered && notrunc)
+		return put_user(error, ufd);
+	return error;
 }
 
 #endif /* __LINUX_NET_SCM_H */
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 53b5a8c002b1..c5fb2ee96830 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -150,6 +150,9 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC	85
+#define SCM_RIGHTS_NOTRUNC	SO_RIGHTS_NOTRUNC
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/compat.c b/net/compat.c
index d68cf9c3aad5..6bdf4a2c9077 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct compat_cmsghdr __user *cm =
 		(struct compat_cmsghdr __user *)msg->msg_control_user;
@@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index a73b1eb30fd2..55bab203281a 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -351,7 +351,7 @@ static int scm_max_fds(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct cmsghdr __user *cm =
 		(__force struct cmsghdr __user *)msg->msg_control_user;
@@ -365,12 +365,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 
 	if (msg->msg_flags & MSG_CMSG_COMPAT) {
-		scm_detach_fds_compat(msg, scm);
+		scm_detach_fds_compat(msg, scm, notrunc);
 		return;
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
@@ -542,8 +542,14 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
+	if (scm->fp) {
+		struct unix_sock *u;
+		bool notrunc;
+
+		u = unix_sk(sock->sk);
+		notrunc = READ_ONCE(u->scm_rights_notrunc);
+		scm_detach_fds(msg, scm, notrunc);
+	}
 
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..83274ce18e06 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -921,6 +921,7 @@ static bool unix_custom_sockopt(int optname)
 {
 	switch (optname) {
 	case SO_INQ:
+	case SO_RIGHTS_NOTRUNC:
 		return true;
 	default:
 		return false;
@@ -956,6 +957,14 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 
 		WRITE_ONCE(u->recvmsg_inq, val);
 		break;
+
+	case SO_RIGHTS_NOTRUNC:
+		if (val > 1 || val < 0)
+			return -EINVAL;
+
+		WRITE_ONCE(u->scm_rights_notrunc, val);
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.54.0


