Return-Path: <netdev+bounces-298021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIGiJKB5KmpeqQMAu9opvQ
	(envelope-from <netdev+bounces-298021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C467024E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OCGaCUu4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298021-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08B1430067A5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949136921B;
	Thu, 11 Jun 2026 09:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92308391826
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:02:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168535; cv=pass; b=p1MDHWeW/AQxR9vqB4trJOdASwp7OG0pW2lrOirlLVy+0N0DOnKnsXxAHkKshP3ERv1fXQRqaB4m+06F7CP0GqEbvrsZjTBlu5hgWPKFvVqh2cWgPWZawn7SKKmNaWG3xXuyuwImLB7IP+Tf6MliABkVYAj2Rypgn9WEavTIhbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168535; c=relaxed/simple;
	bh=Q1PsgtMA+I3Pe0Hr6XqziPGeccF4AlHt2HLLuWMgILU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxhf8NBahe2WrB7U6dGDYFTinGFeDM5LMjaeQr3DQ6uml+XE/Cj5r7i33ze7M31z+QR26oBYj7psQnw2ItvIWB97GdAKjBbAx0FBeXC2zF9I1ucTOWmTf5/8msnCS9PLw65FhmGNhJlYVg2rjvslgoWtG8ZQ1s09GR3gfGZA4vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCGaCUu4; arc=pass smtp.client-ip=74.125.224.50
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6626cd98209so216077d50.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781168532; cv=none;
        d=google.com; s=arc-20240605;
        b=FFlnUI+CDmBxxNS062wNMg1SmPpAh849YEdXgL3EsMUjqDZCNjs1as9crsxLH+j5+K
         Ykl1fir2ByCsW7hbwT9zk+5Ld2DGcoZLYGnaNVDObPlA7/itphrftvLlWILp0zjTHzXc
         Z4rypS+wNIfVJw3XWJ469rK/BVaO9LCkssXY66TojKeA7l9Y0hlmD3YACf2Oyml4BC3J
         zwzt3QIN8UCzISrBNeGUpCHbiIE3uKfYzUuMxklD4GeEJenLEi+S/rBPPSMRMreFrUxw
         /3BUC4QGcuSjn/3Ly/w0Hxd300I2ZLWp/+jjQ5+mOuUCgnImTUgq0abNhxzSvBPn0f7d
         AocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        fh=vSM6PYrELiK23q1HCHrqa/xt/bBD27tvzDP3lTlUVdI=;
        b=Hp9d+Ly//qdrpYYjZlxAt8R2slLGfc2vkQ5I4VS28DR2P3t2ALTChumjiYQQmnnG6J
         uRJ8hFK3FgtFUEj6QAzL24V1ckTcP97DxhF+fDsPQ3t08keQfTuhLdR5mDZTJJVUGo9m
         /1xphwH1C/swlHwOwWhgEz7dzClLx2cANkAQ/tGJFCQ4TGa0XQHf5sFp80wELK8QKc6X
         Enbp6nMtxiObrUw5TOWWiAQnqDmu9eqVBkK9wbfopYbizPlkhwWgaMlMyIhjhWvHRdCV
         Ip9CfO8T/JjGNSx3ztpazmU/jx3kyQC+WOmlbIXrQwslfnaK2mKTK9/CicI1jyGwfurf
         9eOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168532; x=1781773332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        b=OCGaCUu4Ub0Iozx6xOL6F/dl3Eg1b7rpzo1ZDasQvD+ZQWkggaxZmg7Y5/hW52hOFs
         Lg01MkAvSugVoGBJvm3NRDnoBUWyd+NPkr3GezdgT/r723iGQTLJ0KB8gxRI6T3lRDiX
         ZNXC9FJiyeXUDQ7+KQ6XRJWC864Vp7NfmwpT6lrGwBh1YPuWNDkjHY0jC7fdneq2480N
         4hkjCJGIu9gQiIKkTfO4bOWqRcOl4hDAXd4r5ePG6WXzRLXEwhTPrlkeWVNiUIyTQWxc
         oiMkH0oJiK+JRBIHuvR2r2mZMNbs+Z5wmol1CmTqlCvnUZsUPmORm8aX6l5UCUHO8S65
         MBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168532; x=1781773332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        b=qwb52J+stZzDORw77EdUe1ZHr64FpD62G61Cfj2Taoskb596/kVgJdrpRP9NHuM175
         4BCeb9ZG2s3Y29Or3Pnhj/kgnYxxfMp2eh0whyD19eQNuiZUiQlIJt57bmHeadzHEMCN
         gG1NNboSJpOtY8jBSkii23PVD/KTgilsNsPzk+82SClOWI4B9l5e35/ZLbkM+r7IlVEh
         pfvHt4AmhbRxnCvSDBUrR7DAiHB3B4E3XUF/lmjAruUuL4ER+9SuKJ1w4QlVDQ+8DSDf
         EP10T/vT0NxvcFrkY/npANS7cizwRJsIxEbtjt3Ph2uYm1egcHWyz4y7XSfEeFj5gXiy
         tzng==
X-Forwarded-Encrypted: i=1; AFNElJ/PbMysudDYNqscQOwK/8P4PsylIy8brJqrvbdjDRCp0URzaSu9S4HRzKFtsNlbO9oFqyfzmIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn12Z4Co9BLE1q5/NdqeMf+264ZJHXkGhWEtYbWVU42dAcoNwi
	miMeORblI2MFVbMbsN+d+IEkg0dlyKQFGzOMHCQZQgmeX6IhiQtv4ILcnY2eSj2IonJCIkZcYSV
	OaaR9kCCWI6yahdW2Eo0rdIXbEUeU95qj8bPNADwg/Q==
X-Gm-Gg: Acq92OEs2Fh9nzgv+NsBG6xTQ/2rlp+Hwc52+A4ZQ4KEhn+0gPJPlKR5J4X0dhw/319
	8tgDVAVHcnnVsK8wguIrBP9sTvtuj80i+dBQBpXuUOshbCbpYeXhe79TQe7aWGNIWLMbeVQJFF2
	1bagtW6qEh7W12k3yXD+JshQKwD16fakyHw8hZufSgz419C3FytgXxg2eOWmR6/7E6antpVt/Jz
	PsGt5Kr/8r1m1yThws3EnZlZAfoYHKvtiS26fNykB4MfANwoqEJ0hpR29Uoou10t8lFvm4LkPhm
	MyT+iTvw5bi2pTv9CkC1o18c6WT0AgOz1PiRaiU23VmXKodzmxmkNCocWNTnl5KFfThUGA==
X-Received: by 2002:a05:690e:1289:b0:65e:40ef:dc8f with SMTP id
 956f58d0204a3-662699d47e2mr1333630d50.51.1781168532418; Thu, 11 Jun 2026
 02:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
 <20260611080850.536996-2-sun.jian.kdev@gmail.com> <87se6t8ono.fsf@toke.dk>
In-Reply-To: <87se6t8ono.fsf@toke.dk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 17:02:01 +0800
X-Gm-Features: AVVi8Cf37KuwlUK8Z0rVVPD6yzLkCu6ujOmcxJpQ3mVeHP2o2QssOHKpn8udIUs
Message-ID: <CABFUUZHMomSb0_goXcWvamVhuRCrft-L18UgJ2TowEXiptsQqw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Run generic devmap egress prog on private skb
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	jiayuan.chen@linux.dev, menglong.dong@linux.dev, emil@etsalapatis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298021-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,vger.kernel.org:server fail,mail.gmail.com:server fail,linux.dev:server fail];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,etsalapatis.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC0C467024E

