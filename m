Return-Path: <netdev+bounces-160545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFB5A1A20D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE63A8116
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45420DD64;
	Thu, 23 Jan 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OKTZ0eXB"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B020CCD6;
	Thu, 23 Jan 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628994; cv=none; b=u1YChVB8ctQgliTLP7W7qQYZAWvAGOWmWSN7iMN7y1PmtSlAJEbMKlmR3ZFPP9W89dnkAJCN1rcAav89klOu2uQ2B6SM95/JnZgaRjqRdyHLShAn/YWm3MRYdLcKiRHVBrtw4bLGDvNvN5EciF4+LH3m4Vd5IvcE460cQBfHIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628994; c=relaxed/simple;
	bh=fnLtwIc6MV8b5IUPyw308udN4u67DVdokrzGS7M8PFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKHdoWvvZi+6qBChwp3TIru5uT78WvnWIMQwN0RTaceEWVCBRS0CA2bs0l3nny0G6OGWGrCxWsgl28MnyhIPA5hjEB/dv550SanWi3Absrecg8butWGytAWLpM1B/tilemHAjRO0vO3sl8U8hiDBDLyHF44kfrP8DHlmsO8H+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OKTZ0eXB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66FDF1C000E;
	Thu, 23 Jan 2025 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737628989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLUfkUuRz3nRthcoDnA3/VSyQ9KzaT4t1CIzkWnxXYw=;
	b=OKTZ0eXBaLQy6Rq432EqyJslmMw2hRhB07qvB1bN8W0Wt0CRMzqS8GwtweDXvvZKWvgy31
	RTizLkQ9+JGW+tIGMkPWbTR0wU7ipdRR8npWIto6KFI/jJMLqEbUvqWJQMNLs+sFs0cc5d
	f90N+nLimTcYUf587XRFHQ74p7RDhNQGnc5WxLIHxnOC0BjxgWNxn90abQEhgzx3I2T7Pt
	XmYs7N5XEmhrXhLgfergYerdeNv0fzPZnbUmFw4qkVV2Cgg5KmeWDT3asDSsOqGPXux1Gg
	MEvgJbD5Rf64zTj+4MHWbAim+8U1jSLCoFjoaLCOLZ+U/NqeC6y3aDxCrEwO5g==
Date: Thu, 23 Jan 2025 11:43:06 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 0/6] net: phy: Introduce a port
 representation
Message-ID: <20250123114306.5c2f767e@kmaincent-XPS-13-7390>
In-Reply-To: <20250123113121.1d151582@kmaincent-XPS-13-7390>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
	<20250123113121.1d151582@kmaincent-XPS-13-7390>
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

On Thu, 23 Jan 2025 11:31:21 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 22 Jan 2025 18:42:45 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
>=20
> > Hello everyone,
> >=20
> > This is a second RFC for the introduction of a front-facing interfaces
> > for ethernet devices.
> >=20
> > The firts RFC[1] already got some reviews, focusing on the DT part of
> > that work. To better lay the ground for further discussions, this second
> > round includes a binding :)
> >=20
> > Oleksij suggested some further possibilities for improving this binding,
> > as we could consider describing connectors in great details for
> > crossover detection, PoE ping mappings, etc. However, as this is
> > preliminary work, the included binding is still quite simple but can
> > certainly be extended.
> >=20
> > This RFC V2 doesn't bring much compared to V1 :
> >  - A binding was introduced
> >  - A warning has been fixed in the dp83822 patch
> >  - The "lanes" property has been made optional =20
>=20
> Small question, I know you want to begin with something simple but would =
it be
> possible to consider how to support the port representation in NIT and
> switch drivers? Maybe it is out of your scope but it would be nice if you
> consider how NIT and switches can support it in your development.

s/NIT/NIC/

Sorry.
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

