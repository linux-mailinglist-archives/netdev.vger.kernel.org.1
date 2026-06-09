Return-Path: <netdev+bounces-297073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UxKUO/4jKGqt+gIAu9opvQ
	(envelope-from <netdev+bounces-297073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4E66111A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="Y 1syMdv";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=fL5TeSTB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297073-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F36483039F7C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38533F37A;
	Tue,  9 Jun 2026 14:21:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C10328635
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014906; cv=none; b=G9JSn5DYOVbKC0B8Eq4mGcx/3TIxq6X55gfuaedBsIgHkQDGElB/U/MHxOd4mDOOZOgGpenCZ4Coe2yyDxAWLfOxpRTBoLwX5l38ZfYX6gbdJkTUqBiLbzO2UvftRMS+JCht9vz0Rl3JDRSLU1Fs4ktqo2V+cAWN7RW/SJcUZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014906; c=relaxed/simple;
	bh=GEknocA44VLGQCFPldwKa4wrHw80zUgaD0NJ61aYPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpfJT+DtdUSIcTC+NCBxs4G0js31Djir7/DDafgv8mopV64OGVN0M/NNE4fkJL87HAxY33NOlpIggF8fusO/lGI/pqB6S3A2dwiL8UnzqcJt1I2s+D4rk0lCfQQ1BmH3RP0c4YOTAPdaZXMBf4+cQiy8SeHzYuj0J0bwSlMaIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Y1syMdvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fL5TeSTB; arc=none smtp.client-ip=202.12.124.156
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2397D7A0106;
	Tue,  9 Jun 2026 10:21:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 10:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781014902; x=
	1781101302; bh=dCDxGNVkpPoA3MaDM+5aH3tDaTjS+nHMUgKfHXARb44=; b=Y
	1syMdvuPX/0cQgyTVpQtyJfNSkLXKT1SjzRJZvA9YugJh+c6cwFEmHPZuQfTjm1p
	fYDMGrtUFSMg1Hlgi52CpOyFLfCXUmOXziAk+4q7Nw5enYVHqv3ihvzjMemXhOsY
	uop1Mpx+mP8apBl0Zzy+QnbvfLPRd9tANYfFPTzodj6ZNAASS2qX2fuAHAxO8DI5
	elNRnPodRgl8xeTKpeKV2DLh1J01mDH11uGqpgpd316GrJ0I0nopf1cWuDUgAKA8
	zisoe5EhT0lOqw/atVoaDpPfinTXetXazgF6iwIJqWXMFysiZlEXGr/eYiYdJUuJ
	/6Nbmuioc/LXjALzhfjoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781014902; x=1781101302; bh=d
	CDxGNVkpPoA3MaDM+5aH3tDaTjS+nHMUgKfHXARb44=; b=fL5TeSTBYzzZKog1o
	G8QzkKkRtNOzdSB/ILdGxUJqa3nlmtkgIRtfrZgh7NuyHgFffgNEK5UZ010HIPGY
	yJFVMjLW9dEHT61NzejqBU0hZPKDPUZKNxMGtdtwr5/JIOyKoY4ktIrJQwK2rQwl
	hKcPBvgacISdVYaRZXThpPN2UQ03D54D5W1TdmpI+P42TL4Lt7gyDAGYdq3e6J72
	sadgmiMkVk+r4phzwZOLKsPC1Kc3+Z63P0cIppQpnOLcZKzSTeLmY0Hax+Y7O5nX
	U4CHFCmJVNuNb75jKLZUgZ38hiDxmr2wIMKsuXOf/I+OmPSOiEVDnYzyW23cfHBM
	io5fQ==
X-ME-Sender: <xms:diEoaqeCx1e09gy4BiS_RjnZ0silLXcB65_wvJT8eAXgTG3l5o4dng>
    <xme:diEoamyL_BWOy-qwytFL4Jyb5crdLNg5bIZHyJUeOkYQQWk4mb6joERmR29kLe-nE
    SS_KHMlJuG9cA9q7KsQuXh5jtD2Dc80sV_GOo_Zi-jsr87ylz_LQAFB>
X-ME-Received: <xmr:diEoavI5ePjbXpti46u1uvzCdOM1ehKtYaF-dpY4OTC7r6W0hfUks4gm579dxrz5X8DO5nkKYYnzYZFIu5sYgIw>
X-ME-Proxy-Cause: dmFkZTFAYbPIEdlTaGgLlXLtM++A7Xm5v8ULkYXIB0CEeSRTBEVZ+ZnlmbpeGJkBRhW7Qa
    qxgUrNWZT+Kvuqa4JS36FWYwG6mAwt0ck08N4/tWJKvr5xjlRRHzVO4ahoBcxeJroSjaiC
    Lanrxv4hd6bLPHzP8TCKoNRopk+nsEAp/fM9ZztHWWPaD1PERQDtR4sOWCVSBLtsUvBDTn
    XBLVkw4hNHH6gtnA1oJeBmJ9yy9jZZv6GdEsCFJ6+ynA+ciPmfY5mDDbFPQmqdvEhTDvNS
    VVSTVM1dRgvkrdvAVgO+aI7wHSAzcy4Oo2p3P9UOCyzaVynRRnXp63xGApJDqAp518OBSe
    forXluxPJSIW+kf4F5g/0nvLIvBPPTnp4QlLuXffKV1tHfNPQALDyJfmY/xV7bs5ToVmyC
    HSui2OGzyu1+LjpqwfSZmQx+DngqTUGFwoY3UGGJMffshuopA6e4xE2e5l135/2fpZ3Ijh
    CLjX/gB+6yhjgu1R3DhQD1j8MpqxmWX/VtvVj1u0LWwqGfffLr4SKEaz5zkM+uNSiVbD2x
    h4zgOySKDedbQpKEfSIcD83yc1hWyW+XFO3IY/sGP/8u/90jsEHdcQJ/vV2rydvcfJijhV
    PxfYV5n2PsGUsfh6eMqZDI+m9/fKTVPeQS+fX/KWdqexzH1NmqcACFfsLpIw
X-ME-Proxy: <xmx:diEoaoHN5CM-9id7OXDzjl8jZgPLGa0pRUcxut1MmihertcQMI0wYQ>
    <xmx:diEoar-VeauKHosjPjSyHAx5ea82NeKY5ZB-70Ko9GMzDruiiOwc7g>
    <xmx:diEoaoISBP8PRLiwi7nc3Vb9nbh5FT-HM7gSQfONFTExDolP9oiOHg>
    <xmx:diEoapupO9LgIGOU1jowuHw-hfRnDkQPXSGp0Qx-UH0XnnZHUUddbg>
    <xmx:diEoap5KyL0IU27iu8gA81PrSz0QMInWGmD1RJN8dKVt50sdO_yAZvCc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 10:21:42 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net-next 2/2] net: remove some unused EXPORT_SYMBOL()s
