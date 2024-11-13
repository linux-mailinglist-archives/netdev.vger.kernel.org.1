Return-Path: <netdev+bounces-144486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8DF9C7883
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E2284B02
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124C201018;
	Wed, 13 Nov 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MnoOLjdx"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203B1E00A0
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514489; cv=none; b=sBKX2HqD+AX478kSNfF4JaFY5IOgFXEo19x/z0Pkvr2TueLaGuCSQs+RtLlmHbof9eTH4bogXugxW8r5v80VrQVnZdEe1No4CyE0CLE7SjIFBP/lQtD8fDawvkQBYhMk65y2XuKeZYJKt6LmOA7wZzFU309sfCEPLSGdAioM088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514489; c=relaxed/simple;
	bh=BmTsOCKyrPG2YfyL5acBzci1M0XdqFpbytOYo331NrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2WADGb3oXqYWzDq628rBuMWjK/+//KJk2mNjHX6IXkKJhjVLi39ICGqLppVI4i1NCpo3Oe6C356WzxHjguNuh7hTWy7UcCnJhCcu6E0JKErRzOJxe6oLSUEbpLfY2BWysX6v7QE0Suw1Nx88aH58RWQxwg4ip2Fag221FQWe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MnoOLjdx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56D9160002;
	Wed, 13 Nov 2024 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731514484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3WZgkURvDfhuAy+4YumCl8Ei92ZKeFOurXNer0/T8U=;
	b=MnoOLjdxWbULEiENmACt46MKmJVUNF2l4iQv9hCA2AnyYvo53+QTlPIyrCPjyPYgH87LpM
	1vDofbOldcstJ8IeZw5rvUnfQlud0DAEkiZK19QerLMARHXnXnk0iXYojWv8/L5dDaJ9FT
	WVGaiOVD1DlpbtyLrg30ElQOffxWoLltZ9VOZTWpFzYlwCNXEokp8fghsuPnXvfCCXG395
	cM4cPHRUy3QiTVxRq8PAnQ4oeQZIv2XIQxBCGm8Md9WVoofxqyAP7yQnzAuU/s7QCiErDT
	k3w339PF5AgA+2WqXBCM3zJcGDKAUF+wdm52QxZixYQw/euPdmtugilF/HrvTA==
Date: Wed, 13 Nov 2024 17:14:43 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <20241113171443.697ac278@kmaincent-XPS-13-7390>
In-Reply-To: <ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
	<20241113161602.2d36080c@kmaincent-XPS-13-7390>
	<ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
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

On Wed, 13 Nov 2024 15:57:56 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote:
> > Hello Russell,
> >=20
> > On Wed, 13 Nov 2024 14:46:25 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > Hi Kory,
> > >=20
> > > I've finally found some cycles (and time when I'm next to the platfor=
m)
> > > to test the selectable timestamping feature. However, I'm struggling =
to
> > > get it to work.
> > >=20
> > > In your email
> > > https://lore.kernel.org/20240709-feature_ptp_netnext-v17-0-b5317f50df=
2a@bootlin.com/
> > > you state that "You can test it with the ethtool source on branch
> > > feature_ptp of: https://github.com/kmaincent/ethtool". I cloned this
> > > repository, checked out the feature_ptp branch, and while building
> > > I get the following warnings:
> > >=20
> > > My conclusion is... your ethtool sources for testing this feature are
> > > broken, or this is no longer the place to test this feature. =20
> >=20
> > Yeah, it was for v3 of the patch series. It didn't follow up to v19, I =
am
> > using ynl tool which is the easiest way to test it.
> > As there were a lot of changes along the way, updating ethtool every ti=
me
> > was not a good idea.
> >=20
> > Use ynl tool. Commands are described in the last patch of the series:
> > https://lore.kernel.org/all/20241030-feature_ptp_netnext-v19-10-94f8aad=
c9d5c@bootlin.com/
> >=20
> > You simply need to install python python-yaml and maybe others python
> > subpackages.
> > Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" on=
 the
> > board.
> >=20
> > Then run the ynl commands. =20
>=20
> Thanks... fairly unweildly but at least it's functional. However,
> running the first, I immediately find a problem:
>=20
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
>=20
> One would expect this to only return results for eth0 ?

Indeed it should! That's weird, I will investigate.

> Also, I don't see more than one timestamper on any interface - there
> should be two on eth2, one for the MAC and one for the PHY. I see the
> timestamper for the mvpp2 MAC, but nothing for the PHY. The PTP clock
> on the PHY is definitely registered (/dev/ptp0), which means
> phydev->mii_ts should be pointing to the MII timestamper for the PHY.
>=20
> I've also tried with --json '{"header":{"dev-name":"eth2"}}' but no
> difference - it still reports all interfaces and only one timestamper
> for eth2.

Sorry forgot to explain that you need to register PTP clock with the functi=
on
phydev_ptp_clock_register() in the PHY driver.

It will be changed in v20 as request by Jakub. I will save the hwtstamp sou=
rce
and phydev pointer in the netdev core instead.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

