Return-Path: <netdev+bounces-159254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380DA14F01
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E7E16731E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46471FECBC;
	Fri, 17 Jan 2025 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mc0KjBmg"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AF1FF1C1;
	Fri, 17 Jan 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115625; cv=none; b=giub6rUKCIrKNGdVYVLLp+yPHqt/2Yqcc5hkelbn9Nhx/0SW3IdF+S4H/nikrD7aFZ64OKBsz4qs3PXVD+27nMHcWsmim5Cq5LWQ4rkiDCE9X5b8fSVeQdMM8dIxC/m1lWIWvBd2+r0ge9JjOQNcwbYysQ6ahuB9QA7OjgxCSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115625; c=relaxed/simple;
	bh=BDyeNUdYNgJIV9Wz9fNA3O+1iHfYkvub8q2++d++Wzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEy7Qa8+Bl7obUA4eYlRyuoIqsU4jN8yeAS/E6n+kToHyH62VcPOcGTDBrxXywJTzHTSbyWLsNCZwq6qyt10hQmaGI4Iu3FiMiR3HVmmEmimt05V7I9niBaDs8l2iyQ9xxiGnkSv8qsC2Wh9aMpmalBIrRn3Heh6oTEtDJ6XDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mc0KjBmg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 017F4FF802;
	Fri, 17 Jan 2025 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737115620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8s9Nvc6uI8BiPOLipMqZY1pbcBB2gHob6Y7DtmFdoI=;
	b=mc0KjBmgh1T8QrUsMm5CneXoqRZ88g39WKkWitNYXBg9sE8mbP7oZqQWi569W/s3Q/TJi0
	PKZDABEZv/64lud0Uj8E+8U1EU6C6P8fd80ptF3faGcjcxhibiBhBrG+2JgGlcrAh8wyfG
	GJqs1RdjiY7sMaQfwZ1JpBQem6QQRrIroIJMoy1IU4FNdY5mMlroTo4Dg+N+DAp1B4XPqj
	tAhayjSaq1h7uSsTpQUfIUk43FtBeNTIZbbfbFCBiJOJnNzis6s0CzMeWpuKCmwy3oWZ9M
	MafxrB01WiIoIQvcEnuso7PtcR2PpXJGVdVaEG1RWJfo41SFk6JXYsPZYVa6NA==
Date: Fri, 17 Jan 2025 13:06:56 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v21 3/5] net: Add the possibility to support a
 selected hwtstamp in netdevice
Message-ID: <20250117130656.23a41605@kmaincent-XPS-13-7390>
In-Reply-To: <4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev>
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
	<20241212-feature_ptp_netnext-v21-3-2c282a941518@bootlin.com>
	<4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev>
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

On Fri, 17 Jan 2025 13:57:41 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Kory,
>=20
> On 12.12.2024 19:06, Kory Maincent wrote:
> > Introduce the description of a hwtstamp provider, mainly defined with a
> > the hwtstamp source and the phydev pointer.
> >=20
> > Add a hwtstamp provider description within the netdev structure to
> > allow saving the hwtstamp we want to use. This prepares for future
> > support of an ethtool netlink command to select the desired hwtstamp
> > provider. By default, the old API that does not support hwtstamp
> > selectability is used, meaning the hwtstamp provider pointer is unset.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> I'm getting this error when doing suspend/resume on the Renesas RZ/G3S
> Smarc Module + RZ SMARC Carrier II board:
>=20
> [   39.032969] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   39.032983] WARNING: suspicious RCU usage
> [   39.033000] 6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c
> #7 Not tainted
> [   39.033019] -----------------------------
> [   39.033033] drivers/net/phy/phy_device.c:2004 suspicious
> rcu_dereference_protected() usage!

Thanks for the report.
Oh so it seems there are cases where phy_detach is not called under RTNL lo=
ck!

This should solve the issue:
-               hwprov =3D rtnl_dereference(dev->hwprov);
+               rcu_read_lock()
+               hwprov =3D rcu_dereference(dev->hwprov);
                /* Disable timestamp if it is the one selected */
                if (hwprov && hwprov->phydev =3D=3D phydev) {
                        rcu_assign_pointer(dev->hwprov, NULL);
                        kfree_rcu(hwprov, rcu_head);
                }
+               rcu_read_unlock();

I will send a patch soon.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

