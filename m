Return-Path: <netdev+bounces-258377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDxQDIEKjWmLyAAAu9opvQ
	(envelope-from <netdev+bounces-258377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 00:02:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8A128361
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 00:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03E130FED56
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C53527FD56;
	Wed, 11 Feb 2026 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTT1eM9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0330148B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850904; cv=pass; b=WCvfCzH5QjZhVnb5MYURct0BY9SjJgRkFLIgNNjuA5E7u+3ybuqD/81nGuxTNsWFtqX9kuyB2n5qMYUdP9CKKGwcHalQJG1IzT8KJ4pQ8Hg+5yfV//LNzxyWdtP5CNarcHy1akY1nESIsVSNUGsyqfIHpe5XlUdb0PYNOw8CdMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850904; c=relaxed/simple;
	bh=1udlOiyE/Ppx2kNUZ2ygSNvFIXtyAU8H42LORwBeYA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFh9TuBJ3WmayFH+A5xsERxkOaXTzH7rdEKrgPDHcnCG+6zuht5cFuRKek9D6lLMRr9StQE29c3lT6kyrkEVpi99azgHpBKFiG53RHhNNQXmovyo6u8SWDVZUpV2zhSyfWobiGbeL372Ob1NSYk5AmcLLTM1Uetg20zcNSc6YIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTT1eM9x; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124a95e592fso150066c88.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770850902; cv=none;
        d=google.com; s=arc-20240605;
        b=O8s8wquFIMEdjOwMIYv/pPsvCevSOERyWMkCxd1FvXeiywyjG0nRbfetq/wEdNA8s5
         8X91r6eLv/yldjoSUTiTZ7463n2riUp9FunP5341U5n48Mc9SNxPuB1ohMZ8lpbpFMhS
         nEZX0ONSjUDdtuRaQ/TUpyFw9nz2SGXU2rpw6iRhZTryznnqoT8IiPMFZxxiaRgA7g+1
         95xAtF6DFVGF8adk06SVmqKGwPYaeEbgqM5eyHvUdXeAb5lY2O1mk0xuiuKOBUML/f8o
         LWOKI7Isos97MjcTRZiO/mqZPEYSnQsXGrs1lXdvOivrPIAvnU22fn70RXZCuyUX8Zxe
         XAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        fh=64yxvz93vNos+hnIZ3LZ3UMaHgGPOmCLtAL9JpqusKg=;
        b=iW6BrXpSch80nXgXlWZ2lt7PIp935d6KOUbZEyVi4a6rSFBZPJLSTKR73h22mrG19R
         9GG+E+vDUgHqKkOImqZ5if8yQR01/kS0nsfbAgz16hFn3hvZZfn7ztZSejhPeEGAzNjU
         DtvatDBzEGxtWHb2c+EH4E7K9P5VLBcl1bGcj0R5rXlzxg/hwx0uvO851ofe0cFJG5rv
         g/SpTtrsmB/4gRu5nX3OdoZS4dqofBt8VKRIR/u6mnZLEHW+tSb6I+PreGtjcprYvOYQ
         Y3FGTGxO7ffHxJpT+7CORwxzuPRl8FFEReoC5TmRasQ7zgiDw1RY2UYimmqd1u1ePE3k
         WEjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770850902; x=1771455702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        b=GTT1eM9xyOI64gbEHWAlGC13XWHAh4jaXcswlafdvjtpF2qw17YtHOTIzlUFJhPQp5
         5M5AGUJDFXaxpl3W7BFEbVTcm+urUlLa2RbxKKGhmMCuE8mU9IOC4hxFQq/icQ0vkAz3
         S+AGutSSCi7VwvmIraNVs60FJheykGfbR0AndRnneUshbYxxgG3MHowcsTZpl5yDtl8C
         CrkSXOj/gz3L0SxdGmhh+5pcqTizWFPDDh3dhvw2wZV8mUxOC+g/X1jPIAywZ5WfZ2ML
         zhKl5GYYfmtajoQf/ArRyeq4XOpMwE9+fAyR5P1W5EWhZR9bTtf0xSRBU2Re4eFGevZe
         +PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770850902; x=1771455702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        b=qLx3rdM5kjbJaPs+fIVRnKBabFQPRu0N1w7+pKDSTDImFHVv7vX9hmdHuVnYZrjr8s
         oPDxRFt88XUQQ8rh6TZiG1dNyoDNLIqbZwV9a+5IZtdr/lm1v/WjWNAfUjd3GXgp3+eo
         1WczXBFpvNGOSxsmAhNo5+JVYQOHxitZa3UT1v/BX1b9ph2PLvcsczWCrpZ3eJaJzw7z
         BqeNKCzV9kVGyeh+Nnjqpts7q4gnxwVG+BbYYMEdkqFeKIXZgjNX8MOfCvh0gnU0CPCI
         7DRZpdrfNc9GCT3CVvgnTGXcihp5NSfASNsK4N76zzZ57/g6DSpEE5eB+S1iNAcZ0140
         bfag==
X-Forwarded-Encrypted: i=1; AJvYcCW/BASxIsIw5Je4DV3IQrBx+XNeUmzU0bZYGr8AYkSLlVvlzqtoPptAI5nnUtoT+1b77cvoX/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9pB4erNZBI2gKvNlr8XvyQE3UAzJl6K/OkbQIe6fGVrHFGzI
	WjP+kllfbCqXVG6hwoy8PR6F9d2dgxLpKc/AfeJGkAwcBJr0/zXHrKOq5ybHf+WLqjsT8jnn0x/
	ufPMdCema/X2Fi74uy1H7YwXvraO0PqAFE2lRihXO
X-Gm-Gg: AZuq6aKOxFYDLxw1z0+MKHa8oRtyGH2s2ZrAmW6QTHkzmDmcpRy2n+d7oAiUxJEVIeu
	DTgdsT6zyJLX0nEpKbmSa+riNfHaQxM3bVe2RpOxXzWdp3B1ecXTupoWQNgOEjhljbzB/0Fzj69
	ful5lKWOWRNyPuC9CNZdcZhuvyPXxi1bKlg0+OVKEfGPm+ayNnQGAAzpaoqH8Tq6GfQyM7zyyDO
	UVSqR+jfellFsWbQpx056bXacBHo212hiOekJmxmuZcpeInb1nKco/66C8nhi18c8c9LKLSwy1d
	N6atRKBdTt08Zafy4qGAQJ4VQEhRrHrUB7DcDgn/85uK1/1xe0HCKcTRkg0u5TZGZrggPAdk
X-Received: by 2002:a05:7022:61a1:b0:11b:9386:a3cb with SMTP id
 a92af1059eb24-1272f79d964mr331465c88.44.1770850901221; Wed, 11 Feb 2026
 15:01:41 -0800 (PST)
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
 <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
 <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com> <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
In-Reply-To: <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 11 Feb 2026 15:01:29 -0800
X-Gm-Features: AZwV_QhvnyTfpo7ZeXE5tz6CWfHDm_tDg0QmL3FSO5v1u6Lfo4ma72i6m6j-1Io
Message-ID: <CAAVpQUB5mGbD79ZLVCi0G8UDpwjQW15=BV9maB6ikLzCYTjA0A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258377-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,rbox.co,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8BE8A128361
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 2:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 11, 2026 at 2:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@=
google.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kun=
iyu@google.com> wrote:
> > > > > > > >
> > > > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer =
by
> > > > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > > > >
> > > > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_l=
ock(),
> > > > > > > > but there are many functions where bpf prog can access the =
field
> > > > > > > > locklessly via fentry/fexit.
> > > > > > > >
> > > > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and rele=
ase
> > > > > > > > the last refcnt of the peer sk while a bpf prog is accessin=
g it,
> > > > > > > > resulting in use-after-free.
> > > > > > > >
> > > > > > > > Another problematic scenario is that unix_sk(sk)->peer coul=
d
> > > > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > > > >
> > > > > > > > To avoid such issues, let's reject access to unix_sk(sk)->p=
eer
> > > > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > > > >
> > > > > > > > If needed, we could add a new helper later that uses unix_p=
eer_get()
> > > > > > > > and requires bpf_sk_release().
> > > > > > > >
> > > > > > > > [0]:
> > > > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa=
4/0xb0
> > > > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/=
2495
> > > > > > > > Call Trace:
> > > > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > > > >  print_report+0x170/0x4f3
> > > > > > > >  kasan_report+0xe1/0x180
> > > > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > > > >  unix_shutdown+0x9/0x880
> > > > > > > >  __sys_shutdown+0xe1/0x160
> > > > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > >
> > > > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helpe=
r")
> > > > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767=
-79ce6ef6cae0@rbox.co/
> > > > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > > ---
> > > > > > > >  kernel/bpf/verifier.c                         | 18 +++++++=
++++++
> > > > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++=
++++++++++++
> > > > > > > >  2 files changed, 43 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct=
 bpf_map *map, int off, int size, u64 *val,
> > > > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type,=
 __safe_rcu_or_null)
> > > > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __s=
afe_trusted)
> > > > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__t=
ype, __safe_trusted_or_null)
> > > > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, _=
_safe_untrusted)
> > > > > > > >
> > > > > > > >  /*
> > > > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct=
 vm_area_struct) {
> > > > > > > >         struct file *vm_file;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > > > +       struct sock *peer;
> > > > > > > > +};
> > > > > > > > +
> > > > > > >
> > > > > > > That's just one out of many. It's not really a fix,
> > > > > > > but a bandaid for one case.
> > > > > >
> > > > > > Right, this is only one example where a pointer lifetime
> > > > > > does not match with bpf prog.
> > > > > >
> > > > > > > We discussed it in the past and the only way forward is to ma=
ke
> > > > > > > helpers only accept trusted args.
> > > > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > > > We should do the same for helpers.
> > > > > >
> > > > > > What about just reading an untrusted pointer ?
> > > > >
> > > > > What do you mean 'untrusted' ?
> > > > > There are 3 types of ptr_to_btf_id:
> > > > > trusted, untrusted, legacy (without either trusted or untrusted f=
lags).
> > > >
> > > > Ah sorry, I used 'untrusted' since the pointer is not always
> > > > valid, but I think legacy is the one I meant in this case.
> > > >
> > > >
> > > > >
> > > > > kfuncs now accept only trusted, while helpers still accept
> > > > > trusted and legacy. The legacy should be disallowed.
> > > > > That might break some bpf programs, so it has to be done carefull=
y.
> > > > >
> > > > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > > > could optimise out branches that always return 0.
> > > > > >
> > > > > > Currently, this passes the verifier and can trigger UAF.
> > > > > >
> > > > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > > > if (!u || !u->peer)
> > > > > >     return 0;
> > > > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > > > >     return 0;
> > > > >
> > > > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_=
mem
> > > > > treatment. So above works and won't crash the kernel.
> > > > > It's effectively inlined probe_read_kernel.
> > > >
> > > > Yes, it doesn't crash.
> > > >
> > > > I was just unsure about the bpf expectation [0] like how we
> > > > should treat KASAN use-after-free report by bpf prog reading
> > > > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> > > >
> > > > So, if this is WAI, I'm fine with that.
> > > >
> > > > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2Rb=
LP+SpHBGqKcUT0iMA@mail.gmail.com/
> > >
> > > That's different. That's the actual UAF inside bpf_skc_to_unix_sock()=
.
> > > That needs to be fixed with what I described above by allowing
> > > only trusted pointers into helpers.
> >
> > I got this point.
> >
> > > In my earlier reply I meant that:
> > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > is fine. It's safe access, because it's sanitized by the verifier/JIT=
.
> >
> > but I'm a bit confused here..
> >
> > Even though the verifier makes sure the pointer is not NULL,
> > u->peer can be freed concurrently by another thread,
> > then how can verifier/JIT prevent UAF ?
> >
> > Or can this be still called 'safe access' regardless of runtime UAF
> > because the user-provided bpf prog was verified once and not in-tree
> > kernel code ?
>
> The verifier/JIT are not preventing UAF. They're preventing crashes.
> u->peer->__sk_common.skc_family is equivalent to two
> copy_from_kernel_nofault(). They may read garbage, but won't crash
> and won't cause any ill kernel effects. It's up to the program
> to use the values in a sane way.

I see, that's fair.  Thanks for explaining !

