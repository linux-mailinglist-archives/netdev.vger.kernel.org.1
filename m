Return-Path: <netdev+bounces-258375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNz8FVQBjWnAwwAAu9opvQ
	(envelope-from <netdev+bounces-258375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:23:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E70128187
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44373303C334
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E02350D46;
	Wed, 11 Feb 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHYER+Pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EF34FF45
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848593; cv=pass; b=UmytMa/k2MQcgfENJkqkOJyLwLwDBE/XJUf5X+HMMT3auVx3VF0PQBbEkDxpnH6cLQwi8YyS45mK/qehwQ3pBWqbAxpHWIZfYMa9PxmhlDfXPMzqbO8fkm/3dSVLKGw/lt4cD1CTj3s9LQkYqzJ3ROwHUzEfhHD5Z87TGbSJLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848593; c=relaxed/simple;
	bh=eXDI5rcV+A/T0/rpbI/ShJOsViO8yaBsbpbntt+dflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T86FfWuySzeucvBKvvyusDZQA03z4tr/UzSZFwTodxv7nAEFthHDM77QBwa1hRzKbeKa6ux5QCaLdKp1vHLfPBW3BXobCNMZtKwO55mLB7F4/uGTCJ4lEwiIO3VAgP8DCT11FXD+iPR2cmSLWpw+KIwEdqVM9S+NvcoS/lWPqwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHYER+Pn; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12721cd256bso4559835c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 14:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770848591; cv=none;
        d=google.com; s=arc-20240605;
        b=H9iviISZt78opM0+bLV4c3yscyuPDtGpvmi3MXFnvD2QTyX6oA/tcN8RI/q1hl9BTW
         PhgW36xPYGE2aXZplN+DY7maS3LJKZrI44MNyw+sjUxppctXlcB7HTlAuY0JW2gFRYmq
         nRq56xlLkK2U+j3MuRHH/EubkLxsr9rCUwB2WVvBrruGG250Mr2sm5+i3qK0YxncgxWi
         hn4EYJhAS3jqU/XtUBsDWeKPLbvrpJGtXB6BsqFU3BmFFeklxWu4Br/0kRIs9lluTV5y
         VuJWvd5X1a+qQ8efJHbE9xr1ZUqG2rE4atRqTKQ+DbXsbx9TBpoDxB2p0W1J2h/Ywg7l
         58yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        fh=qqQeR6RMM+0i8KaPMWpTLGQRrVuxFYhBmtuCN+gWQWE=;
        b=Vk850petMrm1o6FqAj5af2mCA/0FO5lhMvWPGJXe6GDdRtpEdzFzm6lvBak5fD8cKU
         jbkLPYuUZBsvUp+ika+FZw5bOXFJUbovS0sVN1o6BWw5vczj+/7Y9AVLdJ/6fhak2HG+
         h/Bq16Us0/b/SX4bwB+yfBs+OecJGwZAfGZZJ59U7cBlDa1h8KWuQWyHRSxO8xY5wrtL
         HqJNub9ItBR2bF3nsO0BZ6tf9A42InDbG+nB7wiCwMIzzvk0DtO9eWBLisso0+bp63VT
         DzPU/BEEYIv2HpQzJ0HsAgr2959aNcruqfC9Vl5ChLoL2xOTtkgXxP6gXtGNJltqnRp8
         O7qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770848591; x=1771453391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        b=UHYER+PnFcGCyQWDmtc9O//LAEie/bQwyaQWFCokH0mVBNlCK/in4gLojClY3q0lUc
         Up3jlmYodtPtQ9nEVefP8jolqeGI+tGtDp4RWN3z5105oJV4eOarHhs8wKfxSzBa5QeI
         a2lFj7Zs1BcW6aEmD6a+J9fqWDimONs2gmM1oCjNE7BhfgzfrMN+DKoehXgyASRtvWf+
         mowmjD3sj/Bc9BeRvwvAEckm/JW8MkFBYauRxgh1w9Aytt0OGImw2pdwtwaZSDrHSXTe
         jYGCPI/wBWJCn1WNpF92GCB0Lgzlq4vSKoMcs5Vwe3FFxw3YCud1O5UpjNCd5mbHUbob
         UjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770848591; x=1771453391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        b=WF54FgiVPR4UIKjkjRLNp0TPbWrQePOFtjVE1wUYnbwuOtDCSB1Gqce+yZ3nvvmv85
         yJvx+8dCJjW4HPGrMcGgnkCj5ZnBPYCyY3icycuyLa8/8uYoBxmK+4zYmX76iNDYoSSO
         9Dcw1JgAdW3AjdYI6GZoiQ9rzg11HtJ5VKYpBWxrlA2MR3h2iIZllJAyken5L2CmkVTZ
         b6ij3gBUll8/lbzJevauSGy1t/Adgcxn3PCN2MXOM+NO7erUNOPJ0W/YQzyGMadQPDzp
         bCUX0FJmkep/t+a36HI470pJUDWy86KqSgCrQReOMlgYeZeKKlN4T+oN6Ck/UnObro10
         x69Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr1Pt9Ottd3v7qTlTS2BLChqGQrbYWMvgpJ74Wp/q9Ej6ze7QlKJ8XYEFr4TuCSlvqfbLXE9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZENG0ZSmum2gaPEFopAQqar5wv1FLzukmam5MeTr/YY92yjp
	EKOAPcotdMqbmPK2lPFOrA0oZ0zUUynEJTHqS9NTH898LlJrgOSXzPGa9X9O9+HaUP9RXK02dLx
	x3tyuO3kP6Bid140lLofVl+ONlRBEoErXs9tt3Hwz
X-Gm-Gg: AZuq6aKGPRPLsinym6tVJ7UTE2BaelMyt+J9u9ITTiUT1yqU7X9z5QqSNi42lUfNbnG
	ENJZR/D7pLJvtO7587Ez6tBH6JJrbc15PzOHnzpuJpVCahc3vJO4ANBOF1kborI2f9NVYhG3xqW
	lEJAKrs3o9aoIr4tpdbcUicMoLyTPJ8HM4CscMbvMtDIkonCcEsIgBFxP1oMz5ZwvYRfnP1U4F7
	GS1Vm5YMOlqQvuamggOGDulMAicwZ7nN/VUKovefWynciJHdRjfQ2El3Rj1iER77ZU7oezSzxqM
	DAIL5d7aA05MTxQlN7qeTQdUHftpFXHfA3xIGreApqKsj+cpDHP2vyL03WNvuhlIwmF9Cf8O
X-Received: by 2002:a05:7022:aa3:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-1272f6ae25cmr375464c88.0.1770848590968; Wed, 11 Feb 2026
 14:23:10 -0800 (PST)
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
 <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com> <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
In-Reply-To: <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 11 Feb 2026 14:22:59 -0800
X-Gm-Features: AZwV_QiPNieHzWYGG_TDs6__svEWgiAeY4tKhfKEKpnfCSRcmQuqSC54pxDgLH8
Message-ID: <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258375-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,rbox.co:email]
X-Rspamd-Queue-Id: F0E70128187
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > > >
> > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@=
google.com> wrote:
> > > > > >
> > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > >
> > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(=
),
> > > > > > but there are many functions where bpf prog can access the fiel=
d
> > > > > > locklessly via fentry/fexit.
> > > > > >
> > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > > > the last refcnt of the peer sk while a bpf prog is accessing it=
,
> > > > > > resulting in use-after-free.
> > > > > >
> > > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > >
> > > > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > >
> > > > > > If needed, we could add a new helper later that uses unix_peer_=
get()
> > > > > > and requires bpf_sk_release().
> > > > > >
> > > > > > [0]:
> > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0x=
b0
> > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > > > Call Trace:
> > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > >  print_report+0x170/0x4f3
> > > > > >  kasan_report+0xe1/0x180
> > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > >  unix_shutdown+0x9/0x880
> > > > > >  __sys_shutdown+0xe1/0x160
> > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > >
> > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79c=
e6ef6cae0@rbox.co/
> > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c                         | 18 +++++++++++=
++
> > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++=
++++++++
> > > > > >  2 files changed, 43 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf=
_map *map, int off, int size, u64 *val,
> > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __s=
afe_rcu_or_null)
> > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_=
trusted)
> > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type,=
 __safe_trusted_or_null)
> > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __saf=
e_untrusted)
> > > > > >
> > > > > >  /*
> > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_=
area_struct) {
> > > > > >         struct file *vm_file;
> > > > > >  };
> > > > > >
> > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > +       struct sock *peer;
> > > > > > +};
> > > > > > +
> > > > >
> > > > > That's just one out of many. It's not really a fix,
> > > > > but a bandaid for one case.
> > > >
> > > > Right, this is only one example where a pointer lifetime
> > > > does not match with bpf prog.
> > > >
> > > > > We discussed it in the past and the only way forward is to make
> > > > > helpers only accept trusted args.
> > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > We should do the same for helpers.
> > > >
> > > > What about just reading an untrusted pointer ?
> > >
> > > What do you mean 'untrusted' ?
> > > There are 3 types of ptr_to_btf_id:
> > > trusted, untrusted, legacy (without either trusted or untrusted flags=
).
> >
> > Ah sorry, I used 'untrusted' since the pointer is not always
> > valid, but I think legacy is the one I meant in this case.
> >
> >
> > >
> > > kfuncs now accept only trusted, while helpers still accept
> > > trusted and legacy. The legacy should be disallowed.
> > > That might break some bpf programs, so it has to be done carefully.
> > >
> > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > could optimise out branches that always return 0.
> > > >
> > > > Currently, this passes the verifier and can trigger UAF.
> > > >
> > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > if (!u || !u->peer)
> > > >     return 0;
> > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > >     return 0;
> > >
> > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> > > treatment. So above works and won't crash the kernel.
> > > It's effectively inlined probe_read_kernel.
> >
> > Yes, it doesn't crash.
> >
> > I was just unsure about the bpf expectation [0] like how we
> > should treat KASAN use-after-free report by bpf prog reading
> > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> >
> > So, if this is WAI, I'm fine with that.
> >
> > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+S=
pHBGqKcUT0iMA@mail.gmail.com/
>
> That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
> That needs to be fixed with what I described above by allowing
> only trusted pointers into helpers.

I got this point.

> In my earlier reply I meant that:
> if (u->peer->__sk_common.skc_family) # unsafe access
> is fine. It's safe access, because it's sanitized by the verifier/JIT.

but I'm a bit confused here..

Even though the verifier makes sure the pointer is not NULL,
u->peer can be freed concurrently by another thread,
then how can verifier/JIT prevent UAF ?

Or can this be still called 'safe access' regardless of runtime UAF
because the user-provided bpf prog was verified once and not in-tree
kernel code ?


> The code inside helpers is a normal kernel code,
> so kfuncs/helpers should only accept trusted pointers.

