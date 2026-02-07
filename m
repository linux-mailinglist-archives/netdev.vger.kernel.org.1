Return-Path: <netdev+bounces-257761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KFWELlNh2mjWAQAu9opvQ
	(envelope-from <netdev+bounces-257761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E905E1062C6
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAEC53016811
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CE34FF67;
	Sat,  7 Feb 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lYNtmPM2"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFF271A9A;
	Sat,  7 Feb 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474921; cv=none; b=S8hip14EuZOeySH1tTBLpcIk3IEVcqfHXWcclQsc9+tlDXEqpF6llQVJwmSKafPBDb/o/Jy5Es061NgWNpzi6f3sAQ0oU17NUExaxfE2PJnMamMA5/fkR0EkaFOyoWxYuLHF/YHghyKrrR8BbZ0jhNis06NDf1uGk2qJnfzZfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474921; c=relaxed/simple;
	bh=VvRhjH4hTKapCtClYsgBZbrGChd3nVZjJ9WJNhLGvlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VmW35PkUsblbgVgnfUOI6dg8e4hzR85xAunMu4AhLLuy3iwKFAndkjEyyQ5nDHvhEVXGOFEADXXBYZJrGbLwicuYrqDqXINSqRF2aVzW0a9/HugtFMdI3CEA0u05Uhbqip9iPRVt7hyPeYuuD9VRT+QPNMCMR1hJVVoO5kZaVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lYNtmPM2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vojOt-00Airs-Jy; Sat, 07 Feb 2026 15:35:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=bK1n8TnZjOHQM/fZ8MSrVUXmF3jzAmBE7GkteDfxDfc=
	; b=lYNtmPM2lfyMz4BfsjbaRg8M4vdYw/ySfXm6gb0hdHld6xZGW+aAIb4SMZE1NXUmobyUrs6S0
	LJdx+13+o/aQooKF5wdFYPbH75YrX7B4pPLEwD57HQZUYV8ZCE63Liv+vH2comugOYsYCpnkk+6ai
	csLA3yBg+uDkG7uFrPEvGVe7ndZPxoA9G5NI6MRwWmxLqkK0Yrngv6G07/KYmzXw0D7K8+EE6tZjD
	5r8lyRmcCgvChJN+7FSrgEUh4FcQ0gS9ulkXtLKxFeCvV7mqQNtWDX/VBEgRDn+r4s2tn9HRhF+Rb
	daoWISJzqH6Kdm/Y4WO98SNj0qPOJvgvs29etQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vojOs-0005VL-NH; Sat, 07 Feb 2026 15:35:06 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vojOp-006OQ1-LD; Sat, 07 Feb 2026 15:35:03 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2 0/4] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
Date: Sat, 07 Feb 2026 15:34:53 +0100
Message-Id: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBBFr1Jm3SkmgrZd9R7FRWImdUCSMIliE
 e/e4Am6/O/z/9shkzBleF52EFo5cww16OsFxsmEDyG7mkE3umuUfuASeMMksURckjOFMCzzjKk
 IOhLy2Bndt60drfV3qDepQt5OxRts8jBUOHEuUb6ndlVn9b9hVaiQlDNk+7rw7iU2brcxwnAcx
 w9Gtbf50wAAAA==
X-Change-ID: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257761-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,rbox.co:dkim,rbox.co:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E905E1062C6
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
Changes in v2:
- Instead of probing for unix peer, make sockmap take the right lock [Martin]
- Annotate data races [Kaniyuki, Martin]
- Extend bpf unix iter selftest to attempt a deadlock
- Link to v1: https://lore.kernel.org/r/20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co

---
Michal Luczaj (4):
      bpf, sockmap: Annotate af_unix sock::sk_state data-races
      bpf, sockmap: Use sock_map_sk_{acquire,release}() where open-coded
      bpf, sockmap: Adapt for the af_unix-specific lock
      selftests/bpf: Extend bpf_iter_unix to attempt deadlocking

 net/core/sock_map.c                               | 72 +++++++++++++++--------
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ++++
 2 files changed, 58 insertions(+), 24 deletions(-)
---
base-commit: 2687c848e57820651b9f69d30c4710f4219f7dbf
change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


