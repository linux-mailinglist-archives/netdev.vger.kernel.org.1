Return-Path: <netdev+bounces-155171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BDA01591
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB7E1638BB
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A681CBE8C;
	Sat,  4 Jan 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oLfKtMkz"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C37136A;
	Sat,  4 Jan 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005063; cv=none; b=PjJ7gHiEOG9EBTYoG8RFsyoMckwdRfE4UxP3tyN3+zSu3C5n75wq370RSDaOZzd9hpDKUMLlUZY35yiiBtyLLmgnwFlVRtVAjlj/Oe9Jp51K4QaE6rfkMdXiBiimcPxSHmEB6+6RL7w7EYz/UlWZcRjqMG2jNxro9O1BtTBPFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005063; c=relaxed/simple;
	bh=G/IYv+zQTBPz+2viGf2a3G8QEY6mYv35VRJNa5p+8kA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCCiGOBvpbi36JdUfgPWZ8P0w/NPJRWkl7CGPg1TGju2qyemn5mZQjrqjUHvK6GqomxNmuek5WhG3f+aSYz4mr9qKHxoi9pX2FYIb4Fbztgz17H6jgCI0A35N0uQ+H/eB9f4Cc+5WKJriOmwN5wYnh/OAY5wR4/+xJoKZCyqexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oLfKtMkz; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7628FF802;
	Sat,  4 Jan 2025 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736005057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/IYv+zQTBPz+2viGf2a3G8QEY6mYv35VRJNa5p+8kA=;
	b=oLfKtMkzLF9+wmmdvGiH+Iw/BxtSt1o3sDZ6pijIfp/gqgiw5dTrBfd5OTgba4geN7YmMo
	uCrIOgi5bp8KpLyqbxMPtakysxt/LJzVTJvSXPzvH4qNugIBrSYpN5q9KRZYCfBd2EuPR5
	g1EJ+3YXizyjrC4g1mugcsxKoWcu6RAHz2DY9S9fsCDM/ltDvHEnto0PFq8VhFQuPfX80S
	MUWJ7XKB+lVKXXNbnOJ8Vxp9zOTGktW85+HrRh5/K+zQ7zfvGW9WRTFBByZQ+ImtO+F+mK
	9JNy+7sjO+CL4++lboO3veoVmgkAgikxaN6RarWxyE55EDyX3FveOVwZ2bJ9YA==
Date: Sat, 4 Jan 2025 16:37:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <20250104163734.57a1613c@kmaincent-XPS-13-7390>
In-Reply-To: <sxan73paedcp3jm2y3uchnl7c5qgbasgjt4tjv5pobamzxgqf6@ldx3hor6wrzx>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
	<20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
	<sxan73paedcp3jm2y3uchnl7c5qgbasgjt4tjv5pobamzxgqf6@ldx3hor6wrzx>
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

On Sat, 4 Jan 2025 10:43:25 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Jan 03, 2025 at 10:13:07PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Introduce a new property to describe the power budget of the regulator.
> > This property will allow power management support for regulator consume=
rs
> > like PSE controllers, enabling them to make decisions based on the
> > available power capacity.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Please use same SoB as From. You might need to configure your Git
> correctly, first of all.

That was not an issue in the previous series. Net maintainers and you were =
ok
with this:
https://lore.kernel.org/linux-doc/20240417-feature_poe-v9-11-242293fd1900@b=
ootlin.com/

Does it bother you now?
If so I will fix it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

