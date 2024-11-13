Return-Path: <netdev+bounces-144492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A099C7980
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF454282D44
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24316FF5F;
	Wed, 13 Nov 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a9TuTW53"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFD7083F
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517358; cv=none; b=nHmlXl8CrupC+RUVAC/UzoYqDvUptx7eYpEUFFfqk6COfTRWMQ0HgS2XZP7d04wKkyRusYOtcc05bNf89IIKEuJmiu1QbEM+imnky+NEypDpis6tUnJFJnN67GaVIkkpp/v3t0WmC/9uSBAZgjbb33g9owHxznq9JhXQEt6+27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517358; c=relaxed/simple;
	bh=pnJUadk3cwWU+ddCYRgwonnlPinumuSzBdk8sV/RQzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PodDcOBWiH6pyq17n//gWHhyXKu+1icBSjGzUIp0MhCsQgGZIYgIIm2X18jn+E6PRK8HZrRYrsQKojJANRl1qwlALyAvscHq0rGfFbSNpFPtrtkgXhooe10VDEIVwoEo9bP9RtuDuoWi3+EhgMUTzL0BCmpOwt6s0xUCvwEeGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a9TuTW53; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD209240002;
	Wed, 13 Nov 2024 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731517347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0ybhIePpsVTq2cCVODT5U3P8JE0djKapmhgh6aKusc=;
	b=a9TuTW53nJGnvPVifZcIUIGkDxmL5By3uqhZLt9Dxa/kOzIMMBHyqK+D2y9TC7zEbQAwno
	DDUqiGRkcBbpO2gxixBWUf4ncczeZsDu713j2cKyrcVjPr2Nwf2AZWSmtmfMuZtnkZqoZE
	gYt6Up6oIzwvvKqZhowVek9w2a2H2gaD86btAMe+AAgVaWQkyrvh2cbaGwKopIOoSJknz1
	zMI8MDPkPTbKyjdSuhpzmRJBKeJ6eSWPpphAoNy73OQWnUiqTZRj9aRQA8rNl3YpgYtW3e
	RdNI06jEAIj23Sh0EtNxv3g+wfoQX5zRKtGxE2r/ShLbR+oDuo7+SppTzUHdng==
Date: Wed, 13 Nov 2024 18:02:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <20241113180226.78d8d1ab@kmaincent-XPS-13-7390>
In-Reply-To: <ZzTZRCWLxHZ_WDhW@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
	<20241113161602.2d36080c@kmaincent-XPS-13-7390>
	<ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
	<20241113171443.697ac278@kmaincent-XPS-13-7390>
	<ZzTZRCWLxHZ_WDhW@shell.armlinux.org.uk>
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

On Wed, 13 Nov 2024 16:52:20 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Nov 13, 2024 at 05:14:43PM +0100, Kory Maincent wrote:
> > On Wed, 13 Nov 2024 15:57:56 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Thanks... fairly unweildly but at least it's functional. However,
> > > running the first, I immediately find a problem:
> > >=20
> > > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > > tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
> > >=20
> > > One would expect this to only return results for eth0 ? =20
> >=20
> > Indeed it should! That's weird, I will investigate.
> >  =20
> > > Also, I don't see more than one timestamper on any interface - there
> > > should be two on eth2, one for the MAC and one for the PHY. I see the
> > > timestamper for the mvpp2 MAC, but nothing for the PHY. The PTP clock
> > > on the PHY is definitely registered (/dev/ptp0), which means
> > > phydev->mii_ts should be pointing to the MII timestamper for the PHY.
> > >=20
> > > I've also tried with --json '{"header":{"dev-name":"eth2"}}' but no
> > > difference - it still reports all interfaces and only one timestamper
> > > for eth2. =20
> >=20
> > Sorry forgot to explain that you need to register PTP clock with the
> > function phydev_ptp_clock_register() in the PHY driver. =20
>=20
> That is certainly inconvenient. Marvell's PHY PTP/TAI implementation is
> used elsewhere, so the TAI driver is not specific to it being on a PHY.
> The drivers/ptp/marvell*.c that you find in my patches is meant to
> eventually replace drivers/net/dsa/mv88e6xxx/ptp.c - the same hardware
> block is in Marvell's DSA switches.
>=20
> > It will be changed in v20 as request by Jakub. I will save the hwtstamp
> > source and phydev pointer in the netdev core instead. =20
>=20
> I think I'll shelve this until that happens, hopefully that will mean
> my existing code will work and remain a re-usable library.

Ack, Thanks anyway.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

