Return-Path: <netdev+bounces-271118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLKQCnCswmlBkwQAu9opvQ
	(envelope-from <netdev+bounces-271118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:23:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C4317EF7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08831301AA47
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35684402BB9;
	Tue, 24 Mar 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLwZcOa4"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF5402BA0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364721; cv=none; b=l6BHxkjuwyEHthqZaXcpu1bh0+clmQPN3iP2Fl5vDSNkwzEq9ImmSuqf3ehBv7rF9ci4Ov6WIWfu14oUQQkgun1M8NoyZulNk632JRP47BsPR6nguWaBheWaAQxoOT81e79XDa3yoaEnwa6x0IMRXEm5D2KAIWTtGP3ACFAxTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364721; c=relaxed/simple;
	bh=EoNw4rON8XzaHA0uEutSrZfbbRMvyo7PgfPlOdOBkbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skv3Hb/CMMQJ9DsTfWXdYGuNHcOvBjkstaxsVPWY5k9W2YXVoAKSonitEqD1mLqYAhNofidSbd64W+Zp7sWb9eqyktmRuqFiStz1vco25AEebC8uT/nj71QDosl1fTdKSwvlIjdeIg9PkYFZl1QrWMiFnGPSZW+l0tVWIxOXc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLwZcOa4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774364717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mp06N+shbK0OmAG2sS+vpYyT6SVE6VmkZ+2R/SmM1WQ=;
	b=dLwZcOa4xkEdhUf8UK6PH6sByGiDxFH8LC8tvgwRrebJIQTl10z6/LEaaCEj6kpA/euVLE
	2OOI+3j359tGPdQ6uAtjTu+8uZoSP7m8UVVyoFszGCnjwPdZ5UPVgae3hNRJyUrm2FtSet
	SzDGUyuf9NGwOhonGmqp0osNSd3/lMI=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Enhance freplace compatibility
Date: Tue, 24 Mar 2026 23:04:41 +0800
Message-ID: <20260324150444.68166-1-leon.hwang@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D4C4317EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The potential issue of kprobe_write_ctx+freplace was mentioned in
"bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs" [1].

It is true issue, that the test in patch #3 verifies that kprobe_write_ctx=false
kprobe progs can be abused to modify struct pt_regs via kprobe_write_ctx=true
freplace progs.

When struct pt_regs is modified, bpf_prog_test_run_opts() gets -EFAULT instead
of 0.

test_kprobe_write_ctx:FAIL:bpf_prog_test_run_opts unexpected error: -14 (errno 14)

We will disallow freplace on kprobe programs with different kprobe_write_ctx
values.

However, xdp_has_frags does not cause such severe issue.

The issue of xdp_has_frags+freplace is that it is able to break the backwards
compatibility of XDP.

At the commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check"),
the backwards compatibility was protected against tail calls, but it missed the
freplace case, which is also able to extend XDP progs. If xdp_has_frags=true
freplace progs are allowed to attach to xdp_has_frags=false XDP progs, the
backwards compatibility is broken.

We will disallow freplace on XDP programs with different xdp_has_frags values,
like the way in bpf_prog_map_compatible().

Links:
[1] https://lore.kernel.org/bpf/CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com/

Leon Hwang (3):
  bpf: Disallow freplace on XDP with mismatched xdp_has_frags values
  bpf: Disallow freplace on kprobe with mismatched kprobe_write_ctx
    values
  selftests/bpf: Add tests to verify freplace compatibility

 kernel/bpf/verifier.c                         |  12 ++
 .../bpf/prog_tests/freplace_compatible.c      | 124 ++++++++++++++++++
 .../selftests/bpf/progs/freplace_compatible.c |  40 ++++++
 3 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_compatible.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_compatible.c

-- 
2.53.0


