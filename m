Return-Path: <netdev+bounces-216471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FAFB33F3A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340201A821D0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C91C8621;
	Mon, 25 Aug 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eAM+B1GY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74F78F58;
	Mon, 25 Aug 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124438; cv=none; b=YCe4izSKQRlTIrLjo2A0hq+iVt/h+vcJYwTZMajkmkNTecliHtRG51wjGDgoLMEcTh+IuMcJyBcLvfp7KkXxH7RRoOgO+d+RMxiiKYzH8vDW5XKnegXQJuSP6oClWz/WGQjDK8vgtbXWuHMoRW99k1Q3Hih3nap8Y9VefuJrbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124438; c=relaxed/simple;
	bh=h7hrNFYhLwn9BT1C/3Vpaem6D+z7W+zRXwonq3Svi9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fz7jZMCu5eFsxCx3cxM01guIBqbm0e0cbylCvaE8D9k0x54+CEJzxLgjEMJOBqVXBCcerlbFZTazlKd/nn0NsarCigtrsXF6kDt4zCx+1U49h1HvE95yz2LI1WLsARQGvmWCRJF7GwQk1zvvzKy35i5O1JC011W+ErfbkSGzw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eAM+B1GY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 90C394E40772;
	Mon, 25 Aug 2025 12:20:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65F38605F1;
	Mon, 25 Aug 2025 12:20:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61EC91C22D928;
	Mon, 25 Aug 2025 14:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756124427; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h7hrNFYhLwn9BT1C/3Vpaem6D+z7W+zRXwonq3Svi9s=;
	b=eAM+B1GYYZEgno+6Km3RDSdQ1mPQVco5var0IJcR6N5q2PC9VPYVsGwvI+AEXQCN7HrLqh
	oHY6bWAi6c/ahoHPYaXSyFrrILw4MZcChzUbrH7ECUllP17Xt5Rt/LP0a1U/JJUe6d8Ow0
	lNhpO9AeKbE9nspnIVNbCEShiNvIbsJcJ6JlY5V6K/nD0pKgZKTU4v+2+rXSNqQA7fPTzD
	0Ds+DldTArlmq7XVJM5WLvvhrpuwgbxxwHkXdUeYZV2aPV1GRySxtc5h+uSewbK/hLOH26
	8ToRnqUz6lx3uzVCNdPX9MeZ6EeZemCqmIHxr+h920oQXy0Iso2vNmKo9z+X2w==
Date: Mon, 25 Aug 2025 14:20:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <20250825142001.19b796ae@kmaincent-XPS-13-7390>
In-Reply-To: <aKwpW-c-nZidEBe0@pengutronix.de>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
	<d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
	<20250825104721.28f127a2@kmaincent-XPS-13-7390>
	<aKwpW-c-nZidEBe0@pengutronix.de>
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

Hello Oleksij,

Le Mon, 25 Aug 2025 11:14:03 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Hello Kory,
>=20
> On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:
> > > I've not looked at the sysfs documentation. Are there other examples
> > > of such a property? =20
> >=20
> > Not sure for that particular save/reset configuration case.
> > Have you another implementation idea in mind? =20
>=20
> My personal preference would be to use devlink (netlink based)
> interface. We will have more controller/domain specific functions which c=
an't
> be represented per port.

Ok, I never played with devlink but I will check.=20

> PS: if you are on the OSS Amsterdam, we can talk in person about it.

Yes sure. Let's meet at the social event around a beer!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

