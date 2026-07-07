Return-Path: <netdev+bounces-305270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cSCxLL5/TGptlQEAu9opvQ
	(envelope-from <netdev+bounces-305270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52171738A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b="P/4EO+pV";
	dmarc=pass (policy=none) header.from=rbox.co;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305270-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305270-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3707930325EA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DF378D77;
	Tue,  7 Jul 2026 04:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72206369D67;
	Tue,  7 Jul 2026 04:25:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398305; cv=none; b=mX9w1L9GHTRB3TiT4+vsNQm+ZsoSIzn211OaUmU4IoVFHFXgHg7hU30ARx2M41BZXdMIa6e1afZTP7bY4uVfrA958uJJknU4v8ukZdVbi2btQoKbXB/5ukECzsPQRhVAnvWsCxyNbnRaK4ySpU7Oc6e9To4xDPn1FFUiBvcBeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398305; c=relaxed/simple;
	bh=H/UTfwPtFkHMTQ+Y0z5FIKqj8fGTlva082mWwsonMKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PS8rc/ekQrJBKbkaYINqHLC3BlEM4FwEyMXwWMw0igopHrMhC4z9rvw8tw5vLxC8CO1k18uCpGhcTkhwFpaAssibvDcB+WrXUfMSBFx6e9LkHVIZ2ZHiBTlPqnvXa3krUdveQy1f9DXU/jAKWTBn/oSB4puN5WSJqMO3zWFjfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=P/4EO+pV; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMa-00Dei2-Fj; Tue, 07 Jul 2026 06:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=k6pzvF+9DJvGdfAv04/qwnJKLXYRbZ1AtZu3Wi0AOZc=; b=P/4EO+pVinHlSYryX09glbxyoD
	sm+yBVSaeaVtmRUHatQ1MrARbi4bJsqc6NgpI8hTVPNpJyKxqfKKa4osnL0QWxHrpIlJS5aov959P
	9NSORf7UKCuuwapNAWk/iCt+pkWPWD+/3Floy8eWghq5Brqa2rjVQSv5WsSD2JRgdd4yMon1BHJKw
	EGsqs9OFY92aYGVQKd3wSS2ZyKW7hirBKp6mlsHHwY+cJ1rGaYUKZkb0g0/R7bWg5s4kCMpFzL+lc
	el63uMGk9SuCegRAi+3KNKAJGjRuMulMjvNG7xtRg2F+q3eMTl9qvaQ8O2yZQ3xV/v3xRvb9MwRTb
	DAKrSHBA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMZ-0004lD-5a; Tue, 07 Jul 2026 06:24:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wgxMQ-00Ctdi-Vd;
	Tue, 07 Jul 2026 06:24:43 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 07 Jul 2026 06:23:57 +0200
Subject: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:mhal@rbox.co,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,rbox.co:from_mime,rbox.co:email,rbox.co:mid,rbox.co:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F52171738A

UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.

Because sockmap accepts unbound UDP sockets, a BPF program can increment a
socket's refcount via lookup. If the socket is subsequently bound, the
transition from unbound to bound causes bpf_sk_release() to skip the
decrement of the refcount, causing a memory leak.

unreferenced object 0xffff88810bc2eb40 (size 1984):
  comm "test_progs", pid 2451, jiffies 4295320596
  hex dump (first 32 bytes):
    7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
    02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace (crc bdee079d):
    kmem_cache_alloc_noprof+0x557/0x660
    sk_prot_alloc+0x69/0x240
    sk_alloc+0x30/0x460
    inet_create+0x2ce/0xf80
    __sock_create+0x25b/0x5c0
    __sys_socket+0x119/0x1d0
    __x64_sys_socket+0x72/0xd0
    do_syscall_64+0xa1/0x5f0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Instead of special-casing for refcounted sockets, reject unhashed UDP
sockets during sockmap updates, as there is no benefit to supporting those.
This effectively reverts the commit under Fixes, with two exceptions:

1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
   handler for BPF sockmap usage"), the proto::unhash BPF handler is not
   reintroduced.

Historical note: this issue is related to commit 67312adc96b5 ("bpf: reject
unhashed sockets in bpf_sk_assign").

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index c60ba6d292f9..9efbd8ca7db8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_udp(sk))
+		return sk_hashed(sk);
 	if (sk_is_stream_unix(sk))
 		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
 	if (sk_is_vsock(sk) &&

-- 
2.55.0


