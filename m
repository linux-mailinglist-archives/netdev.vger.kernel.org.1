Return-Path: <netdev+bounces-287723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLukCg/iBGrPQAIAu9opvQ
	(envelope-from <netdev+bounces-287723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8153A991
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 154F53042958
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16619375AB5;
	Wed, 13 May 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hAWrloic"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010B37F730
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704857; cv=none; b=nouxoEWDcWdWajlwR+V/OlvtEcMcw5XqOg69Mf2NFn0TavBMCMhbeAhtuPq+8xiOH2dhqaTK34edFHaa+vG7QZqsWn8dvINioGbW0fcvG6W0a5ilKzktJ6IjadbYmsAxNtnbtzb4xgA2N7ktdUdc9OWVl4+ppwC0/5Q6h8ScXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704857; c=relaxed/simple;
	bh=S83SpLBcoPhP+7bn3MzKq8rVqA+SBfDLXqtD/uo4Txw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK41A8JUz8nekMbBMOkNt+cSwR9twNNgluHfTyTjxC3rRjp4KBFFwLm9q69p9Q1YTnDMq2Z/Kkw/qvM5Pkydz0GQQrw2Pr45Dl7DrFBMpfG4pjiG2D3G0ldgpPjznE7WqyVZZUHTb74y6Dux2RvnoFtxie4JxcAXIX3fPHWByXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hAWrloic; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DKJNHQ574627
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=yJheQG7
	6HofnDX2IrZr6leEpdUzDSYlnoMp9xfPS3mI=; b=hAWrloicYrUnt90A5xd84re
	FY7ZAnyL2DvbvsLfvmZrIasG9Y5wvwJGjBvdYkQf0PkkvSHOG2OzQrAwcctVbtoO
	FJPg5vmsd6f4UYGPkWCgkQypcvMpDAitLDMQHlx1sFrW0MxEuPMz2V4mxQeHYW2b
	sPJsH7rT69uGexj3RKXWrC7JHRJfhUkm+8m3oCHtdZPlgKtHOSM4QcDXqQ++Mrkf
	F9YW/+Sfp12rY+Yu02jzBDuRrHOaniPWQljZ2f+kwuByfFMnjr9SmdsPIyym/8XC
	6Po3wLcrwcUimFpjQbCcsG5iGcagUxeWvTQxBO9QX+QfL3NIf5LCQFF4vf83ChA=
	=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvt30ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:54 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7de4be150b9so14362089a34.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704853; x=1779309653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJheQG76HofnDX2IrZr6leEpdUzDSYlnoMp9xfPS3mI=;
        b=VNig9h3P0OAY+bTz2e9qRL8YegEo3jmj2dFZJfDvzqDc3V/sTZLanwosMSI0hlIDCo
         y/WcWptD9HDKDgLFp079vjIePE5FdXXtIWhB096nW88wpFAr3K3lYmoy6wZPYwuk4LVO
         tH2IzpU6PtxsQg7a0+X3ZinrHSWFw+xFsrQxcS/56mHrCyeEr5YAEy7LvFzxy25NCynC
         7LF2sIoA/W1r+VjPcMVV0oJEQdVfeSraDzGZRJvhtfZpgRovasiZU/fNqg4Gl76chrU+
         Lm7Wf/Wosh2BG0X3Y1LlrUJ7Ga3c1bheUcgSnUkQsSbQ86pyVsxr9ZbJQrspOjNjWEb2
         H55Q==
X-Gm-Message-State: AOJu0Ywnj9n2FS67afT8164oGD0mrwl0BrI9+owZAXmUtm0IA/NsD63P
	cSKaoqgbQj3s9E4BrbJM9Hr6DzAU4meE/TliEgOGW6RJT+DYgLIHnrPfULStw1xthZIMuZpuBxU
	SFR83k5Bl6veHnJmCGJjf647yVtU5eMts8NM9bUqM3Q1oREqSb8nBC8rM4PLdKTZq8fCslnn4CQ
	5T/iJVnsU02nyurmEEjPUjoHaZYdcHAR2UQ6+w
X-Gm-Gg: Acq92OEtvjuloiCT/+BD9RY/FHhAXM+JvxvBKrXVZGvUAWpxTRwQB5WNmeGLkbyG/JK
	Wr1hkK7UJQCiUSRxGbAsMFRsdcQdD1RBiI799oKS7JPEcz1/uEDWJnvbBSY7Bu+fXCQFwNfIq0m
	VlMZqSrvDyk+E7H5MkKs6JPKQZsqQRgi0qHJXErvgecblUuIfmIfNRqJ3Pcm5ld9iMounTtQjcN
	IiVForSLmpux3v74uAsvqTyCgkjxJriUEEPIqn/yj3nbyoYOuu5I2wpNqn4Dvqts5891vtv14Gq
	08wrQ61lvW40tTJkN5AbBfqLmpoD5XEMhfRGj3yO8FKmgoYWWtuCNdH1slBO8x1sUQKZ1EXSpBX
	egPdl+/slW+k=
X-Received: by 2002:a05:6830:d17:b0:7d7:fbe5:e9b3 with SMTP id 46e09a7af769-7e3d9ff2e9fmr3314770a34.3.1778704852962;
        Wed, 13 May 2026 13:40:52 -0700 (PDT)
X-Received: by 2002:a05:6830:d17:b0:7d7:fbe5:e9b3 with SMTP id 46e09a7af769-7e3d9ff2e9fmr3314732a34.3.1778704852386;
        Wed, 13 May 2026 13:40:52 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f3edbff9sm337351a34.21.2026.05.13.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:40:51 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v5 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Wed, 13 May 2026 13:40:47 -0700
Message-ID: <20260513204048.2721843-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513204048.2721843-1-ntspring@meta.com>
References: <20260513204048.2721843-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bsp8wkai c=1 sm=1 tr=0 ts=6a04e1d6 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VabnemYjAAAA:8 a=3322akBNrI9nzhgYK84A:9
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: R2AHvIzp-jqz15OuBKn1uPRGa4JTZOEx
X-Proofpoint-GUID: R2AHvIzp-jqz15OuBKn1uPRGa4JTZOEx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwMyBTYWx0ZWRfX0enHs2uVfwVm
 zohsvIeVbPa3fAq2q6s4eI5+0m1qjoelzf1MGDZgieEs7iLSzRxx8V8cLLh1IcDBGhdywgM9cD1
 +KRuHAPo9x9+zxzAAMS310Xcan58hta1ylQsG7auFMR5a/8atXkzHernbGuRtBhzwsJP2o1I2Bn
 yvsENuvFJABpqLqHn0AMAFkhETFxG+QvZr4hM9mjyGXdB6t7wJh9zLBqvROpT3CRqtxjGMM30V4
 WaYQLaZZgZUrtLpkXOaT3c/dAsy8SqtAHIvw6OGqP9v3cQjDM85VPoV0vgu7X9e4ybo3WJJu8Dl
 po1ysiNWqVeZoDQ27ad1TqqPCyzS/KR/dwoc6KlDCC/4v7bvnyt7NNpw1gOntGFepg5fgwrlIj4
 jnAXcot83/KGKn8uidOyRlzSVx223RxRdusQkmZCmZZLwqY5AwOveG2kqfYztGzgxDp9r+QWc6x
 qHeQbMUHYLu61fJPHcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: CEF8153A991
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,meta.com:mid,meta.com:dkim];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
and spurious-retransmission events, but the cached route is reused and
the new hash is not propagated into the ECMP path selection logic.  Two
changes are needed to make rehash select a different local ECMP path:

