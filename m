Return-Path: <netdev+bounces-155849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C750A040C2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D0318869C5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF71E3DE5;
	Tue,  7 Jan 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pKY+u6mE"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4B188733;
	Tue,  7 Jan 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256379; cv=none; b=KTfGc6UAZLuTjqS5uzgCmOFBz7QQOryQ6fks2cgrqw86NjliBrSYSzG+uw8tLac2GYkgBqU11iHgBxSB9n/OKMXiK+bq4FFRz3EPXg2TMNfyrdmTYht43F6amYJV7y55taNXuJdU9/dQzLOf8/ORrLaZRToJ1oFFyx2v37RmS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256379; c=relaxed/simple;
	bh=sAp4ZTN80riFMDG6M57dqFsA6VIuvYa4ldbRWLa3QM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5XcbTMyYtwZ88bao1fAZs53s2A26PT/3H5bEKvAVfx3cCxVe9flhFNhlbhoW1mAJDHH1hCe1ftIp2ulchEjURGsiuE6uLtgJLSVvZGKTwE9k7RIK0FL3bzh6EsJu6/+yktVriN5o/diY6klTOFU0dscYR26pP/GoG6sJsAQIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pKY+u6mE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29B6660005;
	Tue,  7 Jan 2025 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736256367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZy6zaL3auTQI87bDI7Q8hHx2ztKK9SEbDscRh+BoZE=;
	b=pKY+u6mEp8EaWU6MPTKWH/z/tscf/lVeses2qVc5zXT78RReZGt3AJ5Jt6CMrqFlFzSeDZ
	99gfkFnafZMMsYWJFmJGX4nmhIwcl7RAWzeVvylZe/OcsmjG2W8gQ8ITBLaM/37Jz5UyV/
	sfWIyhyruvOySGLfpt1VSg41L+3igzXyVeU19VQsy53PT7c6Jyk/9dTqZd7TFUGCJeIVL8
	tb74JuFfSteb/sucIIpnqfuCxXBzLXEIkZtk5HMlWiLqg+aSfss8sfThFyXaSkYkLQWcl/
	8CO47EexKrdhzpsd5WC3/E9dkoE24pabFVskeGrZdDpql8xCFMqlUh1SJG7GDQ==
Date: Tue, 7 Jan 2025 14:26:05 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
In-Reply-To: <Z3bG-B0E2l47znkE@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
	<Z2g3b_t3KwMFozR8@pengutronix.de>
	<Z2hgbdeTXjqWKa14@pengutronix.de>
	<Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
	<Z3bG-B0E2l47znkE@pengutronix.de>
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

On Thu, 2 Jan 2025 18:03:52 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote:
> > On Sun, Dec 22, 2024 at 07:54:37PM +0100, Oleksij Rempel wrote: =20
> > > Here is updated version:
> > >=20
> > > ports {
> > >     /* 1000BaseT Port with Ethernet and simple PoE */
> > >     port0: ethernet-port@0 {
> > >         reg =3D <0>; /* Port index */
> > >         label =3D "ETH0"; /* Physical label on the device */
> > >         connector =3D "RJ45"; /* Connector type */
> > >         supported-modes =3D <10BaseT 100BaseTX 1000BaseT>; /* Support=
ed
> > > modes */
> > >=20
> > >         transformer {
> > >             model =3D "ABC123"; /* Transformer model number */
> > >             manufacturer =3D "TransformerCo"; /* Manufacturer name */
> > >=20
> > >             pairs {
> > >                 pair@0 {
> > >                     name =3D "A"; /* Pair A */
> > >                     pins =3D <1 2>; /* Connector pins */
> > >                     phy-mapping =3D <PHY_TX0_P PHY_TX0_N>; /* PHY pin
> > > mapping */ center-tap =3D "CT0"; /* Central tap identifier */
> > >                     pse-negative =3D <PSE_GND>; /* CT0 connected to G=
ND */
> > >                 };
> > >                 pair@1 {
> > >                     name =3D "B"; /* Pair B */
> > >                     pins =3D <3 6>; /* Connector pins */
> > >                     phy-mapping =3D <PHY_RX0_P PHY_RX0_N>;
> > >                     center-tap =3D "CT1"; /* Central tap identifier */
> > >                     pse-positive =3D <PSE_OUT0>; /* CT1 connected to
> > > PSE_OUT0 */ };
> > >                 pair@2 {
> > >                     name =3D "C"; /* Pair C */
> > >                     pins =3D <4 5>; /* Connector pins */
> > >                     phy-mapping =3D <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY
> > > connection only */ center-tap =3D "CT2"; /* Central tap identifier */
> > >                     /* No power connection to CT2 */
> > >                 };
> > >                 pair@3 {
> > >                     name =3D "D"; /* Pair D */
> > >                     pins =3D <7 8>; /* Connector pins */
> > >                     phy-mapping =3D <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY
> > > connection only */ center-tap =3D "CT3"; /* Central tap identifier */
> > >                     /* No power connection to CT3 */
> > >                 };
> > >             };
> > >         }; =20

Couldn't we begin with something simple like the following and add all the
transformers and pairs information as you described later if the community =
feels
we need it?

mdis {

    /* 1000BaseT Port with Ethernet and PoE */
    mdi0: ethernet-mdi@0 {
        reg =3D <0>; /* Port index */
        label =3D "ETH0"; /* Physical label on the device */
        connector =3D "RJ45"; /* Connector type */
        supported-modes =3D <10BaseT 100BaseTX 1000BaseT>; /* Supported mod=
es */
        lanes =3D <2>;
        variant =3D "MDI-X"; /* MDI or MDI-X */
        pse =3D <&pse1>;
    };
};

We can also add led, thermal and fuse subnodes later.
Let's begin with something simple for the initial support, considering
that it has places for additional details in the future.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

