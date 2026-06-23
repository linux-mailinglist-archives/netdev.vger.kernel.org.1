Return-Path: <netdev+bounces-301444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vmwPFL3IOmp0GwgAu9opvQ
	(envelope-from <netdev+bounces-301444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E993E6B949E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=agEVr39L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301444-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC19C31238A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9173911AD;
	Tue, 23 Jun 2026 17:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF13905E4
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237025; cv=none; b=ce1n5GZ0t93D4Xpu0kAzB0DtpW2ZTYuYTRXj7+AvKJVq3MT9vVvJa3nIUPVlX8sP5IMq8aKwOcVL77H+b9b9Bp8R7vZWVzN0g1T1ki6z4U1lcBDlIeYMjj82oIkNy6IbLMmKbbiSAPuUN3sNieA7KUkjG2Tl1FP0fg7OKsP7NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237025; c=relaxed/simple;
	bh=tQS7G3igjqTE5AGoBawXrCKdVpGS19OgIH+yLemhCrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm1HXzLLJ+sT0GD9gNijD/4Dv+BmiRleAewwqZN2YN9AW70lfm5DFL0iZ5WV06ZYrLpq2w3FM1d2scel8qUh+ifRWrXrGlU3HtNMKVVsUvD8vCMxNmzk6q/VOyz3alInucqL2LpPWZ+XWTeOQHfYUqkSWwASi7BTMNvg5aP1vOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agEVr39L; arc=none smtp.client-ip=209.85.161.46
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a0e3a9c3a1so75179eaf.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237023; x=1782841823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjCQl/P7Gd0beihZZQp6q4xIlerD4L/jMZ3FMoPeCaQ=;
        b=agEVr39LalOY5RpnkLWG2XDt/mi+ZugN2yCeIzHHdLRuSyGNB84L1NJeTSc2jhmenp
         LgPAQ/Gw10DnwrPF/g7ch2p+Y7ULwT6hL97HibVOC/RFvcN73OP0iRvrJ0uH4XdwRN8Y
         Ifr+ysaj69Yr5yWHD2m5dTD7UAWtSoQ24iGyLem0Qfwb0c1Lyi7v5DXcyDw2bK2URv+I
         uvQsoo+jEN8thDo7sGyxofLrwn943BuxNUlpO3jsnoxrMIAQ5NpqXgqNRKwErMSxIMqF
         6cMX/GrDD5ohAxgCD38wh1gGQ/XQBgn7GlRGw7NS8RJRGjwL5iTd6GLAmv5foknFaiMo
         4UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237023; x=1782841823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LjCQl/P7Gd0beihZZQp6q4xIlerD4L/jMZ3FMoPeCaQ=;
        b=s1iku9yWac/KCN72AIUl9G1DDe6tlWBAXLjG5v1lzBAe6eGw7UfZVWRqIY6zjXemLG
         BustZ5Lk1xnoOEmSegIwlQq0k1CJ8FeH8B1u85MnLogkHW5i11+SjgKIUycCIbSYusVf
         qnXoRGpexrv63pFSFELL5R4n7UwdMPR1JxJbX8DqW3luoCFiKtY18aglHqwTIWO/oSyW
         VM2Y+Jv2A2VWTVs/CWR4RkYgN7aON7yP3PzjTYysFwF2VniMzkLCaw5AQRyMgjvxyVAU
         GXU/GD6Q1dMTQlPCsgshZuY/40IrihyOvdQiffk705fLD8u3ZNeWAV1HUII83qM7zILo
         1BIg==
X-Gm-Message-State: AOJu0Yxxich1TbFZxSfvfJDOTcoZmX9Kr1lFd374VolxAI1PWJck9LIg
	mJXFy38ODB+HDz7L1PfgHL31QGIDB+11PMXJvZMuz8GgHgigKB8yxkEP
X-Gm-Gg: AfdE7clAlW9dsTsgHSEkYp572gizlqg1ya5xOxO6OUe9vmXI2kshaFi+ksaVvWHT7cJ
	S633GdWFUzZB6JLA/6NGWpa7r2eY9yO4wSCCRnS3F93n4IUnxf/mRiHpGKMmMa+Xl4/3c7Wv1Fb
	zyhxvqNtWPIPrr1h2k2nYkDg6LlpWqaTqqhyDG6oXfIgQPa20Phlw3lk625I/udN8ax5tITzwvZ
	uAQeMYJK+fKZoECED3NrQQwaJRfaSw9y7wSsMWSRfbmhOlH9E3h+TOVWZntlmT+vJI2m5kLOj/e
	XQi+tvWDZsjgHwi0H5pn+Ew5CyX7Fo1NvxDyurgxk1TM/LoG2jZPsiebfXSqUp/DNimbaOijbVU
	DVLtcurUwZfGejnk0m7WZZ7pdmgtHxDQpxKWU6JczxBzWgwN2uo8nY1oyUaDlvj3qYEorDUuzZI
	3aDda6dYK7eRJ2hQ==
X-Received: by 2002:a05:6820:1892:b0:6a0:e0fb:8eeb with SMTP id 006d021491bc7-6a1163e2fdamr2378106eaf.25.1782237022980;
        Tue, 23 Jun 2026 10:50:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44778b6159fsm5202677fac.11.2026.06.23.10.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
Date: Tue, 23 Jun 2026 10:49:58 -0700
Message-ID: <20260623175006.3136053-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301444-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E993E6B949E

bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
options of an skb through a dynptr.

All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
available to bpf_tcp_ops and any future struct_ops.

With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
only constrains kfuncs listed in qdisc_kfunc_ids, so removing
bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
it fall through the filter unchanged, and bpf_qdisc keeps access via the
generic struct_ops registration.

Widening the registration is safe: a struct_ops that does not receive an
skb in its context has nothing to pass to the helper.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c     | 1 +
 net/sched/bpf_qdisc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1dd5e37ae130..f85578772930 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12633,6 +12633,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..5691c13781a8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
@@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
 BTF_SET_START(qdisc_common_kfunc_set)
 BTF_ID(func, bpf_skb_get_hash)
 BTF_ID(func, bpf_kfree_skb)
-BTF_ID(func, bpf_dynptr_from_skb)
 BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
-- 
2.53.0-Meta


