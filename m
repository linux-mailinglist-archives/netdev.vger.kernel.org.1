Return-Path: <netdev+bounces-301042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +SZcGUESOWpMmQcAu9opvQ
	(envelope-from <netdev+bounces-301042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D66AECF2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kE+vJ55m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8CF13011EBA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39536654F;
	Mon, 22 Jun 2026 10:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73439F19F;
	Mon, 22 Jun 2026 10:44:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125086; cv=none; b=b+fKtc+/d7hP1PYob61lIazUFZ9vPZjlVukUKMTKlJ1Ky42tFO0c5ZVSnBfe4K8dhRBI9/I/fVUuIQnOLRBWleKhl3okjRgAlBXgia70w6uJRkVI6XNmC02UU46jwUAyHI3EZ366Jh8CDQ2O0fIb8eSLLQwyDJ0gzCfdG5WM+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125086; c=relaxed/simple;
	bh=L8ALMhMzye9OWF9aqb4A63inTTgNPXkuLlL6kT5bjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoVJfgSlnSWZqo3DOe/P8B5Laoelxtb4ljRv1+sK+JCZ59rEHfV4uFXxAKaLVMDazqPJQ5VCBwpZTu5Dtbf3VAxH4Vhm6Ue2cIpqaUO/iRToBGZBujqJ0dvd0iDu3fdi8UahYJG3scE0xnP4ys9jRtQX7yC4lQ0RTr3YyHjd/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE+vJ55m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BED21F00A3D;
	Mon, 22 Jun 2026 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125084;
	bh=KAZXrpf5DysoitoHYWCgK/fcW29jojMKSDLi2cg6A7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kE+vJ55mm34hSOd/hRlUr0IDQd8CBjlqLXim20N522Fj4GIt5CgfFyUMhFCHUCz/Y
	 VvJl9uQFHZDXnPVrUI6zzmAzslmuwa2qRNTRzgmm+T9NlcMKRpSfiKpafEOJQXJ+Ae
	 4IxGDiDU/32DATLGx/2YFpMXqqzzHgNLgVBpslIJOXlSocPEJ7hyWcmWKq1agFnWF1
	 sPzkfOvVksFqf8KuDOawPTOzxE8exBQi2ZMmlGQz61eyZUpq9buaJR73tWHR9dRJNA
	 HEAGjQXH3l1/1u+Oi0eG09vwEJxVJGz9nfqhyPcQcq0ROFw1cColAyG82HCA5X5EE4
	 NbW3rkAMnmNSA==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 06/17] mptcp: implement peek_len for proto_ops
Date: Mon, 22 Jun 2026 18:43:26 +0800
Message-ID: <18c20e74da2323812ba3881ae0a5aa25ada3a8f3.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301042-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F29D66AECF2

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS stack uses tcp_inq() to query the amount of data available
in the receive queue without consuming it. For MPTCP sockets, this
information is not directly available from a TCP subflow; it must be
computed from the MPTCP receive queue and the current mapping.

Introduce mptcp_peek_len() which returns the number of bytes that
can be peeked from the MPTCP socket. It reuses the existing
mptcp_inq() helper (used by ioctl SIOCINQ). The implementation
considers the first skb in the receive queue, the current ack_seq,
and handles the FIN case.

Assign .peek_len in both mptcp_stream_ops and mptcp_v6_stream_ops
so that upper layers (e.g., TLS) can obtain the correct in-queue
byte count for an MPTCP connection.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7f0c560f6b7e..18c8b6c64c3f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4689,6 +4689,38 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb) {
+		u64 answ = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+
+		if (answ >= INT_MAX)
+			answ = INT_MAX;
+
+		/* Subtract 1, if FIN was received */
+		if (answ &&
+		    (sk->sk_state == TCP_CLOSE ||
+		     (sk->sk_shutdown & RCV_SHUTDOWN)))
+			answ--;
+
+		return (int)answ;
+	}
+
+	return 0;
+}
+
+static int mptcp_peek_len(struct socket *sock)
+{
+	return mptcp_inq(sock->sk);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4712,6 +4744,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4825,6 +4858,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0


