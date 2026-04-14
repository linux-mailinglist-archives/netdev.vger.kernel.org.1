Return-Path: <netdev+bounces-278471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OP6KLJL3mkzqAkAu9opvQ
	(envelope-from <netdev+bounces-278471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC033FAF3C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBA7C301C5F1
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C23E717F;
	Tue, 14 Apr 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="nmoNkIKw"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A973E867F;
	Tue, 14 Apr 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176042; cv=none; b=uP+2FtWlae8HhC+IEiPJC5CTni1qQOiApAHjN77lk9HHmyuxixG0XxiEPKrg9iORpo2PS1zaY4YzTDKbycGvkvmQxV7GKjo0iHlwNOrSwlsHRbyeCqgUFh+ZI5Zu34vHqYyqFbTIQuSJEIKjOc/taXR1C0cz2JndNXtnrwUiaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176042; c=relaxed/simple;
	bh=xj9pUya5DRk6xrlAWUYqxjpSpcrRTIPYrDQmWtkDJAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PIBLth/kW+gnwWCUop7H8LcNEbLzV6LZDfFz1lkNifs8eRXatwcaBMXb9MMiOV7aURB9hYgSRdHFC2OhqWDbFxHnPxYu3nCs/TcTvHe0OFzX/xIkYRXjTjmlvtPcrtLvlycMxRlYroR9nQhqReumAJtUNKTP6OC2Y5igX0Jr43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=nmoNkIKw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWO-00Fdqd-IH; Tue, 14 Apr 2026 16:13:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=wg8YTxZZZ0aBAF60rNfWCIPwUzWH/QpbjE2Qtc07f+o=
	; b=nmoNkIKwz3/gXR/2holNt66mgELdYed0PSHFweG8/saAL49GSWtrtUnhrkWh89jQnRLWsM3MC
	O7AjRbNurCpf2r1TUxmKq2SrIY8RLs+jzivI3B8/5pyo0Acl+knN6bcacN0cp738l4A7WpjD2REjg
	TetLCN6mkLvJHKOfH8ET8sIcI2R99kZMt33ow2aNPeLDzRmuJ6WPTqWArCR6KTK6KB8abwRj0Vd6D
	tMRSREEZoVUKEV7BKwUID+pLMQ+y+EkHOPcmHJMeiJtOPzsaJe6e8U4N9L9L22ABr42eFMGikxdz8
	j/8VGe5EDn4A7WELbIsU3llSRqgeCN+x7cFyYg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWJ-0000UL-5R; Tue, 14 Apr 2026 16:13:39 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeW8-00DhbX-KI; Tue, 14 Apr 2026 16:13:28 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v4 0/5] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
Date: Tue, 14 Apr 2026 16:13:14 +0200
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQrCMBAF4KtI1o5MJtpYV95DXDTJRAPShPSHS
 undDd0UXHX53jDfm0XHOXAnbodZZB5DF2Jbwvl4EPbdtC+G4EoWhFShpBqGNkyQcuwjDMk1PUM
 7fD6Q+gyOM3uoGtJKGWuMv4rCpFKGaZ14CJO8eJbyHbo+5u86O8r1tH9hlCCBpWvY6PLh3T2bO
 J1sXOmRNo5Q7+AIEGqPtVQKWds/Tm2cwmoHpwpHHq0+S7QXUhu3LMsPStw6v3EBAAA=
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
 Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
 =?utf-8?q?=E9=92=B1=E4=B8=80=E9=93=AD?= <yimingqian591@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,rbox.co,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EC033FAF3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Updating sockmap/sockhash using a unix sock races unix_stream_connect():
when sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4:
- Circle back to v1 approach
- More details in commit messages [Martin]
- Make unix iter take the state lock [Kaniyuki]
- Link to v3: https://lore.kernel.org/r/20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co

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

To: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Yonghong Song <yhs@fb.com>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: KP Singh <kpsingh@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Hao Luo <haoluo@google.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Shuah Khan <shuah@kernel.org>
To: Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Michal Luczaj (5):
      bpf, sockmap: Annotate af_unix sock::sk_state data-races
      bpf, sockmap: Fix af_unix iter deadlock
      selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
      bpf, sockmap: Fix af_unix null-ptr-deref in proto update
      bpf, sockmap: Take state lock for af_unix iter

 net/core/sock_map.c                               |  4 ++--
 net/unix/af_unix.c                                |  9 +++++----
 net/unix/unix_bpf.c                               |  3 +++
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ++++++++++
 4 files changed, 20 insertions(+), 6 deletions(-)
---
base-commit: 0f00132132937ca01a99feaf8985109a9087c9ff
change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


