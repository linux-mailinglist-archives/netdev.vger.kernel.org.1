Return-Path: <netdev+bounces-297522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wdOwHg0dKWqOQwMAu9opvQ
	(envelope-from <netdev+bounces-297522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:15:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B616667065
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:15:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sLnfHf+n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297522-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297522-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA050306924C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEA3A7D81;
	Wed, 10 Jun 2026 08:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56C3A4F3E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079176; cv=none; b=TkNO6wN1e3JXGFSuKWvGkeK1CnkXUwPxFNBxYO3cHNanMb4oTZxlCtSjFfepc8dWGd+ypVqjpXIziLC1EIfJ4HrsUBqmlPyOwWCD0Kl5SUxGNjilpz2HsrgPieBfqMjGvqixhMM4Kpry9M+nBiU/b2E5FJ2AIL2Vl9PcFI4Y5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079176; c=relaxed/simple;
	bh=S+x69YITbLsuF4gVxjJS4UgkTpaYc+6Eg485Y1Iqkk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdjnFZHtP+92yUvH/LDngj7JFxHC6puvcNr+kvuNJ7+5RH8IxmsE/YrGanhQibYVdmkL2LdubXwmJQsEnZ9fS0KcXP9zF4xOx7NCS3sxKzvK+3YUbJRwEZs8i1lB6iIVeO9C82kpq5RSjlB0gY3JMiyTI3kT2rOaSJGz2uhDVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLnfHf+n; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so3852038a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079174; x=1781683974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIUSMLxfpzLCylhoWJxQMNLsTqrlPijUzWqPL+Fw5Mg=;
        b=sLnfHf+nJSm/B29AV4fPqP4QJmrgEFdH3RVz+RxI+c1XuCVxGXSWqBWCkMbuQqOkCK
         6jgHDUUkyl02a1ZcXqDFfuQQS93y1DQ+7/e4j1+2jIE2gzT679Y3JCBM6FDwZQQEiQdt
         UXgTtj225cuL410JSEC4S+QpVZr1y/OypHWNIh8oLFQiDZtuEQr2mKr9x7z90XZmPCWd
         sicylnOb0t4fB+M7mOqCqCszSvDINSXuUOF2xWHW11EbZzECGisLFIUYXTZcMt9CYVJ+
         mmlErGGc+o5wll4Sm8OBmAmppuwtVlgzzVyncpIVBZU/CtYzy/SzI/d9W20S/swYlfn4
         VbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079174; x=1781683974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIUSMLxfpzLCylhoWJxQMNLsTqrlPijUzWqPL+Fw5Mg=;
        b=iWzqtyXN+OB42ZRTnd+dhEQts4ezEpjpUlc2pEP6oDd8e/SV5b03MQFcE2DY6eWVDk
         AKYFqYkJAPm8kUVxyf6rchWRFwckzfFpewQZeDu1x3IXHnydLcSMfDZM5P+F8EYgkAR0
         xJJJGF5XO++xHmHUfALkdJuEWVGN7HsfJ2KtkVD86hOxJ6hGZbsIF8UOvk7SAWGn0fWb
         SeugabM6Wo0iCqQ3DglfrcIpFTlgU9wblJpzUGaHTs3CeUDh/a8IMqQBkmU4E7NBcZ2e
         II0djL6wMcS59SfobK0XOrRZVJ9RmBfgw/eLwNJTxAekLlA0Sd6Hap6P+UjliEFjibiq
         CSLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+m1HwMVvGCjrylicFtgYIVgb6BHr4IfO+iOAFRGITlbjBDOOEYx37E1jDuB418xIFftA1AaiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVNirjnG5Rr+vtJfnc7eFTIHWXQ0KCO0zyP7LWsfv1NurZnWy
	r6/mAJgB5TBkPMMkDPKeC6mJQ4sEltoVWk4A2xnf6jmbGAsNXB+LCUlI
X-Gm-Gg: Acq92OEHZSEXRGfaodkzUBER67yTVFHeaMaqOSyQoSl1sosD/kJui3maKPMNb2zZM16
	w+b8gs209SAjNF7qr9h5lsiNFPDokQq260wDC9aIlpRZamLQn9x/ULTNSRWOsHQQuPCEE5k33bM
	/cyVNtYDWdGhvjE6fZdCq3H9WKtf2GqO05AnP9ir2Fq4QeU2I8OjtzuD0SgptXC56UfYQ05lhYj
	CtwLsxKYmyxk2D2splgEScxXppIwjePoO6wlfU3CEpQb4byi/u1C/rA0noRivtyx4cr2T6VCcMG
	lGuyc8ExU4Bz5G1hRyIbAgP3alVxQcUbeqjLtO7suu4QVf1K8VDQf3S/QkkgsE2lDZM00ewj4Sc
	JP+EUnCMY8RdtgvjNj7lVfqM15JCbbZoxi7Z8bL1jMiGWbECkl3SRkDHa2/qFywlGQ+wWTwZXs3
	oZed3YI8dAc8KH9lWnHXcHo1cP66JVpOBOUQ+4yz5eGWE9u4DnJnao5UO2c5+ICRRYwxR/hAiqV
	yvy3zRFds4=
X-Received: by 2002:a17:90b:4c85:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-370f0f459eamr25027703a91.25.1781079174299;
        Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:53 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
Date: Wed, 10 Jun 2026 08:11:53 +0000
Message-ID: <20260610081218.506709-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cwang@multikernel.io,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,multikernel.io,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B616667065

start and len are u32, so

	u64 last = start + len;

evaluates start + len in 32-bit and wraps before storing it in last.
The bounds check

	if (start >= offset + l || last > msg->sg.size)
		return -EINVAL;

can then be passed with an out-of-range start/len, after which the pop
loop runs off the end of the scatterlist and sk_msg_shift_left() calls
put_page() on the empty msg->sg.end slot:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
  RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
  RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
  Call Trace:
   <TASK>
   bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
   bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
   sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
   tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
   tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
   __sock_sendmsg+0x153/0x1c0 net/socket.c:802
   __sys_sendto+0x326/0x430 net/socket.c:2265
   __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Widen the addition with a (u64) cast so the bound is evaluated in
64-bit and a len near U32_MAX no longer wraps below msg->sg.size.

While here, change pop from int to u32. It counts bytes against the
unsigned scatterlist lengths and can never be negative, so the signed
type only invites sign-confusion in the pop loop.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..9cdfec2ca11e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2974,8 +2974,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	u32 i = 0, l = 0, space, offset = 0;
-	u64 last = start + len;
-	int pop;
+	u64 last = (u64)start + len;
+	u32 pop;
 
 	if (unlikely(flags))
 		return -EINVAL;
-- 
2.43.0


