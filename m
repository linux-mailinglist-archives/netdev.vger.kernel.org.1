Return-Path: <netdev+bounces-305273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FT3TBmqATGqVlQEAu9opvQ
	(envelope-from <netdev+bounces-305273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963B7173D2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:28:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=toXSCDNN;
	dmarc=pass (policy=none) header.from=rbox.co;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305273-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305273-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 294D0303895E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED337BE9C;
	Tue,  7 Jul 2026 04:25:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1A376A0B;
	Tue,  7 Jul 2026 04:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398309; cv=none; b=BIdu7Wfo9QzDbE8WjLqB8ArB49MZY2qogpZD16IzOzzi2jRRFozpVomGd94UpztZgHreJkvaT9C9V0c47q7VgQ/g4yBpxFYLWhnlNExdXInYrUbBBSpaRdTqNVCiYTV6q11Dp//0/+Nj/NBvsX/OptknGC0L2KxB9KFPfB9qzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398309; c=relaxed/simple;
	bh=opHTuuL9qw5T8tWLSEXG0Rt1luagGrS4UY1zmwZHa6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NwHoRgNreO7OFmIs+TFlt9vi2ji15Bq5HNZhrX95astN+EHJHVQHi5ZcvbXUR3rBq3Q7Aae4+YmyssgeHJS95dKsK6lm4Qqb3LrD+8Oipb4QAFzNmMgRufQoE5oQu4GRwIbpisNziWpGb0ZuBRCqtDXlXMG+fwxXexhLExYZLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=toXSCDNN; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMa-00DUhX-Q1; Tue, 07 Jul 2026 06:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=VEDYRANxd2n4E7p/Uqpqw4YEwTx+raQSJRg3dXH1x+U=
	; b=toXSCDNNz9MfJeIbpiWA0UzebKuDxG6j9ppanpNhNsEqgCZ+XMZ3NFXtszEoNik73B3kv54DB
	RN6tDStprnMIPPpYSBOWxB7EJCZp0DjXyMPOtn3a+gxb84ZGBYtSq3OoU95LWZb+b9MtQT3+3V8fE
	y6u0DcRa0T2jA5wNsfRlAXi9HGXhH5/gg54hP5zqMGLbjlZDD6CGS6p3o4C0+L3fVqQc5Zy+nyNaf
	lu3Tj6fsn/pXA7CwRv2YQh7+Wc5rwNSypTyziOvSQZh9ORTcYTPkq4mYR9Y9DUwdWi6kNu3n58/EM
	D/WJ+XxuwHth2bVEY7jOOui4CpfSO0fjAg8A2Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMZ-0004lH-Bi; Tue, 07 Jul 2026 06:24:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wgxMO-00Ctdi-HG;
	Tue, 07 Jul 2026 06:24:40 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v4 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Tue, 07 Jul 2026 06:23:55 +0200
Message-Id: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6DIBAF0KsY1qUBRMGueo+mC8WhUlsxoMbGe
 PeiLmwX7mYmf96fkAdnwKNLNCEHg/HGNmHhpwipKm8egE0ZdsQIS0lKBfZW1e+8xS9r677FfRl
 GyGtcKA6JSrikpUDhu3WgzbjKN1S0Gt23o++LJ6huMZdYZXxn3WftH+ga3qpYfFg1UEwwSSThO
 ouJBH51hR3Pyq4dA/tV0mOFBUWAAEaoyhKa/yvxrgjCjpU4KFrLEqSQjKdyV+Z5/gLSI6/LXwE
 AAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:mhal@rbox.co,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7963B7173D2

Fix for UDP sockets getting leaked during sockmap lookup/release.
Accompanied by selftests updates.

Two Sashiko's concerns to be addressed separately:
https://lore.kernel.org/bpf/20260626205814.BAC3C1F000E9@smtp.kernel.org/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4:
- selftest: drop redundant `if (err)` [Sashiko]
- Link to v3: https://patch.msgid.link/20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co

Changes in v3:
- selftest: better error handling, ASSERT_*() macros [Sashiko]
- selftest: fix grammar, reorder patches [Kuniyuki]
- Link to v2: https://patch.msgid.link/20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co

Changes in v2:
- selftest: drop the original, adapt old tests
- fix: change approach to rejecting unbound UDP [Kuniyuki]
- Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Shuah Khan <shuah@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Eric Dumazet <edumazet@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Cong Wang <cong.wang@bytedance.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Michal Luczaj (4):
      selftests/bpf: Ensure UDP sockets are bound
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

 net/core/sock_map.c                                 |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c        |  6 +++---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 tools/testing/selftests/bpf/test_maps.c             | 13 ++++++-------
 4 files changed, 22 insertions(+), 20 deletions(-)
---
base-commit: 17566290dc802b03a8127729b19c5962d63a7947
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


