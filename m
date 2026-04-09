Return-Path: <netdev+bounces-277006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNnlGial12lfQwgAu9opvQ
	(envelope-from <netdev+bounces-277006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:09:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BD3CAD31
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 895E93007AF8
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECEA38B7AC;
	Thu,  9 Apr 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xUNMTqwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335F39A806
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740174; cv=none; b=FT8qimWJUVGD2Jih98sJ/mq1+ecHu4UgUVLQkFlc5A3/jEKeYomeQKEOya2go62HNySevHXySKsuYCy/yThRwufGUM7a6UFFur5hD0JunQQCCdZjoAkGkC95xijbc2GXNqVfeJd6pa0XDtaVFMq9b1HhfOjcw79qNCiXrSo4azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740174; c=relaxed/simple;
	bh=WG5xZWlTRUmuJqOvkiY+HFGmNz/+NaTBjyOPHqPa7iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE//wUaIJOUdaYjg3Wks+2oyfkifHsjvx79R2uNh36ZeJxDxJ4xnbwAWB720UaDTbA4Q33SJ/f/qVduCfXMPgrzC7JFoEuY4VYzdfef83WXczXDZqz8nhzzNkRiU7faZZzclJ8top5jSrDvk/RUw2ELZscof3RwnE+1NzCtHQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xUNMTqwA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37DE51A3228;
	Thu,  9 Apr 2026 13:09:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1D095FDEB;
	Thu,  9 Apr 2026 13:09:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85FFC104500B5;
	Thu,  9 Apr 2026 15:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775740169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UNLl0SMuvdEb//oryfJzsLQQiO0+77/IxxorWllfVB4=;
	b=xUNMTqwAWemVb5WqznHTJZjSzexD1NeOQyOyoFude0jvx52poeJ21tLiATpuNczgGSa/nu
	NiGAuijBv6CgemaNZin1uBZk71aKFUkX5XooO1K3h7mMFrbGj6kpyEpEOdmwg48RWKStM4
	As4izBjkCQ+QQ3hBGduvJwQfJKchQT7O9YQgVgonNN7bNilqITCs20yhQmJS3MZzEdMCGr
	I38oY25lFV9wDvbmfazZXXuCuhUSVlZ0LjsbPuDITcawtidiTJdx92LhCEOCLs/jtrSccC
	ubyGaE6+zaZ3gm8trq3WmLZx5NuKbicBgp+w/Cg8JraeHMoDwfrvPJKPGL5Atg==
Date: Thu, 9 Apr 2026 15:09:22 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <20260409150922.74d82c39@kmaincent-XPS-13-7390>
In-Reply-To: <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
	<20260408210711.439068-1-github@szelinsky.de>
	<841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szelinsky.de,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 643BD3CAD31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 14:30:53 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Apr 08, 2026 at 11:07:11PM +0200, Carlo Szelinsky wrote:
> > So I went ahead and tested the phy_probe() approach on my setup (RTL930x
> > DSA switch with an I2C Hasivo HS104 PSE controller as module).
> >=20
> > PoE itself works fine, but phydev->psec never gets set - ethtool just
> > says "No PSE is attached" on all ports.
> >=20
> > Took me a while to figure out what's going on. The problem is how DSA
> > handles PHYs: when phy_probe() returns -EPROBE_DEFER because the PSE
> > controller hasn't probed yet, the PHY device is registered but sits
> > there unprobed. Then the DSA switch comes along, sets up its ports, and
> > phy_attach_direct() force-binds the generic PHY driver with
> > device_bind_driver(). Now the device already has a driver, so when the
> > deferred probe retry kicks in it just skips it. phy_probe() never runs
> > again and psec stays NULL.
> >=20
> > What I'm seeing timing-wise:
> >   - MDIO scan registers PHYs, phy_probe() defers (no PSE yet)
> >   - DSA probes, phy_attach_direct() binds genphy
> >   - t=3D17s: HS104 finally probes
> >   - deferred retry: nope, driver already bound
> >   - t=3D35s: regulator_late_cleanup (caught by admin_state_synced)
> >=20
> > Not sure what the best path forward is here. Should we look at fixing
> > phy_attach_direct() to handle this case, or go back to the non-fatal
> > EPROBE_DEFER approach from v2 for now? =20
>=20
> I thought about this some more. Looking at the phydev->drv might solve
> it for DSA switches, but it is not a general solution for when the PSE
> is used with a normal MAC, and the phylink_connect() happens in
> open().
>
> Now, the HS104 appears to be a quad device, intended for switches. So
> maybe solving the issue only for DSA is O.K?
>=20
> Otherwise, maybe we need the ability to associate the PSE controller
> to the MAC? At a quick look, PSE and PHY are not tightly bound
> together. So we could make the MAC driver call something similar to
> of_pse_control_get() in its probe function, where it can return
> EPRODE_DEFFER. net/ethtool/pse-pd.c would need some changes as well.

I don't think we should associate it to the MAC. In a hardware point of vie=
w the
PSE Power Interfaces are wired the MDIs. It was associated historically to =
the
PHY, because, at that time there was no representation of the MDI. Now than=
ks
to Maxime there is, so in the future we should associate the PSE control to=
 the
MDI only. We will already have to keep the PHY association compatibility to=
 not
break binding API but please do not add another layer of association that w=
ill
increase more compatibility burden for the future.

As I proposed in another thread, if the PHY can't find the PSE PI, we could
save the phandle of the PSE PI somewhere in the PHY structure. Then at PSE
register time, look for each PHY and try to resolve every unresolved phandl=
e.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