Date: Tue,  9 Jun 2026 16:21:22 +0200
Message-ID: <cbf1457c5d192a206f2f244ea3453766cb5dbbf9.1781013810.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781013810.git.sd@queasysnail.net>
References: <cover.1781013810.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-297073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[queasysnail.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67C4E66111A

chtls was using a lot of symbols that no other module requires. Remove
those EXPORT_SYMBOL()s.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/stream.c               | 1 -
 net/ipv4/inet_connection_sock.c | 6 ------
 net/ipv4/inet_hashtables.c      | 2 --
 net/ipv4/tcp.c                  | 4 ----
 net/ipv4/tcp_ipv4.c             | 1 -
 net/ipv4/tcp_minisocks.c        | 2 --
 6 files changed, 16 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 7a37e7dd2c43..2d748581862d 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -112,7 +112,6 @@ void sk_stream_wait_close(struct sock *sk, long timeout)
 		remove_wait_queue(sk_sleep(sk), &wait);
 	}
 }
-EXPORT_SYMBOL(sk_stream_wait_close);
 
 /**
  * sk_stream_wait_memory - Wait for more memory for a socket
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5b934ce8d98a..18b567288158 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -824,7 +824,6 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 	__IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(inet_csk_route_child_sock);
 
 /* Decide when to expire the request and when to resend SYN-ACK */
 static void syn_ack_recalc(struct request_sock *req,
@@ -901,7 +900,6 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 
 	return req;
 }
