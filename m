Return-Path: <netdev+bounces-294307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B40CO1UNH2qMegAAu9opvQ
	(envelope-from <netdev+bounces-294307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:05:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EF630819
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rL0tt7Y4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294307-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B450E3025293
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DB38D3F1;
	Tue,  2 Jun 2026 17:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5F35292A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:00:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419615; cv=pass; b=sjfK6cRp9nt2hsacZEpVhEGduEjIBEoN/iac7Ds2bfMVxtttWqFafrxq095p/yxceBr5hRVYtgCrK4NL9xs5EuQWQwFG5ktxsCr8mJRxHJ46XUyP6DQJiXBFZMoJcBbn/sdFBdpxD7u24CIkZklvojtmZLRBN0z+tPERtP3embY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419615; c=relaxed/simple;
	bh=drNlRluABRnJtprucJzGVievS/w8VYPwS2qqj1Vtf9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auyYFaq0HwuXdN1gb/c/HrbpnVHbPlMuqw4KtJuocRoQTW2wssU2N/3SYLwC6hnbhf5+gKJ+/ZQ+xxq+Bsa66bXyN/7ql76xTaBS7HQ5XwKzho0ymPoyWJyZKHjF60Zr94dI7LVqmNkFvx0XXfpT7CF1b0AQi7bDRuZ+qXV/nPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rL0tt7Y4; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d634956fso133509881cf.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780419613; cv=none;
        d=google.com; s=arc-20240605;
        b=Aw9ADNqBoJc0pT2aPoPMmO4V7hM3xXxq232lZqQCaSAFE1EjskfAQlbOY4vT27RAMP
         8kP7NGVmFxCvkfRBjv6iMiFn9Bharh4uJZ2erWOVhcBIJH1wJUNpTOGaQ8ATGlUsorRP
         GECS/uuH15WyymMOp8vjedMfGaK82B6SUozYzwEX7AeRgcSELFiV2VgKnMvLw8m6LE8t
         tTEP5mmUvu06wO0pSghaIdEhlV45ZpB2k7GjJv0vXFzDlif66T44FYXgImTBV7J6QKp4
         jVRl5j7ecbTIeh9u3gDIXeSPS9q8KjHrILj2AC2rcIXV8dZTpk/nb5C55qWdRVQyOEXL
         Z20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBhc8/ih69iZXkvQ+oh7MO055cOwe4gcQ9X1rXZHFqw=;
        fh=0QcKFhKY5v6vWJpPuRtRclJGTbXrHyjRc0LvrQzggco=;
        b=WNthvCpdCUk3jR8Zs17ymSpMFdYgu++gbmoccDY0Hr94lizBXICMgQU9D/RLu2j41K
         IxW3zRBj9NSjgVecnO9NH+WY1iIYs2GVW4zEt4IQPeNj0S5G/6MAJOKEEr+JE/M68iOx
         yWRPKGM4O9jiO4r4JdEDjKg3T72jv0R+OfXchsbxBBV1dEj4iOrWObKU3gdNNmO95ooJ
         U2jsRrtBv6NNDiHHKexKxPH1Tz6Z6xMf4xZOifK5+s9VZD3c9WBeZu4rlf+abn/4jLtI
         HQjw4CbBTczQxfp15hr+2hQG8Z6n6lrExK0yw8zkXE07m3CJgF0izi8i9EaZCbl87ZCf
         v5HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780419613; x=1781024413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBhc8/ih69iZXkvQ+oh7MO055cOwe4gcQ9X1rXZHFqw=;
        b=rL0tt7Y4BqoQc+Rp7qJ8672US+Fa6PILit0efVS+0il3lj5vo5sT+/wPNUXA0SUSbg
         EY1k/Dj2LBR01xKosuY6fUwk7c3S6REfigJ1eTyPWDqJ0IKfqdvkHrhHbAlJs04xo9BD
         4+7fnUeRjhecxA4UOqRbYY0ZBIfadIfclSMGFqseQWzBC26aDIXiPOss26SX0eUSErF9
         k/2uYENuF/8kGJo6Dyk3kvo1Vp7oFwZDct0q924sWv/k865DZEQTfZ3BXtLcUzHUDdvX
         pmj03kCI5FPpIsmZhsYHPvLjyVjdaF+kNkp1cF1dic/DN40VjyNUUNblrAph0HDwf2UA
         8Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419613; x=1781024413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBhc8/ih69iZXkvQ+oh7MO055cOwe4gcQ9X1rXZHFqw=;
        b=ieb//lkEAGgOw24mrSIIF49LJbg5Fb25kNWZIsAJwvZPOLgw7gSVHUMesImhc7Sp7w
         zLLIM08V82UWv1ItWH3aTE/DVOz9B3mABUCQ5m9vcQlGzZ/JOh/B3eXF0SMf1hLZpI1u
         zOnCADav9jFO52Weus0vEQVzqCOHTg6Tcal4tfuz7wzjPryeutasyEvqJBtkC/aSHrd3
         8bo0IZHo1XxXxperwvZ6//WYsT+FXzcMvAICl8Ad/LKBv7MCtAnJr1WQWpY2z1z+jGE4
         2xj0WOOS+6h3WkV7aQI/LON6HrZyvZReS0dgLpQkJdrkuR5W5L3SaR/Q8tniG3nItN7M
         HXHw==
X-Gm-Message-State: AOJu0YwLPWWQ+8fXRMQXXXCkfQrbqmUjW0Raml+6W1EHu9mvfYroDIa6
	x09sJSnzHQSo5OHiJn/4NbzparFkZaEBE8vtBrxcQoVfnQblbFnyRGW2uAT29jVYN5mLVePsR2q
	+2rsEVmYGnluQ9eC4wgTgMQpAQ4wU669wa8iu7lll
X-Gm-Gg: Acq92OFTzi9B0qCznGz7QSc/r89DYUBoCJaATTEntEQecbnAKm3931aMj/ntmx2EJeO
	O+CEpJFEZ9zxmhXdEMzgWVA+m4v66MdDSzTQXjrbFGOQsFIeXkBrxqLL2I/KYBoJKb/dPokmZqp
	Z2FQO7gQccUnHX24u8NiG6pdZKfDEoyYxZIS08nFgUpCvTmWd2r3swGKwQmQb1S765fEZotkC4P
	Ta4wu3En7HaOtSNl7nT1J9weOySXiFoiVpOOwd1k3cL9DJ7c6hKtJxhfvCwCOYjq3OM30j88Hm6
	sAaf09J19SLU/zSDJ/d4OxSCowFyF9yWuE9NUDOOVEQC2k3mOHeI67KOhEm+RQkC4mAhIVHih23
	tAOk6wnopAmM3+YcFev4ZAgSQArU1ysRDR3VvNO8=
X-Received: by 2002:a05:622a:588f:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-517781045e9mr355731cf.11.1780419610615; Tue, 02 Jun 2026
 10:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602162727.893863-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602162727.893863-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 09:59:59 -0700
X-Gm-Features: AVHnY4Lh_1oPRlpZANoDxriKJDXUr-c48eEjIKhNsrcPd5qyLhSewz3s74JK6yU
Message-ID: <CANn89iJYzJ8GDoEeVywvShQsW4FmAM3YCZ8qSZAM-7BZXwT1mg@mail.gmail.com>
Subject: Re: [PATCH net v2] raw: annotate data-races in raw_v4_match()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, maze@google.com, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:maze@google.com,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 434EF630819

On Tue, Jun 2, 2026 at 9:27=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> w=
rote:
>
> raw_v4_match() is a lockless match helper under sk_for_each_rcu()
> and still reads inet->inet_num, inet->inet_rcv_saddr and
> sk->sk_bound_dev_if with plain loads.
>
> inet_num and sk_bound_dev_if already have WRITE_ONCE() writers, and
> raw_bind() should use WRITE_ONCE() for inet_rcv_saddr as well.
>
> Add matching READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> v2:
> - Note that inet_num and sk_bound_dev_if already have WRITE_ONCE() writer=
s
> - Add WRITE_ONCE() in raw_bind() for inet_rcv_saddr
> - Previous version: https://lore.kernel.org/r/20260601073937.1137673-1-ru=
nyu.xiao@seu.edu.cn
>
>  net/ipv4/raw.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 5aaf9c62c8e1..faa49f3d239a 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -120,11 +120,14 @@ bool raw_v4_match(struct net *net, const struct soc=
k *sk, unsigned short num,
>                   __be32 raddr, __be32 laddr, int dif, int sdif)
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
> +       unsigned short match_num =3D READ_ONCE(inet->inet_num);

I think inet->inet_num is immutable, raw sockets have SOCK_RCU_FREE.

> +       __be32 match_rcv_saddr =3D READ_ONCE(inet->inet_rcv_saddr);
> +       int match_bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);

