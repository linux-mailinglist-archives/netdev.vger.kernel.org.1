Return-Path: <netdev+bounces-266687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHSjLmyOsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:46:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67450266BFF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3BB230FA619
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF936D4FD;
	Wed, 11 Mar 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbQCxJiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0332572D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243908; cv=pass; b=Th1MP0cI8ZLtsArkd0JxlhD/d58V/zAeq0PGkFANC8dDwSjGrTFO0lWN7RNIzPfDQ29/WTn/PhYOj4nnXFbpAG1r/ZLZHaY1Z8r+B6dUVNEKixn53IN6P+IKaWoKlkoEBGRDht3fMtR72GjCJdHFEOwfLghY7RSPRZAAK2cDvVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243908; c=relaxed/simple;
	bh=Cealpa4wizJ8480d9oSZXFOM7NEwmmWz1/9vguosSAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpVRxXhPGtOHQAvBfpV5YM8CnbK3VvQB0vGzG2r1v9IZiln+/s5lmZfYvvmSObolgctjY52EzOLHIaduJihFll50uFQldKclPHHrtTyMeIkxeK+YjNLLO8hbC4KkEr3VgB7kFU0yZueks/4W1EkaxSC7EhPToYnIi9+8OZUBGks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbQCxJiR; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so41083495e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773243904; cv=none;
        d=google.com; s=arc-20240605;
        b=kI6+BmubWvf7UijWF0tF9lGdSAgL6a0VrqxqiG8qjvZfzamodSrpRnFNTtg5soyTGx
         iD08ZH1w83VR1A7QaYBZn/38P+JZtmNjfd6oNOcpIp2zXv39QQvwtuRT+t66QJElFrAB
         M41MFsqcGGpuV3iZh5HQ3+hGFkGZRdMBJyFmB64zr8rGIroIRpHigdKQa7UEa5noOE5L
         ACWWGCxCi0h9poE8CuWjjSbE/VCVPzle/AJO9EAe4VCiVpxXAgugY35PhCxa1im6qpYC
         rraRH78ui9sE6iKX4HqitO1orsqagHntOc1wFvnk2iawhPKwsyuBBe99laWkBgOAPo3f
         LKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        fh=C695wpWsUNEli271/g6AfRck3OwZrBnIjdYbAh3eBmo=;
        b=faH1B6oszQwFil6fPMkgYLKpSgE9o2YzDdVRTacJp1pg9+uEI2+wWrorGhh9kCEAs4
         sOj1VVq1fMTckS7JKvPSCEOtinPcctW8PD0fJW4Szu/UQYEpZ4yCWr+i6FS1a59LgIPZ
         iA//QFV32cAoLE6HxZ3W2BImMg8wOYID1IbV9mQP+uMjAt2vup0kQ2c2NcjxnRt7hXt0
         j5aKJK9qAaHYDqnp/c3Wp0qU/Vf8fUu1FL8u9S1OVZvmRKX0M1SBqFjeN+YHuJRs0Qu9
         /9ECbJg217p/9aWWNC4qZGsHGKuxb8QvxXYjIX1miLavTux3R7fbuQwSt3oIIqCJ45Ym
         PYxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773243904; x=1773848704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        b=FbQCxJiRxh0p6uVjU7Q2Ntc+AaW3L8DV9W2dfQ0XRv9gBXubLT7H7HG6yxUYoBPN5R
         yk3fkpIFgOTuJA0lf5NpDVjEDiqXW+g16YF30XydPl6i9bw0AcNH7nkZekB1oyrVPz1b
         Yo6GXYrqM8j1rJdYoX3cnbVl0O6k7SH9nlKv/sm+Q8c4F7c96j8VJdBot7EMF3yC9b5x
         azhNDcR9Ft2n22N699sYnbcf9yzF6pHxrrWWovBWr3tc3Olt6DLAA7ddf0lGPFXK6OPK
         lVAMDfnTU0mdFg78idbHZhnChIZoFVgy3uGhkzC24AoC1gBxG8Cc4hDOTVHYEQBsChxz
         XSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773243904; x=1773848704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        b=qo8fjPP7Jw8TuXnaWvLHUjH1yK1VwnfvprFR78Knsl5YWkcxjcJgxdXw/Ng1UKDwjR
         mwX6vV78R3a68jAzp+dUwqAHIKksskdy7m2SUlQCBYSyCg8GYC49PJm+dZBFsExjXfRP
         1Cy8TStj7TCueVj17h/I4Phk7XvkWxFXCDklBETm87zA+HlPDvMFHmZdZRAPi71ukcS+
         LLjH5+R8ng1jsrBcid7IQwTzNENrqtKvOyBQjJO5QPAexCekBCjK8VNkm465SYbQevUo
         MqhrYf2C+/9V1WbYccJgpSw3dQY73Te/jp7LcP5UXjVgtFSH6GiBdNX25sg5sOW9LoeJ
         3Vfw==
X-Forwarded-Encrypted: i=1; AJvYcCWEnC+jLCMeZ+LROfQD82oZy++udjIkH4+i7vlXX7uajcJpQFMfgJ01e8VsBqgdxVHMzTC7Xlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlKWsjXWD340I/s5Z25YOzYlFXzoNC7o4tnZlQLhom1Jc2kdY
	ZgUPD/qajJhXYHue+ujUkQKkdiaQd4S0I3fV783z73B/UxE66aep+elwNaF1XYbwfAje/g34pQq
	XW0sQOkZ/OLKMSn8LjBlUtzgPa1tKfqI=
