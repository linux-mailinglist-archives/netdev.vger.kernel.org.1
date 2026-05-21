Return-Path: <netdev+bounces-290469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE/fE/AWD2qVFQYAu9opvQ
	(envelope-from <netdev+bounces-290469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7475A7498
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C67B33817A7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1553E1D13;
	Thu, 21 May 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+6brNlC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5F3E0245
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371598; cv=none; b=C7TcF72LJj3CWCn1zcqCehpH2WjaGXEICoqhMqgjQ3tklK/vOWSajQNwEM5sHlzo8HSYvpuAnn2PFygO5yb4S5Kq39gMEbEfY5DSIULeEbtGGsqY1CR1c519pNrTLqkQ1CPwgOTAGdpr96OniawEfRkn83s6CeXkwTOsMpkJ1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371598; c=relaxed/simple;
	bh=DOfWH6hLKc3o9vRvYL5MSuCO1dG989HvIXld9/XiNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pA1bHC+hg+VgM31UD+NU+puCmf4qgI1TCcV8sdjZf2PagHJ07u8S684/B2lxdpR7HC4hh8hOPGst1K7Fz5jMacry4KKgGRkv2nj8/khzITr47EZcAeimHtP4eC7iWp+jqDhZBmhLcWBH91aJ0ABuJ0kZwXvHl0ILlGne91FpWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+6brNlC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b941cd869cso39113385ad.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371597; x=1779976397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=Z+6brNlCk8rg9zkj6XMWn5GlJ9sjPv+cecp+klRYajWObFN9dCivmMefFXbsAe94DB
         2nNtlL1jhbbzenp/yZLuK0D6E97BIy3KV2pFO4eG9iFF7f3sm2QggLq8wSSz+Zse11wx
         NteAC5HVtgq+amX3HdvGLB9a7nUddfNg7YABXFQlUzvu8Ajhz7g3Fv4dKbYzDKKHnR+z
         aI5FVbzigvxocHsXxhtK8sfGtXaGNszG72fIE/TP4XRbQDQO6IgNFDnb9bHNjQaP1kiT
         6dmFmlx3NAitTg2uYRotVofLZR2GUbfsv6ofB0zjOJS4qrFe5VCPqKy78UUmR5y3ik0C
         fH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371597; x=1779976397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=N4Cb4qxn1VlJhtwKOoU6N4Ue3mnaz4j3wpvfNoR0/pjEm1wsntZr1gP3fVAbcV8qQh
         9b7m8L2x9OYbHy8cFIP0flWz9mQjpK8LaFnWMcI+YSFGLwuRRicmUXihLGzeICjG7CIF
         UDibhGesQJ8SQ4riwwMmfD+FqQLjVErzQh2H2axxPP1h9d2LghiXDmY2lx3jmkM/dlJb
         Rdjm0TDNxlzoM12Ute37El+7dA1vOuckk+kwCJMaXvVwKigbXtjPp57wIDsCIl5MaT4d
         nn6/X/FjMMA0bwrAzWxa4lIpiUPZ4j/rkXZb/DNqjjIRfddsOfcMe3g691j7iRg3wpkl
         hSqA==
X-Gm-Message-State: AOJu0YxCGlCPqiRme7w4eJktZH8eVbBYwsPPsUct4RhDN4qa6mA3wEAO
	GSGlKH7ciXRglmkA8G4DENegVtW9JPszYxWbrIpwgqn4lFNUBSYsxXpk
X-Gm-Gg: Acq92OHgbt5t6FTSXW2VbbErHH8deJJLFpxEM0R8NQruTOFHz0IQihfhij+8eGyPx1A
	95OyrxHgGQMxzHSf7/bachi0QhucXQKL3kUD/TMso+480I+X/kjTmqBSPoqOmuA+/45QGl/vESr
	XU8SnvJ4FBervVarAnmFIYisaotDCmd3r9+IF/jgmOKK7f2LejPr2NkEpKk/cbzsGhDH4oeuJro
	NmC18OSte0K+L9K5/MbADgS4qYFgS1G5KQvLzBtB7giDk4iF/tNdEJvkSDx0vKzb60JKUGgkUbV
	UK15Q/5cvjrWOE9gma7HmYbLZNyjM4xuKT+AyPE4tZVbTwlJJkVrXXWywkxpCjiMrKUYkaOLW7p
	bYIKtAVwuiM0E/4r2q0s31kJeGr49t4GhBDUo00BAxoIQb+DoPl3AxvJVpl9bjRK/yN1fKQ382+
	ubxx3xWUHZdyx0AnGTU9FaAy1q5PWIZQYeYdpOzvRvBgprV2F7+hFXfNQy6LfxNFfu2Kg6VJoJZ
	hnxOEs2ioxzcEn571iBwX1t1ChooZQ=
X-Received: by 2002:a17:902:db07:b0:2bd:e01d:eb25 with SMTP id d9443c01a7336-2bea308aab8mr32286875ad.32.1779371596913;
        Thu, 21 May 2026 06:53:16 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
Date: Thu, 21 May 2026 21:52:39 +0800
Message-Id: <20260521135244.40869-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: BA7475A7498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
populated by the network stack uses ktime_get_real() which is in the
CLOCK_REALTIME domain.

In the series, kernel reports the software/hardware timestamps through
sockopt and then userspace bpf application gets them and calculate the
delta only through an unified time unit.

However, prior to this, when a BPF program tries to measure RX packet
delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
is incorrect because the two clocks have different epochs.

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..863645d096ef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_get_real_fast_ns();
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7


