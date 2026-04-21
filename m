Return-Path: <netdev+bounces-280183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBptEtKf52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B606243D1B9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C983076CAB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D0364949;
	Tue, 21 Apr 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fChs/fI9"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41D3644BC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787198; cv=none; b=Mxu1cDmBrd5AiOZ7OgiHGjDGk9zFu7LyLdj5sYLCmO8WbaY+stVlnBD5z8SIP9ZgzY35wRN/4eS6tK6UeMjb+rpVDh7IvaALMJxRLSmzKPJ+U+RoejEZwlRSNjf2NfLTinR+Xx6SQ56K8XW7S5SPptX+z+9gBYyoY78mSoky550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787198; c=relaxed/simple;
	bh=SWb2WR4cv0tgGdl6YMq4mlXq+3AHLn9iSZBZQtWSVVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU3oT/xt8tbs4abJuquNUkdgToSQwuVLA+9D75zmN4dqMfLRyJa6YooUcbUeUVqZ53GdOSYOLOL0qptBPhZKFkpeiX0pX4mZL5T+yV9f11J6WJFbubrg0onQeJdN5AYiUrn6UvcvMa5ZYwIMb0sP9VZpVlsinmaqmp4ezoaBf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fChs/fI9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7vdOjflaIY1NUfTHdVQ3+OJuS3RoXj7+ev2ZQFb23E=;
	b=fChs/fI95OAswnfJx+mWzguYQJEC9vOCZBMM4so0x27mvwZUlFnVYvk/YKdPNGP+ruS2LH
	G3oXP16K8MCH16FIQW5S9JE19xFHur8A9pMQLDjwYPamEM/eNzOkstndLQPESlOAxw9Ef8
	ucYK3SEW/2lvJ5i+1u8T1D+wnkWql6g=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY
Date: Tue, 21 Apr 2026 23:58:04 +0800
Message-ID: <20260421155804.135786-5-kafai.wan@linux.dev>
In-Reply-To: <20260421155804.135786-1-kafai.wan@linux.dev>
References: <20260421155804.135786-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280183-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[27];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B606243D1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a bpf_tcp_ca selftest for the TCP_NODELAY restriction in
bpf-tcp-cc.

Update bpf_cubic to exercise init() and cwnd_event_tx_start(),
and check that both callbacks reject bpf_setsockopt(TCP_NODELAY)
with -EOPNOTSUPP.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c |  4 ++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c       | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index f829b6f09bc9..4f632aa3a79e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -112,6 +112,10 @@ static void test_cubic(void)
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
+	ASSERT_TRUE(cubic_skel->data->nodelay_init_reject, "init reject nodelay option");
+	ASSERT_TRUE(cubic_skel->data->nodelay_cwnd_event_tx_start_reject,
+		    "cwnd_event_tx_start reject nodelay option");
+
 	bpf_link__destroy(link);
 	bpf_cubic__destroy(cubic_skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index ce18a4db813f..b941ab3ebad5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -16,6 +16,7 @@
 
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_tracing.h>
+#include <errno.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -170,10 +171,17 @@ static void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
+bool nodelay_init_reject = true;
+bool nodelay_cwnd_event_tx_start_reject = true;
+
 SEC("struct_ops")
 void BPF_PROG(bpf_cubic_init, struct sock *sk)
 {
 	struct bpf_bictcp *ca = inet_csk_ca(sk);
+	int true_val = 1, ret;
+
+	ret = bpf_setsockopt(sk, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+	nodelay_init_reject &= ret == -EOPNOTSUPP;
 
 	bictcp_reset(ca);
 
@@ -189,8 +197,12 @@ void BPF_PROG(bpf_cubic_cwnd_event_tx_start, struct sock *sk)
 {
 	struct bpf_bictcp *ca = inet_csk_ca(sk);
 	__u32 now = tcp_jiffies32;
+	int true_val = 1, ret;
 	__s32 delta;
 
+	ret = bpf_setsockopt(sk, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+	nodelay_cwnd_event_tx_start_reject &= ret == -EOPNOTSUPP;
+
 	delta = now - tcp_sk(sk)->lsndtime;
 
 	/* We were application limited (idle) for a while.
-- 
2.43.0