1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
   tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
   tcp_plb_check_rehash() so the cached dst is invalidated and the
   next transmit triggers a fresh route lookup.

2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
   SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
   inet6_sk_rebuild_header(), inet6_csk_route_req(),
   inet6_csk_route_socket(), and cookie_v6_check() so
   fib6_select_path() picks a path based on the new hash.

   This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the
   flow keys (e.g., symmetric 5-tuple for policy 1) which must
   not be overridden by a random txhash.

   It is necessary to update mp_hash explicitly because the
   default ECMP hash derives from fl6->flowlabel via
   np->flow_label, which is not updated from sk_txhash
   (REPFLOW is off by default).  ip6_make_flowlabel() cannot
   help either, as it runs after the route lookup.

sk_set_txhash() is moved before ip6_dst_lookup_flow() in
tcp_v6_connect() so the initial ECMP path is selected by the same
txhash that subsequent route rebuilds will use.  This avoids
unintended path changes when the cached dst is naturally
invalidated (e.g., by PMTU discovery or route changes).

The dst reset is guarded by sk->sk_family == AF_INET6 since IPv4
ECMP does not currently use sk_txhash for path selection.

tcp_rsk(req)->txhash initialization is moved before route_req() in
tcp_conn_request() so that inet6_csk_route_req() reads a valid hash
on the initial SYN/ACK.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/ipv4/tcp_input.c             |  6 ++++--
 net/ipv4/tcp_plb.c               |  7 ++++++-
 net/ipv4/tcp_timer.c             |  4 ++++
 net/ipv6/af_inet6.c              |  3 +++
 net/ipv6/inet6_connection_sock.c |  6 ++++++
 net/ipv6/syncookies.c            |  3 +++
 net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
 7 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..8f602a665b71 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
 	    skb->protocol == htons(ETH_P_IPV6) &&
 	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
 	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
-	    sk_rethink_txhash(sk))
+	    sk_rethink_txhash(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+		__sk_dst_reset(sk);
+	}
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
@@ -7636,6 +7638,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
 	tcp_rsk(req)->req_usec_ts = false;
+	tcp_rsk(req)->txhash = net_tx_rndhash();
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
@@ -7717,7 +7720,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..accdd83dfc3d 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,12 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	if (sk_rethink_txhash(sk)) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
+	}
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..24c1c19eda6e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,10 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
 	}
 
 	return 0;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..48a29ac34838 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = sk->sk_txhash >> 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..42aa402e9a0b 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,9 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = tcp_rsk(req)->txhash >> 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +73,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = sk->sk_txhash >> 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..bdb4c9706a86 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		if (ip6_multipath_hash_policy(net) == 0)
+			fl6.mp_hash = tcp_rsk(req)->txhash >> 1;
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..e6d5ad83f670 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -258,6 +258,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		saddr = &sk->sk_v6_rcv_saddr;
 
+	sk_set_txhash(sk);
+
 	fl6->flowi6_proto = IPPROTO_TCP;
 	fl6->daddr = sk->sk_v6_daddr;
 	fl6->saddr = saddr ? *saddr : np->saddr;
@@ -275,6 +277,15 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	/* Non-zero mp_hash bypasses rt6_multipath_hash() in
+	 * fib6_select_path(), letting txhash control ECMP path
+	 * selection so that sk_rethink_txhash() rehashes onto a
+	 * different path.  Policies 1-3 derive a deterministic
+	 * hash from the flow keys and must not be overridden.
+	 */
+	if (ip6_multipath_hash_policy(net) == 0)
+		fl6->mp_hash = sk->sk_txhash >> 1;
+
 	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
@@ -313,8 +324,6 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err)
 		goto late_failure;
 
-	sk_set_txhash(sk);
-
 	if (likely(!tp->repair)) {
 		union tcp_seq_and_ts_off st;
 
-- 
2.53.0-Meta


