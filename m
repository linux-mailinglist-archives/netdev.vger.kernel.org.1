Return-Path: <netdev+bounces-251678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK4PFHomcGmyWwAAu9opvQ
	(envelope-from <netdev+bounces-251678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:06:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB844EDDF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C124356C00
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE52DF6E6;
	Wed, 21 Jan 2026 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W42p5o1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD229CB24
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957556; cv=pass; b=hkBn8qMXmyZwivw1ZXr/7bNIIpEsaFBEisHUGhRb/EJnvlqoF3PPXak0LOuNh7ch4rGjxiBPbeN3XlsryzW7/fZba6MVNaIW4BvnFcrO07oi6wK5id2J1sU07YtTCfoe68ibxyYYaw7/ldJrN+n8rgQX4uBy1GtUdVGkRCgTquA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957556; c=relaxed/simple;
	bh=8pqa8OYjP+H2tR1BiFys92JI6YisCfB390EDUyM1WRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnTctHhTrpmDsi2iSnNxLv6sgDiPwdt9vSGvP4j/nqynptfixMSP9P/sdfDd4916UDuecThqQW73nD2D8YxNLCanMeH1PXgQXWFbciWuOme4OfMLFKA8yNeiv3hiiGA2OotL2+3BaOr2xpgEIF9dZEjrS6N9TmreedjLdTGPIqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W42p5o1n; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so52965ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768957554; cv=none;
        d=google.com; s=arc-20240605;
        b=Vn2Mg/4bT0RucJVsv4Mc9T8WSkFTO76E4bZd5mKKFiaOpC8S5s4at3BP7ltqK5jLd8
         yNPXlZ3mdqRo/6gebOaqwDLz+4iniOo5JaG4J/iD+R9YnyTNM7it5Ms1ymyJF41FYhCX
         PYBeW1e4H4r5sQtt51Ptc2/iq6r1DLmwqhyZL4buFStKX5c8E66tRNVED2kZWFwko4HL
         I9YpTjP0quRCyk69hbPOE/fpmyLEjy2UgArb2t8aB6rWt1s23UTPfBy90dIEOOGT0df1
         G7vy+A5FKZyVCWqMKcqAiEuoPbyJUxNkr9G/LN+FC/V3EtgZGPyplUftSeDNpMI/GRip
         DjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        fh=nmL9j9GXIfL4MEniDenG4JByNS7WuiVFgTzNBgzkpgU=;
        b=QOrQPCJRbogWFawxhrgJf+cMArn4lDsmhRlq74X7XoyIfqX7iN4OAU5BON3XgTDc7z
         85EVgfD/C9qu81rErwrZmvBwjYB5TqwaCOQ/aq+UkRyYqKE5qcD1JftMPmXGXbQ0XyeG
         5yCcmKnywKwnN6kMsVM+2obY64Cnta518QCmp+lPKE9NwND7BtFa8nfP6pahOCjytfVk
         eqCmbrECvqmY7/vtuHsCeW/WAaLtJqs4Aoxg6Q4vHneHmMqHjzcxHl6QBCzxVns9FZ9j
         lpy3k+AyhTStotelJgrfLE5FjaW92qtx3bP3Ils0zzFBK0I0fGjf/HKmoCasuRlxPZrL
         zNzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768957554; x=1769562354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        b=W42p5o1nHPSQpoaK0IJBSSLyySjXHyKLfNEE5sAViaNnHBk3vt9VUKXezBYP67iBWY
         nmkS//o/6iL9trXQBdvZ99sRwzF6Jo6LWGmvFhIiD6Dy1J12+Ye85UqWbKM8WzCQY8UC
         QOCYFT9o2eOYd/ndoIGB3yIoHc0p+TGcL/Dj8sPkWq24r4VT+iqz1kNscfOi1jKiRGOX
         Xjo8hpNhKD6voa2CeXjr7MuG9RF9ctgJ+nVu+e9QmNEqHMH4IxcGQLERpRhJxM0oKvTP
         FepClyia8+0JetAQalbPs1PtzRXKuWiyJeO+/XWsYY0D757lgkiMm8Jc6fXMvoDH+hO6
         JrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768957554; x=1769562354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        b=t15WG2OcYu12bDjwSRHPIXLug7ubdTL1KBIla10moIt7IDtvhqYj3Ln2nNW3pLYtMw
         21o/ozNUvzl3omrji5Aq2N9VIAFJKrZY3hDDIdv6f2hbETzAJrsVyn4gl+kyZM65LFr7
         aSsXOf+JXRHbpl7FWgP/qtOJ6HCCvZlcHB8Swyvi+bj3DIucc3v3f61dwnMMvL7CLsKG
         pcPMi3pJnQK+FdMKW7ASuVUs1KAvbfxDMv8QJ/3r+vKG7zvPjBAQNFfTJoMCYGuTpeeU
         mwtBJ2qCPJEFwX8dLTrR8VUV9IOKhoCIkKEP59/roP03acMA2JPScbnLo8WcjbDBhuP+
         Od7g==
X-Forwarded-Encrypted: i=1; AJvYcCV1kCJAzOltLD7widjuuOiCKqn8hFfroMoWRYm9e9D8Ffy9D2o0TyfDycTCiaYluJQ+QJzJJOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkuS3SSObNwoGpzg/XUKllCCaNILzur+4Mg7hFyLMlBU4qHcR
	V/0qohh3glte2AVdNmZ5y9yN2ShYJblTdFcyR6zMUanebbAJD8GYI4PUpyO/W/TFo1+ojQaxMH5
	jq4/hpXOKrKrv1EEofnOGyme6znY1b6E=
X-Gm-Gg: AZuq6aJdGyTtOrlaj9/0V8ZrY0s+ZhBbame7Q5HX6L7uKpglvdWcDnSmPhh3PeXJrtE
	JC83Mp0Zuh4KowZTBlToR+AizUhNOAVSua28h9xZYa7BxMxivh8C0r9ONo7rsFSYvw69Tu4aqHg
	YYnL21uCIHKFlSX2lDvr1tgrDAfypKM5lTkhFnqtduNwCWZodZkPn/BCRUE8iYlxDTXLaAjgPLy
	zVarblZ7hgrQrtlbzGfUzaJ6PI91PxzS/vufaGHgtc2yzb6NIdjBMp3v3l5yqJY2Ti+bJQ4cUgs
	WhlT+JcwdYI=
X-Received: by 2002:a17:902:e842:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a7698f3e16mr31237755ad.23.1768957554251; Tue, 20 Jan 2026
 17:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn> <20260120070555.233486-3-dongml2@chinatelecom.cn>
In-Reply-To: <20260120070555.233486-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 17:05:42 -0800
X-Gm-Features: AZwV_QhHH4eFAffWBHjf2jaxTKvjTuSmLWouBdzaCGqxpzoDbl1L3nV1kK1LavU
Message-ID: <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Queue-Id: EAB844EDDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> Add the testcase for the jited inline of bpf_get_current_task().
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v6:
> * remove unnecessary 'ifdef' and __description
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>  .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 38c5ba70100c..2ae7b096bd64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -111,6 +111,7 @@
>  #include "verifier_xdp_direct_packet_access.skel.h"
>  #include "verifier_bits_iter.skel.h"
>  #include "verifier_lsm.skel.h"
> +#include "verifier_jit_inline.skel.h"
>  #include "irq.skel.h"
>
>  #define MAX_ENTRIES 11
> @@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bit=
s_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>  void test_irq(void)                          { RUN(irq); }
>  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
> +void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> new file mode 100644
> index 000000000000..4ea254063646
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("fentry/bpf_fentry_test1")
> +__success __retval(0)
> +__arch_x86_64
> +__jited("      addq    %gs:{{.*}}, %rax")
> +__arch_arm64
> +__jited("      mrs     x7, SP_EL0")

I was confused to see this, as your patch actually implements inlining
only on x86-64. And then it turned out that on arm64 we inline this in
JIT. But Eduard also noticed that we actually SKIP this test on arm64
because of missing LLVM dependency, so that's not great.

So we should do something about silently skipped tests at least...

> +int inline_bpf_get_current_task(void)
> +{
> +       bpf_get_current_task();
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.52.0
>

