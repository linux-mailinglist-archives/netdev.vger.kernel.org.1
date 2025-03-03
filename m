Return-Path: <netdev+bounces-171360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2CA4CA30
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E07A3D5A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9E8635B;
	Mon,  3 Mar 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZUNleldD"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BF78F40;
	Mon,  3 Mar 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023949; cv=none; b=OAsAWG/LYyVCnEFKzKGKRONz0eSmLwlxkweuPpwFOb6Dt6ZyAMxOSngqJqYZYFFb0vRJbXY4ffTkZXSP/7aEiDy7SNMFHz8Ltmm1irqjiCwVqa+8IPgE2XmX2ucSNKpOlOdPwrqOrrFmT/uohfOyxNxN89Yjd/Iyi0VK57bCmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023949; c=relaxed/simple;
	bh=UGdiHxV+cCPPcY2up8NJvAoTrAjRKSFf2eL7CxVBjDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nzge0GiTTdCod+xl36ev2xHKfb89MuR7Q3g+E2X5GftpxlpVQgFMXebhmOAUSXSQM0+dVByVftCxLEzu+UrpfQcYsGNDbWmsq12n1I5Iq3kika3HHVKuUk7eD9LIK1Vc3N/r+bqpCSP99WY3QbtaUESnRQMa+yyZAXgAlkINB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZUNleldD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E72C84432F;
	Mon,  3 Mar 2025 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741023945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPpTerC4hLINRf1Gupo5oTIIFDAqKCP0hsRiaiP783g=;
	b=ZUNleldDt2otWbBhV/st1ZKBAlw4HXcV0O5aPm0w6XjDXI0zSlX7j5lk0zXGPqU8pRm75D
	X/NmpvIhAqp08+TOksq5Gy9iIUc8PSQ3IlDi3bF1rOrSUBaBuoCYfuZw9EQqJWwAEHCRZb
	TRl8FtQWhuQ0wgyMQr8vVYmbOQ2QJiwKS2503RpKRrnKI5a4Q00i2mqONBrXFCiJ9sz0//
	IKVyIAcJeh+kLbunUWZdZH5cQ5QRd8UHYVaxlyMAp2zRaCPXuVo32P6HwEoMfLn1vZfjFX
	MF16m7EqA/fRw0WEZPGzTeFhXno5wNH6fska6ejdt++L7x8/2y4E6Xv5Y0bJAA==
Date: Mon, 3 Mar 2025 18:45:43 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when
 getting a phy_device
Message-ID: <20250303184543.33f74191@kmaincent-XPS-13-7390>
In-Reply-To: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
References: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepv
 gguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrrhhthhhisggrnhdrvhgvvghrrghsohhorhgrnhesmhhitghrohgthhhiphdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat,  1 Mar 2025 15:11:13 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
> ethtool netlink command targets a specific phydev within a netdev's
> topology.
>=20
> It takes as a parameter a const struct nlattr *header that's used for
> error handling :
>=20
>        if (!phydev) {
>                NL_SET_ERR_MSG_ATTR(extack, header,
>                                    "no phy matching phyindex");
>                return ERR_PTR(-ENODEV);
>        }
>=20
> In the notify path after a ->set operation however, there's no request
> attributes available.
>=20
> The typical callsite for the above function looks like:
>=20
> 	phydev =3D ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
> 				      info->extack);
>=20
> So, when tb is NULL (such as in the ethnl notify path), we have a nice
> crash.
>=20
> It turns out that there's only the PLCA command that is in that case, as
> the other phydev-specific commands don't have a notification.
>=20
> This commit fixes the crash by passing the cmd index and the nlattr
> array separately, allowing NULL-checking it directly inside the helper.
>=20
> Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some
> commands") Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.co=
m>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

