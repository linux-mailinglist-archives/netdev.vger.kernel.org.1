Return-Path: <netdev+bounces-49299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E27F190E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0A61C20B06
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7241CA9E;
	Mon, 20 Nov 2023 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkyLtgYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACA1D52E;
	Mon, 20 Nov 2023 16:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91183C433C7;
	Mon, 20 Nov 2023 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700498887;
	bh=ESh01jqSQWkTBYBeIvcosjdQy4FIhEmQsKnmw7vBqNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkyLtgYDEV2bf5laQJi0/RvJtLahfgLpzfonczwYtiUCKRzmqrG/k39dKN1XoF6sg
	 Jc0PXqlhyKurmcq24L6vyVeoLsN9huxzhMQl+Zc1YeG7RbMhMzDTlt5NPof2kqVxHj
	 keod2SkcB2wGqjre3HrbIJUkjBgoLc01pgh+dpEFg+V+AGK0ITO58tGLii9rPJvqAv
	 eAEVJpvP668lMwaZiDRczWoa8tm+9fa1SsAsJVRQXoVD+8xnlNybSvj/83fc4Q7hCg
	 PvGKf+gpB21QW70HQ1M0G5u3N9QokEAA15KNz/peCyxmn79Sh18Er6LMXJqWyE7h5A
	 ID03DQ4dHFF0Q==
Date: Mon, 20 Nov 2023 08:48:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Message-ID: <20231120084805.5f012a40@kernel.org>
In-Reply-To: <20231120100549.22c83bd0@kmaincent-XPS-13-7390>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
	<20231118182247.638c0feb@kernel.org>
	<20231120100549.22c83bd0@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Nov 2023 10:05:49 +0100 K=C3=B6ry Maincent wrote:
> > Does this really need to be in uAPI? =20
>=20
> I have put it in the same place as SOF_TIMESTAMPING_* flags but indeed I =
am not
> sure ethtool would need it.
> I can move it to include/linux/net_tstamp.h and we will move back to uapi=
 if
> we see that it is necessary. What do you think?

include/linux/net_tstamp.h sounds better to me, Willem may disagree..

