Return-Path: <netdev+bounces-290930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHHuNWLREGpyeAYAu9opvQ
	(envelope-from <netdev+bounces-290930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C95BAD4D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 084783011043
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB43905F9;
	Fri, 22 May 2026 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nqwAJO2v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9D38AC72
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487061; cv=none; b=sFlJ/St6AM4k58ybLsP35moIHvkdrI2qQwCvxsUQ+Cw6APaa4uVmPw+UYOc7sCKWq1lbjYkrkZqL8IVrnxW7fQjb5TPuOYRO/BfNMJzK5Lki3fiawqC/jEVU7oCrzeIyAIguSOnEEOnMcfM8UguekNAo0nYNXJOWEzJ/nNCQPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487061; c=relaxed/simple;
	bh=1sQqcdwpTOqm2KaSBtEidDgsIngs+R1B9MGmF4OSMdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdKbW1w34+Qskh+UKCxwO3lxiTKYGhmcLkDCjRruhfoQ7+KNCsD1aZSz1Yr9/gqAeDx19FcJsXYt5hHQ20zH+CtNp4C03IU0T5xdjyfODlBzKpLZQ5Jh6K/iCWIBabU2mJKY6lMTp54PQtCpF4OU80HfQd2IukLKIelsgtoxkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nqwAJO2v; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4UVps3812099
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=roHw39P
	X+sBdvT1cEJUpVb8D/p+JlMBI2VWmztQcgxQ=; b=nqwAJO2vKKputkPoaWFaJ63
	4hy0VP2JXGgiiKMLGqZVX5whKTPWlhx/4rlf8LvQ+oWIuX1F3aYitzhf/RPKKkgU
	Fj9ZI6/bL8IVBmBnZBLy9DIb8NH4QPgETTH/vxasWOFjHDeC2y5iKOwq3kt0zEy8
	QsqsNn1zMDhynL9F3KZGD/vGqCZDQSpmMNlhYCpdhsXoC6lrTmFZdoY+J6m6aTnE
	K4jFD5BQByIQubk0HVcpboxlGtRGZYNUYPeDBlJVKWVyR0q5/LbgXuQk84hpVlbC
	6ECd/TS5Bse+l9ZyIt2I6zKeD4Qc89tAlj0/pfOyy4WKEPbbEE/v2QAR6gHH7jQ=
	=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea86qqu1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:37 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbd50dee52so23969740a34.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487057; x=1780091857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roHw39PX+sBdvT1cEJUpVb8D/p+JlMBI2VWmztQcgxQ=;
        b=IrwrcRGxcaBVLjcTAUPVHaLqg5Jb74S/WIOB6WQvg2ZavWFuykU8S/AFggdfFxKQMi
         aY03Jy1rgA37q0coRYBgP/e8aWLj51N+AwmWqFTGLIr4S0ofiiLLTjRxeCkDltNcYGyq
         XZIiuFhDo6EDhz8LERpNM5j3KMYlqaA2gBpQgzhNiURK7XyOJBKvTx2D7CfsP1/eZbYO
         Ija8st9wnmJidHSihv/4oS7ywsyuvDVaAa2iUjY7mRQqSyX6uzWKZ2+DUkumPKqRVXUG
         4NOFm7G3iXdhGdwETscAjL5UjBpN3nhQ7FWx4m4moHIYDDiCg5gBo3ZpIsHjWboGUcHt
         Idpw==
X-Gm-Message-State: AOJu0Yz3asdlp3CX0X2svsyRA8mPz2/pkLh93kg6oB2cstRywqRLi2JR
	039I/TlFDDM9xm1Y+kDc26fBjLB1Yt/3RVrziBXAK2bp44HfHMWKnNs7Bzcj4X4actVm+Tm9jCl
	1bsS5Pfp/a70ZSMRzCL3lajfBxVOvWa+eS1VwcQ9UNrRfpwLWhL6kV72PbO0cFXZPQZ25Zp3RuL
	ywvz51Fx85W8peWuHZ4ModAscJ91zGSiiPHtBA
X-Gm-Gg: Acq92OFTAsIv5Zb5FwR4jhv4gJ00BqjGHkAD01CzpaIff46uQviR3NFK8BKfpCpiguu
	eqWc+6YDgHAY7r3ApECggqEw2KrlIdC80mre5HwFBkgSq38kUir+DHqDN5YOCqwuLRlaVq1kz66
	4Ov1x2AIW/Ykxmv+idPRSriTv25RfW2jdc0Pgje6Y/kpI2IdYuNU8ME32t5kjJ6LKuFsqeoy0D7
	uu0/rDfjA56iHpjl2cfHCd3j0+T1RkAdS3Rv9tFsdhh9mFm0dz0J8a8OUGHhxO2cXXRUuiRLjbw
	rg29Xoie1cZTJ2F/PqhYvqzGJ7xkG9gQji/cLY6V2qJUI6/nShejoogidIE8CnMd6RAoeheMvgX
	RR3OmpfhTRg==
X-Received: by 2002:a05:6830:3c88:b0:7dc:d967:63de with SMTP id 46e09a7af769-7e5feded159mr3649470a34.3.1779487056997;
        Fri, 22 May 2026 14:57:36 -0700 (PDT)
X-Received: by 2002:a05:6830:3c88:b0:7dc:d967:63de with SMTP id 46e09a7af769-7e5feded159mr3649447a34.3.1779487056360;
        Fri, 22 May 2026 14:57:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60667af4csm1842003a34.27.2026.05.22.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:57:35 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v8 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Fri, 22 May 2026 14:57:32 -0700
Message-ID: <20260522215733.929238-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522215733.929238-1-ntspring@meta.com>
References: <20260522215733.929238-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxOCBTYWx0ZWRfX0IS1r/LK9k8N
 c5iysSmplA3Gf5zVGVGMvx/rCf9QtNtonLiSVM/TUNy3bfpOJ4GQXPSVgzcEkIo4hdjOQjt1s7c
 js6NBg7WWH6UelKUM+xB+INBKRcpcJdnxSgC3PVQwhSSHG3Pe90QWiJSlM6xc6zdEL1VWglapN2
 cYACRGswMe0DD7bgLjrsH47yQmVU2McT6QgbDD1Et71IGYTC4pE/tveg3/3TmlVmgCw5xQtIgPp
 B6t1uij5YS1CX/erpotcOLIfGMQrORBdxe/lzJOanAVV41vE7fSukImrM5TEXecLOm5ZYMNWo5s
 8WCQn54zCMULzS1UqJIguqX/9bcKhE/xEW+gSobIPD1+y9XUPXulJ5OfEh3BV1op3OSPFiH848b
 GblNN4K78oYwW6F1kGz1PAfM6WhsS3tfd1482uYjUxD890MOW2bgmIQoSQaPPcY99Mqm8mq3Fhf
 ZeLNVFp6EBby4WIsn0w==
X-Authority-Analysis: v=2.4 cv=GaonWwXL c=1 sm=1 tr=0 ts=6a10d151 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=TRHSsKDO3c-AA1P1OBkA:9
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: _epmrGra486dwLK3cDGrz78CArAEIF90
X-Proofpoint-ORIG-GUID: _epmrGra486dwLK3cDGrz78CArAEIF90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 681C95BAD4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

   The mp_hash assignment in inet6_csk_route_socket() is guarded
   by sk_protocol == IPPROTO_TCP so that non-TCP callers (e.g.,
   L2TP via inet6_csk_xmit) fall through to rt6_multipath_hash()
   and retain their existing flow-key-based ECMP behavior.  The
   expression uses (txhash >> 1) ?: 1 so that the rare txhash == 1
   still produces a valid non-zero mp_hash.

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
ECMP does not currently use sk_txhash for path selection.  For
IPv4-mapped IPv6 sockets this produces a redundant dst reset on a
cold path (RTO/PLB); the subsequent IPv4 route lookup returns the
same result.

tcp_rsk(req)->txhash initialization is moved before route_req() in
tcp_conn_request() so that inet6_csk_route_req() reads a valid hash
on the initial SYN/ACK.  For syncookies, txhash is set to the cookie
(ISN) before route_req() so the SYN-ACK uses the same ECMP path that
cookie_v6_check() will select when the ACK arrives and the full socket
is created.  cookie_tcp_reqsk_init() likewise derives txhash from the
cookie rather than calling net_tx_rndhash(), since the original request
socket (and its txhash) was freed after the SYN-ACK.  The ecn_ok
clear for syncookies without timestamps stays after
tcp_ecn_create_request() so it takes precedence.

bpf_sk_assign_tcp_reqsk() is updated to initialize txhash via
net_tx_rndhash(), matching cookie_tcp_reqsk_alloc().  Without this,
inet6_csk_route_req() would read uninitialized slab memory from
request sockets created by BPF syncookies.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/core/filter.c                |  1 +
 net/ipv4/syncookies.c            |  8 +++++++-
 net/ipv4/tcp_input.c             | 18 +++++++++++-------
 net/ipv4/tcp_plb.c               |  5 ++++-
 net/ipv4/tcp_timer.c             |  2 ++
 net/ipv6/af_inet6.c              |  3 +++
 net/ipv6/inet6_connection_sock.c |  8 ++++++++
 net/ipv6/syncookies.c            |  4 ++++
 net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
 9 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80a3b702a2d4..7fea9ad881e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12301,6 +12301,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 	treq->req_usec_ts = !!attrs->usec_ts_ok;
 	treq->ts_off = tsoff;
+	treq->txhash = net_tx_rndhash();
 
 	skb_orphan(skb);
 	skb->sk = req_to_sk(req);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index df479277fb80..8591f2606ca6 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,9 +280,15 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
-	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	/* Use the cookie as txhash so the ECMP path matches the
+	 * SYN-ACK, where txhash was also set to the cookie.  A
+	 * random txhash would be inconsistent because the original
+	 * request socket (and its txhash) was freed after sending
+	 * the SYN-ACK.
+	 */
+	treq->txhash = treq->snt_isn;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 
 #if IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..810c95a11c8c 100644
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
@@ -7659,6 +7662,11 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
 
+	if (want_cookie) {
+		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		tcp_rsk(req)->txhash = isn;
+	}
+
 	dst = af_ops->route_req(sk, skb, &fl, req, isn);
 	if (!dst)
 		goto drop_and_free;
@@ -7698,11 +7706,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 
 	tcp_ecn_create_request(req, skb, sk, dst);
 
-	if (want_cookie) {
-		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
-		if (!tmp_opt.tstamp_ok)
-			inet_rsk(req)->ecn_ok = 0;
-	}
+	if (want_cookie && !tmp_opt.tstamp_ok)
+		inet_rsk(req)->ecn_ok = 0;
 
 #ifdef CONFIG_TCP_AO
 	if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
@@ -7717,7 +7722,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..849ac4aad480 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,10 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	if (sk_rethink_txhash(sk)) {
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+	}
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..7c05f1072a06 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,8 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
 	}
 
 	return 0;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..7a2b1de7487c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..7ca24eef614c 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,10 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 &&
+	    tcp_rsk(req)->txhash)
+		fl6->mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +74,10 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (sk->sk_protocol == IPPROTO_TCP &&
+	    ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..70759cd64b34 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		if (ip6_multipath_hash_policy(net) == 0 &&
+		    tcp_rsk(req)->txhash)
+			fl6.mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..ecdc8f84d203 100644
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
+	if (ip6_multipath_hash_policy(net) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
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


