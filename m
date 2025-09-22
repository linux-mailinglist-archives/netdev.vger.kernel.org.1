Return-Path: <netdev+bounces-225416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ACEB938EC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02127A6DCA
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3933274669;
	Mon, 22 Sep 2025 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fOpYssh4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0F1459FA
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583161; cv=none; b=a9aW94iDnfnZlzI1l8shK2KwKP0KFls2I+gLKUngzmeqqtdKDm+GLiGmRpBzY2Xi5doZZ+rFh49RVkbigNzhdZQyQlgXQAwreenaupjoZwIwqrm0F1F16vLyh42Q+xksvmXHjuDRljtHLI09Qnz5O4E/ChPA1nQc33zRZeC244A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583161; c=relaxed/simple;
	bh=Eke5AU3x+g0LDBushVsQMvV5FjRmlm7Fz2dz+avxuBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKCUh0vefaowLj7SDOYQ/qC88+t41U2MZRuKervUlM6I4cOW5K0zWRV01Gf4L2iEy0yM22O3DTg7rADUUfqm8JSN/pSDyVbwn4Mhrf//KWtPuv4a9LAjKUPi8UvOxXROUoFdrwp7au967PRBUpCAxkm2D7l/ealQW96rDiApINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fOpYssh4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 94743C01FAE;
	Mon, 22 Sep 2025 23:18:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BCCE60635;
	Mon, 22 Sep 2025 23:19:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C0A7102F1886;
	Tue, 23 Sep 2025 01:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758583153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S85P1i3oWpDcKV3f+HG9P7b6+eWWxrobHcRhWBYATBY=;
	b=fOpYssh4I96XxOQsqsFLZOD6WTurcgCxukyuOeIvqw6/cX1bi0K057VmigFzqRtO7luRBm
	b20tm+urNIp23ZtaEURbO2rEt4QKeHizzr6hf46Cm50vJVd8Gx8p90vH4E5qEHKJdm+Jl5
	izahUVqs2vvS5NIyjpgiuUSTgfgsnlmOAyCo8npHW0M+RIDiXOsN8UC/8bvLm/CxERst+5
	HRWKRyRe0DZJFrYbrE5dWXHMYYXSxPXlCsbaIrnOqCexFxo/SqKSf9y/oNV1Dx4a/TmRlG
	XZx83rBwxNNOtoqAkkstgqSpn3wqNNrqB2adua0hLx36+x/r8g2flI6j6jBndQ==
Date: Tue, 23 Sep 2025 01:19:04 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [Query] ethtool cumbersome timestamping options
Message-ID: <20250923011904.4ba598f0@kmaincent-XPS-13-7390>
In-Reply-To: <aMBKh2sqDwkRY04y@shell.armlinux.org.uk>
References: <aMBKh2sqDwkRY04y@shell.armlinux.org.uk>
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

Hello Russell,

On Tue, 9 Sep 2025 16:40:55 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> While spending some time with PTP stuff, specifically my Marvell PTP
> library, and getting mv88e6xxx converted to it, etc, I was trying
> out the timestamping related ethtool options:
>=20
>         ethtool [ FLAGS ] -T|--show-time-stamping DEVNAME       Show time
> stamping capabilities [ index N qualifier precise|approx ]
>         ethtool [ FLAGS ] --get-hwtimestamp-cfg DEVNAME Get selected hard=
ware
> time stamping ethtool [ FLAGS ] --set-hwtimestamp-cfg DEVNAME Select hard=
ware
> time stamping [ index N qualifier precise|approx ]
>=20
> and I'm finding them particularly cumbersome and irritating to use.
>=20
> Typing:
>=20
>   ethtool -T eth0 index 0 qualifier precise
>=20
> or
>=20
>   ethtool -T eth0 index 1 qualifier precise
>=20
> is quite annoying, especially when the man page states:
>=20
>            qualifier precise|approx
>                   Qualifier of the ptp hardware clock. Mainly "precise" t=
he
> de=E2=80=90 fault one is for IEEE 1588 quality and "approx" is  for  NICs
>                   DMA point.
>=20
> Note "the default one". That implies if it isn't given, this is what
> will be used if it isn't specified, but this isn't so, you have to
> type the whole "qualifier precise" thing out each and every time.
> So, it isn't a default at all.
>=20
> Either the man page needs to be fixed, or ethtool needs to actually
> default to the value stated in the man page.

We could indeed set the precise qualifier as default and make the option
optional.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

