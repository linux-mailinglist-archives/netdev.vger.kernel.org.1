Return-Path: <netdev+bounces-284796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L6CELct+2npXAMAu9opvQ
	(envelope-from <netdev+bounces-284796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:01:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379514D9F0D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38FB8300EF7E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEB0423A63;
	Wed,  6 May 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WCorv7i1"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC93B8BBF;
	Wed,  6 May 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068879; cv=none; b=jTZ/6iVp/Is8xL7ZuHok8XJLH3O7/pfuqjlp+zw57ISSVNzULO2Q22bHncN50t0G81cGzq6DCnNIBgHVTjr7VHT1xRxTsXEqIPIb5JEWtYzaYea9elaA+YV8dQenBRStFiJ/mqAIqXn8nIMvFRn8mBsP9+iXB8ELOG7M0u/nqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068879; c=relaxed/simple;
	bh=/IEg2YfTdKNiNrgfyTbcOUMeHHjx80RPr6ybxHm30NY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIlg8SGD8a+E3iR3q6MZFhwHESTu+ddvY+6MoN3A7e46FsSFGNgSajaGLbqIk0pxlt8dODF0vQ25TTmsTW4y0tBrsxLp8zc444I9QoeEZ1i+1ZiYn7RhdyAqQcrJ30walb/aDt06Cu1oTNzHjonf5YN6u/c+JqoE5PRPxfN3v9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WCorv7i1; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hrPdgpHSS71JrUxeKpIaHFl9p0CaalSlOddpkgbvodY=;
	b=WCorv7i1Ns/Y8vk646yalzVPeZI+Oaec2jFa/yza2IQojX3v7siKc426rCH89zLsIovLRLjqq
	jtwM0iFd51QSjYEFGpvSEeImjZu4pswHezUwzQ0cFE9PlcWML+w+5EyC31HTC9b2YMyyHNLgGc9
	1inijCiSE3KxwEVUH8DsIzo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g9YgN2swQz1T4GL;
	Wed,  6 May 2026 19:53:36 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 08F3840569;
	Wed,  6 May 2026 20:01:08 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 20:01:07 +0800
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 20:01:07 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <jchapman@katalix.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dqfext@gmail.com>,
	<gnault@redhat.com>, <gregkh@linuxfoundation.org>, <cuigaosheng1@huawei.com>,
	<lujialin4@huawei.com>, <gongruiqi1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.6.y] Revert "l2tp: do not use sock_hold() in pppol2tp_session_get_sock()"
Date: Wed, 6 May 2026 12:00:34 +0000
Message-ID: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500013.china.huawei.com (7.202.195.103)
X-Rspamd-Queue-Id: 379514D9F0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284796-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[katalix.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linuxfoundation.org,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cuigaosheng1@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]

This reverts commit ce63943f9bce64df1be9b6a65b04fa6e1d99ec2c.

Upstream commit 9b8c88f875c0 ("l2tp: do not use sock_hold() in
pppol2tp_session_get_sock()") was backported to v6.6.130.

The blamed commit c5cbaef992d6 ("l2tp: refactor ppp socket/session
relationship") was introduced in v6.12 and was never backported to 6.6.y.

Revert it from 6.6.y to avoid incorrect reference counting and
potential use-after-free.

This is a revert of a backport, so there is no upstream commit.

Fixes: ce63943f9bce ("l2tp: do not use sock_hold() in pppol2tp_session_get_sock()")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: <stable@vger.kernel.org> # 6.6
---
 net/l2tp/l2tp_ppp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 34d8582c0c07..6146e4e67bbb 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -130,12 +130,22 @@ static const struct ppp_channel_ops pppol2tp_chan_ops = {
 
 static const struct proto_ops pppol2tp_ops;
 
-/* Retrieves the pppol2tp socket associated to a session. */
+/* Retrieves the pppol2tp socket associated to a session.
+ * A reference is held on the returned socket, so this function must be paired
+ * with sock_put().
+ */
 static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
+	struct sock *sk;
 
-	return rcu_dereference(ps->sk);
+	rcu_read_lock();
+	sk = rcu_dereference(ps->sk);
+	if (sk)
+		sock_hold(sk);
+	rcu_read_unlock();
+
+	return sk;
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -201,13 +211,14 @@ static int pppol2tp_recvmsg(struct socket *sock, struct msghdr *msg,
 
 static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
-	struct sock *sk;
+	struct pppol2tp_session *ps = l2tp_session_priv(session);
+	struct sock *sk = NULL;
 
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
 	rcu_read_lock();
-	sk = pppol2tp_session_get_sock(session);
+	sk = rcu_dereference(ps->sk);
 	if (!sk)
 		goto no_sock;
 
@@ -517,14 +528,13 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
 	struct l2tp_session *session = arg;
 	struct sock *sk;
 
-	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
 	}
-	rcu_read_unlock();
 }
 
 static void pppol2tp_session_init(struct l2tp_session *session)
@@ -1530,7 +1540,6 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		port = ntohs(inet->inet_sport);
 	}
 
-	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1566,8 +1575,8 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
 	}
-	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
-- 
2.43.0