On Thu, Jun 11, 2026 at 4:30=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Sun Jian <sun.jian.kdev@gmail.com> writes:
>
> > Generic XDP devmap multi redirect uses skb_clone() for intermediate
> > destinations and sends the last destination with the original skb. This
> > can leave multiple destinations sharing the same packet data.
> >
> > This becomes visible after generic devmap egress-program support was
> > added: a devmap egress program may mutate packet data, and another
> > destination sharing the same data can observe that mutation.
> >
> > Native XDP broadcast redirect does not have this issue because
> > xdpf_clone() copies the frame data for each destination. Generic XDP
> > should provide the same per-destination isolation before running a
> > devmap egress program.
> >
> > Fix this by making cloned skbs private before running the generic devma=
p
> > egress program. Use skb_copy() instead of skb_unshare() so allocation
> > failure does not consume the skb and the existing caller error paths ke=
ep
> > their ownership semantics.
> >
> > Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for =
generic XDP")
> > Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  kernel/bpf/devmap.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index cc0a43ebab6b..a3d6c60dbddb 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -512,35 +512,52 @@ static inline int __xdp_enqueue(struct net_device=
 *dev, struct xdp_frame *xdpf,
> >       return 0;
> >  }
> >
> > -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dt=
ab_netdev *dst)
> > +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> > +                                 struct bpf_dtab_netdev *dst,
> > +                                 u32 *act)
> >  {
> > +     struct sk_buff *skb =3D *pskb;
> >       struct xdp_txq_info txq =3D { .dev =3D dst->dev };
> >       struct xdp_buff xdp;
> > -     u32 act;
> >
> > -     if (!dst->xdp_prog)
> > -             return XDP_PASS;
> > +     if (!dst->xdp_prog) {
> > +             *act =3D XDP_PASS;
> > +             return 0;
> > +     }
> > +
> > +     if (skb_cloned(skb)) {
> > +             struct sk_buff *nskb;
> > +
> > +             nskb =3D skb_copy(skb, GFP_ATOMIC);
> > +             if (!nskb)
> > +                     return -ENOMEM;
> > +
> > +             nskb->mac_len =3D skb->mac_len;
> > +             consume_skb(skb);
> > +             skb =3D nskb;
> > +             *pskb =3D nskb;
> > +     }
>
> So with all this pointer soup and back and forth, the version you had in
> v2 (with the check and skb_copy() in dev_map_generic_redirect()) was
> much cleaner :/
>
> -Toke
>
Hi Toke,

Thanks, that makes sense. I agree that v4 made the helper interface less
clean.

I'll wait for more feedback before respinning.

Sun Jian

