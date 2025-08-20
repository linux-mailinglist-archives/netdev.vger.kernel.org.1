Return-Path: <netdev+bounces-215207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFFB2D942
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85927BCD79
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22032D23A8;
	Wed, 20 Aug 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="18hhPAgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821F2D23B8;
	Wed, 20 Aug 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683562; cv=none; b=jvQX7kg0GgLXqwSfRVpYf5xjpOHK1OrR48qmQB+Jaqh0Usm2rXnuFu6I8b1XR5rRx7IKjJyOOtHRxxg6pnxYIipH0nyEIwR3xboqOB0bHjnK+O+rpCKl81XEKaDj5KEOsI2UCkBixnRprll/Ma3BjBkJLz4JVqVqNYIz02QEMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683562; c=relaxed/simple;
	bh=sMhZfTFAeG2QpntP2NVkL4o+Dl3CBT7XGEidA+J56TM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uw3jH6EwpUXNDS0IPrBG3GYDCvg7KaUweDfJHq1NsoLYSgx6TU4XmwV25zppaDW+y71sc5NS0bW6JNU/6M6W/HR9xvMXxbWih0q+ctzCxZ8DBQvHUVDt3Spg7NOKNg1iaPvi26f0oEmFvGP34RM68OKapWBwkYor59N8v66GSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=18hhPAgH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1C933C6B3BC;
	Wed, 20 Aug 2025 09:52:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9435B606A0;
	Wed, 20 Aug 2025 09:52:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15FFD1C22C448;
	Wed, 20 Aug 2025 11:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755683550; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7/YncygtLh6CcLTv8t4vURKiUBBhT1Mh9x7E1RDPudM=;
	b=18hhPAgHbGoiTmVvQ6R0c79+45Q+FebUjPcQzifAaHGA2DczMh0p59c0wtaT83qlTeSJnM
	kkHxFLBaWNySPM7QpmsUVAj1Yv6jZenyDKS42klT8Jwh1VUEkNpD/1iWW/ISK+nwutj1gU
	vdS8twRpPnRyzsgDD2w+mKnMdzk+UKQA1/TNxpuq5afQyeibwcHWNpYg028LUtGMZnLrab
	dYpyOUDQnu7jDYKbl7XQ0nCEgmTBimizcADOsYuiZwVZSm6v8mMBN/ela6SxES/teDjK0+
	2g8gJWduR373nMxDnMd1rjaow5eQ2Udg2rHdHSNJoVJp5kajW9d1vDzy7Fx9Dw==
Date: Wed, 20 Aug 2025 11:52:20 +0200
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
Subject: Re: [PATCH net-next v3 3/5] ethtool: netlink: add lightweight MSE
 reporting to LINKSTATE_GET
Message-ID: <20250820115220.1655e5ff@kmaincent-XPS-13-7390>
In-Reply-To: <20250819071256.3392659-4-o.rempel@pengutronix.de>
References: <20250819071256.3392659-1-o.rempel@pengutronix.de>
	<20250819071256.3392659-4-o.rempel@pengutronix.de>
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

Le Tue, 19 Aug 2025 09:12:54 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Extend ETHTOOL_MSG_LINKSTATE_GET to optionally return a simplified
> Mean Square Error (MSE) reading alongside existing link status fields.
>=20
> The new attributes are:
>   - ETHTOOL_A_LINKSTATE_MSE_VALUE: current average MSE value
>   - ETHTOOL_A_LINKSTATE_MSE_MAX: scale limit for the reported value
>   - ETHTOOL_A_LINKSTATE_MSE_CHANNEL: source channel selector
>=20
> This path reuses the PHY MSE core API, but only retrieves a single
> value intended for quick link-health checks:
>   * If the PHY supports a WORST channel selector, report its current
>     average MSE.
>   * Otherwise, if LINK-wide measurements are supported, report those.
>   * If neither is available, omit the attributes.
>=20
> Unlike the full MSE_GET interface, LINKSTATE_GET does not expose
> per-channel or peak/worst-peak values and incurs minimal overhead.
> Drivers that implement get_mse_config() / get_mse_snapshot() will
> automatically populate this data.
>=20
> The intent is to provide tooling with a =E2=80=9Cfast path=E2=80=9D healt=
h indicator
> without issuing a separate MSE_GET request, though the long-term
> overlap with the full interface may need reevaluation.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

