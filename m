Return-Path: <netdev+bounces-96999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E18C89B2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9478284CA7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FF12F5AC;
	Fri, 17 May 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nlBpfuOw"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68712F598;
	Fri, 17 May 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961513; cv=none; b=Y5h2UcRRmsyR1e4Cd42o4sFxAFETiBCAnQ4lkRNN9Y0Xvj8wk/ItUtOJJIOYS6nOr8w8FiNtMk64Fy/PmXvL1O7hUa9PAVWk6Tukzr2W23p3aoNjOZXbcF2TWHYtnFjJpRBmBz2md2N3b56SBtuoIvhgVuSVBGyA3pV42aGQ2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961513; c=relaxed/simple;
	bh=UQresL8i5XslVSjYIf1mYzAjCbmYtYZ0tx9VZLeEh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K839DwWonpPPW6swWNqKk58id3BFz4J6qB2JeYZ+Gs1IVVsnSLqya6nzn0qqr5ufzoBPkwe/tIICwRwJuEgDDmh8sf3oOgWn9d5sLVo8SG6f5TGytje2199yxoyBYzT9r49hI89VSVG4XLHDPnlMhOmfimC1wXdE7G+VVCorVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nlBpfuOw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A47EE0005;
	Fri, 17 May 2024 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715961509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zixD6G+Iqmvf/KokPf1pygaOfwIjKh/xrai3jHSQCII=;
	b=nlBpfuOw6YxQxIdFvJTlW2MtgMlSGIi8OgV8bSmY66lUvcxiiIKrANEPWuRJQ0Hh5iMInd
	ZzIMzY+CSAK/fsMR2rqwFFMLMSJ4eRrx8CSEIhyYJZ+5bzrP+CCR4c6kTYMj3HWmwABTdq
	KyYb1m/8uShB4d18Ia1Omfxd72WElT6vg8LPvj6nmJXaE5wZFNpF2YBYh0zjFNzGOpTGx0
	2kPZ4WK0Zvq0h8VhTlbBLH9sCqiirJdn0GR/wLNaEtqkRw3ZVpDv6fWZB+oOXnI4ct/7kW
	+uwzrduHV8ULUl2JrxzymwPKFVWwNjqRq5TUUQZLbGd0w6MNFimlm+R6ojKKuw==
Date: Fri, 17 May 2024 17:58:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v12 13/13] netlink: specs: tsinfo: Enhance
 netlink attributes and add a set command
Message-ID: <20240517175826.690b69e6@kmaincent-XPS-13-7390>
In-Reply-To: <20240501191407.5661aca0@kernel.org>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
	<20240430-feature_ptp_netnext-v12-13-2c5f24b6a914@bootlin.com>
	<20240501191407.5661aca0@kernel.org>
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

On Wed, 1 May 2024 19:14:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 30 Apr 2024 17:49:56 +0200 Kory Maincent wrote:
> > +      -
> > +        name: hwtst-provider
> > +        type: nest
> > +        nested-attributes: tsinfo-hwtst-provider
> > +      -
> > +        name: hwtst-flags
> > +        type: u32 =20
>=20
> C code is unhappy about the naming here vs what the actual C enums
> are called (make -C tools/net/ynl)

Thanks I didn't know that check.
It allows me to fix several name issue!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

