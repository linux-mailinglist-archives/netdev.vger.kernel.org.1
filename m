Return-Path: <netdev+bounces-278483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H3oAqtS3mlIqQkAu9opvQ
	(envelope-from <netdev+bounces-278483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B53FB719
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04318306E641
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D13E8C65;
	Tue, 14 Apr 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrx6BKQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1A3E5EE2
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177532; cv=pass; b=uOP8mPYa4n6dRepSLiXngnl6/tRjRs6FDTES+XpeZqm3ufFa0lHN+kCPqRH7HYIx5+Few/j6eHgSxv5XXSwc/posxn+5dw9ThrT/DaX1Q6Vc5tJ/HG55zmndQoPVAyxiWUxNCCwkHK0q3uoKVFpnoScYzOmsDWCu3FVDC6CXTGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177532; c=relaxed/simple;
	bh=ZvMerGqSJAlyqgeddQ6lYem489w5ZSqqOzbNiQRZjn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh00nazqrYFpLZpAzfuq8eLjwlJw1spm/xF1qHaKmV0Iky/kxGQPzygUGp5yDR2moUaZFCbAgh1jaFEu2Xdf1imQ1xyZXFYJ7Af8WWEsw7YAJ19JKO8EKWN97yIjEm0/7L62y/iiHmgccKmjBgO7aj+05DYnp8BETdge+miEhVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrx6BKQa; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7605ec91so2120577f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177530; cv=none;
        d=google.com; s=arc-20240605;
        b=IJ+CmbE993SrQyz6LuAefWLSLiSu0zrrSxkXEAxfRvwjIFz2VHs/ydYf/HdOKzLTeO
         GxflTdvJta3aItw2ODiX3+1/0eISkLaMGYvtFX51G419bqrnoqxwb41kTw1qpx7aln5b
         WktjfYw1JbcrHGUJIJmENvkGhIftlX1lTIQuUuL8OUIIv8/HXtRDj2EGFfMftdpWfMnc
         /m95bcsVk1ipi/JCGxdGSb6tL7KRp6Ig117Nccqcb5VVv6vTvZDZtgKVp7P4tYaQ4Gkv
         wsQzxOHxfd8kv7xE19U3Z3tLZByo1f/8fNgazupG2QjhApCLydE1pLscNWFhR1U9TZ0b
         hb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        fh=ofqli7oCwCDYCkbDG84MVmViAPBuYh3s3Tp/6NMfZwc=;
        b=Nnay9LgKCQl5YgJLYP3kEItsWBhKo/aRSAUw1VJeeJ/QzTaWuP2y0vRshke2px9EsZ
         T9TqiKQUa6y1FcooMiX33t6th66VJw4KuBxGCoQvCRi3/uEyNpiS/hLQKUAtQpPA0O32
         5OgrJxNxobsEJ+RGIZwjBmQHKnM+dmUKJTLyjsExo3ckGRIZVaFO0AMrJELL3Vf+etEv
         VdBg8ycl1xbJiYCxC8auePAWuJeBn5tRltkre1X9E356Re/1vdmE/tlEk3IvncoSV4MG
         35YYyViyNx0n9Th3R++a0XFfAmcinCG+1er5nc7hhrafgQukJ2twYJ5Llm3HDQu9W7Ti
         qrTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177530; x=1776782330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        b=Mrx6BKQac/mEAyn4HtM7CA/4zoqjbafFfoOa3S5jeSGGwGbKSXmN2jivtA8VEYQJYw
         z9Ue1GdunUm5I9i9avQeEKnEvBc9lc/FhuMxJp7/ZaQMxjtywG7YwF2oSRuLLMwb7E+Q
         zEAZ/EfdfvZEgvZz3KWjh4FUtdtb1XMKRwb4tOeMnvom+tZUDs2JlSK3l6Z5Zu/z05i3
         0JNubg6yJ+UDiJcZbtNBmu2meWIPmgYH9GfLO4PRhBw2JJ5SFiOd8ZeTigvYHothvHa2
         EEFEeDrnwNaSOp9YHhdwpZ2oqRrZA+wWzkBUBa6q0ME48njcpfFcQG9Ckl2I1im5Wxm4
         /JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177530; x=1776782330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        b=bM4T4OLOeX7gJcUHl+dyPJ16/dq7w2f+VX7/50henn/MLmaiCZzFcCghf8TKL/y3Gv
         1iVdObHo9vLh0twLx0KGpHD2FpfYJuZIw2opXIJyHH5cW0293FtkayLj8Qmqv/JUW/kF
         wF6LOw4xNDkoMM6csQRS86iUp6LOXZYf2pEEQdTCXteaajSiNNmshhGUEnPtcqhcU30U
         eDF47Z2fo48pO+/lzoElDMMoW4EDArZaJ22LBTdb426oqltnxaK/OXgUchDjKQhS8b7w
         1t89Bc5rXo2nWPI/fXyKfxZxAEMKfULo1e4IB9wA3VE0XPnmUVdPPNr9E3NfeACobth7
         yRMA==
X-Forwarded-Encrypted: i=1; AFNElJ8Ub9INChlRtcXOf483H/N/ejMrDCtb/GnMEnH1gBgHjO7gmxPJ7hT6XjIWFEojRXemW1W9wa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtPgW8wT2FfAEy8M5y/pdcILUuEqFJMyHOwdZTtSBEBF9uIVk
	AJE1AolD38J26/lKehymqi3QsczdHDNxmHqvthYFQLkv7wjXbUP0HLKyEZC8sG31qPRvVXGpn2R
	XiHdPihbpCkQ+RH43+cfbKaa5GeYi3S4=
X-Gm-Gg: AeBDies6LyKKRdtoyuhyc03mIFdOhNjwDA5OLCadEiX2wMwkyO/ymGgj0SRVYnyFBFh
	frh4836KPxy91UVPgc8ABiXn/pdeMQ8KQQbo4j5R2w2KquQSs10RmUSttPQzYtdjXNQfeT0dfFa
	P/69QVngiiJGJUx9RsgdvLfDG6dRv0cOAnCwb5f1JLQjTdZBhzeLJdJC5D0lZO3nOlBcqs1pjmN
	gpsDk09kzN904FId3O8L9e4HWw/OZ5UNx+KJU59YmVoHKqVAIA5GurUHVA65G1X4TWF6CQPyLNM
	5uAD1M37jrEh1ScjC7lCO9zaTjTtfp3VodofQFLzIXlmAL4Eh8m7DVmmO7yAJOW3xlb+jPtrNct
	aACAT1qsDOHuAtBolnUKkQpDZEg==
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-43d73dead51mr14691281f8f.26.1776177529609; Tue, 14 Apr 2026
 07:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com> <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
In-Reply-To: <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:38:38 -0700
X-Gm-Features: AQROBzAAc3g7dGJeHc3HZECQFqFuOBrJ_YiWzr60z_aqmL-sqKG6l_qunoKkETU
Message-ID: <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 934B53FB719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Found=
ation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enabl=
es
> >> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
> >> BPF programs, when both KASAN and JIT compiler are enabled. When
> >> enabled, the JIT compiler will emit shadow memory checks before memory
> >> loads and stores to detect use-after-free, out-of-bounds, and other
> >> memory safety bugs at runtime. The option is gated behind
> >> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
> >>
> >> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@b=
ootlin.com>
> >> ---
> >>  kernel/bpf/Kconfig | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> >> index eb3de35734f0..28392adb3d7e 100644
> >> --- a/kernel/bpf/Kconfig
> >> +++ b/kernel/bpf/Kconfig
> >> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
> >>  config HAVE_EBPF_JIT
> >>         bool
> >>
> >> +# KASAN support for JIT compiler
> >> +config HAVE_EBPF_JIT_KASAN
> >> +       bool
> >> +
> >>  # Used by archs to tell that they want the BPF JIT compiler enabled b=
y
> >>  # default for kernels that were compiled with BPF JIT support.
> >>  config ARCH_WANT_DEFAULT_BPF_JIT
> >> @@ -101,4 +105,9 @@ config BPF_LSM
> >>
> >>           If you are unsure how to answer this question, answer N.
> >>
> >> +config BPF_JIT_KASAN
> >> +       bool
> >> +       depends on HAVE_EBPF_JIT_KASAN
> >> +       default y if BPF_JIT && KASAN_GENERIC
> >
> > Should this be "depends on KASAN && KASAN_GENERIC"?
>
> Meaning, making it an explicit user-selectable option ?
>
> If so, the current design choice is voluntary and based on the feedback
> received on the original RFC, where I have been suggested to
> automatically enable the KASAN instrumentation in BPF programs if KASAN
> support is enabled in the kernel ([1]). But if a user-selectable toggle
> is eventually a better solution, I'm fine with changing it.

Let's not add more config knobs.
Even this patch looks redundant.
Inside JIT do instrumentation when KASAN_GENERIC is set.

