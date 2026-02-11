Return-Path: <netdev+bounces-258376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHtEFyYFjWlVxAAAu9opvQ
	(envelope-from <netdev+bounces-258376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:39:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286C1282AC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 086C5300372A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119B3563C4;
	Wed, 11 Feb 2026 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOuFpfr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B778303A30
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849568; cv=pass; b=mVcZRsZoToKNx7pktmwMY/3u9PuEbWu9KlBa/y6sXephdvMrXQJiEQT/EEtWv4UgiFBAMpj7yqsJ8XnZlPgFFsTcgxkX0cmR8QksWApqrnHzxQbzkj08b8ooAeMc+o//h1CL2APGfMejFfw+tu+JH+S65Rz49qXjQ1o2dVMi4q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849568; c=relaxed/simple;
	bh=ygfV75Xo94JB86PUxabdo20IGfrJlF+2SR59V/gjj04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fussNMkdqTCgV8qVe7vlYml1BNYygqicgEIO0QZRbm63//fP4/7JmMQnPyb9B30V/WlsUg2Zn9sb6E6zlxXGVu1ohseukn1ayWjuRmZoaah0uWZrIBNDikn65UIS16X8HPp1nWhA/cB94Bf/DESWGER7GwnAD50f2lmnwcA6Tyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOuFpfr0; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4038290f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 14:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770849565; cv=none;
        d=google.com; s=arc-20240605;
        b=MYTHPlM+A7e7swq9RTMe7rJk8gXBdshKe4mAQo149Bq/KEwUHMmbD/9OtawA2miFDK
         1xNXVpkush3Iqy53Xc6SHsqFwQHw2hJ863fC79hzHPhvjpljkwhJT5BrI5wwDiBG4eHg
         r2vsMFAjOABrybsVXnV82LQUslTxa6mNhZu8Ef4aeqp2N8P8NFYWlRuaYPoLEMqA2sD3
         rgVI6tJG7rQa0obAytMJUgcv/QZgkpP4usJGbfGdorQ3dYFRJQAPUMeQBqdh+JhwU7qz
         MrLUfe44GLBM0nA/IeszAXfmJsFpZHqrarr0vmJKHjvdaHD14yct3q+cLgxChfcT5fs1
         bbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        fh=Tm6Yqou/YUQSSC5Gfty7v/xYBIPGR8iT/widhGc7bAI=;
        b=MOd5qsDnd0sufXQQE9qv9Uq1UziGjkQhViPXS4r3h9HaWAFR9A+dvjSU/PlyAluaGD
         m8ksWTF8CuZ50wqyKx8U60H/rIaq3gPlmOfruIWiGL8U+C0+RP+VNTTECSzngoNneoaC
         ZYjSm91bRTFflWwoiC14trzcS7Ori77bywWJ0+OADFUvMZO2nIWnQLy5Bo/LPiR0Pmu0
         pmla7Zq+yWzOM5fHJV2Wq9AbU+FNFV4R/AUQvQWgTXbae2P36wfkQXel+Gbm6+qv9fUl
         KtQ6dkUzgL6tPAoPS5RQJJ4KbgTdWkC5zFM88YXUfKYeUZag/jUrEXujCDOia3JXY4ka
         MB0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849565; x=1771454365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        b=dOuFpfr0EDjigFHkBr32CCFWtrwEe5uZ1+ieTVEZiykTqePKo5rnWCpDmyWY9sWOyR
         YNnuagSLgCuVvNFQHZi0VTdig8/qsxdemMQ1tOIHPRlUhUXdwy4IwIHBrFnidQBg+Liv
         QM7RbukKr2YwYBSd9Pn/BSMc1aS77wQClg0RW3X4szh46d5UQ2hGWbn5g2HjY3Y/0Gad
         VJFVUHbV9ZnEr4wRybCjNa0BdLTQaBZ8DzV2Iv91MICse/PelUX2o3iSiavJBvhdAikI
         GgLMTykgy1x5iiRA3oB7pj2QgoeLLpcA+G4TWAFkeMBLC4zb/jin+6dVFRKzPpJrYV9E
         A0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849565; x=1771454365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        b=kO3ZuI2qEtaP/YlDf9TfZL3Wz+xaBgwkTTp2j4t/JGWz+La43mXQR/vc/M2hgCCapK
         TbW9PtfDSuzrkcTG3zJR6BgvdAkermqZI0YetdAuoQYm8qRrGLdJ7pdL5jDhqEt/GCM0
         yVRO9eeKQE8eCYNGQ7zDuU6KsRD/+BVOT6B2pi2ZDXDrEVS4uqbSC/CkJNNBd6TM2UH9
         UdPypo0x4ZjUyfMw/N0OeBJ5zVe/vBv11HoScPhUNPWtIiKHYyxceQWvfz75QAUKsiJy
         r3+pdJMHhzIbwcfL29aup/50iFq36CA9galD0mAK7saSf+v0IiJbgiNhuDkHqNxni6fl
         vTkA==
X-Forwarded-Encrypted: i=1; AJvYcCVwcAlP92vXCCA8QjAV6WgsYchAUpVSffUkc5LUQOlj6kbPwa5MWNjX4QzNvOgtEkpCYL9bZFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKCOPNOxufEc7bDne0c17jYX/V0GhFiMPdo7TKJFZmdpalLAG
	XSPPJFKDDbTZ4USplusXz7CLln65YOLlNm18+GDeD5NxaZL+F3TjZyiBvhjomjfsvokOy4OaOJ7
	mczEWm2GVsWDpStA0kwP51/UfUk4J5D8=
X-Gm-Gg: AZuq6aIeJyzabvtBN6CPPaR6eM5wOCh6gTyRh6mV2gC6IlBs9AZt+wht/6yRbIAbt+v
	QOpX3whj0ZJvKX6VQOlABF3ezJ3p5km0zghWqm6he38Zt1bMlKIYqKscoGuZkWMOz2JWH1j0S2c
	v9c7KLYK3p69Icc2PZN9ng+6Z3Vj9gN+yNfqTb7Y0OmT1zbd/MwntDgE1i0petTOlk31c86R+rQ
	Z5zokwDdaaQBP4miojrd1BlMESqXHSUP5JDpo3d41U/SqRdfgTG9wkCWyvbNA9+WbvyOWPuzO9v
	9Ejzqinx2Wf7buzyuPHsBBJ2VDZlaK85+58w3jD2npsK6aG8HqMZPR/doGttq4oF8VA52NAs+m6
	+bmvLRLg/rA5qGnf4H5agxJUzXA==
X-Received: by 2002:a05:6000:1acb:b0:437:681e:cbc3 with SMTP id
 ffacd0b85a97d-4378ac92470mr1509564f8f.13.1770849565325; Wed, 11 Feb 2026
 14:39:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
 <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
 <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
 <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com> <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
In-Reply-To: <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:39:14 -0800
X-Gm-Features: AZwV_Qik4ZkumFKH9So-dw-55ZcCvj-mt-W4k4Qqq-_Jj3P-XFC8XKCbt20EFA0
Message-ID: <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,rbox.co,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 8286C1282AC
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 2:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@go=
ogle.com> wrote:
> > > > >
> > > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniy=
u@google.com> wrote:
> > > > > > >
> > > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > > >
> > > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_loc=
k(),
> > > > > > > but there are many functions where bpf prog can access the fi=
eld
> > > > > > > locklessly via fentry/fexit.
> > > > > > >
> > > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and releas=
e
> > > > > > > the last refcnt of the peer sk while a bpf prog is accessing =
it,
> > > > > > > resulting in use-after-free.
> > > > > > >
> > > > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > > >
> > > > > > > To avoid such issues, let's reject access to unix_sk(sk)->pee=
r
> > > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > > >
> > > > > > > If needed, we could add a new helper later that uses unix_pee=
r_get()
> > > > > > > and requires bpf_sk_release().
> > > > > > >
> > > > > > > [0]:
> > > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/=
0xb0
> > > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/24=
95
> > > > > > > Call Trace:
> > > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > > >  print_report+0x170/0x4f3
> > > > > > >  kasan_report+0xe1/0x180
> > > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > > >  unix_shutdown+0x9/0x880
> > > > > > >  __sys_shutdown+0xe1/0x160
> > > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > >
> > > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper"=
)
> > > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-7=
9ce6ef6cae0@rbox.co/
> > > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > ---
> > > > > > >  kernel/bpf/verifier.c                         | 18 +++++++++=
++++
> > > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++=
++++++++++
> > > > > > >  2 files changed, 43 insertions(+)
> > > > > > >
> > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct b=
pf_map *map, int off, int size, u64 *val,
> > > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, _=
_safe_rcu_or_null)
> > > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __saf=
e_trusted)
> > > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__typ=
e, __safe_trusted_or_null)
> > > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __s=
afe_untrusted)
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct v=
m_area_struct) {
> > > > > > >         struct file *vm_file;
> > > > > > >  };
> > > > > > >
> > > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > > +       struct sock *peer;
> > > > > > > +};
> > > > > > > +
> > > > > >
> > > > > > That's just one out of many. It's not really a fix,
> > > > > > but a bandaid for one case.
> > > > >
> > > > > Right, this is only one example where a pointer lifetime
> > > > > does not match with bpf prog.
> > > > >
> > > > > > We discussed it in the past and the only way forward is to make
> > > > > > helpers only accept trusted args.
> > > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > > We should do the same for helpers.
> > > > >
> > > > > What about just reading an untrusted pointer ?
> > > >
> > > > What do you mean 'untrusted' ?
> > > > There are 3 types of ptr_to_btf_id:
> > > > trusted, untrusted, legacy (without either trusted or untrusted fla=
gs).
> > >
> > > Ah sorry, I used 'untrusted' since the pointer is not always
> > > valid, but I think legacy is the one I meant in this case.
> > >
> > >
> > > >
> > > > kfuncs now accept only trusted, while helpers still accept
> > > > trusted and legacy. The legacy should be disallowed.
> > > > That might break some bpf programs, so it has to be done carefully.
> > > >
> > > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > > could optimise out branches that always return 0.
> > > > >
> > > > > Currently, this passes the verifier and can trigger UAF.
> > > > >
> > > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > > if (!u || !u->peer)
> > > > >     return 0;
> > > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > > >     return 0;
> > > >
> > > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_me=
m
> > > > treatment. So above works and won't crash the kernel.
> > > > It's effectively inlined probe_read_kernel.
> > >
> > > Yes, it doesn't crash.
> > >
> > > I was just unsure about the bpf expectation [0] like how we
> > > should treat KASAN use-after-free report by bpf prog reading
> > > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> > >
> > > So, if this is WAI, I'm fine with that.
> > >
> > > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP=
+SpHBGqKcUT0iMA@mail.gmail.com/
> >
> > That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
> > That needs to be fixed with what I described above by allowing
> > only trusted pointers into helpers.
>
> I got this point.
>
> > In my earlier reply I meant that:
> > if (u->peer->__sk_common.skc_family) # unsafe access
> > is fine. It's safe access, because it's sanitized by the verifier/JIT.
>
> but I'm a bit confused here..
>
> Even though the verifier makes sure the pointer is not NULL,
> u->peer can be freed concurrently by another thread,
> then how can verifier/JIT prevent UAF ?
>
> Or can this be still called 'safe access' regardless of runtime UAF
> because the user-provided bpf prog was verified once and not in-tree
> kernel code ?

The verifier/JIT are not preventing UAF. They're preventing crashes.
u->peer->__sk_common.skc_family is equivalent to two
copy_from_kernel_nofault(). They may read garbage, but won't crash
and won't cause any ill kernel effects. It's up to the program
to use the values in a sane way.

