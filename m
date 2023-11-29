Return-Path: <netdev+bounces-52261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135B7FE0C6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9195D1C20A1A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64C5EE90;
	Wed, 29 Nov 2023 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HehMCBn4"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765AD67;
	Wed, 29 Nov 2023 12:10:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A64A320002;
	Wed, 29 Nov 2023 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701288603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgC5dpTfYgWKVDzyM3hqpBbueVl62650K6Ip1o3x970=;
	b=HehMCBn4xGNBo1aP0K6yRMQV81PbEcGfN/2qgpw7YOXEkU68jK0yqBNT+sVC7xC73Rn8j5
	Z9563tmOQVPae1xffEyes0GBGlXrluP/z1PQbNujRXDDFuOSM5PLB9AZ4pnTb4KFHVRVgr
	jqw50hfjBA2th4CEwwrBWa01Y2Tw8+4UNo6cDOOyuiZgBVv9AWneHbKHcgnEIXFaRgvBIQ
	h+t4yz6wCA3+zh13v+tbvW7G8WruDenxo/iX0f7MoJlpFf05y+gh4YRjR52qH6M/rNiidG
	r8PbdpcmWTYDT5Or94xlOsPhyMUICW3Dy2XAi40fJWZ7G2VXL7VQCCanTYun1A==
Date: Wed, 29 Nov 2023 21:09:59 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
In-Reply-To: <20231120134551.30d0306c@kernel.org>
References: <20231118183433.30ca1d1a@kernel.org>
	<20231120104439.15bfdd09@kmaincent-XPS-13-7390>
	<20231120105255.cgbart5amkg4efaz@skbuf>
	<20231120121440.3274d44c@kmaincent-XPS-13-7390>
	<20231120120601.ondrhbkqpnaozl2q@skbuf>
	<20231120144929.3375317e@kmaincent-XPS-13-7390>
	<20231120142316.d2emoaqeej2pg4s3@skbuf>
	<20231120093723.4d88fb2a@kernel.org>
	<157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
	<20231120105148.064dc4bd@kernel.org>
	<20231120195858.wpaymolv6ws4hntp@skbuf>
	<20231120134551.30d0306c@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 20 Nov 2023 13:45:51 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 20 Nov 2023 21:58:58 +0200 Vladimir Oltean wrote:
> > I'm still waiting for you to fully clarify the "per socket vs global"
> > aspect, but independently of that, at least I understand why this is a
> > counter-argument to my proposal. I need to tune it a bit (ASSUMING that
> > we want DMA timestamps to "look like" hwtimestamps, and not like their
> > own thing, to user space), because the PHC index would no longer fully
> > identify a hwtstamp provider, so we need something more.
> >=20
> > I imagine both ETHTOOL_MSG_TSINFO_GET and ETHTOOL_MSG_TSINFO_SET to
> > support a new (nest) nlattr called ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER.
> >=20
> > This would contain (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_PHC_INDEX
> > and (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER. It could be
> > extensible in the future, but this is the baseline and forms the key.
> >=20
> > The latter takes values from an:
> >=20
> > enum ethtool_hwstamp_provider_qualifier {
> > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_MAC,
> > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY,
> > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_DMA,
> > }; =20
>=20
> Sounds reasonable. Having more attributes than just PHC index works.
> Given the lack of distinction between MAC and PHY for integrated NICs
> I'd lean towards ditching the "layers" completely and exposing=20
> an "approximate" vs "precise" boolean. Approximate being the DMA point
> for NICs, but more generically a point that is separated from the wire
> by buffering or other variable length delay. Precise =3D=3D IEEE 1588
> quality.

Hello Jakub, just wondering.
I can add this hwtstamp provider qualifier in the next series version but it
won't be used as it is set and used at the driver level and no driver is us=
ing
it for now. It would not be accepted if I use something that is not used, r=
ight?
Do you still think I should add this in v8?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