X-Gm-Gg: ATEYQzxCCWG2bxOTQV+9n2ox4DtwNMNTEdhO4ZPB66EJ8KqtkW0jFT5AqvfdGgu2ft/
	z4SMBZnjZQke7KZs8nRRGTFVAH5pfOrvsGLT2Yz6vwXVj6K4v3XtHS+7Wf6YvBElQtr9UFUhDos
	drY8jVDxLEgBxJcTUA5pHjmK2Qv147Lc6jLOQ0Ia8cgPLDzVpfgOEk488Ddku5oQfMGglllfofx
	I6Ea2myGJNCd8T4HiaOH9XsGCwlwh6eKi7IMcVMDEQ1spGDbCBuDfCJFv3cLDgyv21gyzMfDmmd
	R2jYqtKL3PTQuJ/1GldK2tjdsmTfFpLPWpJSt2nZDsdPi2+Zfy1RAs0QIKbrjv0a8IgtOhuixqP
	om6s+nHrJFnXam4WZU+nPFSpvfQ==
X-Received: by 2002:a05:600c:64cc:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-4854b0b97fdmr48721955e9.8.1773243904237; Wed, 11 Mar 2026
 08:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
 <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev> <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
In-Reply-To: <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 08:44:52 -0700
X-Gm-Features: AaiRm53SchNpZb8YhY7jsacq3OKB-1k2FHbNE7n6phLF0ekD6dALQr59DCuF8EI
Message-ID: <CAADnVQJ=NGUydRq9SghNgoo2a3JZqz4498Sk81t4CfdHm0vSHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Menglong Dong <menglong8.dong@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266687-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 67450266BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 2:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 07:08, Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > On 11/3/26 01:23, Kumar Kartikeya Dwivedi wrote:
> > > On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
> > >>
> > >>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > >>> --- a/kernel/bpf/core.c
> > >>> +++ b/kernel/bpf/core.c
> > >>
> > >> [ ... ]
> > >>
> > >>> +     switch (match) {
> > >>> +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> > >>> +             if (owner->kprobe_write_ctx !=3D aux->kprobe_write_ct=
x)
> > >>> +                     return false;
> > >>> +             break;
> > >>> +
> > >>> +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> > >>> +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx=
)
> > >>> +                     return false;
> > >>> +             break;
> > >>> +     }
> > >>
> > >> In the v1 review, Alexei Starovoitov asked for strict conformance
> > >> both ways rather than one-directional validation:
> > >>
> > >>     "Don't be fancy. Require strict conformance both ways
> > >>     in *all* patches."
> > >>
> > >> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM=
3Az197eL_0A@mail.gmail.com/
> > >>
> > >> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> > >> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_wri=
te_ctx
> > >> but allowing the reverse.  Was this an intentional design choice, an=
d
> > >> if so, should the changelog note the disagreement?
> > >>
> > >
> > > Let's follow the approach Alexei outlined, while the changes look ok
> > > to me, let's remove the one way check and just do
> > > owner->kprobe_write_ctx !=3D aux->kprobe_write_ctx, same for the othe=
r
> > > two checks. With this we can also get rid of this INIT vs UPDATE
> > > distinction.
> > >
> > > Other than that I think patches are good, please also test both
> > > directions in the selftest in next respin.
> > >
> >
> > Hi Kumar,
> >
> > Thanks for your review.
> >
> > I agreed that both-ways check could simplify the code. But, the UX coul=
d
> > not be great.
> >
> > Let me explain it with an example.
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >         __uint(max_entries, 1);
> >         __uint(key_size, sizeof(__u32));
> >         __uint(value_size, sizeof(__u32));
> > } jmp_table SEC(".maps");
> >
> > SEC("?kprobe")
> > int prog_a(struct pt_regs *regs)
> > {
> >         regs->ax =3D 0;
> >         bpf_tail_call_static(regs, &jmp_table, 0);
> >         return 0;
> > }
> >
> > SEC("?kprobe")
> > int prog_b(struct pt_regs *regs)
> > {
> >         return 0;
> > }
> >
> > prog_a is kprobe_write_ctx.
> > prog_b is !kprobe_write_ctx. And, it will be added to jmp_table.
> >
> > With both-ways check, prog_b is required to modify regs. I think it's
> > too restrictive for users to use prog_b as tail callee.
> >
> > With one-way-check of this patch, prog_b can be used as tail callee to
> > keep regs as-is.
> >
> > This was what I was concerned about, and the reason why I did not follo=
w
> > Alexei's approach.
>
> I agree but the main question is whether such a case is realistic, are
> we going to have write_ctx programs tail calling this way?
> Tail calls are already pretty rare, thinking more about it extension
> programs are probably also broken wrt checks in this set.
> bpf_check_attach_target is doing none of these things for
> prog_extension =3D true. Nobody reported a problem, so I doubt anyone is
> hitting this.
> It probably also needs to be fixed.
> Since you noticed it, we should close the gap conservatively for now,
> and wait for a real use case to pop up before enabling this one-way.

+1
tail_calls in general hopefully will be deprecated soon.
As soon as we have support for indirect calls there won't be any reason
for tail calls to exist. (other than not breaking current users).
We definitely don't want to open it up further.
So the simplest fix.