Why do you need a local variable to store sk->sk_bound_dev_if ?

This forces the compiler to read it (in a register) or store it in a
temporary variable
before tests that might short-circuit the read (eg if network
namespace does not match).

>
> -       if (net_eq(sock_net(sk), net) && inet->inet_num =3D=3D num  &&
> +       if (net_eq(sock_net(sk), net) && match_num =3D=3D num &&
>             !(inet->inet_daddr && inet->inet_daddr !=3D raddr)    &&

Why isn't inet_daddr covered in your patch?

> -           !(inet->inet_rcv_saddr && inet->inet_rcv_saddr !=3D laddr) &&
> -           raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> +           !(match_rcv_saddr && match_rcv_saddr !=3D laddr) &&
> +           raw_sk_bound_dev_eq(net, match_bound_dev_if, dif, sdif))
>                 return true;
>         return false;
>  }
> @@ -727,7 +730,8 @@ static int raw_bind(struct sock *sk, struct sockaddr_=
unsized *uaddr,
>         if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr=
,
>                                          chk_addr_ret))
>                 goto out;
>
> -       inet->inet_rcv_saddr =3D inet->inet_saddr =3D addr->sin_addr.s_ad=
dr;
> +       inet->inet_saddr =3D addr->sin_addr.s_addr;
> +       WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
>         if (chk_addr_ret =3D=3D RTN_MULTICAST || chk_addr_ret =3D=3D RTN_=
BROADCAST)
>                 inet->inet_saddr =3D 0;  /* Use device */
>         sk_dst_reset(sk);
> --
> 2.34.1

