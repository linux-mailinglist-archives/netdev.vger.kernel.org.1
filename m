Return-Path: <netdev+bounces-305271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mp1hGr1/TGprlQEAu9opvQ
	(envelope-from <netdev+bounces-305271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:25:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB0A71737E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=e78bz5uy;
	dmarc=pass (policy=none) header.from=rbox.co;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305271-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305271-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C853300F79F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7735836B;
	Tue,  7 Jul 2026 04:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F293769EA;
	Tue,  7 Jul 2026 04:25:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398308; cv=none; b=ChL7CHwn5w9B3wjasZxaZ1Py7z2v8g3gRclVvCqpIqsdn1EEoe49fVnpWJ1A5IlKeIwbFeiUJadKINIBIGIly7UX4G3cSHY/Pd05pM8pA2yohPnSB5BAW9MLvi/p/ZNJTxYTRizysoR1ZQAuDGO8Y74FOU7SJuWpN1ykPGPl1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398308; c=relaxed/simple;
	bh=85tq27hLD+jzwy3TCziJfyDxd7YsbuuJAEaNgXrCMDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAmSIRd0vGui9WrTnMngRSHPsLvJRng44cK5yKbUESzorxe/EUSKu643S8LbSGP7WbJNSe4HzQ9N67cW1b4dj00D2lNMmL3ENh0TjHfO+VAUxTnyXsGJup1UFYYF0/xgFdu8dzByNUDAo6mwYIpnx7s87akmJJyvpIVTW7895XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e78bz5uy; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMa-00Dei1-F3; Tue, 07 Jul 2026 06:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=tKhC+vAaiVHEXEq4FWXbZp0M6pkOOXe+U7ki5CbA0tc=; b=e78bz5uyJHHDEk1z7QSv5njRBF
	tr3upiv/BLQ6TgGFTo4gPWNJHYfL9y/5QTtQ0KUmUuk6hYVeVpbpLzIkxAwDZzVFeJbMcYYcy/U0v
	G5+f9JSAjQFfuid9jW2lhx2YdDokw/7qLzUG7E9qsZ5BdAobjPIxDrejLyq0U+ylhE1EKHTG9b2uW
	H+xW443IRQFMP+c9zVhByeyKbyDOlbIeDNxQ/eQjodQRzSGMEBz/y489cIn3w9Cv1tOk+dNc98pzZ
	YXBPcqzsgVpEAphS5RpmtvA2MTrDBgdsglYY3IcrGDFEmgMUpJuU8MBBJJHYQkmDYiBDfB3GH2igX
	oZT5CC/A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMY-00076O-Qb; Tue, 07 Jul 2026 06:24:50 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wgxMP-00Ctdi-O2;
	Tue, 07 Jul 2026 06:24:41 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 07 Jul 2026 06:23:56 +0200
Subject: [PATCH bpf v4 1/4] selftests/bpf: Ensure UDP sockets are bound
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-sockmap-lookup-udp-leak-v4-1-f878346f27ab@rbox.co>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:mhal@rbox.co,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,rbox.co:from_mime,rbox.co:email,rbox.co:mid,rbox.co:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EB0A71737E

Update sockmap_basic tests to bind sockets before they are used. This
accommodates the recent change in sockmap that rejects unbound UDP sockets.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..2d22a9058a8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -853,7 +853,7 @@ static void test_sockmap_many_socket(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -922,7 +922,7 @@ static void test_sockmap_many_maps(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -993,7 +993,7 @@ static void test_sockmap_same_sock(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);

-- 
2.55.0


