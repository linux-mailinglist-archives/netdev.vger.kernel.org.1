Return-Path: <netdev+bounces-278567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNivKZ6S3mkHGAAAu9opvQ
	(envelope-from <netdev+bounces-278567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DAC3FDF4E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F267F30552BE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E22D1F64;
	Tue, 14 Apr 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpc7xVpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FEF2E975E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194180; cv=pass; b=dlFtJg/l9P4iEc5bTkT1mBUC9002/pjNepJsNBeYUA3AbafSgOW+OzrQR2zV3kBhow0q/GKkqiZyvgMxStL3s0caWizGGDm67dslARvx3lFjbNKq7RyY7G+3EPiQTs6i1ZzKeQxVaqYqwj17zIK2s3aPkxEl6qbocQaTDAEdDOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194180; c=relaxed/simple;
	bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+HnHBVSurL3Rh9E/qmpBWPFPP4+SWgIrs+howpgdJh8LE657swCuyQfdRQJonMowGnHpoOyuTByxESdDemNHLlrqeG/mD7XlJK/vF7RLgVoqVNmN9cPZCrAGIaVDRD778CFGpu+ecgTmv5PIYwrnU2+nwBusBW2/OXVh/lxKZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpc7xVpy; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso56142465e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776194177; cv=none;
        d=google.com; s=arc-20240605;
        b=bNomggAIRvSon/mm8wJkpmPfasllRsMQ66sGwRfK+1eZsYKSw+vbSn4OZu5runb1np
         4CTfClG4wsNdoRe4IRradQRgjNl2KwhMs610RRML2pkI5bjsWmpusa2pfo1M9Rs0Owmn
         wW+c/TjAdbMWUbh3tiq8iQMiFd5KgOTAr5caaapRtd1a1V6GpFI4DsFlNEHoxMos6D/a
         TUlYixNspTzEAXJTdniqlyJPY4H7aNOHR4qvaYlXvaOTj7San0hVgawA4DiOtsqpWA48
         3Ek5xH8UvUH8zRrSrhxJ1gFoLC77MPBROpjzL5hgImVYsHyA9UvakTpa/pEDdNORFNg+
         DUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        fh=i9onXbMYrEhbDfg+AFXGl9ljLaUMs3QcYp0yxXFqiTU=;
        b=iLCg3hPX5jrD40xIKKI64zED/QOKZA2hZviBXwptb4mvTUNDOBoliZiR3rmn/MllGZ
         8Uq07SMKQDYo1X/pM3lFrgpZTwxDp2tNpW8YPC8je7hAe4QAQCBx8OL3tZQD9dWlOdqm
         wJkcSCxSv3PtXWVVjyPpBV1jzYxjR9k7rc52k8sguJE+yb56FLF75iWnljQPFO/xZWGa
         yZomb71dp7RMuJr/I6wCcWASJ93emv3rcS5qnLotYmshTeabxv+FzlE+mAP4wvLkLUnQ
         kdi5lM6OujVdD9Id4x7wxk0UNYKY+UqOe4CuzhTHtnP0rhBlXgeQASc5onVjiET3HXJI
         A7EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194177; x=1776798977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        b=Mpc7xVpy0aat/nOvxYcxYcf2t38XGL68q0eCA5v8oM4hPWbLdss4Rdsj8qSPNKhUqi
         KOczID1epKGzJJbY7riB26JVfzODnvHVKvoEUn79UDeMfee5OzhrgRdK1TpYXbhjZsWX
         JhK6CkseYiAEXB9MJqp7p5UviYRFK9SMlDFtSaWcj6Z8V9/HICDnls2FgnuLznBXww4p
         6snmdRCdSEuCc6aQnsWjc2cMPKwpaSRio8NKUZmUCm4qv0jybc+2GTvTOfosR7ZSPDGH
         J8H7u7gvVoRhzbOYL57IJGZujPjwoYSKuRkRVdro1b5v6HTcj2LCdPo81G1vaLdfglOp
         HxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194177; x=1776798977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        b=mCgoKYpiM4NBtNkXrmJ0wJyukOj99/8p7BzZJF814ybCDBdRbvFOMOAiZGpFdT1Dzy
         TDzSY83NOLVRuZSVZVetKLxpfKZ+ew4OXsxDZ81mltbv1vvX/jA+4ioyVZVCfqxQeSsg
         TQ9gcz3IeVvQrJdArKRD2IbtUTJihBcuiBuDfrhBQ7oGcQtF3E3Yx74CoZhk3paXcmmu
         RqN2AXoEe6OltQKn5LFY9GnDNLAhYRygIkGcoPYDMy0robwZg4/uDZv5RUxjEXFWACBq
         sYcjGJa0ZbPXUuhQ6/4t9+c+EO5Dd9Yh3rVp4ExBOFf4ZJ3XkKVTly1jUTTfACsmf0QI
         59kw==
X-Forwarded-Encrypted: i=1; AFNElJ8T/3kByFQglmU8Ryqc/afAFKabzx0SJH5YH+t1T11Av5vtrIpMb4y3IvdnE5jMfD/ODExn8vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8qvx6pjwMMRcsSHI/uWpdquP1Q/mnfFGJTE4VvYdQrSMRIvP
	7Jrx1vyWL0MDMSNNmf4KHWBQPAUHebnbtMUhPjuBMLj5SKJh0mWpmAwyXgA+VXK7Bb2SWtJx0hg
	WIhERFnmt/RAI0Kixcrk8uk9dClIm6i0=
X-Gm-Gg: AeBDieuKuMin/fMQ8vGwS9myx0cRCGPjuH143vM9L/s/i7lhjjjSG0w7GiTNG4GQrgl
	Sawe2UYybUd/vkSryrp83iaTm827X9CsU/T/YNIni8sOSx/gj1qzgSisEmS2iodvJ7WIoPVZofu
	8t0aloBC2gSAcgmGquWxo9VfWSHQQZk3xoil8Ui35/4BrTZSUYWlwVmOUYw+ftPm4gsoGCf34R8
	cy7NNfFcoWU2jhbQkTOC7iDLdSrO8Jl7roJlVb7yrj5+corGF7S4L+/J+zNcYL4b1tsB1He9IWU
	DSoWWjdICS3gaxA1B59E/iYUjxaFbiM/5604v5QG5whIOtCDMgj7Y3MDYZ9+jtM+Y2NYBH6X8ZL
	TtnZW/Vksa8ZDZ0mDjCt3XRAxS+e2/JL+b4uN
X-Received: by 2002:a05:600c:1f83:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488d687bf61mr256552315e9.25.1776194176915; Tue, 14 Apr 2026
 12:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
In-Reply-To: <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 12:16:05 -0700
X-Gm-Features: AQROBzCIKxzyzm1_jzBBwpYG5l-_Hq5ftS9HvYZuKsAkHlvW0CNWB1k5nfXPFjQ
Message-ID: <CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+DiJ0XKSpyYfg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278567-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 09DAC3FDF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:41=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Tue Apr 14, 2026 at 4:36 PM CEST, Alexei Starovoitov wrote:
> > On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Hi Andrey, thanks for the prompt review !
> >>
> >> On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> >> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fo=
undation)
> >> > <alexis.lothore@bootlin.com> wrote:
> >> >>
> >>
> >> [...]
> >>
> >> >> +#ifdef CONFIG_KASAN_GENERIC
> >> >> +void __asan_load1(void *p);
> >> >> +void __asan_store1(void *p);
> >> >> +void __asan_load2(void *p);
> >> >> +void __asan_store2(void *p);
> >> >> +void __asan_load4(void *p);
> >> >> +void __asan_store4(void *p);
> >> >> +void __asan_load8(void *p);
> >> >> +void __asan_store8(void *p);
> >> >> +void __asan_load16(void *p);
> >> >> +void __asan_store16(void *p);
> >> >> +#endif /* CONFIG_KASAN_GENERIC */
> >> >
> >> > This looks ugly, let's not do this unless it's really required.
> >> >
> >> > You can just use kasan_check_read/write() instead - these are public
> >> > wrappers around the same shadow memory checking functions. And they
> >> > also work with the SW_TAGS mode, in case the BPF would want to use
> >> > that mode at some point. (For HW_TAGS, we only have kasan_check_byte=
()
> >> > that checks a single byte, but it can be extended in the future if
> >> > required to be used by BPF.)
> >>
> >> ACK, I'll try to use those kasan_check_read and kasan_check_write rath=
er
> >> than __asan_{load,store}X.
> >
> > No. The performance penalty will be too high.
>
> Since we are mentioning it, I did not consider yet any performance
> comparision/benchmarking (and I am not really familiar with usual bpf
> performance validation practices for new bpf features). Is there any
> existing test I should take a look at for this ? Maybe some specific
> benches in tools/testing/selftests/bpf/bench ?

So far everything in bpf/bench/ measures bpf infra like
maps, kprobes, tracepoints, etc.
We don't have benchmarks for bpf programs.
So we don't know how well JITs are generating code
and how much inlining done by the verifier, JITs actually helps.

Puranjay is working on creating a SPECint like set of benchmarks.

For this kasan work we should make the best decisions from
performance point of view, like not wasting unnecessary call
and not saving unnecessary registers. btw in the other patch
I think you can skip saving of r10 and r11.
But we cannot quantify yet that avoiding extra call gives us N%.

You can micro-benchmark, of course, but gotta be careful
interpreting the results. It might be too easy to get into
thinking that JIT must inline __asan_load() for the sake of performance.

