Return-Path: <netdev+bounces-265582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMPGLjbfrmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:54:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCC123AFDE
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952CD3091CA9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161513D34A1;
	Mon,  9 Mar 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+HM+oW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9153D567F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067969; cv=pass; b=ZU49agYMvgasrbuhKuQEK0YbpMOBhKQKMrNp9UAuDfLaTgf2QAV8/YCF3QqkSTl0BybWpMtkxw1w0AcAHtCxOusRDBEZ/a9SFxpb2OO7K7Sf6iGtSL/Kz3pZ4sI2WuM6qzej0rTDHNEMbR/3HzYQ9JNVym1+vi+kwXtHmssMGpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067969; c=relaxed/simple;
	bh=1yh0Em33pSzvhmWNALzcyzFfQlommmd1lBluwLC9/5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy9m0wHFoM/5cy+WAgkTYavszXmAc/mSEorQfM63Hw2Mmfo98P3lhz1bP9lLl6qQFK7kNpDih/IC9p/3pAEK4B4lmCaE9T4CuukCfKkkMn5N8T0x47C03Xz66V2RP7R1pJ0s2SI+ovW3d4+X6AifHs1nsteXXZxCPM1EHvwIZDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+HM+oW4; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509046c5c7fso24058711cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067966; cv=none;
        d=google.com; s=arc-20240605;
        b=HqPcQamo83xVCm6Tr2gMEn2J38ltzuzYnR/j7NFm0RCFZeWdQA54KTMFPF6tdy6oBC
         IQmCisg/IFdus9zT7GCj1Nnd0Whsm0/QC+UbudOczPke099lEQKH6NtZOrf625WO/QWn
         ch5VhPYDIbaguJRByeOAwcO76skE27Kooj9uapLhyutpy/75IM3w44r84cMWwRHCcUb0
         CVsJoXWbzy316+R4EnA0ssXtIsrPVURiDRtJsgxSa6XhSdbIJcsI37TCKeV1RFtWkD8k
         vltitbYI+PlM6rCXEeiXeXedCpTxJC0OPaB0yfu04PbfcLr0nmn6zfSwfoJEY2odX6c9
         fGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5SXCcHlkTElZKPfkbORrBraaCPntJHZL0aqTvFnZ28=;
        fh=tMY2rqkFQaicYS4Gda579YrQm83jWf8f8Jg2lXvxKsE=;
        b=Z+lx5UA21QNdX0UrExF7D06BAO5Ew5e99rxdsz9jDsJ1U25gK6/MT9tkONANP2GXnI
         AGTKJHaisnP9oTuG2oWGhE7PLqxH04WOMSJipwm0fJklqkExmEAZH62RRFDBTNLozk85
         SHrD+ssH4CngPJXYDQViVZB7N+whZ6z9px1OUSokCeAbDDREO2cdfju5RLhAHIPV2HN3
         mtGUF9zlV1X40rdWGjMAqZjQIj+cFaeaN23fZyLBx+jtJodYNYP+z1uxEjmLAOIAeQY6
         Ydbv+ktKLdkyLiBw74zf7SHTmAInV6VtAg4nzMR0ETwL4A01QWuS1nZW1agIK34ceTkQ
         Q0dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773067966; x=1773672766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5SXCcHlkTElZKPfkbORrBraaCPntJHZL0aqTvFnZ28=;
        b=L+HM+oW4c++c3mK3IVnIEkkZ7tyOu6+3zohAf9gRGfGAkDSUsqV0h+7UkleUcwjf8Y
         N+ho+xrgBGHEU5kbb+xhXHllAZ56bc5IRCFsPjzEcHtWpcwslWWAbzhsjfP9WlZkHyMk
         4cuQRq5yD9ACHHxaQh92pfyIskZXlHlc7T1etuMPtrrr6FVbMrv3Wc9uQwcC/r9OFn0A
         4HqSMeZvJdJLuwLsrYPMz/kXSRgsKhE4JK5kZFy/dlEGH883Q6vwIbgvf1yXFFWLs5ph
         lZlt3RPrqFXHH0HNHKEnoBwouLwPE2B9psue6LY4LHKc9gJpPZGGvgV39OZDzOb+33JU
         QWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067966; x=1773672766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5SXCcHlkTElZKPfkbORrBraaCPntJHZL0aqTvFnZ28=;
        b=h7iDin3uils0khvh9Pq236gFTd7EiAqv1YsjWnYVF58lqK1+wi4dEUoZPqT5CwqjWI
         /AR1Y7oG6WnhRxgdMJ6Pxi3Miwv4ig1eWxwHcntYAyBGgRxStSByyafhj4FIh8RSNfnN
         mcO1iDarW3dTbrkkKpRl29F5194L4JdRyW5bAQRbohRgq1o+YY/f8LbksRY1niOpoBrO
         4rkvVnwzrZbhRhLaJ28/oIyv1wMtI8DZ4VznEUDzHYlLhiztd2E3fLEPRo7hOnQGhPH0
         XssyYuVKtS896REh2G9I4thfIcR3SHjR2SgdWFKrh1NO50JC62LrweHn16ZxxDkBOGVx
         D2/A==
