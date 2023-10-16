Return-Path: <netdev+bounces-41470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30AC7CB0E7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49711C20C41
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512430FB6;
	Mon, 16 Oct 2023 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH4nY8b7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75030F94;
	Mon, 16 Oct 2023 17:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479DC433C7;
	Mon, 16 Oct 2023 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697475796;
	bh=Vx73FpVlkBN9x5VuKdWHHh99ktLX7tsDFLYW1HUCKH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EH4nY8b7LAH1scjlTuimouVGxGT5eSdosXd9Se89Zx5CvqrOAtDsHntyKHAkUkpWL
	 oa35WUwna7wUxKwdIg/AEs3t2dKClNvhXKrst+SSqGUCE0iTtJaOMfQmOtW8lv9V24
	 VLNLgQagLyI+FwKISdE+NzYGMpS+VfTxGH5JHg3ohzagV9hEluwUtlsNXlsMqjY3Zd
	 WzLhmkzP2A3RWj/ygqZIu82vGEv/P28vOmw8zVUA6n4EqZGc3s1fCZgxqB+ei/37Bt
	 5dNy+9+OSlw5dKS1OHCl/NutMIrnXlfsPQ+oXGFb46dXXHEpiZwwlw3U4vGTxmkCXx
	 N10yao1Q8PJ8g==
Date: Mon, 16 Oct 2023 10:03:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231016100313.36d4eab9@kernel.org>
In-Reply-To: <20231016182307.18c5dcf1@kmaincent-XPS-13-7390>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-9-kory.maincent@bootlin.com>
	<2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
	<20231010102343.3529e4a7@kmaincent-XPS-13-7390>
	<20231013090020.34e9f125@kernel.org>
	<6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
	<20231016124134.6b271f07@kmaincent-XPS-13-7390>
	<20231016072204.1cb41eab@kernel.org>
	<20231016170027.42806cb7@kmaincent-XPS-13-7390>
	<20231016084346.10764b4a@kernel.org>
	<20231016182307.18c5dcf1@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Oct 2023 18:23:07 +0200 K=C3=B6ry Maincent wrote:
> > What's the reason for timestamp precision differences?
> > My understanding so far was the the differences come from:
> >  1. different stamping device (i.e. separate "piece of silicon",
> >     accessed over a different bus, with different PHC etc.)
> >  2. different stamping point (MAC vs DMA)
> >=20
> > I don't think any "integrated" device would support stamps which
> > differ under category 1. =20
>=20
> It was a case reported by Maxime on v3:
> https://lore.kernel.org/netdev/20230324112541.0b3dd38a@pc-7.home/=20

IMHO this talks about how clock control/disciplining works which
is a somewhat independent topic of timestamping.

