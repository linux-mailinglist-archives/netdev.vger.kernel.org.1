Return-Path: <netdev+bounces-278215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQeMVts3WlNeAkAu9opvQ
	(envelope-from <netdev+bounces-278215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BA3F3C4F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA275302BA42
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A939934C;
	Mon, 13 Apr 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUuHEjv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118137E315
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118827; cv=pass; b=O5gjeBLO5px7E7BR4l6wx0QQAINMtvOz7IFPMteMD/Iy2nLs6HDxFzXsYIdL9GkTzLHY68ndo4E4yVM6G6Dyi4LxxVRjybaqM0+oF10D4G9NX64dLuh86CKOpbIVmTJHqvSiVsGB856If2MIMLgmOa0MNyAwprVorcJiXB6ot/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118827; c=relaxed/simple;
	bh=vxVQ2muHMuW2TUZfvshASG/qQsXz8ZNjUFFlQbYxcsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNr1aPdoTd0OpnUx/BimrU6hhWZVlzavyrdUhqVaCE85sEy6tBmQArlkZh6Bpq7C+koInFGLLf1X0DeasxmdaocZQ78fGvVsRqYdjAFxtCdURhTjVJ0HCSnMPelgk76GwkCySvQR9n9eLPD70mnU5Hi4DTyqgNrODbMsAwnh9bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUuHEjv9; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1125091f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118824; cv=none;
        d=google.com; s=arc-20240605;
        b=LwHzSBNUPBdZ9YNDycCdiMe9M7Iq1lANc4WjmRjq8QdXYmwBvJgYJG9qBPVsKKnr8I
         LocgN6pZGWM15QPh4oZYoOJ8gulhOHdBcppWMV3fMyFwq98GFBLcs9D3hRAVT+u+KJCD
         ejj+mdAy4260hxSJwnu9bGWhRus6Bs3jOBuXs+1Qit2dkxszBY7mcHD5arMlXyuYUUXC
         BvgYmghdQ7yHi3MRj/AKPiVUb1WBX/3/fKAQ+DbVE0wp215HpI9Zm4ccmIHlnvNse25d
         CiIs5rVKXg6MxITdbL8v5c2CtFaKr1xqbac83NBH/PIGVuGMVRD7Szm7cMVwR1vVNkVu
         uSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        fh=bQsHVbYPKw9Fykb/FnWMwiF8MttQdmsIW2i+gLIZVr0=;
        b=KTA6T2w6TU7LOB++xaVzcjqiLsbXmKcJuLU+BtZ9AOvgRzT80LeGpRD8EZhwC9dkh4
         F/GexyIjlGH43cE/NH4IoOE5zXkc7TVQquJKRLOLbcJA0DuSxFfTwJdktpGkBHqzGiy9
         Y/mi/c+q0mEKVdShLrlQXXGwC3eEh9Ytom7g7nSbgGPFZb9PdUqKAey8dNbluP52AIPt
         XTH2EDLJBjEV84WNh9dtiB3DfOPvkr0D9CTiTVJgd13QECnTg+P4a5mGsug/Bt4VfABj
         /pKSN+av/05p6ELfaeYmOApfO9M37QRmHqd4x0SORbV6a2D1Dhupp3cGWzZ7FMSRhwOO
         MUqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118824; x=1776723624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        b=nUuHEjv9Qng0o8+V9wNyx2C1uKpl067pNckpPRU8BSVRIZm6dfPLgPqP3Lw6xvRci+
         rrcuEMkS2XRywm2h09uyOmnKTQLHjpwyQGvjUnLR+ExxnIb4xqqDFxbjpBpiCdkyHDu6
         LngF2uqRRcGoW00iNEZr0UyyjrVcwf6T9kuuWf43+Q+4040c+17+hPikRfF7B+59GUTb
         v0zLOfHxr3+GJWfTCLexySi89isOOMhUvNlxmklB6c0vrs0x3+/IhBVk0aINzdLUFyEc
         ECICpTc89k2vaIx8sS2gDTBHGv8hhUFLZY3bqeBPytXxOYF2Wvk0vylCz5nLQgfVgPUv
         tQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118824; x=1776723624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        b=Ts/b92cj7jJvd+u5R9r+QfprdH1C95dsVIulBCbYNpcYU8cJd00i9fjUb8yvGcFRPz
         cIi9mxwiNRGlPNaNdRZZE6SISBAuPAVlx1KnH0/sLdZaaB2pfrdV0SmnMZYdT+oUcGEE
         Mk5YzJckFtLB/67om9RqTd5ssY+uvdilpHqGash71W3dtZ7SHFI4xqEkSutRFVn/RPKp
         kBwm5dX+5VLAJpkvuGtdabpVetYfKYM5AUL/DWEyEMIZCknuJc44b5fLjF20FeyOc+VI
         U4d73uApODZUCe7qtXAxEHulzBwY7FxavqUDfOnMVQgU2irRBZHT+vaL3/bUZpObf1a6
         B/vw==
X-Forwarded-Encrypted: i=1; AFNElJ/e8V82D180Qz7tL2HefCRMUaSIqj2AwVET9Iu4aNqsfrI3F55XY7FEG2o5YH+BvX23Jw7/VXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCtGH8yw9XCBYszjbiOBUOq94FyqfPTwVHdgINawNwmRM3Shd
	oEeuEDlBO3gLxpDiVDoeJh93u5XtHKxOllNzi9ooRsi6UtimW1GMrQhhJEMas0IPxsl7E/6SWA2
	hQ9I5mUU1Q7BhqcUXoZvzBbSG30noE6w=
X-Gm-Gg: AeBDiesafIdddW0kNm3Hds7IxNjEb1l25MDTUjYP2F83AqpudHBJL59ci/deZX31+6T
	DJ3R8ANEPHUyumRWTwU9VfVkqGU/JbRUC4q0g2VgKhav0AbTkCcrp9Jfa7FVDjfVp+Nn+nNLeM8
	gA21p4zqUT+I7Tu58ANiSRwaxaNXkgvRCm6D6wOwjVzVFVRT9wBugR7WpAeXqub1JsssYYCxNUK
	GqmrHj/FXamWXmYxEDMDSFFTe9xuU297+BLibOfEJIbr4dbIaQw+Z+W2LTM2FaDPyOpH90htDU6
	6a9ehzNYStJqLbOZ4Bcsw/GCff532fKLRwilTTcY
X-Received: by 2002:a05:6000:2303:b0:43d:7af0:3a8a with SMTP id
 ffacd0b85a97d-43d7af03dffmr7155232f8f.46.1776118824134; Mon, 13 Apr 2026
 15:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-3-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:20:13 +0200
X-Gm-Features: AQROBzASLHf5ILBNuw_x5OeLAHJGUfv8fbkKsOkNoaIfzCwURKyPvUbS0Z-ZunI
Message-ID: <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278215-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreyknvl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3A0BA3F3C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
> BPF programs, when both KASAN and JIT compiler are enabled. When
> enabled, the JIT compiler will emit shadow memory checks before memory
> loads and stores to detect use-after-free, out-of-bounds, and other
> memory safety bugs at runtime. The option is gated behind
> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
>  kernel/bpf/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..28392adb3d7e 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
>  config HAVE_EBPF_JIT
>         bool
>
> +# KASAN support for JIT compiler
> +config HAVE_EBPF_JIT_KASAN
> +       bool
> +
>  # Used by archs to tell that they want the BPF JIT compiler enabled by
>  # default for kernels that were compiled with BPF JIT support.
>  config ARCH_WANT_DEFAULT_BPF_JIT
> @@ -101,4 +105,9 @@ config BPF_LSM
>
>           If you are unsure how to answer this question, answer N.
>
> +config BPF_JIT_KASAN
> +       bool
> +       depends on HAVE_EBPF_JIT_KASAN
> +       default y if BPF_JIT && KASAN_GENERIC

Should this be "depends on KASAN && KASAN_GENERIC"?


> +
>  endmenu # "BPF subsystem"
>
> --
> 2.53.0
>

