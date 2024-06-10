Return-Path: <netdev+bounces-102205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C1901E6F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7338E28378C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63274048;
	Mon, 10 Jun 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PGDpWvDH"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D9CA62;
	Mon, 10 Jun 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012385; cv=none; b=T+9PQoiNdhIG8KPj/H+t/oGTFB3/5yfxZU0ajQog8QE8cWC4juLJ9p57QJU36zlh0O1xAJ+3Wbt1bchy+GuKIPlvt3LDX87ci06Rwrxev4S3Vc2AHzJF+1BMyaj67RPikrng4GDWuciJ5wtHHwgEZt+sHhHpZ4fI8e2nOXbdvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012385; c=relaxed/simple;
	bh=4sDRBYwAnPLox8vS4ELY1A2qb0SwGdJhH/Bm4YEC7Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg4pOn7H7eGNah4FyhMC+tiqR7oe0Y6kEfSFDCd0kROAh/pGFf9wxs2rPny/Qu0cTnYt16kY/vWvNaAgFMySClH2KZxHw2D/obF/l24x3XM4F35dTQSl2ymeSiSDGaJry4x9oMz+J/pMI8xh3DUq9xPyymUK5VnXytllplDmq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PGDpWvDH; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87A2BFF804;
	Mon, 10 Jun 2024 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718012381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNZzOGuJb6tUoHOZ/zBBQKUASdGttzUiL5NxwXYa0VE=;
	b=PGDpWvDHoga4WmSbPQsT82tXfFilx9O3w4uXAK1xBc6npFomtrgfPNzQ4+4fd4uwg6q7R3
	IyH4aEvv3RshRIw/6GCnk4e60Np9bFxvkzllmaxuKcp3sJFWh6OxGrYvZ5ut+BAY746RT2
	gN0vEtxFUBTj9F1jS1QmcV/d1tEX9QkBBwtSUmSvaXD2hGNANEabKrwSwCChRCuXQigxd7
	7xDYCrUR5kdJ3il1Y7+Fk9h4I5HY18TbaZHB9oSmTakdehQHrRPWSQyFiLoRCeG+xEQdCb
	OpI9vGP+ung/GaRdsREjxr6M1Jxwb3EMppd6tZY5PgShCnNiNXPLwNiLdSmgPg==
Date: Mon, 10 Jun 2024 11:39:39 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 3/8] netlink: specs: Expand the PSE netlink
 command with C33 new features
Message-ID: <20240610113939.41d86109@kmaincent-XPS-13-7390>
In-Reply-To: <m2bk4dm5ct.fsf@gmail.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
	<20240607-feature_poe_power_cap-v2-3-c03c2deb83ab@bootlin.com>
	<m2bk4dm5ct.fsf@gmail.com>
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

On Fri, 07 Jun 2024 11:09:38 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> Kory Maincent <kory.maincent@bootlin.com> writes:
>=20
> > From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> >
> > Expand the c33 PSE attributes with PSE class, extended state information
> > and power consumption.


> >
> > diff --git a/Documentation/netlink/specs/ethtool.yaml
> > b/Documentation/netlink/specs/ethtool.yaml index 00dc61358be8..8aa064f2=
f466
> > 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> > +++ b/Documentation/netlink/specs/ethtool.yaml
> > @@ -922,6 +922,22 @@ attribute-sets:
> >          name: c33-pse-pw-d-status
> >          type: u32
> >          name-prefix: ethtool-a-
> > +      -
> > +        name: c33-pse-pw-class
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: c33-pse-actual-pw
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: c33-pse-ext-state
> > +        type: u8
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: c33-pse-ext-substate
> > +        type: u8
> > +        name-prefix: ethtool-a- =20
>=20
> I see this is consistent with existing pse attributes in the spec, but
> are there enumerations for the state and status attributes that could be
> added to the spec?

Indeed, I can add the enum also in the spec.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

