Return-Path: <netdev+bounces-264578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H9ACf8SqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96233219534
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901EF306340A
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A330368260;
	Thu,  5 Mar 2026 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="m5MfTKrx"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D17370D58;
	Thu,  5 Mar 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753518; cv=none; b=Xk1aA0C/Lhiicq1Q6NEjpdc7gmB7Qw/lEJRFkcCmgfTTYFi/4ZW2gPhaTmFNWV9JLCA3fllz3Eg/91/RPDXDKBN0idbnwDYr0aUtpVwEugc3CDJeWaxylZdiKZXuo7m6XEmV675aNkTLHwFKPe/QggY2AaSe1PkWsa85TjI6U8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753518; c=relaxed/simple;
	bh=2Zm/vCX44tIBrhELnixLBqeJIbGLvACyZtaY690h8HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u784dIkG4CErhx1hv4Pe56/6jkz8qbGkY62rso2OcXN8EJ1tPqgvPVY+MQULj1OK9wpQckuRMXGzSlrx8r6ww9Rq6UWzU3ln/5fG3CSxW1zEJnj874UTrjO00411eacy0NylZS5WfUp62AvqHwxxT5xt0FHuYBdTvCIDlpeMkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=m5MfTKrx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAN-0012ti-Cy; Fri, 06 Mar 2026 00:31:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=0I2f/edEHXIoyj0ttAeBgrnGW6xqGgd7wHIhUGIegQk=
	; b=m5MfTKrxyUc2VWbJFWBQS9fCGn0V23ugHm9EcmDx/+41nYLx/UWDzP/drFwN+PG+La33cmXse
	5/jTv4/1UE9BrOsJqztkdsT5ek+RnBYcnbW8vCIrU8Kgdru4Y6VpH/NaFFvDpFGVCLr+j4FNORXEI
	jf3VcXaAQp0hfO39KVQXtZAxVO+/ZucNU5BdanzkkYqd6ZHC6oSM9qk0kaj8v57gh/6r7sboEvp8n
	HP6U0pPrINYTV0Afqu2YwSFc4NlwwGmxyegqeGH9thkRcTrT565bIrz+LsBcsixSoqhP7UuC+yAqc
	3OFzGBdSLx76eeiZ23bFBraV+H0gE9FyxH51hA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAM-0004BW-IH; Fri, 06 Mar 2026 00:31:38 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIAG-00141B-3I; Fri, 06 Mar 2026 00:31:32 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 0/5] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
Date: Fri, 06 Mar 2026 00:30:54 +0100
Message-Id: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NywqDMBREf0XuurfkAaZ21f8oXRhzUwNiQhLFI
 v57Qzbt0uXMMOfskCg6SnBvdoi0uuT8XIK8NDCM/fwmdKZkEEy0jIsOl9ltGKLPHpdg+kw4L9O
 EIUc0FMli2wslpR60tjcomFBKt1XFE3Sw8Crl6FL28VO1K6/TecPKkSNx05NW5WHNI2q/XQdf0
 av44QRTJ3ACGXaWdVxKRmr4wx3H8QVsFcVhIgEAAA==
X-Change-ID: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 96233219534
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264578-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rbox.co:dkim,rbox.co:email,rbox.co:mid]
X-Rspamd-Action: no action

BPF_MAP_UPDATE_ELEM races unix_stream_connect(): when
sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.

BUG: kernel NULL pointer dereference, address: 0000000000000080
RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
Call Trace:
  sock_map_link+0x564/0x8b0
  sock_map_update_common+0x6e/0x340
  sock_map_update_elem_sys+0x17d/0x240
  __sys_bpf+0x26db/0x3250
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0x6b/0x3a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Series fixes the null-ptr-deref by teaching sockmap about the
af_unix-specific locking. Accidentally this also fixes a deadlock.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Drop sparse annotations [Martin]
- Keep lock_sock() along the unix_state_lock() [Kaniyuki]
- Unify BPF iter af_unix locking [Kaniyuki, Martin]
- Link to v2: https://lore.kernel.org/r/20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co

Changes in v2:
- Instead of probing for unix peer, make sockmap take the right lock [Martin]
- Annotate data races [Kaniyuki, Martin]
- Extend bpf unix iter selftest to attempt a deadlock
- Link to v1: https://lore.kernel.org/r/20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co

---
Michal Luczaj (5):
      bpf, sockmap: Annotate af_unix sock::sk_state data-races
      bpf, sockmap: Use sock_map_sk_{acquire,release}() where open-coded
      bpf, sockmap: Fix af_unix iter deadlock
      selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
      bpf, sockmap: Adapt for af_unix-specific lock

 net/core/sock_map.c                               | 60 ++++++++++++++---------
 net/unix/af_unix.c                                |  7 ++-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ++++
 3 files changed, 51 insertions(+), 26 deletions(-)
---
base-commit: 56145d237385ca0e7ca9ff7b226aaf2eb8ef368b
change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