-EXPORT_SYMBOL(inet_reqsk_alloc);
 
 void __reqsk_free(struct request_sock *req)
 {
@@ -911,7 +909,6 @@ void __reqsk_free(struct request_sock *req)
 	kfree(req->saved_syn);
 	kmem_cache_free(req->rsk_ops->slab, req);
 }
-EXPORT_SYMBOL_GPL(__reqsk_free);
 
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
@@ -1280,7 +1277,6 @@ void inet_csk_destroy_sock(struct sock *sk)
 
 	sock_put(sk);
 }
-EXPORT_SYMBOL(inet_csk_destroy_sock);
 
 void inet_csk_prepare_for_destroy_sock(struct sock *sk)
 {
@@ -1301,7 +1297,6 @@ void inet_csk_prepare_forced_close(struct sock *sk)
 	inet_csk_prepare_for_destroy_sock(sk);
 	inet_sk(sk)->inet_num = 0;
 }
-EXPORT_SYMBOL(inet_csk_prepare_forced_close);
 
 static int inet_ulp_can_listen(const struct sock *sk)
 {
@@ -1405,7 +1400,6 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 	spin_unlock(&queue->rskq_lock);
 	return child;
 }
-EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
 
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 					 struct request_sock *req, bool own_req)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 3e795547b40c..ba0faa9ae2bb 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -252,7 +252,6 @@ void inet_put_port(struct sock *sk)
 	__inet_put_port(sk);
 	local_bh_enable();
 }
-EXPORT_SYMBOL(inet_put_port);
 
 int __inet_inherit_port(const struct sock *sk, struct sock *child)
 {
@@ -331,7 +330,6 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 	spin_unlock(&head->lock);
 	return -ENOMEM;
 }
-EXPORT_SYMBOL_GPL(__inet_inherit_port);
 
 static struct inet_listen_hashbucket *
 inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 890182a151e1..455441f1b694 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -297,7 +297,6 @@ enum {
 };
 
 DEFINE_PER_CPU(unsigned int, tcp_orphan_count);
-EXPORT_PER_CPU_SYMBOL_GPL(tcp_orphan_count);
 
 long sysctl_tcp_mem[3] __read_mostly;
 
@@ -3027,7 +3026,6 @@ void tcp_set_state(struct sock *sk, int state)
 	 */
 	inet_sk_state_store(sk, state);
 }
-EXPORT_SYMBOL_GPL(tcp_set_state);
 
 /*
  *	State processing on a close. This implements the state shift for
@@ -3506,7 +3504,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	sk_error_report(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
@@ -5104,7 +5101,6 @@ void tcp_done(struct sock *sk)
 	else
 		inet_csk_destroy_sock(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_done);
 
 int tcp_abort(struct sock *sk, int err)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fdc81150ff6c..ec09f97cc9e6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1894,7 +1894,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
-EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e6092c3ac840..ddc4b17a826b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -392,7 +392,6 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 	tcp_update_metrics(sk);
 	tcp_done(sk);
 }
-EXPORT_SYMBOL(tcp_time_wait);
 
 void tcp_twsk_destructor(struct sock *sk)
 {
@@ -670,7 +669,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	return newsk;
 }
-EXPORT_SYMBOL(tcp_create_openreq_child);
 
 /*
  * Process an incoming packet for SYN_RECV sockets represented as a
-- 
2.54.0


