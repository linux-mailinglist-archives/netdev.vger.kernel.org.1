Return-Path: <netdev+bounces-298252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0YGxDSHvKmqazgMAu9opvQ
	(envelope-from <netdev+bounces-298252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:23:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC6673F19
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:23:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ukhLLI00;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298252-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8716D30FA083
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F44C77D0;
	Thu, 11 Jun 2026 17:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97147A0C4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198327; cv=pass; b=Umv0PR9dVqzl/unhkEduGPHa0MeEi2UUa2WK5n65wGzT8QZiNk5GwPhL/BacOjqLbgDwpOeoX+jQ29SPK4/KiQ5pjdUsPwiqM8BxvwjzvvRLI1UxcidhlY5f6QMxa+9spTDG427qzULdQUn6fsoXKsiltiWGVYWZz7eSSdpmysA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198327; c=relaxed/simple;
	bh=RF6RnK1V6KWTJODwlSUS8mSgqzTMBaybdR5w62cvbXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEA2bpJqDHxmAUEmcQNlFNg0x4qw5aGS/H03knx8/sIQpc4QXH+BVJyhbSpUfqEb/3KM7UqvlBXEu/Z4vSsoeYvgZtIZ4XW/XKioRt5VJN0elzAYYOIsBlXgIH/Y7TDJSifV6czUS+h6MedHzlLeVdSD8hl3bT5404/RVb5iOmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukhLLI00; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e8833c99fcso863967b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781198317; cv=none;
        d=google.com; s=arc-20240605;
        b=jE5I6acl/BAXlYZD8lrX67CuiWERK/AlbtltuXAwWKo6lD1A99mvyO+MLYM0+0Sqvy
         IEE8nPfT8hqHKhS8W3aJ1MsZONHpbsaBkumw/6G550v9Yrv1Fqx6ZwDPUvg66I643BYu
         rKxtqbxEuR4BIa3+U++4mnWqbGCbUPBkHERkNZ/DqcOci+gpPQVS5/FuqqcGZ79fF3Hh
         2h4aUOA7rsMk1pDer7Uic/nEc0ZB9/VxpG/c0j7C76BIT3huW9rUdkIrnLSNQgVdL/1v
         Tg65wQ8xa5Q3C6eiKoL9IZds/NCcq7NP+KLtL3M9CcGqJ0dbjVC6A8YivHNM6OXtFcBj
         M01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yxvgmlFS8nguHYRzqj3MhrJBlnYhEzk73xvYxti+qI=;
        fh=SN1ViyKC8N9zdjKziY3LauYF/DGJ6FkiTymiomnn6fU=;
        b=kwa9ZD9poTAtEW0DOek7TiIHjMgKf3TWSHhw3hvLB0tlVCsDyh1+DC7SPNO2Iz50oH
         Ce4NDIxXxW2Z/0kcWQyxjHyjPtZZl+ypDZeNqJLnJsH1BKIq5VQCjQeof/4vUYnrjgSE
         t0XjEkt8Q+tFsWDqbvczr9kdfYeghRjhTtoCptEiiYW2n7UfGgjagnp1XN0MqL3oYPqW
         r63jhrMy2ggo1rLNQwK9jEn8qkVr6gXFaj8k8cT6QuPKgcRHowJz1tZP3VuvxoWC8RY3
         c2DU2CP/YxooBkaxtToanZ5dSuUu5loYXP/5uLMZL+SoHjKrBv43UkDPsHbfM5Fa9u7G
         5PpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198317; x=1781803117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yxvgmlFS8nguHYRzqj3MhrJBlnYhEzk73xvYxti+qI=;
        b=ukhLLI003yqyqv2UcvYMW7PdV0N9EZpM1/sIFSKPUV0HL+iLbOs5ovoNokIUNoWHkm
         kAmPutpE1yPTbkK6EgxgA8TjX8qkN9NhuUD+oUiZpQu0amyu1Z5CKMk0S0Qo8wDHaY49
         uyhHSYGo0O6s9VPPUi7S/UMiejDHUxGBN7ZS9dgKNeiPq3Wpzs4DMcBLsi9yV5+20e2A
         y8FNyaeD0YNE8xI2UT7DN14YmD0xHT3mlXZ+ELAQPGH7ldZc6e/xvDMp4U4SrbJoLklb
         v8f5pWEPu9G3it7lQ2l8GYOAH4PH+6HDqcnOaK4EZ34jifGeVKwr2U9Tiuiel5XrxXy9
         h/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198317; x=1781803117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yxvgmlFS8nguHYRzqj3MhrJBlnYhEzk73xvYxti+qI=;
        b=sqMx3XSCKiZ59WtcGa2NBwlZZ9BCrfVto8C6pMTkorljBAgG86WLw24ok17U1tQ+v+
         kyRb6kNs/vMli9NA6Sp1jVgJL8HqvSq3rGbpK3oo/3k6Po2AqFnpb/nnMsFJhqtkzUO3
         4iv60lvnUkrOZc7LYCbj0ipKS50SpxXQdFq5NQd1vV/d4SLLyRETd/MAMWEV+3d1tv34
         5J7LXFcfRRWozBlMmqKszZ7KUe+iS12dtvMo0RnXgEhiFaB+vWORPIJVjQKjGFSsxxXp
         DtRe8VfymMlEwdBfST9gt4+CR4xXYzXgJYSh/PWFEnx+uQXQBFXjcP8vN6rC+FLq/JQZ
         EQQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cCP8Dv1SQDXJTv8021tdN7utkvu23UfOibueQH1R+Cm7bJSQI7+q7Yk5niGjGanb6QUqo2/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00wHBPli3U5lzN4CFi1DhzPtsa1WBJAkNHy08gO/AVICbNXgP
	ldXNVq1s5buXqKcCCT9d3h2Qi8GJAp+TYLJuviShCkEXqr2yyreGDWssOe76Fr8rikJ0CXRfU/n
	TQ+DXblWib56Ui3Oyx6ij/JCrlukq7E8q1EbUoK5IssL8zo9/L688XdEp
X-Gm-Gg: Acq92OGugfFQb0N1Yb/bODr50RWIXrY5CYXO39oTxZ6oy/T7ZAPhtXeCEiu7NnX2bkM
	IIkO5Vyz7pXeN0auG0ribrwU3ltoFu+uRiMuWEAqKhFw5aQFwMeUBh5r2/O4jM0nbSF1sp3jmaj
	/yiB9uH9VgWrfOU3a0XhoRdKUlts5BzikSgfYPY7LLHIAypaou3akg9ddMCRub1Py2u3ALJ+tjL
	MGX9b1wuNKDDr+fRCookthUuD9AHwLCRwlYW28F0TePQK5mzU/IZU6GGPyTFs9ReSPtkFyAYEoV
	WKEE3E+0yII95m3w005dh9jvymw2apIr1zv0SSX7FeObL57wGeidyT/TiUxYsZXIe2LBR7hzFwq
	tz/SqnOVaImHXHIe5BFQ=
X-Received: by 2002:a05:690c:4a11:b0:7e2:2c41:4f70 with SMTP id
 00721157ae682-7f6554f5ba0mr41694587b3.11.1781198316461; Thu, 11 Jun 2026
 10:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780979031.git.bronzed_45_vested@icloud.com>
 <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
 <CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com> <20260611102134.5886fe04@pumpkin>
In-Reply-To: <20260611102134.5886fe04@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 10:18:24 -0700
X-Gm-Features: AVVi8CfQV9C0jwXUGSwnP1WIRJkEKyOZcBjF7zwOzAQqmvmw5mg65JBwzz4UyY0
Message-ID: <CANn89iJREO16p7koa+bXdkQPxzxpvYUFU6QmpLK7wwe13CU13w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
To: David Laight <david.laight.linux@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, 
	fmancera@suse.de, yuuchihsu@gmail.com, idosch@nvidia.com, 
	herbert@gondor.apana.org.au, yuantan098@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:n05ec@lzu.edu.cn,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:fmancera@suse.de,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298252-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lzu.edu.cn,google.com,vger.kernel.org,redhat.com,kernel.org,nokia-bell-labs.com,suse.de,gmail.com,nvidia.com,gondor.apana.org.au,icloud.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,icloud.com:email,lzu.edu.cn:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BBC6673F19

On Thu, Jun 11, 2026 at 2:21=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 10 Jun 2026 10:04:06 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Wed, Jun 10, 2026 at 9:18=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrot=
e:
> > >
> > > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> > >
> > > Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> > > socket state. The sysctl is stored as an `int` but copied into the
> > > `u32` `tp->reordering` field for new sockets, so negative writes wrap
> > > to large values.
> > >
> > > With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> > > `tcp_mtu_probe()` size calculation and drive the MTU probing path int=
o
> > > an out-of-bounds read. Route `tcp_reordering` writes through
> > > `proc_dointvec_minmax()` and clamp them to the per-netns range
> > > `[1, tcp_max_reordering]`.
> > >
> ...
> > Thanks for the patch. I think we can do better.
> >
> > Also I do not see a fix in tcp_mtu_probe()?
> >
> > What about:
> >
> >
> > diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> > index c0e85cc171aec099fd5d4897b1a623dd27eaee08..987bc87e255a81680ae5e23=
ddd01c1f0de4425ec
> > 100644
> > --- a/net/ipv4/sysctl_net_ipv4.c
> > +++ b/net/ipv4/sysctl_net_ipv4.c
> > @@ -1058,6 +1058,9 @@ static struct ctl_table ipv4_net_table[] =3D {
> >                 .data           =3D &init_net.ipv4.sysctl_tcp_reorderin=
g,
> >                 .maxlen         =3D sizeof(int),
> >                 .mode           =3D 0644,
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ONE,
> > +               .extra2         =3D &init_net.ipv4.sysctl_tcp_max_reord=
ering,
> >                 .proc_handler   =3D proc_dointvec
> >         },
> >         {
> > @@ -1293,7 +1296,8 @@ static struct ctl_table ipv4_net_table[] =3D {
> >                 .data           =3D &init_net.ipv4.sysctl_tcp_max_reord=
ering,
> >                 .maxlen         =3D sizeof(int),
> >                 .mode           =3D 0644,
> > -               .proc_handler   =3D proc_dointvec
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ONE,
>
> Would it be reasonable to put in a 'sanity' upper bound here?

Probably, I am not even sure we use this much with RACK anyway.

Neal, what do you think?

>
> Since tcp_max_reordering can be lowered after tcp_reordering is set
> the bound set here isn't 'hard'.
> So the same sanity limit for both may be enough?
>
> I also found this 'gem':
> void tcp_enter_loss(struct sock *sk)
> {
> ...
>         u8 reordering;
> ...
>         reordering =3D READ_ONCE(net->ipv4.sysctl_tcp_reordering);
>
> Which makes be think that someone expected these values to be small.
>
> I don't know what the sane bounds are for either sysctl or tp->reordering
> itself (which is u32).
>
> -- David
>
>

