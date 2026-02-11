Return-Path: <netdev+bounces-258360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCmwDjn0jGk8wAAAu9opvQ
	(envelope-from <netdev+bounces-258360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93729127C12
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944E13010B92
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACD3624CE;
	Wed, 11 Feb 2026 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR2unsBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B3339719
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845169; cv=pass; b=mmTr9IsEZLZgaepoEaxUBX1qAir1eVfFQD8Sh0j8aGO0eTAIdtncdHVw4s8B4BOIekA6AvEEM2gEWzEqFG330mN5v6wianS4f9GPpn4jzBtmhUMrQDk0HJltW+0ZzC2s24RXPqfATF8OBKQIwf1zQQRB/h3Mwb5LXbNyTTnTOrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845169; c=relaxed/simple;
	bh=F2M7aQlFoZH0cgy1kFODhyqS8nrF6gbB7NAYuBeaUTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJwn9jMZDmxGTcPJ+M0zD4UPiV9f+FodcGRs1ttp00ME9xm2EHkseqNnp+6f4tSHo1UL9OD9FRn5gf6fOHFkVsNxqnh2C/vFOyUsLilRr969D7mhLwgnEVsOJul3GfjKqhqH0BsyDI6GZcXGyQi3XmT3kXWwsw3PEqWsolnpB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR2unsBn; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43767807cf3so2993916f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 13:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845166; cv=none;
        d=google.com; s=arc-20240605;
        b=dScgAMY7EndwGFw0qUNKB9OdguBTk7ZwmVxpq+MRYF0lghQ0XiVse+sPeHDnDpxphV
         H0fI/dN2lbwlN+UTVZsQUavIB6pRKHmAKPje0d8ZtiG3KqDTqceOD0icEAFQ2LL1jfFz
         fkEM4fEaJWrIBgEbO/ImylKCMMtUVMpQLVazEV68COnwiBD7opn/zFDxxcutkmydVVR+
         IcnD2XLJhUKE+P7Y026ZMdxZj500GD/XrVoobuf0BUTXA+X0grXHwRh4Ek8l8q2mNQD2
         3yOXxTIu4KsgNj9nB/XcPG63fKbde0RdI90QxJjdSbbBKOR7qOwTGLKPOuEJ/qYyCvea
         lzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        fh=vQ9dC6mCVaWHzAJ8dlGsjBSzujnPIC/E3mt3o/mtlW8=;
        b=hy/YbQWkwZizzgioXUmFck1aKRQHt+77Cp4Yz5dTUlIJEzuwus1dilZ612XhsbAT29
         UqHiVkwNS3vrid28+vMent6W3mCLTn8dc3q0dpJpIVSVJ8VMxdR3QbmN4l+/5zQjSgOn
         6/Am4xkfM8xwYnIU7G6WYujniG1TYQZu1npNV5/5d+GNQII5SK7YVocB/NcGfem9dUYd
         thcHiC+QOXlHxrjQECx/09ybQKEjFus7F04QY+O8F4Tttw2RStIMt2ESS7yrEVJ8mCu8
         X1+E7CVFk7fOb8iVDbZQycNGOxv45MK7ZTV4crl+SJsnZnkWfwufYGOn86oU5bF6KS33
         L3yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845166; x=1771449966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        b=MR2unsBnLBM1+CzuSXpvL09F3V+2/OoVR58SFRX31FgaVFtixoWaUZ/WFu7ZVOU8on
         GU7Z7Ix2onbMJWmVBxPV2dcO38gafRGbYqCmo05ykJR7zuL00/m7/UqeR1Wu11597X4B
         9rOe/F9shJzqcOyqA2ND9P2Pzq+s8QNl97LjIZQV/VsVnL5Ma89eCEXZFlUVRcVP9EBp
         gJtfSvU8VPsqmRNCERLgfNbHyXP0Ok5pmAgBhjhw+r1nznH2Esd4lXV+Ci7Y1x4gIVpq
         oerEqk96n9h/NH7dCd7Kn8+BkIK5ne93uiA7hOxSf7/RjdbXzkzJG6xW/7C3ILy9o2iH
         sSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845166; x=1771449966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        b=JhkdZz2SaaeMhKvN2Tiu+1RwQEiwavH0Ar+gQWoD1PqtwfBJMXC1iYgSDj9rYaNLrx
         Yxsz6Xi5HoWXAe4komM87ywITxsu2VeFmzsMmztTR6/qpZ+RjTZfYaPvsYMclswLGoQk
         UhZiThgiEPKBso5EPUDlKgGj/HLIgckn7zbq1Q6TtmJkj18x6bd2A2NfMSr//iej0h8K
         bRxqldFi5Pel/XYgVY1fY90p0e6xj2HukrBKzSB61konyHv6Uo45CHVPnwXDjJICTorf
         lURT5NOCSJsO1mO8+SLIshP355cHrd1lfVP/f6FI95pSmwYMkPAMjKvnberKZeEgPuUS
         SUYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWN/ooNQ8YFpeuxauKr3QXGhaqu6OMrTPHoIF3fR+XIkGc4KPrf4c3GURaPNpQCz6lm0/PXxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcsuBuzFVBQcSr8dFZL4DuUSRUMDvMkzLcvI63bwS02P2dugv
	3v3BWGSapfV9wBjpYuN44v0EEurWY9NCtLjwAXH17nkMPSjtTrs1WhMskdQy4bZTGhVE+bpvFa7
	8EtZDkd2IyrvsGk29HHtW4H2yG/3FI8w=
X-Gm-Gg: AZuq6aKjfh+TP5CLHOU9hgPL9ETYXtexnLs3QDOlaNRXPoq1JlZBHSNjRhUsBc/NXUm
	JtOXxrlUcjp5YJg3SvJBYvJFkZHo4xRyFouDpnDQuSCbI3yTQgURO9Z26H70skxb/y6VMXxBpvl
	pSm2n9r1wNDI4wtIr2ePg7gyDCQHNCEEbk2+ucC3dwkK83AKrK7PNr5JK8ql5nhEk0gIhViG1cZ
	eLndlsFMioj452I0VCvKKvuSk18YHU4l9qWsPxT7H1iLQweRpOlcS+wJEUNBk6885txaK19wnHp
	+ix6PCj41tT1+RU+bbfshhv3QQCmHLfOqFp0fM3D5RWo7hXSBcSQVDni6MfSsxKorR8yb3Sl8rw
	qwtBFoveuMNZSHLntRqnYx3JL6A==
X-Received: by 2002:a05:6000:2dc6:b0:436:3475:4737 with SMTP id
 ffacd0b85a97d-4378ac830dbmr1118836f8f.30.1770845165507; Wed, 11 Feb 2026
 13:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
 <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com> <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
In-Reply-To: <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 13:25:54 -0800
X-Gm-Features: AZwV_QjLi8Bv6mmZLoIJpsm3LgwONesQYtRLMgT6WXTmt9Mr1zAQ9ZKNptCgiO0
Message-ID: <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258360-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 93729127C12
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@go=
ogle.com> wrote:
> > > > >
> > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > bpf_skc_to_unix_sock(). [0]
> > > > >
> > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > > > but there are many functions where bpf prog can access the field
> > > > > locklessly via fentry/fexit.
> > > > >
> > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > > > resulting in use-after-free.
> > > > >
> > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > >
> > > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > >
> > > > > If needed, we could add a new helper later that uses unix_peer_ge=
t()
> > > > > and requires bpf_sk_release().
> > > > >
> > > > > [0]:
> > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > > Call Trace:
> > > > >  dump_stack_lvl+0x5d/0x80
> > > > >  print_report+0x170/0x4f3
> > > > >  kasan_report+0xe1/0x180
> > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > >  unix_shutdown+0x9/0x880
> > > > >  __sys_shutdown+0xe1/0x160
> > > > >  __x64_sys_shutdown+0x52/0x90
> > > > >  do_syscall_64+0x6b/0x3a0
> > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >
> > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6=
ef6cae0@rbox.co/
> > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++=
++++++
> > > > >  2 files changed, 43 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 3135643d5695..b328a1640c82 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_m=
ap *map, int off, int size, u64 *val,
> > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __saf=
e_rcu_or_null)
> > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_tr=
usted)
> > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, _=
_safe_trusted_or_null)
> > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_=
untrusted)
> > > > >
> > > > >  /*
> > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_ar=
ea_struct) {
> > > > >         struct file *vm_file;
> > > > >  };
> > > > >
> > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > +       struct sock *peer;
> > > > > +};
> > > > > +
> > > >
> > > > That's just one out of many. It's not really a fix,
> > > > but a bandaid for one case.
> > >
> > > Right, this is only one example where a pointer lifetime
> > > does not match with bpf prog.
> > >
> > > > We discussed it in the past and the only way forward is to make
> > > > helpers only accept trusted args.
> > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > We should do the same for helpers.
> > >
> > > What about just reading an untrusted pointer ?
> >
> > What do you mean 'untrusted' ?
> > There are 3 types of ptr_to_btf_id:
> > trusted, untrusted, legacy (without either trusted or untrusted flags).
>
> Ah sorry, I used 'untrusted' since the pointer is not always
> valid, but I think legacy is the one I meant in this case.
>
>
> >
> > kfuncs now accept only trusted, while helpers still accept
> > trusted and legacy. The legacy should be disallowed.
> > That might break some bpf programs, so it has to be done carefully.
> >
> > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > could optimise out branches that always return 0.
> > >
> > > Currently, this passes the verifier and can trigger UAF.
> > >
> > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > if (!u || !u->peer)
> > >     return 0;
> > > if (u->peer->__sk_common.skc_family) # unsafe access
> > >     return 0;
> >
> > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> > treatment. So above works and won't crash the kernel.
> > It's effectively inlined probe_read_kernel.
>
> Yes, it doesn't crash.
>
> I was just unsure about the bpf expectation [0] like how we
> should treat KASAN use-after-free report by bpf prog reading
> a pointer whose lifetime is not guaranteed by bpf helper/verifier.
>
> So, if this is WAI, I'm fine with that.
>
> [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpH=
BGqKcUT0iMA@mail.gmail.com/

That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
That needs to be fixed with what I described above by allowing
only trusted pointers into helpers.
In my earlier reply I meant that:
if (u->peer->__sk_common.skc_family) # unsafe access
is fine. It's safe access, because it's sanitized by the verifier/JIT.
The code inside helpers is a normal kernel code,
so kfuncs/helpers should only accept trusted pointers.

