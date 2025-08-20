Return-Path: <netdev+bounces-215206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86601B2D945
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E741C47E33
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDC2E264B;
	Wed, 20 Aug 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WhczS5GU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7302E425A;
	Wed, 20 Aug 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682985; cv=none; b=imdSzsWdriASkjMHP+UbGx6vzYkWr8b2ZJD6N/40By27fRghJfCtgJPRqHvQz2xsbQoxg3K1dlM5wb04wYjMLMYTM73c2MEkxneOfv7B85i4hHOKUP9ZyCORZb0nMp+dS/LH8DGS+xgGiK89cM+5NOJ0vFXNMIKTOxAvuEXFHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682985; c=relaxed/simple;
	bh=tg9IjVPKeAoMTFuCx62Uncfr94ePF6KkIVlDLDMLWpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO47S6wBTV+4mKjZ8kefSZep9rSACAsKqMGj0Qr/9KbXWhVAmL7YWr3zCUfYUXyx/Y1J372M4twEPbPzfxfe+x3jQe9P0HF1c06wdCv1xhptvfkOz66D1D5GGr2QcpqLSiBnLXqW4q2HSsC/FDvEFcvQrQUwiRp9Ie7gymDEOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WhczS5GU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 15D1B1A0C84;
	Wed, 20 Aug 2025 09:42:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D36E7606A0;
	Wed, 20 Aug 2025 09:42:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 534981C22D68B;
	Wed, 20 Aug 2025 11:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755682974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zfvFfiyxPXbBfvwJE5bTDjBpTAzKbRTBc/ZQyDkJoz8=;
	b=WhczS5GUqPCbwutj7Eq0AMzsZV6det/s0AO9qWO0ei2wr5RMwi+wcFptCoSCLBpJUJiJ3c
	D+XrnoGOtRMY+T9InT42UKwpaLqEfpD36ugR3SCI8nv4qGfTWl5n+rmcdalgXqQfY4bu7T
	iH7JrcKU860ZXU8yQA7qvpODkBrtSN7ThKhUx/RkeqIwa6w2bLr49Qpu+vuVLFLXPXXNX4
	ZsRT9N8h9K6q0J0Soqr2utbOa+65c4Lm/HWZqr7x2sYefuqPjbcos/kiPYbpQkFNeBO7Or
	912AyA4s88vlrn/1dsA7+i66TGPN+UdF90dlXcaNrNXCaIF20AuMDOwsph80JA==
Date: Wed, 20 Aug 2025 11:41:58 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Nishanth Menon
 <nm@ti.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v3 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250820114158.187a5043@kmaincent-XPS-13-7390>
In-Reply-To: <20250819071256.3392659-3-o.rempel@pengutronix.de>
References: <20250819071256.3392659-1-o.rempel@pengutronix.de>
	<20250819071256.3392659-3-o.rempel@pengutronix.de>
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

Le Tue, 19 Aug 2025 09:12:53 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Introduce the userspace entry point for PHY MSE diagnostics via
> ethtool netlink. This exposes the core API added previously and
> returns both configuration and one or more snapshots.
>=20
> Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
> selector. The reply carries:
>   - ETHTOOL_A_MSE_CONFIG: scale limits, timing, and supported
>     capability bitmask
>   - ETHTOOL_A_MSE_SNAPSHOT+: one or more snapshots, each tagged
>     with the selected channel
>=20
> If no channel is requested, the kernel returns snapshots for all
> supported selectors (per=E2=80=91channel if available, otherwise WORST,
> otherwise LINK). Requests for unsupported selectors fail with
> -EOPNOTSUPP; link down returns -ENOLINK.
>=20
> Changes:
>   - YAML: add attribute sets (mse, mse-config, mse-snapshot) and
>     the mse-get operation
>   - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
>     ETHTOOL_MSG_MSE_GET/REPLY
>   - ethtool core: add net/ethtool/mse.c implementing the request,
>     register genl op, and hook into ethnl dispatch
>   - docs: document MSE_GET in ethtool-netlink.rst
>=20
> The include/uapi/linux/ethtool_netlink_generated.h is generated
> from Documentation/netlink/specs/ethtool.yaml.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/netlink/specs/ethtool.yaml      |  88 +++++
>  Documentation/networking/ethtool-netlink.rst  |  65 ++++
>  .../uapi/linux/ethtool_netlink_generated.h    |  37 ++
>  net/ethtool/Makefile                          |   2 +-
>  net/ethtool/mse.c                             | 362 ++++++++++++++++++
>  net/ethtool/netlink.c                         |  10 +
>  net/ethtool/netlink.h                         |   2 +
>  7 files changed, 565 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/mse.c
>=20
> diff --git a/Documentation/netlink/specs/ethtool.yaml
> b/Documentation/netlink/specs/ethtool.yaml index 6bffac0904f1..ed4774826b=
16
> 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1872,6 +1872,79 @@ attribute-sets:
>          type: uint
>          enum: pse-event
>          doc: List of events reported by the PSE controller
> +  -
> +    name: mse-config
> +    attr-cnt-name: __ethtool-a-mse-config-cnt

Please use double dash here, Jakub wants to remove all underscore from the
specs.

> +  -
> +    name: mse-snapshot
> +    attr-cnt-name: __ethtool-a-mse-snapshot-cnt

Same

> +    name: mse
> +    attr-cnt-name: __ethtool-a-mse-cnt

Same

...

> +MSE Configuration
> +-----------------
> +
> +This nested attribute contains the full configuration properties for the=
 MSE
> +measurements
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE             u32     max avg_mse s=
cale
> +  ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE                u32     max peak_mse =
scale
> +  ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS             u64     sample rate (=
ps)
> +  ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS                 u64     symbols per s=
ample
> +  ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS              bitset  capability bi=
tmask
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +
> +.. kernel-doc:: include/linux/phy.h
> +    :identifiers: phy_mse_config
> +
> +.. kernel-doc:: include/uapi/linux/ethtool_netlink_generated.h
> +    :identifiers: phy_mse_snapshot

I think you forgot to remove this kernel-doc lines as the MSE snapshot is
described below.

> +
> +MSE Snapshot
> +------------
> +
> +This nested attribute contains an atomic snapshot of MSE values for a
> specific +channel or for the link as a whole.
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  ETHTOOL_A_MSE_SNAPSHOT_CHANNEL                   u32     channel enum =
value
> +  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE               u32     average MSE v=
alue
> +  ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE                  u32     current peak =
MSE
> +  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE            u32     worst-case pe=
ak
> MSE
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +
> +.. kernel-doc:: include/linux/phy.h
> +    :identifiers: phy_mse_snapshot
> +
>  Request translation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

