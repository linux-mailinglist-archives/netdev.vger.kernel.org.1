Return-Path: <netdev+bounces-302079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JxLbCe/KPWom6ggAu9opvQ
	(envelope-from <netdev+bounces-302079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:42:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC36C94C4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:42:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZuDHHKdE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302079-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302079-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8E4304097C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0C23EAB7;
	Fri, 26 Jun 2026 00:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DB13B293
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 00:42:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434540; cv=pass; b=hNq2kLac6FTu4OHMBue35xsQgwENd1HHoUkd6qyMM/Cp4J3zlAhAJstTeT9lAeywfBr1YorTFeYipCYptUvBFpxHcIgi4H7GTuMwhogGlW1G8v7W2UZeTGZThBZq8L/XgpSFpW6a1Ve9Zuj09g5CTX9Gy6RxmUMT8bLSCZhp7VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434540; c=relaxed/simple;
	bh=6lqAPKrP1HdYgIGwWo8F8XeEFhwPgBF3NEUOjWWgQV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ope8zur9CmKzIDDkd04myMTZEfbL6i5mmh3brWFzpTKjRQKuPAMXzVHqlAm+CHOMoj32kIsPucFJdGbhujFrhTkski/9log8ii9e7es81wsiQ8hppdQumd+RsFEjy2lyZSNLaWxE7v1PIlOKTj8NRHSveeyEKWpLNPw4T5/M3Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuDHHKdE; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso736685a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434537; cv=none;
        d=google.com; s=arc-20260327;
        b=Joc3/ie/PH9tguRTUm9tbfTMqQP5KCgt6CGZfJO9bgqLE7P8khkQY8/VB7Q6RJaI6a
         Hzvpu/L9oZjIJPfLZMAhpdEjMb4+L3uNpunAjnszX0k64V+dpU058C5sNyTWkr4hL+RL
         vivA177ZfGlag6g98tTn4OQaKXs9rrC0zoZB5saB3hw1ue6I6Kzq2Jjh5GR1maLsblpk
         sezxsD1N9cWAYtQv5/9UOsiEmtI+EzDFqjrlZLCef2qr8nVXyP4SvDTk3buE4aokKDgt
         fg3joHA3JHyvLw6kYlmalbfR0gfgud58D+Rt5EdCigkLJV9Lh7Ax7ZRjfLyUDZnyh5u4
         0hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BBxSVO7pzM2WGB9BqMOrTGeuqZSgMG22gnOd+610PEk=;
        fh=nwMgQDOjtcSjnqpC2pZdveLOE18uUzaM+Hud7p1UTP4=;
        b=GCgyZJPZnlEO2ZYJ0AyErZrIbDXDpT65TWuo+LdXRze0HpJIRX7XHa+x+wBsHh55WS
         Uw49Pr+WBphGxSTcluUO/5aimXipLMso7SsHFHLjQZx6jaY94SSIWij934FYBO33IlQn
         sU55ON5HpeskwRrWPmULmqKiO9H/y9JrsYlsBdsQGcM1XAzD8iiTDbSdFRZNYKjDOk4z
         nMnAYmLOUcrTiFU9jyUCUSwNEQGkUfQoaRUJqK7JImC10c6DodePlXc22357hZonqNyS
         BiyLniQqshrctl7NUrl+NHrqn0hjRwSHHX4Sz2xYNtji33sTmqnFirG75CfG5/75FS0P
         6aOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434537; x=1783039337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBxSVO7pzM2WGB9BqMOrTGeuqZSgMG22gnOd+610PEk=;
        b=ZuDHHKdEMCYoYkOh8dm+7UQtWgUiQ0jUFXs7tTDoMA4rtjJDqmknsygWxQKcCiEMwD
         +w2nf0EJOnBLNDEiX67ZtIjd8H2n4Ig+aDmyAmbl2BHUILz+32kyW1LfGprdFsyIspUo
         ww1SZUr3KXGLrKLe775jJ3dXJIKUgKie/FjDPKeOzQUObnOqXH2aaVnwrRfH3Hv8d4Ix
         0aDp7TgrUxCpHvE0hZVQ0AOG2A1jrNWuRncWXBrD2b/FGyXV7TCok2JMYkViCt/zRgZp
         HuKbyyRAFTlTer3g5WW3DW2mc8w0NuJ1MT9v1kkFgiTo5auDJFwOimBxvJJKR3L6A+1C
         iI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434537; x=1783039337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBxSVO7pzM2WGB9BqMOrTGeuqZSgMG22gnOd+610PEk=;
        b=s+KpEdYq2aFUK+E1NrCL6B/y8979CG+xteRKnCYTvRAaOp7VarjdXf7HuK9qs5hEgA
         5m4fLp7zSO2m2Qgwaj8PGuW1ehOvyGUJ3jUiax4TlNNtSUObjVeh2/EHR+55UEmTMLy8
         iPH5jbPUacr4b2CDfWjV4iKGmTK+GGopI2dGsf1ZtIK8dfIc6yVhkXeue+CL5UUzbr2n
         ZtrHqBmQYqXV+QiPuO4f8KxmbFgBYclPqHBzYhilPKu73nZYgzvHS030x+LXW/hAjsxb
         QhlivSDM5WgIxDdi5WKsW34w3U0f/kumMiut2z/T29EXHwL+nzkItuSFq+f9A3l9J6cW
         TEcQ==
X-Gm-Message-State: AOJu0Yy7x5mFU63kIzb3HHZVnJUN1+2BPD+FIKbNMnfXOkrYXQ1R4gus
	zrJOLLzdQuOLave7gMx1DozsZD+oybhagxu6+h7PJVr0o3fuSGrOjVEJ4CXbtUG0+LgQ/ESPeXO
	BoN3OqYRg25TmlQn6XxKOZRDB1IBjj9000g==
X-Gm-Gg: AfdE7clzQ4lT/rP03PEA04WpcOfhiTHyroc0dCpCiNJGyz8G0Stu9xTwP+KNRR479oj
	4BU9Xa+B34IZYPafRPoRXviibbOOq4BlyTKOuSGduwUNBjWBFyF/+hRQVkc6EVwvIEIlFN9IOLD
	KVmgqS/C1VN5faLMWDvpY92jWzI49TMdbv8yYCp2k2Mfb+ew4B3Ez84HgYz3c7mestZdbXhrNYX
	YPKpm/hcdjeCJSvOldMHLSEwcxqkyIr4G27YGZOnS/mbSTK789i75nd6PNFRUhUW+3N5dgsUd74
	fTC9iXHVXSsiVpWyG/YiAXr1/JAzrvzdVI+muTYaTiWjQB79Vy1CjK+axLROlCwdq+VZJtFe/h4
	46zrk3jOtZ0EuFZQx5Sp/4ixwlo4=
X-Received: by 2002:a17:907:d94:b0:c10:256:3d6a with SMTP id
 a640c23a62f3a-c1205e9e12dmr331284166b.31.1782434537091; Thu, 25 Jun 2026
 17:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624032122.986986-1-rosenp@gmail.com> <20260625093630.1173136-1-horms@kernel.org>
In-Reply-To: <20260625093630.1173136-1-horms@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 25 Jun 2026 17:42:05 -0700
X-Gm-Features: AVVi8CceAQ0b7l_tQlg6JSp8r1ektjStrGOgwaSrOcyYiAQsR3ZYZ955BZtnl-Y
Message-ID: <CAKxU2N__hbPOrPe3JUeTLF6d6+=uN+p5ez78rVg6cnrekkvQPw@mail.gmail.com>
Subject: Re: [PATCH net] net: gianfar: use of_irq_get()
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	afleming@freescale.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302079-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:afleming@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DAC36C94C4

On Thu, Jun 25, 2026 at 2:36=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: gianfar: use of_irq_get()
>
> This patch switches gfar_parse_group() from irq_of_parse_and_map() to
> of_irq_get() and widens the irq field in struct gfar_irqinfo from
> unsigned int to int. The stated goals are to fix a leak from a missing
> irq_dispose_mapping() and to enable -EPROBE_DEFER propagation.
>
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/eth=
ernet/freescale/gianfar.c
> > index 3271de5844f8..17a0d0787ed2 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -514,15 +514,15 @@ static int gfar_parse_group(struct device_node *n=
p,
> >       if (!grp->regs)
> >               return -ENOMEM;
> >
> > -     gfar_irq(grp, TX)->irq =3D irq_of_parse_and_map(np, 0);
> > +     gfar_irq(grp, TX)->irq =3D of_irq_get(np, 0);
> >
> >       /* If we aren't the FEC we have multiple interrupts */
> >       if (model && strcasecmp(model, "FEC")) {
> > -             gfar_irq(grp, RX)->irq =3D irq_of_parse_and_map(np, 1);
> > -             gfar_irq(grp, ER)->irq =3D irq_of_parse_and_map(np, 2);
> > -             if (!gfar_irq(grp, TX)->irq ||
> > -                 !gfar_irq(grp, RX)->irq ||
> > -                 !gfar_irq(grp, ER)->irq)
> > +             gfar_irq(grp, RX)->irq =3D of_irq_get(np, 1);
> > +             gfar_irq(grp, ER)->irq =3D of_irq_get(np, 2);
> > +             if (gfar_irq(grp, TX)->irq < 0 ||
> > +                 gfar_irq(grp, RX)->irq < 0 ||
> > +                 gfar_irq(grp, ER)->irq < 0)
> >                       return -EINVAL;
> >       }
>
> [High]
> Does this change miss the 0-return mapping failure case?
>
> The kernel-doc on of_irq_get() in drivers/of/irq.c says it returns:
>
>     Linux IRQ number on success, or 0 on the IRQ mapping failure, or
>     -EPROBE_DEFER ..., or error code in case of any other failure.
>
> The old test rejected an irq value of 0 with !gfar_irq(grp, *)->irq,
> which caught both irq_of_parse_and_map()'s and of_irq_get()'s
> zero-on-failure. The new test only rejects values strictly less than
> zero, so a 0 returned from of_irq_get() is now stored as the IRQ and
> later flows into request_irq()/free_irq() during probe and unbind.
>
> Should the test be <=3D 0, or split so that negative errors are
> propagated and 0 still triggers a failure?
>
> [High]
> Is -EPROBE_DEFER lost here?
>
> The commit message states:
>
>     Changed irq to an int as required by the of_irq_get API as it
>     supports -EPROBE_DEFER.
>
> However, the only error path is:
>
>     if (gfar_irq(grp, TX)->irq < 0 ||
>         gfar_irq(grp, RX)->irq < 0 ||
>         gfar_irq(grp, ER)->irq < 0)
>             return -EINVAL;
>
> of_irq_get() returns -EPROBE_DEFER when irq_find_host() cannot yet
> locate the parent interrupt controller. Collapsing every negative
> return into -EINVAL prevents the driver core from retrying the probe
> once the interrupt controller appears.
>
> Should the actual error from of_irq_get() be propagated, for example:
>
>     int ret =3D gfar_irq(grp, TX)->irq;
>     if (ret < 0)
>             return ret;
>
> so that -EPROBE_DEFER reaches gfar_of_init() and then gfar_probe()?
>
> [Medium]
> Can the commit message description be revisited?
>
> The message states:
>
>     of_irq_get() differs from irq_of_parse_and_map() in that the latter
>     requires calling irq_dispose_mapping() when done, which is missing
>     in the driver. Meaning it leaks memory.
>
>     No need to map it anyway. Just need the value stored in the irq
>     field.
>
> Looking at of_irq_get() in drivers/of/irq.c:
>
>     int of_irq_get(struct device_node *dev, int index)
>     {
>             ...
>             rc =3D irq_create_of_mapping(&oirq);
>             ...
>     }
>
> of_irq_get() ends with the same irq_create_of_mapping() call that
> irq_of_parse_and_map() makes, so the resulting virq mapping is created
> identically by both APIs.
>
> If the previous code leaked, does the new code not leak in the same
> way? And does the Fixes: b31a1d8b4151 tag accurately describe this
> change, given that it may cause stable-tree selection on the basis of a
> leak that does not appear to exist?
Meh I'll submit to net-next. This is way too messy to fix for net.

