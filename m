Return-Path: <netdev+bounces-156780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA18A07CFE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4405F163828
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97822069B;
	Thu,  9 Jan 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JmGHSnVb"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77721C193;
	Thu,  9 Jan 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439011; cv=none; b=IKWC3ad4V1CUy9KBMtmgAQyS8oSr/A6tbOc6yn/wpT4Y4aglePdCj2lU0/5YGpKWpjcgqYo09YWjE6SURZzzCOL1j7F75Uf8O757k1WwJszMQtmYBp/LSQbfrtTzmgGhlWDy3cW/+D479J2/E11JEpaWgQOKCYx5YhKFyFXDxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439011; c=relaxed/simple;
	bh=wkNHglqoC/wJFkHT+8fds+/YPFBVcl/4zM9Ngw0M+vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayYpy0/DMpeq0RXJen8/zyRXjLCmhBzT2KtmeOpZ4j7EYxziLtr4V5DruKDfZL3AmCQiNIYL+Z6zx7kEmpcvzdBGgeL2u1dT6iAuhj6dkoRDKr2RvqiMyvHR8IWnq9wzfqePX5y2ThEflchwFCFg69JyslC6dLJbkGGN5EsW7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JmGHSnVb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77BF8FF803;
	Thu,  9 Jan 2025 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736439000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkNHglqoC/wJFkHT+8fds+/YPFBVcl/4zM9Ngw0M+vw=;
	b=JmGHSnVbJikDRRwlqAS6fCPX+Bl3b+MpGUczWvbdrAnKz8K7oYEPePlw6E3SfyjtOlitz5
	wf/Yp8Rn18sLrajVaF/g8jy2powggrRFlFKtMBIl8cPFTeuLxdmzd7ymcVI2KkPwvZmj42
	TLNf2I9/N8J/KkEl+2CH/uaEhgXlMNXLUdplXBDQ8I4VvJ3wqTG4YjZUKikiSV2N8Klvyo
	pCMNyqX3sHa3aayFlsSsbUJu0Bz0aAxwcG0oJHuBUlYaJzMjviUJ1tcZbn7AalZKgmRSPT
	u0YoLP22we22rDUgmwjvaUFdycAvqOwdXd7+BV03gXHS8a+sIk96mg3jYxm+vQ==
Date: Thu, 9 Jan 2025 17:09:57 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
In-Reply-To: <20250109075926.52a699de@kernel.org>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
	<20250109075926.52a699de@kernel.org>
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

On Thu, 9 Jan 2025 07:59:26 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 09 Jan 2025 11:18:05 +0100 Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for a PSE device index to report the PSE controller index to
> > the user through ethtool. This will be useful for future support of pow=
er
> > domains and port priority management. =20
>=20
> This index is not used in the series, I see later on you'll add power
> evaluation strategy but that also seems to be within a domain not
> device?
>=20
> Doesn't it make sense to move patches 11-14 to the next series?
> The other 11 patches seem to my untrained eye to reshuffle existing
> stuff, so they would make sense as a cohesive series.

Indeed PSE index is used only as user information but there is nothing
correlated. You are right maybe we can add PSE index when we have something
usable for it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

