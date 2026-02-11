Return-Path: <netdev+bounces-258175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8+lpNsvti2ktdgAAu9opvQ
	(envelope-from <netdev+bounces-258175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F957120CFA
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D7033006809
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668851DED63;
	Wed, 11 Feb 2026 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHBKtqO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B947083C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770778055; cv=pass; b=dg8qmyYPH5Pc2eEdKCPGI1JH17iT/kfoZnZaxpPsXQ1DIHHFU4OconjcGmPfEcnIZGYxABxGMX2mSGyGjxw91o7tNTQ0aUEjO9ON+6Uljw7mGFxwvNWVZCYH/6B42YlF1OsPPSQq7zMhGM/dgQ4zvDqzv3Fj3pqdijkc4JC9QLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770778055; c=relaxed/simple;
	bh=1EMmP3bOOgbmAcfssvM4Mg4vj58oM6VVlrfvuyMQ/fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSAvduL9wM8uW2dj2TKyu/2BZpsvDuBIeRd3G19LWhE3/zWcEMCVsZ8f9gK1oOvFsSe/wvRC3mclVpzx9qVJsYS0Kh6U9iXKmNvGrh651QLZKxBDgswsbkX9H90A2rNt4q9YNR1Fr6ExEhM9Z4zhVH9bCQQfntcyxpWAqryJ8wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHBKtqO9; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435f177a8f7so4642072f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 18:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770778052; cv=none;
        d=google.com; s=arc-20240605;
        b=EucJ1ppYxK7+RGWZaeFOGjx6nvr++4cAPBgXQsM6ysIqtUmh/cGiBLGb0y1WjCchNN
         8HJ2J6fu5GvrGK/mnkoENDVhlsOQGBC2guUI2T0HYF6BRuyNNnmifXgVa6oWc9TsaRkB
         lRoeyrd6ePlEkZz7IjrihUrk4c7vh5HTkcyVW0QrSitqtCi5l5EUIH0164Bu/EiYEQyQ
         3GtrlAH1NvMWMwDtLrZn8ToxwfcE4dahY5W/ObdDDfCI0/HBEUkg6PiweNSFuQEGZyW6
         bRi3fMrQrToDgbkEMmZBQehul+nbGlDR9h7hZfQfHQL/BzSiIpE4p05NVNrI6s8JVGtA
         FN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        fh=6V4n1gMZvm04wZxm/HoLJiMQ5Z7h4JAu2K5IkeIgGAg=;
        b=LOBtTzAdCKhnBgbYwTVxhKPeLbszgH3iWvlVTEZ3hgIj3po60GxOsadj0/3bdKh2hI
         DvHKakbYfgww7FJJxeJh2UBSAYa+BmW0ruz+Y+c2eVF+YQ2ibNawKeWSzDGL2q+CQGut
         Tr9he/i+9WbLI0+5VNZAvlz593KTssHuJqXuwiDeXUVmeHp/h1LfLt2ceN70UtzxSE/h
         eno+DmeFasyu8PCbFGVig/M8hEYZ46GPfq53N8FRC30LWXWvvnYEwyapn1hRkvsQsF6p
         q3LFbOvmJF9h0IRna4I6E+SkH8bk1RPLsmeLXD4/za27spQNbJlDZorp9uBAePAOGWgT
         iMOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770778052; x=1771382852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        b=BHBKtqO9XmGKnRJCmj4KJl/03KtMRMNTR7TiMcbiwft8fomOGvsERlHdpa6FbAknqI
         YdThIprGfyU9uGdKqB6Isved8r0+dscKp9WiwZYkz5qJ562m2PsWg1gnAzPdHTB8lx+8
         c0oV7Sfww657d9hDI+htyyWdGxUhIz1/N2R+AhIcSDuNllq4g3NBKUTityjz3GXtbpEa
         oCgHAMyuPYtAu80Gv4f4QmQlYOOhDE32eo7j4ok2vOXtp4qCNX1klWGHch/PTYYKID1I
         XsnjDzasRWzsa1YN4EMMUjfxG7gef+8YiY+wMHs/4M6XgJgAcqlGsylaeknZOklJ8E5/
         mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770778052; x=1771382852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        b=QV28zXmMccacTP2VwhnXiw4yWepEe3OFzbzWObbxqkLcNKXxu/n1FzjAgIT3SyBHKg
         Yi0FngcZHNoOM42t3wbn1pRfuLXWxYIUmTxYLXTj8mfxG4OzECG5BZUIHkpnB6tx7NtM
         uG71rLnCrxJpez/27dtQcJfdLNCRGb92edEcB408PBuoivho3ENThLj1+EaQSK3lPXWI
         LXp6qCTZBEYU6Y2XO692OAKD41+WAQuKYo6KTmJ9me9M+MR6WrZQYWL0aK3OEaeR2EZ9
         O/ae1yp1rlXuwZaA81ojno37o5ePkxMXEmTuh9LvWJRH8V+/fJqr5BZHSQre1R75SFjt
         6c9w==
X-Forwarded-Encrypted: i=1; AJvYcCUPkjMAfM58NhM00fFi+J6JD3wkIsKGcm8T6gFCg1tegkusf8qefZhT0lQIr2/R06bR/dQ8iOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+77VnMr1T7FUhNX2ty5DfNKSiwJzGdDZ+OMMdBbsCL1fI3NfD
	kZanaPirSNK+/dBBgj3HK4vi8kyRAmrSeZ7bdhsldfp8cwBLR/ss7B7N0ZQ9JtYhqVWHDWpGblJ
	xf+FcYMaK2XpNyIsd1FQ3n7CsXnaLCmA=
X-Gm-Gg: AZuq6aIz4/z3M6q3kg7NOfy2gVP4ojtaNrm78mxO/aBc5Jk7kyyEWqxEvMEvY02mMo1
	468W/9/gpC1YTMG7z7Ur9VjZ6VKnTweMCrt68BkbTWomcvq724WHw7JjmRVz8wJ2fq8Dw07iG5H
	6NpwKZvDQKsYynbtQrLK8+fcebqDPWe1zt4ObWacAX3Lv/aLVGtUCMkSyjgt7QMAvqiuvUUWS5B
	LUgqtvBXxev+/Jpp9WEloyCkFUPc4+A3NRN+rSGBhbDaGbVRGIpGklDJVFlXhB+TfbgFTZ8c4sH
	Dgz83YQGxJIgVqGStcAUrzgKxNPoSgwPqtbMcvWpY3GDZPcOIOcbUYrOdUFFu141HJJWHnLnGfm
	wT/QtgVu5ylYxhafSEzH5DeITQg==
X-Received: by 2002:a5d:5f55:0:b0:436:1707:2884 with SMTP id
 ffacd0b85a97d-43782cbfb55mr1732075f8f.56.1770778051952; Tue, 10 Feb 2026
 18:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com> <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
In-Reply-To: <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 18:47:21 -0800
X-Gm-Features: AZwV_Qjlm8gj9p7Vk-rjzYXw24X30I8fin4TlrHPsw_erjOADTwEOI-4QchPi5c
Message-ID: <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258175-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email]
X-Rspamd-Queue-Id: 6F957120CFA
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > bpf_skc_to_unix_sock(). [0]
> > >
> > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > but there are many functions where bpf prog can access the field
> > > locklessly via fentry/fexit.
> > >
> > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > resulting in use-after-free.
> > >
> > > Another problematic scenario is that unix_sk(sk)->peer could
> > > go away while being passed to bpf_setsockopt() in bpf iter.
> > >
> > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > by marking the pointer with PTR_UNTRUSTED.
> > >
> > > If needed, we could add a new helper later that uses unix_peer_get()
> > > and requires bpf_sk_release().
> > >
> > > [0]:
> > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > Call Trace:
> > >  dump_stack_lvl+0x5d/0x80
> > >  print_report+0x170/0x4f3
> > >  kasan_report+0xe1/0x180
> > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > >  bpf_trampoline_6442564662+0x47/0xab
> > >  unix_shutdown+0x9/0x880
> > >  __sys_shutdown+0xe1/0x160
> > >  __x64_sys_shutdown+0x52/0x90
> > >  do_syscall_64+0x6b/0x3a0
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6c=
ae0@rbox.co/
> > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++=
++
> > >  2 files changed, 43 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3135643d5695..b328a1640c82 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *=
map, int off, int size, u64 *val,
> > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rc=
u_or_null)
> > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_truste=
d)
> > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __saf=
e_trusted_or_null)
> > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untr=
usted)
> > >
> > >  /*
> > >   * Allow list few fields as RCU trusted or full trusted.
> > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_s=
truct) {
> > >         struct file *vm_file;
> > >  };
> > >
> > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > +       struct sock *peer;
> > > +};
> > > +
> >
> > That's just one out of many. It's not really a fix,
> > but a bandaid for one case.
>
> Right, this is only one example where a pointer lifetime
> does not match with bpf prog.
>
> > We discussed it in the past and the only way forward is to make
> > helpers only accept trusted args.
> > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > We should do the same for helpers.
>
> What about just reading an untrusted pointer ?

What do you mean 'untrusted' ?
There are 3 types of ptr_to_btf_id:
trusted, untrusted, legacy (without either trusted or untrusted flags).

kfuncs now accept only trusted, while helpers still accept
trusted and legacy. The legacy should be disallowed.
That might break some bpf programs, so it has to be done carefully.

> I used bpf_skc_to_unix_sock() in selftest in case compiler
> could optimise out branches that always return 0.
>
> Currently, this passes the verifier and can trigger UAF.
>
> u =3D bpf_skc_to_unix_sock(sock->sk);
> if (!u || !u->peer)
>     return 0;
> if (u->peer->__sk_common.skc_family) # unsafe access
>     return 0;

No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
treatment. So above works and won't crash the kernel.
It's effectively inlined probe_read_kernel.

