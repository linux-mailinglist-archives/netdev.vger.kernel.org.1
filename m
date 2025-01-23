Return-Path: <netdev+bounces-160541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3DA1A1DE
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B613A2592
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BA1C5F1A;
	Thu, 23 Jan 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="huPhATPM"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73D186A;
	Thu, 23 Jan 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628290; cv=none; b=DBmmNE2UlneXoWdsFrPREcKjOrSeknfh+PbIs2d1w/5PXlNZYDLs1aRqkhinEi3fPbrXUBEGIbzqQVGh/x5vnyAgzEajIfLQvTCGDmhUoKUNnwbyOWrJzoXvkUeDGxE8WdtXulqkWeW7bW14TIygm4tP6i3Qwk6eUH9a+TWg9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628290; c=relaxed/simple;
	bh=BRLjNbXFj2HIvF4Gt30BLlJMZnAPiZabA/ZoSnacQXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCNeTl8XkbwKvCvQT+elfAsUgFfZ9Bjjx8cFADGLnKlqBpCsZDU0xLriQAG/qXZn58zByAJK+nsDNweCWSwEGSeEwNWudj5tDJH9p7XkP6Hn0IBvIFts0L/kh62+/Kh2p6Yi/MBKqFBAMjQLEKFhmJOy+dZdr1neCTDwYo+lXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=huPhATPM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F4C4C000A;
	Thu, 23 Jan 2025 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737628285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atllUYRRiasod8wnjdFBZu+PwMhVwz2ldRkTWH+EWLc=;
	b=huPhATPMWvUu8tmpQDUTzIkrAKG6J0Ggxf84YsNcdapp7Zes7SGDt3EKRx4xx7mBoFZHFE
	o5yCuHKIJQHUoYoCcicALmBtarBuAZG2+FbCJPK4g0tIGdgO5LrZbyHM+rRyppZnVyKPP6
	pxk+orsY911ccT+2JIr3kAs65HQ/xZI4oW4HMRFbBbNXo2LCwNAVshLlbqjiDBIpiWH/xI
	snFx44trB2ie8gqZV1lThdz3Ob4iaeqjBj+Pm8u3bMRWqK+4TX2YCiEe1GblhS2o6kayxk
	+3svcnLaPdm8AVqtfXc/D2uAD1lKx+CdSotWOrtBpvAbTNVa4gzVLdneQidW7w==
Date: Thu, 23 Jan 2025 11:31:21 +0100
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
Message-ID: <20250123113121.1d151582@kmaincent-XPS-13-7390>
In-Reply-To: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
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

On Wed, 22 Jan 2025 18:42:45 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello everyone,
>=20
> This is a second RFC for the introduction of a front-facing interfaces
> for ethernet devices.
>=20
> The firts RFC[1] already got some reviews, focusing on the DT part of
> that work. To better lay the ground for further discussions, this second
> round includes a binding :)
>=20
> Oleksij suggested some further possibilities for improving this binding,
> as we could consider describing connectors in great details for
> crossover detection, PoE ping mappings, etc. However, as this is
> preliminary work, the included binding is still quite simple but can
> certainly be extended.
>=20
> This RFC V2 doesn't bring much compared to V1 :
>  - A binding was introduced
>  - A warning has been fixed in the dp83822 patch
>  - The "lanes" property has been made optional

Small question, I know you want to begin with something simple but would it=
 be
possible to consider how to support the port representation in NIT and
switch drivers? Maybe it is out of your scope but it would be nice if you
consider how NIT and switches can support it in your development.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

