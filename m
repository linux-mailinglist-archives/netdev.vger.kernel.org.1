Return-Path: <netdev+bounces-99322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D6A8D4754
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E9B23CBF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F02176190;
	Thu, 30 May 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d0rIp3dw"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0B17618E;
	Thu, 30 May 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058408; cv=none; b=bAR0sq55aqOou+thVjMETXoIWG6P3Q1DvSnK5tcz6dePgHYgzVPpv64kMr+Q7Vplp/NbAyo4Tfzt7NmItC1pJpeViEpZF37X1DTIW4h9jZTGPKRHWKUuZFcLMIBMjLveixrBUsYuoiE+CRKThX2DVI2fjAum5vvyEBelTVkDZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058408; c=relaxed/simple;
	bh=eJnXxqymnXa68XS6otpNw5yROUyZND8qNVk7GfyKNws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9UOG5RFoWO3Zx3xINpXRIukki2rnrws7+cN8jAXEYXFXuJdT4bvFkm0JMuluz7vvnwPsWIfjMAtwcbGvXK7RdHxCGQPQps6uqUaNA9QeGeIXnCiSU6AmW6qat1qgbOrP6vPxNylgjkhox+drrgippjN4U7LPGHe27jjJ3P/pAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d0rIp3dw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFA92E0005;
	Thu, 30 May 2024 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717058403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omuiVoMKbFAjZ0PI451uHKpDzHiao6GQBVCNywyqCw0=;
	b=d0rIp3dwWDkPeI36pKgJmeTsbVk+6usO8uzbZRctH7ben4reJklEBT8M76mOgJLzPWIGyF
	oxjNCAeDXbEknqNu6ZHSgQKyT9mJWZFPkgTHhy1Zd6R3obhGiV2GzQsxGNwQ4eyWGV15L8
	qopz6wjjKfeHUEZU/WWX3aKgvMHTr4dxp8ZayFPK/5WxtNnwpO/WCNaBeSfcuQpM/T71oE
	28JsyDUG5fspNUBfEV7/i6BN9dFLW8HcHFnJr3day5lmTTZEPrLvYKlAJbCI72j5JgyV9w
	4bZn98tO0bRzHAkhtLqDMwq7IRYHgt0fuaYYiIBD+oqrTmURbAbUm7PWRmtgPg==
Date: Thu, 30 May 2024 10:39:58 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v13 09/14] net: Add the possibility to support
 a selected hwtstamp in netdevice
Message-ID: <20240530103958.3cef71c0@kmaincent-XPS-13-7390>
In-Reply-To: <20240529180556.0e500675@windsurf>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-9-6eda4d40fa4f@bootlin.com>
	<20240529082111.1a1cbf1e@kernel.org>
	<20240529175032.54070c60@kmaincent-XPS-13-7390>
	<20240529180556.0e500675@windsurf>
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

On Wed, 29 May 2024 18:05:56 +0200
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> On Wed, 29 May 2024 17:50:32 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > > ERROR: modpost: "ptp_clock_phydev" [drivers/net/phy/libphy.ko] undefi=
ned!
> > >   =20
> >=20
> > Thanks for the report.
> > Weird, it should be in builtin code. =20
>=20
> Right, but you don't have an EXPORT_SYMBOL() for it, as far as I can see.

Arf I removed too much EXPORT_SYMBOL(). Need another version for the patch
series then. I will wait review before sending it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

