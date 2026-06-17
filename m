Return-Path: <netdev+bounces-300100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 492BM3lsMmruzgUAu9opvQ
	(envelope-from <netdev+bounces-300100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC2698067
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P2uObVUW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300100-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66570323D92F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BBC3E121F;
	Wed, 17 Jun 2026 09:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39F3D7D77
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:36:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689015; cv=none; b=g8CdrRk4j/sNK4fOb5EFF3pT49XHSo27yclL6iKG9GzVbDnZta8D+DrzGYIE3nKTI9zT15cpYxCNDYAQOUe4g7G3Ve21rgytvlAeUZQ5GbTJf/XNX9N4XRVl9lOCyhsr5NLkcGLPjXoQHDoVz8N+JP+mBeIyLW7uuuGU9EPrjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689015; c=relaxed/simple;
	bh=PdBtwKgFqyMGtomh7hTUPsscrriY96d4wUo+kESMV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJH4kTXpsWTzxvp1M09WGDKJCg6YQ15TN8D8VQwADjyVRMxUzRs6aAcgnQy/lhE+i1Aainw/Nt+ycD3bT9xUUwB23O2FVwaxgZxS+7XH5xt2xBW90m4Nt2sVOtXi4hzZ5AWzke52b74oXJnXPnYAq4nlQkz7zMKOWWjliXPuapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2uObVUW; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84231305a80so3238676b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781689012; x=1782293812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HGsJuBJyPxuBJWOZpUxJqFkb8helZpMElVirEJAoUU=;
        b=P2uObVUWQDzWZwNk/QWV/rrp23bBAIo0SmfraD9noK8JbCi5hI7Xfwfx3xgUlTr3FM
         EV+wjcIPCWnstK6iSe5US6+Ocy92HHT8Bu5M2Xw3Id1pFJkj2gAZG05WwZZ2OLBX9xmn
         rK0yINbI+f30A3e5dUgnRcOYh8VRa+mQtivTpOsD/2QHcwhP3bpXABdzj90MvpQ2l/5V
         cvwzccJKCr+kF00nPKW8Dms9R44mUHW4cc7oTaSaVUOxD2W0zMfcnEQ6lfND6w4PIrlT
         GbE+KdD/CwjzAONSCaYe8Q+VHYKIsy2q0ybc3hqoSdyxJkfAlPQEZkv1APeNFRIPkgu6
         Hw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689012; x=1782293812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HGsJuBJyPxuBJWOZpUxJqFkb8helZpMElVirEJAoUU=;
        b=YkcxIpBbvo6vRmm1MyoCLGRFRXnGHPjkIVHY8hL880jejeMuSVvlXmL43phlIuZMvj
         Ukq0gLUvS94/OpFTEEFS4M5WNQvrple/XTgR1MXR22IqBNqmfUFs3v1p1pushQLc70Gy
         6DQwRbHhhiisrfa+cAZfhRhYy78cU7Ds8UOXjsvLLVPzCbBEgFxYc6eFDVXY74FfDgOs
         6zb3uHy/L6CfuMFPSSAZNSogbko/nR+zJ2HzyJftf8zq17cFwiq5nkQFbLv71/tk95Nf
         3gcCirGY2EN+NnP1bwBt5NaJ+/Z/7KiM1JMibfhm1RUdF0LhtMZHbCfAiNA4dNtl3oUY
         lPhQ==
X-Gm-Message-State: AOJu0YxyWNNpMMXiZvnIQqyFW/Mek8w8zki+lTvaWotuNqIS/7j4/Xv8
	fzsew7W0YC/JyQTjuR+fYsR5PFmklqh6/m3nH+3NHLEmhRJ3Pp1Oz8mZ
X-Gm-Gg: Acq92OFkaRf0c29bhXqPlIsR1ByZ93cNRfVNOO8T62ostWEYR6O4fpUqGuqva+h2nzo
	huElajJQQlYVnLLLlze6tVfGdM9EwDguWXS1xrMGixljCPOH8465bjHjybvYJYlHf8RlxtcuXA9
	Anxv/SRkb+DhztBQ97a4JpJCZxNKublDt/tuov991p7TdRMeXIevCoTiiXQqG46rVKZz95MeMti
	lLdWXv4vc2Lsc1dTIUv0S3lFu/fS2ktx6HfsuAicc0/MN20H2ZHGPm31H0a11E8M+fT0aM7xw57
	sXbCdOlWCQOqnmN3Ay6FbAHKgqTnEI6ZUAGvyQl8rqd6M0aZ3F9rjGwf7mHj+/cg8aaED9aBy5W
	BND9ww1QxinWVsJiKHBjle1l019CPqAeFEzF0yiCNlSKWKWkO/yNAkpQCejBveyUTULmPIlDa+A
	2TbmKkmnk6uw8XpSCnpNXgRz/SyzDeostK+sEhaKIz0Kwj9zd2PdMiXYYtj5+2YqU=
X-Received: by 2002:a05:6a00:3697:b0:83f:250d:59c with SMTP id d2e1a72fcca58-845245b79e6mr3179862b3a.39.1781689012085;
        Wed, 17 Jun 2026 02:36:52 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::206b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm15521653b3a.48.2026.06.17.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:36:51 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of non-linear test_run output
Date: Wed, 17 Jun 2026 17:35:57 +0800
Message-ID: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300100-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ctx.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43BC2698067

prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
for a short data_out buffer while still reporting the full output size
through data_size_out.

Add the same coverage for non-linear test_run output. Use pass-through
TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
and a 100-byte data_out buffer. The expected output spans both the linear
data and the first fragment.

Verify that test_run returns -ENOSPC, reports the full packet length
through data_size_out, and copies the packet prefix into data_out for
both non-linear skb and XDP frags paths.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 01f1d1b6715a..9cc898e6a9f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -4,6 +4,10 @@
 
 #include "test_pkt_access.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_LINEAR_DATA_LEN 64
+#define SHORT_OUT_LEN 100
+
 static const __u32 duration;
 
 static void check_run_cnt(int prog_fd, __u64 run_cnt)
@@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
 }
 
+static void init_pkt(__u8 *pkt, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		pkt[i] = i & 0xff;
+}
+
+static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+
+	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &skb;
+	topts.ctx_size_in = sizeof(skb);
+
+	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
+}
+
+static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+
+	ctx.data = 0;
+	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
+}
+
 void test_prog_run_opts(void)
 {
 	struct test_pkt_access *skel;
@@ -69,6 +136,9 @@ void test_prog_run_opts(void)
 	run_cnt += topts.repeat;
 	check_run_cnt(prog_fd, run_cnt);
 
+	test_skb_nonlinear_data_out_partial(skel);
+	test_xdp_nonlinear_data_out_partial(skel);
+
 cleanup:
 	if (skel)
 		test_pkt_access__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..cd284401eebd 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
 
 	return TC_ACT_UNSPEC;
 }
+
+SEC("tc")
+int tc_pass_prog(struct __sk_buff *skb)
+{
+	return TC_ACT_OK;
+}
+
+SEC("xdp.frags")
+int xdp_frags_pass_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
-- 
2.43.0


