Return-Path: <netdev+bounces-302263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuznMF3jPmp5MgkAu9opvQ
	(envelope-from <netdev+bounces-302263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EEE6D009E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:38:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=g3vLQTxf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E893082E54
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A373BFAC8;
	Fri, 26 Jun 2026 20:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB603B8921;
	Fri, 26 Jun 2026 20:37:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506246; cv=none; b=gU/+yIIY6NzfsUiBL2zKI/fvWWIKkVMf5Q+SkzXkjpIHrXFnSxXFIuepHwT1hSMvrp3y1GsHaaBCDhXfOZ7t0E6JcJO/4L/7MhJnNATrn6tHawPaGE9LoLb7kSWeB5c5ZQuWxlvbIx1axHA5i12RNPtWkiiFKtm/ovfVK0VFCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506246; c=relaxed/simple;
	bh=pKVjCjcmwgLFIBfm/gjvwtOU+DQ4pjGWSvVcM4JnwZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Um8LEJsvPkrmgLyyLQ7lsv33hfw4zJLl3L7v71ree7HG1xgXJ6eJxQzWZ2vCqM1FNtQys5JJsMUJzDEgtxWjbsyE5qC1EWEJg5Mjok0sPeQrwoH8VxNaglMNXmVqIHLJ6B4gnT19BqjV17w1jmtCQ9rDaXm6RrKIrm3rWnzwBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=g3vLQTxf; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIJ-00AoOX-Qn; Fri, 26 Jun 2026 22:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=ly+rs5U3NFQZDhMCTmcjPlOV6xPqKVnp71dYXhsnJ9M=
	; b=g3vLQTxfMgbgck9LjrMYPOiXAqzvpS1ZvYCYczUpEeiykwFrJADJUOSZCMCAEkPmd+Jg+C8Uk
	G1rXCm21GeRGXULNkp+SXCogNP7fO9zQgcGxhK4uj1jGVMpP/ruwcCYe2V9NQqnsuZ0xeUMitz5GH
	m7/3PbNw02CvVf/yFu9BBLtcRDrNwOeZfi5aOnz6H2a0SSYOqQ521FuQ2K5d65Vi8/AZodKXZY1Ay
	KB1ActC51x9AQnnxzLmLoapiiMk0YRUbSD9X4CWuEFatJ36mARdDWMJEjcUuMBh4s/lN4rgvUpzuR
	7M4A0LgV9Ol70upVBLhNu6cKTWG1enuF5Xt/Gg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIH-0003ZS-S8; Fri, 26 Jun 2026 22:36:58 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDI7-006anB-ML;
	Fri, 26 Jun 2026 22:36:47 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Fri, 26 Jun 2026 22:36:28 +0200
Message-Id: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQ6CMBCEX8Xs2TVtKT968j0MB1oWqShtWiAYw
 rtb4OxtZjIz3wKBvKEAt9MCniYTjO2jEecT6Lbqn4Smjh4EExnLeI7B6u5TOXxb240OxzpKqjp
 UWlKqU1nwOoe4dp4aM+/PD1CugfIIw6hepIftc6u1JgzWf3f+xPfygRLJX9TEkSFLCyaba8IKk
 nev7HzRFsp1XX+eRwPL0wAAAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302263-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,redhat.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:mhal@rbox.co,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25EEE6D009E

Fix for UDP sockets getting leaked during sockmap lookup/release.
Accompanied by selftests updates.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- selftest: drop the original, adapt old tests
- fix: change approach to rejecting unbound UDP [Kuniyuki]
- Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co

---
Michal Luczaj (4):
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

 net/core/sock_map.c                                     |  2 ++
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c  |  6 +++---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--------
 tools/testing/selftests/bpf/test_maps.c                 |  6 +++---
 4 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 26490a375cb9be9bac96b5171610fd85ca6c2305
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


