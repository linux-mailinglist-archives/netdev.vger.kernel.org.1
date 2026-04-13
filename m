Return-Path: <netdev+bounces-278013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLd6KDS43Gn2VgkAu9opvQ
	(envelope-from <netdev+bounces-278013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5E3E9DF9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24B9302BDFC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A63A75AB;
	Mon, 13 Apr 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rRIm3GEm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81937C105;
	Mon, 13 Apr 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072541; cv=none; b=LAsEdA5gTXUYUJ01cDMExXeVioYRuUWnjLDsmkRgQ/ts+tIStjd6SiXoIpxYriLFK6OwuZww44Z1p5MRN8n8F80zYH667zHQ/jSSDGJdbHsIzxh9QZueamVYjWzSN52DwnOmnLRqJukPKLNKbS48lUdrfsg2D/w0NtOsQGAOsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072541; c=relaxed/simple;
	bh=iQz3QGzvlPLi1Q8xcyNVDfkWMUmrPXuRNSEBeFg1Uo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h05rFjzfyP+GgYBjrzCxxaVxdFp4hYIBTpyzee8Yx4C89taL8CEbnsbyQxsC90ntw8Jna4rAelcn6l1psupvvHGYDkOEqyCE33tbWblgOSUkqE/cFHT0eiXoJUk6PIWZkd1zss6OGuNFF0ZkV+IA5I6vufimFS0X5vclAb8Z1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rRIm3GEm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26C42C5C183;
	Mon, 13 Apr 2026 09:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96B6F5FFB9;
	Mon, 13 Apr 2026 09:28:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CEFF104501E1;
	Mon, 13 Apr 2026 11:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776072535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KdRx0yDKh1ya5oMGBBSLJlhiu6AO8oN2sWAEKGUPGnc=;
	b=rRIm3GEmB2/6d8wGGif6A/IZCPCsafwPjhsGusDoUrJDA46IF3P5bvBTYDkeSuVEQm+T8k
	Ap8YrQ/NlvevRgZ2do/29D8EDD9tT3RkJZIc35XP8DwhcGHwTqIaPZIcz6K4JrNOS+T0bO
	hvdK5jgMw76yFQk3fia/sePRmvVJA5ey6e6Qr+ax96IZ/i74a8OIcmgG18zQtCv9kc5Ig5
	xfKscXL6KwHPcHOz8YbP0a+AUuKuByFuVV0sz8Z4BuhsNfZlAfb7hgIOGQ3bGGxVMySV2z
	A3x4YJGg/D0/yplGqp2PI+jwC7CdJzkUUthcHdwwiNRNdBmG23hCzTaUa8bnkQ==
Date: Mon, 13 Apr 2026 11:28:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Carlo Szelinsky
 <github@szelinsky.de>, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <20260413112850.1a095bd7@kmaincent-XPS-13-7390>
In-Reply-To: <280018e9-4499-4a13-b692-6d6a4499477b@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
	<20260408210711.439068-1-github@szelinsky.de>
	<841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
	<20260409150922.74d82c39@kmaincent-XPS-13-7390>
	<908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
	<adfPAQDiYX6eIjrT@shell.armlinux.org.uk>
	<280018e9-4499-4a13-b692-6d6a4499477b@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,szelinsky.de,pengutronix.de,lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: F0F5E3E9DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 21:54:33 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Apr 09, 2026 at 05:08:33PM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 09, 2026 at 05:34:56PM +0200, Andrew Lunn wrote: =20
> > > I still think we should be deferring probe until we have all the parts
> > > available. The question is, how do we actually do that? =20
> >=20
> > Indeed...
> >  =20
> > > We could insist that MACs being used with PSE need to call
> > > phylink_connect() in probe, so we can return EPROBE_DEFER. We might
> > > actually need a new API method, phylink_connect_probe(). That can call
> > > down into phylib, maybe again new API methods, which will not bind
> > > genphy, but return EPROBE_DEFER. =20
>=20
> I did not say i would be easy...
> =20
> > How would MACs know whether they should call phylink_connect_probe()
> > or phylink_connect_phy() ? =20
>=20
> It would not. Anybody with a board using PSE would need to modify the
> MAC driver to use phylink_connect_probe(), if they have a slow to load
> PSE device.
>=20
> > What do we do about MAC drivers that are a single driver and device,
> > but are made up of several network devices (like Marvell PP2) ? =20
>=20
> It would need more care, but it should work. You might end up removing
> a perfectly good device because the other one is missing its PHY,
> which is not ideal, but hopefully you get there in the end.
>=20
> > We also have network drivers that provide a MDIO bus for a different
> > network device, which makes connecting the PHY harder in the probe
> > path. =20
>=20
> Yes, we would see such setup doing more deferred probing, but again,
> they should get there in the end. The most common systems doing this
> are using the FEC. Are there any board using the FEC and problematic
> PSE?

Not that I know of but it is only the beginning of PSE support in Linux.

> > Lastly, what do we do where a PHY driver hasn't been configured or
> > doesn't exist for the PHY? =20
>=20
> I was wondering if we can get from the driver core some idea where we
> are in the deferred probing window. If we are 2/3 of the way through
> the window, fall back to genphy?

How could we decide when to fall back to genphy and when to continue the
defer situation?

> I'm not saying we should change all MAC drivers, or recommend new MAC
> drivers connect to the PHY in probe. I just want to offer the option
> if you have a problematic PSE or PHY, change the MAC driver.
>=20
> What we have also said in the past, it is the bootloaders problem to
> download firmware into the PHY, or PSE, so that it is ready to go by
> the time Linux boots. That would also be the simpler solution here.

My thought of using MDI was to separate the hardware port from the PHY devi=
ce,
as in hardware, the PSE is directly wired to the MDI we should have the bin=
ding
similar.
I was thinking of adding a new helper to register the MDIs for the MACs.
In the MAC/SWITCH binding we could have a list of MDIs similarly to that:=20
https://elixir.bootlin.com/linux/v7.0-rc7/source/Documentation/devicetree/b=
indings/net/ethernet-phy.yaml#L332

We could have the SFP and PSE phandle directly in that node.
For example prestera driver is already doing something similar for SFP:
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/net/ethernet/marve=
ll/prestera/prestera_main.c#L370

I wanted to convert this helper into a generic one. Then every MAC/Switch
driver could just simply call the new helper to register their MDIs. I am
surely missing lots of things as I am not as net expert as you, but what do=
 you
think of that?

We would have one path into phylink and one trough the new helper when ther=
e is
no PHY devices registered.

Maxime what do you think as you are actively working on MDIs?

Still, this does not reply the initial question, should we keep EPROBE_DEFER
in phylink if the PSE is not found or should we have have a way to probe the
PHY and solve the PSE phandle later?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

