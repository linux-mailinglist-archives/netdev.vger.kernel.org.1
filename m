Return-Path: <netdev+bounces-149739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8179E7020
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235B528150B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559041494D9;
	Fri,  6 Dec 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y+EBqOYk"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9C32C8B;
	Fri,  6 Dec 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495858; cv=none; b=eQaC1MsvRlKYJCiNkhDvJ3JK6xD7ISo+ohLKj5F3DwUxyzng951mjY2/9XwMyIzCzm4eZN3mQ+9629ThbSIB7LYTvZvvE+tA+eJADEiJFn9TQFVDxGC46ncbtaMxL9gqB13MtqJEON+RbOp0LDS2FOdI/ixumTnOY8VXOCisV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495858; c=relaxed/simple;
	bh=EYc6l9SCD6Czb0VnSBnT2cByYVTwOsvnkpQWn0OO2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K67wT7/KDmoSKwZNks/+/oIL/sF7jLt21Ng3xoRVLhq54bel47zaSWUwCrwLoMmVKvIetdQONJhRUFeYywtqSSWe2NAG4cn8TV0PT0xe9K4FD5QRONZhtAR1zlXWK5reyNxAMotRnRvpi/ADhQKf3AtbBOlOaH647MW09cCwUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y+EBqOYk; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70C83FF808;
	Fri,  6 Dec 2024 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733495853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hpnrirAnx2qcYIUqLTdxLNN1wezgoGtkZQYDAkV9Ek=;
	b=Y+EBqOYkO8pQ8dbSMuodkWyCVV7Vw7MBtrUENujYVIKINF4qg+c2LGFecflUbxtSE0l4qp
	sciBcpfi2yT3TniLd//Z5hXC5lDvyJrm4zrdmUr/NwCctloRsHM49n+nJ8LKioLSo3IamV
	c3X7Qr1J3tl+xNE28ZGB+ASd2sfvAIMGxrAM1ct1Bdn48b0mSj6m5C8UrRYm3NX/RI9rqp
	vKFejzC8L6uzQnBIxpnXa1GjNhGKb/3rfZ5GWGlCvOfflGUZ9EO1wF+RU/VlOq3pIncuDD
	XL21eC4HiX6eVEXGuPWbzRHNHTyHdgmftlsJPpmQiX+MSdJDnJMGJkjSbySPxw==
Date: Fri, 6 Dec 2024 15:37:29 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
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
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v20 4/6] net: ethtool: tsinfo: Enhance tsinfo
 to support several hwtstamp by net topology
Message-ID: <20241206153729.2c233b54@kmaincent-XPS-13-7390>
In-Reply-To: <20241206142716.GT2581@kernel.org>
References: <20241204-feature_ptp_netnext-v20-0-9bd99dc8a867@bootlin.com>
	<20241204-feature_ptp_netnext-v20-4-9bd99dc8a867@bootlin.com>
	<20241206142716.GT2581@kernel.org>
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

On Fri, 6 Dec 2024 14:27:16 +0000
Simon Horman <horms@kernel.org> wrote:

> On Wed, Dec 04, 2024 at 03:44:45PM +0100, Kory Maincent wrote:
> > Either the MAC or the PHY can provide hwtstamp, so we should be able to
> > read the tsinfo for any hwtstamp provider.
> >=20
> > Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> > network topology.
> >=20
> > Add support for a specific dump command to retrieve all hwtstamp
> > providers within the network topology, with added functionality for
> > filtered dump to target a single interface.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> ...
>=20
> > diff --git a/net/ethtool/ts.h b/net/ethtool/ts.h
> > new file mode 100644
> > index 000000000000..b7665dd4330d
> > --- /dev/null
> > +++ b/net/ethtool/ts.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _NET_ETHTOOL_TS_H
> > +#define _NET_ETHTOOL_TS_H
> > +
> > +#include "netlink.h"
> > +
> > +static const struct nla_policy
> > +ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] =3D=
 {
> > +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =3D
> > +		NLA_POLICY_MIN(NLA_S32, 0),
> > +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =3D
> > +		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT -
> > 1) +}; =20
>=20
> Hi Kory,
>=20
> It looks like ethnl_ts_hwtst_prov_policy is only used in tsinfo.c and cou=
ld
> be moved into that file. That would avoid a separate copy for each file
> that includes ts.h and the following warning flagged by gcc-14 W=3D1 buil=
ds
> with patch 5/6 applied.

Oh indeed but the real issue is that it should be used in
ethnl_tsconfig_set_policy.

Thanks for the report!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