X-Forwarded-Encrypted: i=1; AJvYcCXzLMth5Efkjw7rnZl6OajDrmiEQC7H/B5aKD4rsaW5rNwTE5qxr3HH9TsNmd4OX3cbko+rzHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFQFKJvXjE0hNWGIbthfFBQzWy7K6dV72AlSRxyALcp6Jsu/Z
	aKp/Cwyj4s+hAZskBz2LushRSZg2M+hlmuf1nWrTH4q9Yt02tG4QPObh1Ks1dB5OEYlaVbS7HFo
	0huhAxAhNEAWyWQzwUPnJMCtxfa16aDyGKww2QJAs
X-Gm-Gg: ATEYQzxXgE4kBIiMS9LhflKu4o1KfO5e+SwiMPeXmqZbAqF+j0ynKzPj4wdkesbJ4eq
	47JQKsbE0TEnTlJRRbYqaw9Lzs4IEG2WNBajjvUq8WpA1kEinxvoWkA89sZT4muMs7/uoNAJtwa
	N0fAMSRBSMvRnmAj6m5mifCc0R5iGHOFjrxoY9ZSecSEtM3h9TwiYn1rwzT7YoNwWePu0PqGpln
	+IgVJBcrVehxEEgylJR0t2ODcti6z6HMZrQSU4h7QQ7iwjA61cu2KXSldBC29CW2W8Dt7ZlZvOw
	TbsWQy4=
X-Received: by 2002:ac8:5d44:0:b0:509:2448:410 with SMTP id
 d75a77b69052e-5092448095amr10124281cf.47.1773067965931; Mon, 09 Mar 2026
 07:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com> <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
In-Reply-To: <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 15:52:34 +0100
X-Gm-Features: AaiRm50QnKANhW_R40q05JEE12x3-evufvAeXuFplnzgS_XYRo8tnoqKs5NpGzo
Message-ID: <CANn89iKyPZUqmirYza5ewD2dBQfZCMunG771x7cMpUFkvw9x9w@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1DCC123AFDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-265582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Mar 9, 2026 at 3:03=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Mon, Mar 9, 2026 at 2:44=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Mon, Mar 09, 2026 at 12:20:55PM +0000, Eric Dumazet wrote:
> > >
> > > > diff --git a/include/linux/local_lock.h b/include/linux/local_lock.=
h
> > > > index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be=
7b6327e0922a49befd8fc 100644
> > > > --- a/include/linux/local_lock.h
> > > > +++ b/include/linux/local_lock.h
> > > > @@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_l=
ock_t __percpu,
> > > >                   local_unlock_irqrestore(_T->lock, _T->flags),
> > > >                   unsigned long flags)
> > > >
> > > > +#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) |=
| \
> > > > +    defined(CONFIG_DEBUG_LOCK_ALLOC)
> > > >  #define local_lock_nested_bh(_lock)                          \
> > > >       __local_lock_nested_bh(__this_cpu_local_lock(_lock))
> > > >
> > > >  #define local_unlock_nested_bh(_lock)                             =
   \
> > > >       __local_unlock_nested_bh(__this_cpu_local_lock(_lock))
> > > >
> > > > +#else
> > > > +static inline void local_lock_nested_bh(local_lock_t *_lock) {}
> > > > +static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
> > > > +#endif
> > >
> > > This isn't going to work; WARN_CONTEXT_ANALYSIS is unconditional on
> > > clang >=3D 22.1
> > >
> > > How come that this isn't DCEd properly?
> >
> > It might be partially done.
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 0e217041958a83d2a3c18de2965808442546c49b..50455951dc38668b0cbbccc=
db2c5ce726e3c4da9
> > 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7498,3 +7498,12 @@ struct vlan_type_depth
> > __vlan_get_protocol_offset(const struct sk_buff *skb,
> >         };
> >  }
> >  EXPORT_SYMBOL(__vlan_get_protocol_offset);
> > +
> > +void ericeric(void);
> > +void ericeric(void)
> > +{
> > +       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> > +       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> > +       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> > +       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> > +}
> >
> > objdump --disassemble=3Dericeric -r net/core/skbuff.o
> >
> > net/core/skbuff.o:     file format elf64-x86-64
> >
> >
> > Disassembly of section .text:
> >
> > 000000000000fe40 <ericeric>:
> >     fe40: f3 0f 1e fa          endbr64
> >     fe44: e8 00 00 00 00        call   fe49 <ericeric+0x9>
> > fe45: R_X86_64_PLT32 __fentry__-0x4
> >     fe49: 65 48 8b 05 00 00 00 mov    %gs:0x0(%rip),%rax        # fe51
> > <ericeric+0x11>
> >     fe50: 00
> > fe4d: R_X86_64_PC32 this_cpu_off-0x4
> >     fe51: 2e e9 00 00 00 00    cs jmp fe57 <ericeric+0x17>
> > fe53: R_X86_64_PLT32 __x86_return_thunk-0x4
> >
> > Disassembly of section .init.text:
>
> Same for
>
> +
> +void ericeric(void);
> +void ericeric(void)
> +{
> +       raw_cpu_read_long(this_cpu_off);
> +       raw_cpu_read_long(this_cpu_off);
> +}
>
> I am guessing __raw_cpu_read() is forcing the asm ?

Might be a clang issue. Oh well.

clang --version
Debian clang version 19.1.7 (10.1+build1)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-19/bin

Documentation/process/changes.rst mentions the minimum supported version is=
 15.0

