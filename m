Return-Path: <netdev+bounces-293996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK8VLmtOHmrmiQkAu9opvQ
	(envelope-from <netdev+bounces-293996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F15627C82
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6F9301389A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C44E3546E9;
	Tue,  2 Jun 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsIHo38i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BB2C234A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370740; cv=pass; b=GHtstnXQJdhWNxxtWa4NPqvXcheJAhlMG0H1tAeV9OX+dyzMPZvRy9nO7m5hvRSlKRRKIv9Db6cuzM0eZyEpMhCQDF43NENlH0QOAWpTSfh8Bf6EkIWqDPn3+2Of21RwhpT7MW7Vb9Rr3NHklrYmJ0ZZUUF32VLc45OHrZ2TIx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370740; c=relaxed/simple;
	bh=kVrya8B+QGvpgOLDt4XJgDg1K9yEMjFPjkc8boPgxEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gK5m1vwn9BsZpxyJNg19e98Ap2q3AnB598IowUIn6EaXwEHceRC0Tvg+Xn5ZP5wBTQwLxMu8PGDGY+OYkEMdnQCu9au+VdKngMADsezZgx7OIlWo+Z5WVr5e2VIA7SX44cfCId7iKrA8Ct8FKLVC+R54X6nYGPCKuAhSW5ki1ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsIHo38i; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137f0aa125bso132574c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 20:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780370738; cv=none;
        d=google.com; s=arc-20240605;
        b=YOTXIkmQcobb96BkKnmfxR1IOd9E8cybL8cL2bwPW8eUfd7HZMZYLuBPDx14fYimnm
         yix0HaV0M7wZyfO0NPRz9ie6ttLG4p5N+bvATGrEEnfpBBv+vM6DuVSMSf3ojWLpMjDa
         nFpKDZr72hXVmmrKE16kcvgQjpfFiinC9WdQ771ZuKRmhGKxq60Oi9awtqscwfOtoj23
         Ep16DV+jBZVlEZgMUYQC/N7praqM3NBaOPq8nyDLPpJIq/vLDGf3VVxCtOEwrnVq4bRD
         Oz03eleMtOUWcKP9vORMv9JmmcAa8BuAo8itG8tudIAFNeYbp0anGyDMz564ZU6Ire8O
         dIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKKAOhBxBZxfSeOOd1SZs8syItBH55TT6/f2ePXeYLw=;
        fh=k47ySQKDBqISrLIPvpQ3loIQzCVh5fjhXnt97VOHDAQ=;
        b=N6gfzHNw0ooMde5tIVLM0Ia2N10t4ZV8wpS8jrBjNd7DI4ibIg/gjjbil+6Ly/dARz
         z0ehqs+Uo5XU8DZ7xQLWzjx/zOe6ZepTsM7vDmaPhCJe8VrGflE/r6jUoBc9SlCgaRIv
         9hlh5SRiCdZG8MBHawvZR8ZnC4jDyaWQIAyM3P0PQi03XZa+b/khKqB2OR6x90wM9jA/
         Ju4ALWRMUNwufg8vC6kdSg5XZyHc1zX4rqx2HZ6+Fp9cjVS5yEMoySvkGIv/pDTg6ul3
         /O51ZPQIUUrE13IwL2DQIESoXUa4B9Qr5oaDMihg+mPdR9Xo2+IQoU0NBblgkUV6JaKX
         8FSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780370738; x=1780975538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKKAOhBxBZxfSeOOd1SZs8syItBH55TT6/f2ePXeYLw=;
        b=KsIHo38iNM4pzwFjWSgOZh4M5O5SsgkalIUwgJtbNOT3OA3Ay2LkdAkon9mfcVkiiP
         acYS0D3B0eZLgqKO1JEoEVCFXicQMVm/rkmTYJ04+cg7P5KkUIxaeH98KqhxPeVWFn45
         q1wXlwykepUgaX5HQZg7Hxh/V7pqF/X4+aCrJ9FtyLBoMN4Z4o/bcjdqm+w2sNyyNdiA
         u1sOk5VNaQHzt6MiQVjbypuOfYyqokyLtOvVN9spDMzfKUMOirMfSTAlK43VE9R63iie
         DIgrFFzfi3EOG8tfZF+GiB5R+GygFXvL2qRANPsdlwCdRq/rICvgen6A/4MvJGNBNnV6
         dmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370738; x=1780975538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKKAOhBxBZxfSeOOd1SZs8syItBH55TT6/f2ePXeYLw=;
        b=Cwr0xb8GAgPpc63RzOqEUr2zYJw3fF+m/VtCVD8sPXomeg2pmC8I+SKnS5r+2yT66G
         sQcnB8gw4PhcQSEVN7YldxHSBZ2GdIq3GBa0ao4NH0GbDlVbi6HQ2Sxrr2FVB2q07Knq
         qRAHNLMLg8HRSWk7piI2al25syd6/+UgubBcXt7VD0tsxnEniTpDt7AUuqKp6S9t3Sgk
         SbvgGkOrnkcJwhpTzIDrksbLRXLj8N7w8/Uvv2U6TsNFSg2jZZcs8DzwHjC3hHqyQUS7
         exzoQ+wAxy2YZac7Rmqfyq+Ny3uZ5gxonGx+NWO6ZISPk1LHQ0wZLsqJ4h9pqnZy1VCN
         T1fw==
X-Forwarded-Encrypted: i=1; AFNElJ/cAhBwS3Vp0prHl8PyHsoo+bWxikEHmqaL5xbyvfZizYOcFIdR+YifLfoIuq4W5d7aQNLipfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3OSTmp5CHOWBLx3YQF4AfkpjQQe8T+QPaH7mHDP81pGGWfbp
	rRhOHYgwDkUS9OrbwcGCfsz5tkpu+BTLrcGY2216hVPP58qChFyqBvEiwcIn4dgtpt+HG6KiQft
	4TPnIRLVnD3vKE2l0bGzx/cMjcBs3GltKSdH1jU35
X-Gm-Gg: Acq92OF6YoAY8WQ0eTnoVnUip9rFMAEeLQNvFsO/UoUn+ouM8VUbYwU7lRv1xW/RlVe
	vXnWgTJ5CvHgBEDj0rAVJUlzuqjtTfs9heFowVfeo7x5T6VLbR6hlKt04YZEucRBqkK/niI4PDb
	qBVsYJU1hGOjpYoRw2/d7wDC2AhHvHrtY24XLyEfAl6p5VAYeX7hCILJDiiyFhRkHqOWq3pT/1U
	j3FeZkMtxKr7wjhsiEHD2njGUWqbTj4m6wXUhLMinVeqjZ9Gh96m/3aVK7ut/7337xWX/ocj/gq
	8is5YjByLV9C5f/SjUnm8cZjb/+MI954DwAsqA7YVLfmlEzLGLeOnub/R2L/iENj82BAE13PpPO
	BQkGu/V+7r8aR72D9hjgEsAEKJQVgeG4Kr2tIVKSzFdCiCoSzgDxzOVi4WGcEfj8=
X-Received: by 2002:a05:7022:3d8c:b0:11a:3734:3db3 with SMTP id
 a92af1059eb24-137d42926a8mr5813595c88.32.1780370737587; Mon, 01 Jun 2026
 20:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528005658.1756248-6-kuniyu@google.com> <20260602023402.1647750-1-kuba@kernel.org>
In-Reply-To: <20260602023402.1647750-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 1 Jun 2026 20:25:24 -0700
X-Gm-Features: AVHnY4LvVvl8qHegwUjRyZnM7UBQgGtb9RmGPhLGKTKTDOMURYPTphXn271ieGw
Message-ID: <CAAVpQUD23owCGnbX0nxGgOGfjwr7At1sYncimrs6Sab6=rZ8yg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, 
	stephen@networkplumber.org, kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293996-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 40F15627C82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 7:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
>
> This patch adds IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 attributes so a
> GENEVE device's underlying UDP socket can be bound to a specific local
> IPv4 or IPv6 address rather than the wildcard, and updates lookup paths
> and xmit paths accordingly.
>
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index 3a62d132a8c4..c5372b33a305 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
>
> [ ... ]
>
> > @@ -1972,6 +2043,55 @@ static int geneve_nl2info(struct nlattr *tb[], s=
truct nlattr *data[],
> >  #endif
> >       }
> >
> > +     if (data[IFLA_GENEVE_LOCAL]) {
> > +             if (changelink) {
> > +                     attrtype =3D IFLA_GENEVE_LOCAL;
> > +                     goto change_notsup;
> > +             }
> > +
> > +             info->key.u.ipv4.src =3D nla_get_in_addr(data[IFLA_GENEVE=
_LOCAL]);
> > +
> > +             if (ipv4_is_multicast(info->key.u.ipv4.src)) {
> > +                     NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCA=
L],
> > +                                         "Local IPv4 address cannot be=
 Multicast");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             cfg->dualstack =3D false;
> > +     }
> > +
> > +     if (data[IFLA_GENEVE_LOCAL6]) {
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +             int addr_type;
> > +
> > +             if (changelink) {
> > +                     attrtype =3D IFLA_GENEVE_LOCAL6;
> > +                     goto change_notsup;
> > +             }
>
> [Medium]
> Should the changelink rejection here mirror the IFLA_GENEVE_REMOTE
> behavior in this same function? IFLA_GENEVE_REMOTE only fails the
> changelink when the family changes:

REMOTE can be changed easily for each xmit, but LOCAL requires
re-bind(), which would unnecessarily complicate the code, so
I just disallowed changelink for simplicity.


>
>         if (data[IFLA_GENEVE_REMOTE]) {
>                 if (changelink && (ip_tunnel_info_af(info) =3D=3D AF_INET=
6)) {
>                         attrtype =3D IFLA_GENEVE_REMOTE;
>                         goto change_notsup;
>                 }
>
> whereas IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 fail unconditionally
> whenever the attribute is present, even when the value matches the
> existing configuration.
>
> Combined with the geneve_fill_info() change below, would this break the
> common dump-then-changelink round trip used by some management tools on
> pre-existing devices, returning -EOPNOTSUPP even though LOCAL was never
> explicitly configured?
>
> [ ... ]
>
> > @@ -2320,6 +2441,20 @@ static int geneve_fill_info(struct sk_buff *skb,=
 const struct net_device *dev)
> >  #endif
> >       }
> >
> > +     if (!geneve->cfg.dualstack) {
> > +             if (ip_tunnel_info_af(info) =3D=3D AF_INET) {
> > +                     if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
> > +                                         info->key.u.ipv4.src))
> > +                             goto nla_put_failure;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +             } else {
> > +                     if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
> > +                                          &info->key.u.ipv6.src))
> > +                             goto nla_put_failure;
> > +#endif
> > +             }
> > +     }
> > +
>
> [Medium]
> Does this emit IFLA_GENEVE_LOCAL or IFLA_GENEVE_LOCAL6 on every
> non-collect_md device, including legacy devices created without any
> local address?
>
> cfg->dualstack is only set true for collect_md devices, so for any
> device where the user never specified a local address, info->key.u.ipv4.s=
rc
> is 0 (or info->key.u.ipv6.src is ::) but the attribute is still emitted.
> This would change the visible output of ip -d link show and netlink
> dumps for existing GENEVE devices, adding a synthetic local 0.0.0.0 or
> local :: that was not present before.
>
> Would gating this on a non-zero source address (or tracking whether the
> user explicitly set LOCAL) avoid the dump-output change for unaffected
> devices?

Honestly I don't have strong preference on this.

New iproute2 will show 0.0.0.0 or :: even for devices created without
the attribute indeed, but I guess it's almost always the case that
the dump command shows every attribute when we add a new one...?


>
> The commit message describes the new behavior on devices that set
> LOCAL/LOCAL6 but does not mention that fill_info now emits these
> attributes for every previously-created non-collect_md device, nor that
> changelink will reject any presence of LOCAL/LOCAL6 even when the value
> is unchanged. Could the commit message call out these compatibility
> implications?

