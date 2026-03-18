Return-Path: <netdev+bounces-269010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMwMHWaiummyZwIAu9opvQ
	(envelope-from <netdev+bounces-269010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:02:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B722BBE88
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B520030EFA06
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD183D7D66;
	Wed, 18 Mar 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXJg26cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113D3D75CD
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838813; cv=none; b=ZBjSjTFgyE7OLH83HjEaLQBH5/vRYCISujQTK6472ngHYwk3nqpWqgOEL3XzSIKL1URFlO+FJSIrMjshLJZXXDRr88iHB0EB64pfQ3UTYHnopwStzPVden+Ba0+Ia/FkEfHjTTwZbbiw8rMrvNVvD8L6CvyNe0pRX1pmGWfdfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838813; c=relaxed/simple;
	bh=53y5Rybl/OajfsYtPp/FlPAeGf32v6tVDyjPu7HO1qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkJ/KjEhv6qsYPXmAkWVySQRM2vp/FTm+D8cLCkHpqrGM5VkoYATkLrXo6AAl7d/fNvkqDka8OOFelZiwDGflaRmNrjQyXX02JsXhr6LgZzz1NWr0Q3hLTt2HdkLkV4pUeezBMc0YpJ3Si3umBMMgfk4j0oDOSW5arJmEjYEtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXJg26cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938CAC2BCB0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773838812;
	bh=53y5Rybl/OajfsYtPp/FlPAeGf32v6tVDyjPu7HO1qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXJg26cfnHDUFe9/WmsMDToav67efuyh2gc8Ow3lf/1IJwzteaHe+J+e+1zlMfb9w
	 KX3LK9H8KYL7xGoNeFt70QApITIKzwneWAN1nzTn47EHigR1i0rb/RJ53uJhSOWwYe
	 mp9SDWqrhtdBgoTQKiWxSVwRFtasYgKVt043R5xbwVIthxEa2hG1l/nGecE0sid7FA
	 tE35d5D+i/Ehi+tY01zCWwKMASlp9hkd0w2cAY//PUR/OnvtZsGOmd2KzptgQsDTUJ
	 03PWgmp8K5c5pGLE5bdBq4Cojz9qtyGioacnkGhGD+xOSrFFLNif/rxPT5NUi1Zqc9
	 9/jr4vvfxdq5Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so4092038fac.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:00:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjw0ER2NMcX+NhzzZMblENqV/4dFi1KeqHS5qtkt3Gh8b2T6E9cCyPeXDeV6m7kHZ/QrKPGFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcfvvYN1gKuRKN90/nWhaSCtPK3WuDyWcqZAmTepn0l1PDlq2
	axlgt2Do4DLALnm+jlgB282At8tVVYq93rXSeM7s2Zhmm04AEhx3V9hDq07i5G69KSara9Cn2ZT
	PyQGp1og9i9SGmuPxL7ph8Rd8v/0P48U=
X-Received: by 2002:a05:6870:a550:b0:417:349c:dbb with SMTP id
 586e51a60fabf-41bd418b938mr2039961fac.34.1773838811632; Wed, 18 Mar 2026
 06:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5113731.31r3eYUQgx@rafael.j.wysocki> <20260317164215.1766861-1-horms@kernel.org>
In-Reply-To: <20260317164215.1766861-1-horms@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2026 14:00:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g9BinHfQDS6hUvVHdLxDPvbv7ck=m1Bqa=+C3iE+vgxw@mail.gmail.com>
X-Gm-Features: AaiRm53NFD2R_-cERAXuUPAfz4g6VNAuEopKXOM-nBixvIxViuy0UGW1hWEzFN8
Message-ID: <CAJZ5v0g9BinHfQDS6hUvVHdLxDPvbv7ck=m1Bqa=+C3iE+vgxw@mail.gmail.com>
Subject: Re: [v1] net: fjes: Drop fjes_acpi_driver and rework initialization
To: Simon Horman <horms@kernel.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269010-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C3B722BBE88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 5:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: fjes: Drop fjes_acpi_driver and rework initialization
>
> This commit reworks the Fujitsu Extended Socket (fjes) Network Device
> driver initialization by removing the ACPI driver interface and
> creating the platform device directly during module initialization.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1=
]
>
> > diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.=
c
> > index b63965d9a1ba..efb399eb15e0 100644
> > --- a/drivers/net/fjes/fjes_main.c
> > +++ b/drivers/net/fjes/fjes_main.c
>
> [ ... ]
>
> > @@ -1518,16 +1506,7 @@ static int __init fjes_init_module(void)
> >               return result;
> >       }
> >
> > -     result =3D acpi_bus_register_driver(&fjes_acpi_driver);
> > -     if (result < 0)
> > -             goto fail_acpi_driver;
> > -
> >       return 0;
> > -
> > -fail_acpi_driver:
> > -     platform_driver_unregister(&fjes_driver);
> > -     fjes_dbg_exit();
> > -     return result;
> >  }
>
> In fjes_init_module(), if platform_driver_register() fails, does this
> leak the platform device?
>
> Looking at the new code, the platform device is successfully registered
> earlier in the function:
>
>         fjes_plat_dev =3D platform_device_register_full(&pdevinfo);
>         ...
>         if (IS_ERR(fjes_plat_dev))
>                 return PTR_ERR(fjes_plat_dev);
>
>         ...
>         result =3D platform_driver_register(&fjes_driver);
>
> But when platform_driver_register() fails, the error path only calls
> fjes_dbg_exit() and returns:
>
>         result =3D platform_driver_register(&fjes_driver);
>         if (result < 0) {
>                 fjes_dbg_exit();
>                 return result;
>         }
>
> Since the module init fails, fjes_exit_module() will never run, so
> the platform_device_unregister() call there won't happen either. Should
> the error path call platform_device_unregister(fjes_plat_dev) before
> returning?

Yes, it should.

I'll send a v2, thanks!

