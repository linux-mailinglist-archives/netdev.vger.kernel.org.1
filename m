Return-Path: <netdev+bounces-113373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A806D93DF75
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419A2B2155B
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAA73478;
	Sat, 27 Jul 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Aq1nh6jH"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAFA7E101;
	Sat, 27 Jul 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722085218; cv=none; b=Wwzqyvk+QTDUfEtvOrqW5uSj2qxFbJYxz0G0k+XHaSzZFKb2DU/L5UYf/oLFfWCansfF6hXMlDwXZgPYcrVpCMFE+UQUz8bGILl4xo1XhqKl5X0SJjBPp6O094YuJwXS23j54OmgR0NYpTeoiFXLST9/t5ldaP2QtQSOOLWkPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722085218; c=relaxed/simple;
	bh=47KKAW8Z4/5hyco3FTrmUIFgtVHf+0nvCgShB7JHDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2zUxnkOL6lfLMWNNh+t1WfwgVHpyCOrULEQCDOJ2VmECljufeurZ91LOTzGdlGNytMBynUe/VbnfOEYPDYaASZ340xxoPgGYvEo6atkoI/D/zdBy21wUzPN5ge6shzu7R2wm2nOItHfQHWwHUW/FNGnHRK+3yig40leCfRaps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Aq1nh6jH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D0DD1C0005;
	Sat, 27 Jul 2024 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722085213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7sZFvcJjRNHyS+j2zojU/F0BdHWiXiPM8DsgfUSK0s=;
	b=Aq1nh6jH/8cyaS5PIv1YmeknpQLS0EfUGjYXRrl9hGKdd3bk4p+QslAiWQfKqU2k2RnJk2
	yTw79ECxBbCdoO6pp8FNsoJGrYdFZKycqI88/qLPawWeVL5R5//khYedsE34pdJWmOm3Ge
	kzZgOYFEE9mXSZ3MlauCerubSxL6TnPPAloO8dmU5j8HCvCvAuml02tvWvdnFCZpXGDZuk
	JZ1PMTcgXlMCkfkWu33lEAr8KYkL5bRnsdZkLInXDUmjiTRR3+VuCcmGcmPdOXjXK4Y2hV
	hPVFjeuzU0GqurPSC+n8EVxqgYr8qBCBHdr5vI0dDezpsxCckXHYKOXPKhQkmg==
Date: Sat, 27 Jul 2024 15:00:09 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "Radu Pirea" <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Simon Horman <horms@kernel.org>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
 <danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240727150009.66dcf0ae@kmaincent-XPS-13-7390>
In-Reply-To: <f16855bf-ae2a-4a0c-b3e9-d25f64478900@intel.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
	<20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
	<f16855bf-ae2a-4a0c-b3e9-d25f64478900@intel.com>
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

On Wed, 17 Jul 2024 10:43:05 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:
>=20
> > +The legacy configuration is the use of the ioctl(SIOCSHWTSTAMP) with a
> > pointer +to a struct ifreq whose ifr_data points to a struct
> > hwtstamp_config. +The tx_type and rx_filter are hints to the driver wha=
t it
> > is expected to do. +If the requested fine-grained filtering for incoming
> > packets is not supported, the driver may time stamp more than just the
> > requested types of packets.
> >   =20
>=20
> Does the core automatically handle SIOCSHWTSTAMP and SIOCGHWTSTAMP in
> terms of the new API? I'm guessing yes because of the new
> .ndo_set_hwtstamp ops?

Yes.
=20
> >  A driver which supports hardware time stamping must support the
> > -SIOCSHWTSTAMP ioctl and update the supplied struct hwtstamp_config with
> > -the actual values as described in the section on SIOCSHWTSTAMP.  It
> > -should also support SIOCGHWTSTAMP.
> > +ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
> > +supplied struct hwtstamp_config with the actual values as described in
> > +the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get =
or
> > +the legacy SIOCGHWTSTAMP. =20
>=20
> Can we simply drop the mention of implementing the legacy implementation
> on the kernel side? I guess not all existing drivers have converted yet..=
.?

Yes indeed.

In fact, Vlad has already worked on converting all the existing drivers:
https://github.com/vladimiroltean/linux/tree/ndo-hwtstamp-v9
I can't find any patch series sent to net next. Vlad what is the status on =
this?

> I have a similar thought about the other legacy PTP hooks.. it is good
> to completely remove the legacy/deprecated implementations as it means
> drivers can't be published which don't update to new APIs. That
> ultimately just wastes reviewer/maintainer time to point out that it
> must be updated to new APIs.

Yes but on the userspace side linuxPTP is still using the IOCTLs uAPI that =
will
become legacy with this series. Maybe it is still a bit early to remove tot=
ally
their descriptions in the doc?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

