Return-Path: <netdev+bounces-300830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDjCN1q8NmoqEAcAu9opvQ
	(envelope-from <netdev+bounces-300830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA16A934F
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hCyLA6TX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300830-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C376B3013AA5
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11880390204;
	Sat, 20 Jun 2026 16:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF81C8603
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:14:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972041; cv=pass; b=Gm56YEO3U4g99MtHhRINaTM/7LjsBNtul6UmSILvGxMo96l9dHUXrhymdeF4WQdMaNj0hgbQLQpjy5OyhmbhvYaVIKB6GWfteov7HC9C8OxqzH2CBh8NrMOfGPPTVDh/uNWygDnoSN0tQgRn79qgSDfVTEHYsip6h6QmwkskRrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972041; c=relaxed/simple;
	bh=4dBRZKtAGoKMI0PqeaL5qpN6rZUR2uA0FcKMvdGDEwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqF36Sz+izYP8b+TB+aFwHDyytw1vyQhzjoGP6iu3cEOxHcqmLehSJkqUJ6lMrdF52nhly84lYPgEogOBoZEtnq3rvT7SRdvksr+Kso7/8goJ5GTFW21nM4CBoZnYbDJe8IsqdQbRqlGUkd1wCUa8aX8IPzr7BBmWMLiex2h4R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCyLA6TX; arc=pass smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-486621f0adbso2081059b6e.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 09:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781972039; cv=none;
        d=google.com; s=arc-20240605;
        b=Bo5F9WUoixTk3P3deg5FnFUjA4qKfkkzMGJ3by0IMbZLK525XeDSQ+TxFOVdmcgnX3
         Znl3bZmhWy/yT13hdDaNqH3Wxr06gQ8HvTZk72CBjAMwu3nDDcGR6o9c2Vn30v9o+uou
         DzHc8zY4JVJ89kBQAb0Bdwb6S0xzmykO1MksG4eGNQduUCt0x6BPoUWeSwWd122SdHF9
         Llg7WaZaOf0ar8ocjJzvZhSqT4l0kn69HMVz5dxH3awOPLbPKE8Sqs22RKcmdF7qnW0t
         OPVNxqutanJouRopbvRMlJtJ7qb7Worpqa8OxdXMViCryoa6CJQkCdO0Z9FcDUme09Sw
         5vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ulQaBnduoHRZ/m9YHz6Lg718P1rZPjXVOz4ZtgVpBio=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=kHlqZx/LYVVCRRv5n8fxivOu6pfWTtTLqZuEpFYpXvt8m2YETvHq/7F0gUARY1v5BX
         FpaIKIVFFiQ6GjbETxlL58x8E8IJfp1bnhGHX9atgfaD7osQnVcEMa7wzP3cgqj9VkOW
         QpQ+6hnMdRbeU8bxh6OAAT/X2Tj+HAvclG23X0Vb1FkARVrW9dYz5JWwJCRiYQ8rmE36
         vgStQ0ZYiBY4utqobY82RHJK1dHtlmsbZnJ0bz2AIfrmfb7JeEkpDDraS3+tqQZiqJ0G
         btaj60NvpH5+jBzPdujLptllPJl5G0DIdcQTKAda5t2Lu/nWg1RvKq/OVLg304aZWHOV
         AELQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781972039; x=1782576839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulQaBnduoHRZ/m9YHz6Lg718P1rZPjXVOz4ZtgVpBio=;
        b=hCyLA6TXSN64oKVsxa4RJkpSjZBK4KPHuH7l0K/jfm2zZNG/gwv6g/rA3uUz5ZC5Mb
         eJObI3UXunlJVec3FOr+OBgw87b/wQlwPssqyFOvgYw3IvB5FoupChmOmmzEDl2tzR/G
         P88CjnlwkjFFcOB+rc1+bLmm6kiEE6Cjyb2ptNNz3nNkYbgfVdHW3ixkLcS3DFO8kwrF
         EL1IvBjHjg+q38f5kluo+MPnluZBOoHQ4TNXPjkkJ5f66JS9BZFkcjatDmTtrIl/xU6U
         oFiRzpKw+JQK6SG5FavrSKisnwtn1RUhXiQ++efptPUL5mivBJRlV3l4LMyuw5SU60DL
         l4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781972039; x=1782576839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulQaBnduoHRZ/m9YHz6Lg718P1rZPjXVOz4ZtgVpBio=;
        b=EJBW0i+38l2rqv1R+vSVELfrobJ3Gn9TlG6zXdLYV2DdDXX1j69u/uDMnIqk/mUbSf
         uqRrznNjCe7jd6KCznq6giPz7bOACsSyE0DGH+J/RyDLU7yfT0xCJ4OPZhVw0OC4lNkl
         Qk6CgO8SKXAr4Q1ZLtroRrZhjdzhFIlgeC6Gpfuq5UNqevDAtet0EDyBZXd4GdR0Z067
         4xUJPKeRBIsROAtBhyKUchyo42JuAHkGDrKvXMrmknm7HtREMqDX8ayJecFxUc2WZilk
         OArIbjT1iuwygRmf5mMoT2LF3QT09G6/7lh6rsqWU/+qfnZHMNOf/xUye7MNUFDMV//9
         Zsiw==
X-Gm-Message-State: AOJu0YwkDAPTnI6M/EcvcO7kZuTWkWZBhoFt6HZs6D0FGubkBQs0ZfMS
	65HpVcxNvVL4+Cs+MYPCG4gwB/lugfMzgcXUHtJTwUwGuN8rXV0j1wSnT3P8APxQ3bARlV98NgA
	LeevKHuoEqkLh1pmRd7EeRVQXGKYzkIs=
X-Gm-Gg: AfdE7ckRfBurj00oES0mKatzM2Hb1y6kPWso8xdKnCUxfCR8wur0VgNgMfsOyb9y41u
	94IPOgPW/OkSxuuilYESsY+UeLjmim8Hlx3/baYK0zKOcqszMmSjMeZ5jWTEJi24A1ZmtFYyWu4
	ytBMZ9SOi9qLw4pdY7yVFk4v72wgu2Z7he0pfDJ/z3Bf8ZfNUYR50UKZOeqxoP7I3zVoO90qHvV
	+E89LNV1gSHctfwpq8J1Wcyfk9XtIDsXJeDPMoZPVOqfoSet72hwwAvfzLgqMoFNeB3M5xSjyoU
	gRkyab0afN9FegmJg3McaS95qbEc
X-Received: by 2002:a05:6808:c2de:b0:486:a9d8:ceba with SMTP id
 5614622812f47-4896ac94f4emr8380066b6e.32.1781972039594; Sat, 20 Jun 2026
 09:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618202716.2166450-1-mmyangfl@gmail.com> <20260618202716.2166450-4-mmyangfl@gmail.com>
 <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch> <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
 <fc82aaa6-ff6b-4d17-beb2-e6f156e64059@lunn.ch>
In-Reply-To: <fc82aaa6-ff6b-4d17-beb2-e6f156e64059@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Sun, 21 Jun 2026 00:13:22 +0800
X-Gm-Features: AVVi8CdD8BZnOunGDEyPnN0VZA3kdsc0WuvS88p-sXRjUPcGdXVsOrksvKtsC0Q
Message-ID: <CAAXyoMNOwiQCta9CKVtoBUwmX5JL-1MaDjxLrbWyviADyfs=sQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300830-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
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
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34FA16A934F

On Sat, Jun 20, 2026 at 4:03=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jun 19, 2026 at 02:46:24PM +0800, David Yang wrote:
> > On Fri, Jun 19, 2026 at 2:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Fri, Jun 19, 2026 at 04:26:31AM +0800, David Yang wrote:
> > > > With support for LED introduced later, struct yt921x_priv will be 1=
7k
> > > > which is not very good for a single kmalloc(). Convert the ports ar=
ray
> > > > to a array of pointers to stop bloating the priv struct.
> > > >
> > > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > > ---
> > > >  drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++----=
----
> > > >  drivers/net/dsa/motorcomm/chip.h |  3 +-
> > > >  2 files changed, 75 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/mot=
orcomm/chip.c
> > > > index 6dee25b6754a..d44f7749de02 100644
> > > > --- a/drivers/net/dsa/motorcomm/chip.c
> > > > +++ b/drivers/net/dsa/motorcomm/chip.c
> > > > @@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv=
, struct device_node *mnp)
> > > >  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zero=
ed before. */
> > > >  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> > > >  {
> > > > -     struct yt921x_port *pp =3D &priv->ports[port];
> > > > +     struct yt921x_port *pp =3D priv->ports[port];
> > > >       struct device *dev =3D to_device(priv);
> > > >       struct yt921x_mib *mib =3D &pp->mib;
> > > >       int res =3D 0;
> > > >
> > > > +     if (!pp)
> > > > +             return -ENODEV;
> > > > +
> > >
> > > Are all these tests actually needed? If you cannot allocate the
> > > memory, i would expect the probe to fail, so you can never get here.
> > >
> > >         Andrew
> >
> > Dummy ports are no longer assigned control blocks (in yt921x_dsa_setup)=
.
>
> This seems pretty error prone. A missing check will result in an
> opps. At least it will be obvious. How big is each port structure? Is
> the memory saving worth it?
>
>     Andrew

It's about 1.4k per port for 5 dummy ports.

