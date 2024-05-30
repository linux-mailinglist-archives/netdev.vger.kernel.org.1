Return-Path: <netdev+bounces-99399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510758D4C16
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732EA1C21E56
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B117C9F0;
	Thu, 30 May 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GkDUW/Ri"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9917C9E5;
	Thu, 30 May 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073643; cv=none; b=cTvy9mjrK3I8kXq1FI5QhrVvYwptDbI4Gimi6VtmA5t1yqR95B+ngpJnujVSVvTYMd57tJDtbvZ94vGdcbKLMZnN0UFEnbvROvcyXpHtwiz0xBXp9Rz54EFkWQGjPMzamshoubTxzUkOJ5vLldy/KqZBNVNBXW4XyxbPffoZpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073643; c=relaxed/simple;
	bh=F3lUDpXkkg1u1Y2GeIDaUK3xQK3ttNcJBGHRBMhMWw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sR4r3cZWZGQN+4nfBtSeHkLiih6Wel38vneT2GtzQVqZS1tt+xRAhuE/JveJk3vP6wDHDtsLedHgk+wo8+Esa7np7WwZnjqeu1iojgLKGyXhT7NfcB1Q4+AC61BD352fubfkY/+PatYdaa/jQirr8izZo4DAY8T4sQLVt2dkwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GkDUW/Ri; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7B7540006;
	Thu, 30 May 2024 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717073633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+ttqbsSC7Mf0krLnfeQ88z6eFjeEfepuvZI0uIRmts=;
	b=GkDUW/RiMVgDGnGgeGDIBqIjxy1uL7fgZXm0U0PQH4UJpW0XPX2hjMuFGP72O6Gq7gELr7
	uZFQ4E+kBFNGaO73dpNyfsRJjCEL+f5cyXqf55ht+zHvWlYrYVu66JpTjF1BWaZaFiWCBn
	Nc1goeE88WvTV93c69VmmxsEZPNf0CHc5MiKEYO2uzbNtcmXEVknfpaoWeQSVXyChO9P0f
	Fi/yuJbpxZpv6T1h+JUF/YMf1XkdEWfGfGJnZbLRQJ4//NS4y1lm1HjHLv6yBRWt1afUr1
	BYdYq65E/E6gSooj3mU39R+Ws/tdYoXC+ByJdSNEgVJeNPl+CkGfkeg8ltkdig==
Date: Thu, 30 May 2024 14:53:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re:  [PATCH net-next v13 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Message-ID: <20240530145350.6341746f@kmaincent-XPS-13-7390>
In-Reply-To: <BY3PR18MB47074528CBB38F55A3F58A19A0F32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-12-6eda4d40fa4f@bootlin.com>
	<BY3PR18MB47074528CBB38F55A3F58A19A0F32@BY3PR18MB4707.namprd18.prod.outlook.com>
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

Hello Sai,

On Thu, 30 May 2024 11:23:10 +0000
Sai Krishna Gajula <saikrishnag@marvell.com> wrote:

> > Move ptp_clock_index() to builtin symbols to prepare for supporting get=
 and
> > set hardware timestamps from ethtool, which is builtin.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

> >  }
> > +
> > +int ptp_clock_index(struct ptp_clock *ptp) {
> > +	return ptp->index;
> > +}
> > +EXPORT_SYMBOL(ptp_clock_index);
> >  =20
> Please check the "build_clang - FAILED", "build_32bit - FAILED" build err=
ors.

Could you be more explicit? Which config are you using?
What is the build error?

I don't really see how this patch can bring a 32bit or clang build error.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

