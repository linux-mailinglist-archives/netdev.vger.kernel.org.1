Return-Path: <netdev+bounces-132626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81599281F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FA31C2088C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3A18CC0A;
	Mon,  7 Oct 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AjNFk6Jd"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A412E1D1;
	Mon,  7 Oct 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293433; cv=none; b=Ui2NJPwnhqvdIR55rHA9Uj4FuWYs/EZuJpcA/TBhJx3QLRNsEUPeiWsgikzLNwiw0CEFiTMUX6SYgNklaMOYIufmCE07H7xgcSQ91y9GSGuqSvp73tU3e61OsBwyp/Gl+ol2+JCbrHFSkH7lZF6du+ssjPnx5PzHgXpvHJ4YvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293433; c=relaxed/simple;
	bh=Tz1GKph4drPLEeVbp418Bu54k3rNav7IVlT79MqKv0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGeMcFa+RIS3ozz27y2dZWgFd2yGbDVmPKwZ32V8YNRjUYdQ1CZ0BeuvtrDm288vQeJvGebIkyxL4m1s7Q88r9ydjBgYCxhbYOPTjbG33o9hcO8fXZbbdgBFQn15u4m25w6kQKQu+7zz8kLew/S4/dgixcvsVuzoGBAfZEZwyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AjNFk6Jd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 654DBC0003;
	Mon,  7 Oct 2024 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728293428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=namY25WQ52fwKUQOtiBU5zuLS5KPYImSKTERIUGh7sA=;
	b=AjNFk6Jdj2MWLv9QzPMlBjnRGG5qXVrSNe/5xaVlw1rSCA6Sm8FMZGKHUF79vSzfoRxsI+
	QX1T2YoVXjD3u7HKtuuba+4BlDszgchGcxwzy7DuY2QYfyyOxNiNcZGlxT5Ira7MXz7uQx
	2rHE0QWgw7asVBGQhdogNFtJHyi9KVOaNlz6mom6Ieoq+DaUmbBtrGXaCnjHrOvIn0+9ZL
	Elevcr0oA0zcXrNIpjmo4ZCtjZABBwriF020lIAylWMUdohUWb1hw8K4QRKlljXZ6llb/X
	ax53HDL4keySHLsXVcTrYv3cusVJfPVxx5w6NdlRi9pjT8eToHE3eyy9hoewaw==
Date: Mon, 7 Oct 2024 11:30:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
In-Reply-To: <ZwDcHCr1aXeGWXIh@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
	<ZwDcHCr1aXeGWXIh@pengutronix.de>
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

On Sat, 5 Oct 2024 08:26:36 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> >  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute =
is
> > used @@ -1871,6 +1883,10 @@ various existing products that document pow=
er
> > consumption in watts rather than classes. If power limit configuration
> > based on classes is needed, the conversion can be done in user space, f=
or
> > example by ethtool.=20
> > +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
> > +control the C33 PSE priority. Allowed priority value are between zero
> > +and the value of ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute. =20
> =20
> We need to introduce a new attribute to effectively manage PSE priorities.
> With the addition of the `ETHTOOL_A_C33_PSE_PRIO` attribute for setting
> priorities, it's important to know which PSE controller or domain each po=
rt
> belongs to.
>=20
> Initially, we might consider using a PSE controller index, such as
> `ETHTOOL_A_PSE_CONTROLLER_ID`, to identify the specific PSE controller
> associated with each port.
>=20
> However, using just the PSE controller index is too limiting. Here's why:
>=20
> - Typical PSE controllers handle priorities only within themselves. They
> usually can't manage prioritization across different controllers unless t=
hey
> are part of the same power domain. In systems where multiple PSE controll=
ers
> cooperate=E2=80=94either directly or through software mechanisms like the=
 regulator
> framework=E2=80=94controllers might share power domains or manage priorit=
ies together.
> This means priorities are not confined to individual controllers but are
> relevant within shared power domains.
>=20
> - As systems become more complex, with controllers that can work together,
> relying solely on a controller index won't accommodate these cooperative
> scenarios.
>=20
> To address these issues, we should use a power domain identifier instead.=
 I
> suggest introducing a new attribute called `ETHTOOL_A_PSE_POWER_DOMAIN_ID=
`.
>=20
> - It specifies the power domain to which each port belongs, ensuring that
> priorities are managed correctly within that domain.
>=20
> - It accommodates systems where controllers cooperate and share power
> resources, allowing for proper coordination of priorities across controll=
ers
> within the same power domain.
>=20
> - It provides flexibility for future developments where controllers might=
 work
> together in new ways, preventing limitations that would arise from using a
> strict controller index.
>=20
> However, to provide comprehensive information, it would be beneficial to =
use
> both attributes:
>=20
> - `ETHTOOL_A_PSE_CONTROLLER_ID` to identify the specific PSE controller
> associated with each port.
>=20
> - `ETHTOOL_A_PSE_POWER_DOMAIN_ID` to specify the power domain to which ea=
ch
> port belongs.

Currently the priority is managed by the PSE controller so the port is the =
only
information needed. The user interface is ethtool, and I don't see why he w=
ould
need such things like controller id or power domain id. Instead, it could be
managed by the PSE core depending on the power domains described in the
devicetree. The user only wants to know if he can allow a specific power bu=
dget
on a Ethernet port and configure port priority in case of over power-budget
event.

I don't have hardware with several PSE controllers. Is there already such
hardware existing in the market?
This seems like an interesting idea but I think it would belong in another =
patch
series.
Still, it is good to talk about it for future development idea.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

