Return-Path: <netdev+bounces-300617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9YkhAOzlNGpnjgYAu9opvQ
	(envelope-from <netdev+bounces-300617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADE6A42BE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:47:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zd5G0KnM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12106300B0B8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A42F8E98;
	Fri, 19 Jun 2026 06:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819E40D579
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:47:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851622; cv=pass; b=hruKsVMwaZxiWJBdattXjmeHZW+aZfTYJw3at+WE5ig+71zdAOvYSg8L3P4880kxaFW/nIDfoxQIVDKMhKzlR5rxPcPsJEA/YAWRqiJgR3/WGDST0sjA0yW+gwFCEvkgUSCsJ9zwWlylwhtBlt61FjKOmxHstMXYMPgDGSp+ynY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851622; c=relaxed/simple;
	bh=ATeP/BIwP6EgqPgiK5vYo7HtyaoiN0B6SAvCOXGCVbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0aYkU8ANVj+c4iJ0bHTrhl+0h6wKA8FR+dHfBSrUrvaO6uBBvcWz4xcVTeNuhPgZHljjRCQO7pNIqHdbg5Rsiz4UHTVI2GEDUz+9iGY/QzJMNAKV2UwDb6w/Bdd/yy2nLcohfOsz07K1xxUExqbcGiKEtVq7ZVECJugQLamOkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd5G0KnM; arc=pass smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-486b93fc7c8so731958b6e.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 23:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781851621; cv=none;
        d=google.com; s=arc-20240605;
        b=YtwCTxtTtFKyXE600vP8AFkDAU5P16QSbX0RMML0lgXihtTh7JtbmHk3064n08loVu
         rasnHbI1wCpJicUNoB7D7tJE79/3PNIMdfq2gTAClPEqhTKbU5c583TgI8t/wBVtH4LR
         Wt0D2vlPEY+xHm0/GLOHowEwZ8eY8QHIpwjzctKzZE6cK9INbF85KqQZxMNf/biEI588
         E5dUr6hfX9Qxl3aKc5OYH6rDrU4qTBJMgxpZcfoEEjYNGdD1B9CGAi9Muos/xInxrUAn
         P+CeA/bg4IZ+d+wzalxa+ZA9DzbAVmRiWltXEWFaiACtoTuxYnGkX1LQmm07cVUneLwN
         kJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttemi/Fz+sxJasBpKSDCYgcaziGolwgbdDy2xiax/a8=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=hhmNH9x3ULcGNzM5Em2VjIpQm9vnSIPN5tW0dl4y+uDYcQWTANV7eBaTlNRwjb/ebb
         Z1Xhv2w1Wyf8WYZqDPKywQSNER5N3I8WIvSqXw9aQh7wsUiN7gpPV1hsVcSeV8HkZucs
         AZgksm/fFh153UbqnAcv407gmmWqPtY7DrS5QlMeeTZvCtneLmDdQhk+d4R2GUQwihPc
         RaOLnc3sQu/o24QNBCFK7wK9Uf71bvtAGhY6smlS4dvBN6gSx5pyE8sORHb4RTHJ+owj
         l4Ig9cKFsChkX0zPtsTS52g0EP/PHsFgK1SfcLyc+DX6OVZRiy28korewkRi3QmQEV7y
         SKgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781851621; x=1782456421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttemi/Fz+sxJasBpKSDCYgcaziGolwgbdDy2xiax/a8=;
        b=Zd5G0KnMk+0RA2DHWFhtUOEX55toO9twt5kA+YxVnrQoqfn4FuDifHLZKC1VrfmblC
         kjhBKCv1i5/2UxHa7cKxNrufH/MvRpinKVZveWJ4GOJNdHm7ZuTgoweCp32EhKHmMuMF
         0qf8jUd6cYYeCW2/S8tRciFGbmTmVW8otUFdUAzL7SfkkycYKWK3VfEbJ7YlyhEMWTa3
         Z+mPux75TnT8edvec8qVW1TE+W9pSi8WKL54clZSEdYnuOvVQ7uWIshY04nnwqSHocln
         8R3j/feGv9djXTPInsF6/VWONdTqKw4y+MWulEc9l0qrlwR6sNn/5YdU+8bYZS7woaCv
         WaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781851621; x=1782456421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttemi/Fz+sxJasBpKSDCYgcaziGolwgbdDy2xiax/a8=;
        b=gMzyVP6JHNaWIsl03BF8LY01qPAsHvuhzWJwedy/cr3Xqi3vA5lJS1vCIVwbAzFbab
         DaDhk2TbB9VUaNXYjqHQGd6nDnpMjFVEBkpQd4m5y7E2RJ3WsRllyjkkTv5z/BWpvpnh
         waASQ08repHRACBVbkkZ6Hfgscxr8PKsQaHWpZllom3mlWm0xEBNp0Vn2l96e/xqr33K
         ut4Ml2zQF5hD1togk/A6GZWeVN/vH2IoGupyKriNvI+rIqrPVIXk2jodRGJ/ZrRmXRDY
         KpnBQUSs1Rxo33vRGXyxiU7puo+fKLOicXIFv4C6Srq5zn+atiHKNPzHksIvxdAangBC
         1fRQ==
X-Gm-Message-State: AOJu0YxR7USClnKzbJTvvLw7BGUS/gJQa9tc98Tg1HIoV3P04i90mtZl
	W8MQbKuSqezcyxtz9IkiSMw3CbUTxJ9okyjSNV8dJCW0T0MtyV3A5VS2HNnoPRATq5CMWo/6ztO
	Qme4c3w523ionXxN8XJ5hZwX/n5WEUGA=
X-Gm-Gg: AfdE7clpvFtt+av4tDbO95egJhk+XOy/+8Q9W2NUNDloZ02mbC9k2OzeNFybu44O9tK
	HR54gsBxej0UxiY6LHK2zX5nY8F8viLAnCU3NfOQC6QqmH3Ld+gKdjwd7rNuaFzOSdNw+eBZsnN
	f6fg10j8JhqYiVkkGLhcgskMGUAt0P9EE+oC3tWo0iFkBQB4y/1osgsLL7SXPUGTPvz5DtJSGdO
	9juSCx7rlT0lvGOUUGBkAmYRTyJrjvby/SSfyz5E9sQ6EYxD+/0Oxu38sA3exP9THuOoREu7/mC
	x5aM8rd2FItnxazZc11QrXXchKgY
X-Received: by 2002:a05:6808:1c09:b0:468:6a2:897 with SMTP id
 5614622812f47-4896a9b5286mr2137864b6e.6.1781851620553; Thu, 18 Jun 2026
 23:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618202716.2166450-1-mmyangfl@gmail.com> <20260618202716.2166450-4-mmyangfl@gmail.com>
 <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
In-Reply-To: <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 19 Jun 2026 14:46:24 +0800
X-Gm-Features: AVVi8CfKIZlzrVh3jgH_AT5_B3BpZ4AVH4mqi805e2mnKmOVx1ymoX1Y4QXKoP8
Message-ID: <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
Subject: Re: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate port structures
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6ADE6A42BE

On Fri, Jun 19, 2026 at 2:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jun 19, 2026 at 04:26:31AM +0800, David Yang wrote:
> > With support for LED introduced later, struct yt921x_priv will be 17k
> > which is not very good for a single kmalloc(). Convert the ports array
> > to a array of pointers to stop bloating the priv struct.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++--------
> >  drivers/net/dsa/motorcomm/chip.h |  3 +-
> >  2 files changed, 75 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorco=
mm/chip.c
> > index 6dee25b6754a..d44f7749de02 100644
> > --- a/drivers/net/dsa/motorcomm/chip.c
> > +++ b/drivers/net/dsa/motorcomm/chip.c
> > @@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, st=
ruct device_node *mnp)
> >  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed b=
efore. */
> >  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> >  {
> > -     struct yt921x_port *pp =3D &priv->ports[port];
> > +     struct yt921x_port *pp =3D priv->ports[port];
> >       struct device *dev =3D to_device(priv);
> >       struct yt921x_mib *mib =3D &pp->mib;
> >       int res =3D 0;
> >
> > +     if (!pp)
> > +             return -ENODEV;
> > +
>
> Are all these tests actually needed? If you cannot allocate the
> memory, i would expect the probe to fail, so you can never get here.
>
>         Andrew

Dummy ports are no longer assigned control blocks (in yt921x_dsa_setup).

