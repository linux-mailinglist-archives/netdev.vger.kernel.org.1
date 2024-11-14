Return-Path: <netdev+bounces-144827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3679C8831
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628BCB2E9F3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4A1F8EE8;
	Thu, 14 Nov 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jxDE5vdp"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703301F80CC;
	Thu, 14 Nov 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581185; cv=none; b=agVouWp4ZJdAqRJ86Xk+7X72p3kmUeOq/xOh5+37LTdHMVZAmL/TvfErfDdPV/AVU9JgBszo7ObBVPJrRHEodZRzQJidHvxVbQ54XpZRoti+Ev+vjr6EkDixmSIl+htZQnX7bjUVXycPbzK7zRf6/kTdOMishBZKHAiOTfNTaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581185; c=relaxed/simple;
	bh=6GmTVh0328DG3z1UVIJJzkv4fJ3qqsmJH7jtABAW+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK22sqOzOAEg6T9eRk53hBHg8wjzP3Ul7/RT0J4vL5iMNmjtoUYXqxHwn91WM4VYCo7EB2JctNyz0Vby85HUPLzM32VfqZjlMECfjqPHM55Sfx70l01F6MnhiLMSFQoR4YcWG48D9XD7HvApBsyPYIqSJot7f7N4qh9FrfyQmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jxDE5vdp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 628354000C;
	Thu, 14 Nov 2024 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731581174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXjkCtqX7WBxDao3IE3a8VvAAIvFEnT0KiRXJWPUYP8=;
	b=jxDE5vdpag5h+2dL8KSGTV+QohJenpgiJERIiclWddgnRxschtdWzrEFI1tPPTw8mG7fOU
	6LXy4C15Ci7lbsnfUipqFT5amaRmK+jEMin7ZIDL1+XQQdaChBqOqDnd2vGGikRnSrBQTA
	p1nq+tTh4fj68pJnKY9ZvIVgOi52FmSuf6MbhybW8DOUSKjvRhf7HHHPYxxBzD56d4S+F7
	z3jCQmkbfvQfB2qgj2se+8ftLTW2rU8LOMoDvV4oVfiBcRlRV9jvdrZQW9GMracvfMFaFD
	SYM3xOaqFDOTHHEnYolg8l7TFFsYqCzxSfbqjvwwfTIPfWEtFZ0WbHICBVl2Tw==
Date: Thu, 14 Nov 2024 11:46:10 +0100
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
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241114114610.1eb4a5da@kmaincent-XPS-13-7390>
In-Reply-To: <20241113163925.7b3bd3d9@kernel.org>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
 <20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
 <20241111150609.2b0425f6@kernel.org>
 <20241112111232.1637f814@kmaincent-XPS-13-7390>
 <20241112182226.2a6c8bab@kernel.org>
 <20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
 <20241113163925.7b3bd3d9@kernel.org>
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

On Wed, 13 Nov 2024 16:39:25 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 13 Nov 2024 11:38:08 +0100 Kory Maincent wrote:
> > > IOW I'm struggling to connect the dots how the code you're adding now
> > > will be built _upon_ rather than _on the side_ of when socket PHC
> > > selection is in place.   =20
> >=20
> > I see what you mean! It is not something easy to think of as I don't re=
ally
> > know how it would be implemented.
> > Do you think adding simply the PHC source and the phydev pointer or ind=
ex
> > would fit?  =20
>=20
> In net_device? Yes, I think so.
=20
Also as the "user" is not described in the ptp_clock structure the only way=
 to
find it is to roll through all the PTP of the concerned net device topology.
This find ptp loop will not be in the hotpath but only when getting the tsi=
nfo
of a PHC or changing the current PHC. Is it ok for you?

I am at v20 so I ask for confirmation before changing the full patch series=
! ;)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

