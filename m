Return-Path: <netdev+bounces-160527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C6A1A0E6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F52188E6B9
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4E20CCDE;
	Thu, 23 Jan 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nMLJB4cU"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FF1BC3F;
	Thu, 23 Jan 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624949; cv=none; b=mly4ZDFUbuAXm0DSC/AHegwUQ4F0t2towm20e68tq93xux3IY3/nZTAbFgsjtQcCfneGcA/YidKU9bnYWJz0NtyFpfBr0uM3C2bVn76kPLYylx9nAH4Y0wkqlwLbxl/29wvh4FxwLxSoYQ6U5ba0Ku1mw2M51KUGe4Y1ktYkC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624949; c=relaxed/simple;
	bh=y0Ly2u2NnSAQO8P3s6m7Sc963t4Wck3Y0+hbiVHs6iA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czuWHftGcnRR6OWMSADrPE7EICvpv3MH6Hz6ZUT0TqxQk9TZUhEYJuB6w06cshdCvLvmTxQQI4+hR7jK21PNGzfMeOTEGF1JM5PMFQp0MtJo8gkx0R6oGlN2EKjjTHyjaTigMoC6ap63NEGRPDnsWYcy7/9pCNXT8MRz8tQxZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nMLJB4cU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9106560008;
	Thu, 23 Jan 2025 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737624939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2YlYlx83cyR+45tTYr17HHrjYcIDaSt0mPlw1nFDgA=;
	b=nMLJB4cULhW8v0VbdR2QbZ9njGeqo7RCBUWP9SbAAB57ymSLCOKNqSLwj0ilbF7cHjwTKJ
	u4RHUQunWxctad88+JkgqGPeWyNFhfz+cB0kZ0HAcPDsL7zB6psDwSVX/5Jrk2YyLf3i7s
	D7/w8xN9cEm/LcM5//Z4wuS6g5+rFx9l0Hjf2hAlo8xYjIySsjMfQD56BUAQUwqe3skYHB
	DNU62quUCtH+Su5BFE95ZN0BYB3LUkwuDvd2QiUXSufJeBb2iPAioM5f0xQJpCt6PrRPtx
	DF0RxnxzRaZCIUl/iMMqtTqc+FA1Ihoh6V2AV59eQvCg0tUv561BTBTxHaNcvQ==
Date: Thu, 23 Jan 2025 10:35:34 +0100
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
Subject: Re: [PATCH net-next RFC v2 2/6] net: ethtool: Introduce
 ETHTOOL_LINK_MEDIUM_* values
Message-ID: <20250123103534.1ca273af@kmaincent-XPS-13-7390>
In-Reply-To: <20250122174252.82730-3-maxime.chevallier@bootlin.com>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
	<20250122174252.82730-3-maxime.chevallier@bootlin.com>
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

On Wed, 22 Jan 2025 18:42:47 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> In an effort to have a better representation of Ethernet ports,
> introduce enumeration values representing the various ethernet Mediums.
>=20
> This is part of the 802.3 naming convention, for example :
>=20
> 1000 Base T 4
>  |    |   | |
>  |    |   | \_ lanes (4)
>  |    |   \___ Medium (T =3D=3D Twisted Copper Pairs)
>  |    \_______ Baseband transmission
>  \____________ Speed
>=20
>  Other example :
>=20
> 10000 Base K X 4
>            | | \_ lanes (4)
>            | \___ encoding (BaseX is 8b/10b while BaseR is 66b/64b)
>            \_____ Medium (K is backplane ethernet)
>=20
> In the case of representing a physical port, only the medium and number
> of lanes should be relevant. One exception would be 1000BaseX, which is
> currently also used as a medium in what appears to be any of
> 1000BaseSX, 1000BaseFX, 1000BaseCX and 1000BaseLX.



> -	__DEFINE_LINK_MODE_PARAMS(100, T, Half),
> -	__DEFINE_LINK_MODE_PARAMS(100, T, Full),
> -	__DEFINE_LINK_MODE_PARAMS(1000, T, Half),
> -	__DEFINE_LINK_MODE_PARAMS(1000, T, Full),
> +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Half, T),
> +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Full, T),
> +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Half, T),
> +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Full, T),


> -	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full),
> -	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full),
> -	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full, K),
> +	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),
> +	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full, K),

The medium information is used twice.
Maybe we could redefine the __DEFINE_LINK_MODE_PARAMS like this to avoid
redundant information:
#define __DEFINE_LINK_MODE_PARAMS(_speed, _medium, _encoding, _lanes, _dupl=
ex)

And something like this when the lanes are not a fix number:
#define __DEFINE_LINK_MODE_PARAMS_LANES_RANGE(_speed, _medium, _encoding,
_min_lanes, _max_lanes, _duplex)

Then we can remove all the __LINK_MODE_LANES_XX defines which may be
wrong as you have spotted in patch 1.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

