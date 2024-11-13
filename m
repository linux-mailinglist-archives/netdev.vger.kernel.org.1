Return-Path: <netdev+bounces-144489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C69C7A15
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163E9B275E8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1B16B38B;
	Wed, 13 Nov 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XkrsUGOQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E021632E5
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516067; cv=none; b=IDl39SAHp1uO8E8PWTuZwKeqGuP9KnWsf6kBnWN1ZpBh3JyxglSda4G68Olm6xxT6wM7uZmjF86Yx8SZwodyDgQ7bIDDX7JlxEpCC54QEM2SoMBeeSd+uAWJ2jl7RAwK7QQVQEShxHRSJX3aqI89EIjKaHaU1Tx+Vd74G1451gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516067; c=relaxed/simple;
	bh=NWUB829VYqSqLS8N4UYxXBCAY+a5r/oFrweyykOUluU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzN1VMMLGxjpRDYbXhE/V9RCiH4J+nvf/x/Ka60JzfLW2TmBNoPW065up1JC9o4KSjR4mBuVrYsS9VyRpofGV3BgEwcH87zGwrBVrkPZ0f/DY/Phl0phPhzGN1XR+j42DL7S/UKA83lchFRBkOStdMtsVGL9bRrSTOcX270PG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XkrsUGOQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FE09E0004;
	Wed, 13 Nov 2024 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731516063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Fw/9UW4ZM5QrYBrvA/xDiMcxt/QonzvnbZnBfK4Ao=;
	b=XkrsUGOQ9wLpatZH6u3E7N466QeOvL62G1QotQtRNhe1f4DT3BH/ZMo6RhMD9scct2gv7s
	UtDxTDojw6NXWtiQjFlllfzjmIp6JqTUj6mp7cyON7eWHfHexgWvIgWSRGR/FKQEZMLfuF
	qubWzt8iX3P5tskZQXKmYdmgfZuBWdhUokCnffK9ALeDKJN0ZfrecnQtfs1Vn0wVE4/zM+
	nsdhg/Rb8v9GdLKRRwDjkswrlYYSvmW+ZIGEmUO8/gzuL8/Sa8lTkuQO1NVs0b3Lk0RfEw
	38FyNQ2b8h2sT+W+5qdGuzmdTMOq0XZCrOZ3bHNgFkMPquoyainy+sp9597e0Q==
Date: Wed, 13 Nov 2024 17:41:02 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <20241113174102.40c6dc08@kmaincent-XPS-13-7390>
In-Reply-To: <20241113171443.697ac278@kmaincent-XPS-13-7390>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
	<20241113161602.2d36080c@kmaincent-XPS-13-7390>
	<ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
	<20241113171443.697ac278@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 13 Nov 2024 17:14:43 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 13 Nov 2024 15:57:56 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>=20
> > On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote: =20
> > > Hello Russell,
> > >=20
> > > On Wed, 13 Nov 2024 14:46:25 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >    =20
>  [...] =20
> > >=20
> > > Yeah, it was for v3 of the patch series. It didn't follow up to v19, =
I am
> > > using ynl tool which is the easiest way to test it.
> > > As there were a lot of changes along the way, updating ethtool every =
time
> > > was not a good idea.
> > >=20
> > > Use ynl tool. Commands are described in the last patch of the series:
> > > https://lore.kernel.org/all/20241030-feature_ptp_netnext-v19-10-94f8a=
adc9d5c@bootlin.com/
> > >=20
> > > You simply need to install python python-yaml and maybe others python
> > > subpackages.
> > > Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" =
on
> > > the board.
> > >=20
> > > Then run the ynl commands.   =20
> >=20
> > Thanks... fairly unweildly but at least it's functional. However,
> > running the first, I immediately find a problem:
> >=20
> > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
> >=20
> > One would expect this to only return results for eth0 ? =20
>=20
> Indeed it should! That's weird, I will investigate.
>=20
> > Also, I don't see more than one timestamper on any interface - there
> > should be two on eth2, one for the MAC and one for the PHY. I see the
> > timestamper for the mvpp2 MAC, but nothing for the PHY. The PTP clock
> > on the PHY is definitely registered (/dev/ptp0), which means
> > phydev->mii_ts should be pointing to the MII timestamper for the PHY.
> >=20
> > I've also tried with --json '{"header":{"dev-name":"eth2"}}' but no
> > difference - it still reports all interfaces and only one timestamper
> > for eth2. =20
>=20
> Sorry forgot to explain that you need to register PTP clock with the func=
tion
> phydev_ptp_clock_register() in the PHY driver.

And netdev_ptp_clock_register() in the MAC driver.

>=20
> It will be changed in v20 as request by Jakub. I will save the hwtstamp s=
ource
> and phydev pointer in the netdev core instead.
>=20
> Regards,



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

