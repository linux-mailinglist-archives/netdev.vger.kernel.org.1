Return-Path: <netdev+bounces-159626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA7A162E7
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7197A2763
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6A1DF975;
	Sun, 19 Jan 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WsIqYam8"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562381DF745;
	Sun, 19 Jan 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304091; cv=none; b=bU4sJF2swFI7Fqi6WkXlyBCQwSYGZ+nMq72ehKKrJRuUtN5Ixju6yTKJoCrBhZ7uTU6LOv7Bebk/7Z9m8LFzZoi028Th0+38Vkp7rflSr93uLSwXkTsZs7aCbb+3JP89euSwfkcs9ogxc5L4LLgRwgmIMD4C28mWXqsl/PbKj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304091; c=relaxed/simple;
	bh=UmMFdNpykxE/OmcxSq96VUTpgUVC8gGwk0JtMyRtvNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqKdslzpqxVRnxSJmJdvrjlNviGejHfanLbv+DpUSGy4blhydxHISjK3ZeHI0OSVJJS2UPKjYVjcDs3o5hVK6sd8cagJWHd16uKJhWqckitiKDQ6yvbHUNZGnq3acZ89RtNLNoItYzm9jkF1HfK2Ejr9OKWgny0A8Bv++6rkNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WsIqYam8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F59F240003;
	Sun, 19 Jan 2025 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737304080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjJ/Zbxwz28ARZB53SgDTdKko/g4H4N+LJZzXJ24mQ4=;
	b=WsIqYam83pFWOtuAZR7RFbbKQhvQeJVFhlSxBZwSp2EQap1W1CzoGYSsgKoeAjCTZLlS8K
	DtlzJDHEdTfJ6cKDhvVbevgwS/9KmisMtBUO+1ftxCPNjKQHNcLQ0tED3yIRwtGvYUS8w7
	Jt08PvY+wFl7TWxjKq2NAIgNFP2/W0uoNcTRo70vH4T4ipl51a/1kO3SNAluiCUzLUbZ13
	OWw8RqF/9+wtJ8A/3vpEFK07dn8etJl7Z5WN2SPXbeqa35ka2UieP5I3NlioJQBf3nls/2
	ab/bBL20tVmRNj5s5dit1aybwB2Foi0seE8jyzNji5U5NK7OY+GwZ/6KJXLsCQ==
Date: Sun, 19 Jan 2025 17:27:55 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250119172755.4fb94a86@kmaincent-XPS-13-7390>
In-Reply-To: <Z40L6Vhm7lwPGy6W@shell.armlinux.org.uk>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
	<CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
	<20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
	<20250117190720.1bb02d71@kernel.org>
	<20250119134518.6c49d2ca@kmaincent-XPS-13-7390>
	<Z40L6Vhm7lwPGy6W@shell.armlinux.org.uk>
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

On Sun, 19 Jan 2025 14:27:53 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Sun, Jan 19, 2025 at 01:45:18PM +0100, Kory Maincent wrote:
> > On Fri, 17 Jan 2025 19:07:20 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> > > On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
> > >=20
> > > I could also be wrong, but I don't recall being told that suspend path
> > > can't race with anything else. So I think ravb should probably take
> > > rtnl_lock or some such when its shutting itself down.. ? =20
> >=20
> > Should we add an ASSERT_RTNL call in the phy_detach function? (Maybe
> > also in phy_attach to be consistent)
> > Even thought, I think it may raise lots of warning from other NIT drive=
rs. =20
>=20
> How many drivers use phy_detach() ?
>=20
> The answer is... phylink, bcm genet and xgbe.

phy_detach() is also called by phy_disconnect() which is much more used by =
the
net drivers.

> Of the phylink ones:
>=20
> 1. phylink_connect_phy() - for use by drivers. This had better be
>    called _before_ the netdev is registered (without rtnl) or
>    from .ndo_open that holds the RTNL.
>=20
> 2. phylink_fwnode_phy_connect() - same as above.
>=20
> 3. phylink_sfp_config_phy(), called from the SFP code, and its state
>    machines. It will be holding RTNL, because it is only safe to
>    attach and detach PHYs from a registered netdev while holding RTNL.
>=20
> I haven't looked any further.
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

