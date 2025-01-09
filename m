Return-Path: <netdev+bounces-156863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5329A080E3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C83188BE0E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361C1FBEB5;
	Thu,  9 Jan 2025 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEGPWzuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2A1F9439;
	Thu,  9 Jan 2025 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452304; cv=none; b=CfUqHNQxb+c4Zr1fEBNUQqqQfBDtjpHefXg6rBE+cJ+vCEVq+NZwPZvqLDd+xoctHlBawZYHgAtnGnYsHCaqfsBPHLTWnUI9DzXZnLDvMkMyvCJEf4acol2kyhUjeL3onD6b3E/BIm8OTXfR/9qyVfY2pCSLfkDPEHTiOewqwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452304; c=relaxed/simple;
	bh=hik9aIq5m6h+jOMSTz43JcoVDa14wM2bJ+MGJz4iqxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gl0wTzo3fYlWMxztyFfG+fhl0+bJkHhsTwtNCvePGD8xJZMGUp3tiGXbNEiRCd9wBhxaN9rh8Y/n5t4j1vheIO5HeDjfY/L7eRxCQfzPyp7zYkZx3xbe8YCVMQLApkvlRWe6DZbSa49JH8bDsD6OTxmGyId8+4m75nzxXgAc0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEGPWzuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E97C4CED2;
	Thu,  9 Jan 2025 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736452303;
	bh=hik9aIq5m6h+jOMSTz43JcoVDa14wM2bJ+MGJz4iqxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEGPWzuwVaLjOM93p0uSIe8kplFt7NgsytwVDl7yH+PqPMR/NSMzFfars3Jyel7rU
	 yPziLt7ZFHaXcq7eEMDc+u8L4Ab3JnZUqvCSEnswBbtMECYmq3Fmj5DtZkkuTXSLwS
	 DuP8G2H3Rj8zfr5VShvGikWve9IMwe30EgntMJmUFU8UOy/TkR8k15PIsKrREs6ZIR
	 9UNhI7eXHIaXsic7wOgHO1ocPW7te1bPwFyHcoFFtRnyNRumQNwY1Bk+ZdvgTDF/a2
	 FpitDwcxanVFg+NAfLmmNaypVZYrW6OJJqMpuKefB9yFk/qqjmMnv4yael4hqkGPTI
	 inC3K2+JzWp2Q==
Date: Thu, 9 Jan 2025 11:51:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <20250109115141.690c87b8@kernel.org>
In-Reply-To: <20250109174942.391cbe6a@kmaincent-XPS-13-7390>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
	<20250109075926.52a699de@kernel.org>
	<20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
	<Z3_415FoqTn_sV87@pengutronix.de>
	<20250109174942.391cbe6a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jan 2025 17:49:42 +0100 Kory Maincent wrote:
> > > > Doesn't it make sense to move patches 11-14 to the next series?
> > > > The other 11 patches seem to my untrained eye to reshuffle existing
> > > > stuff, so they would make sense as a cohesive series.  =20
>=20
> I think I should only drop patch 11 and 12 from this series which add som=
ething
> new while the rest is reshuffle or fix code.

I mentioned 13 & 14 because I suspected we may need to wait for
the maintainers of regulator, and merge 13 in some special way.
Looks like Mark merged 13 already, so =F0=9F=A4=B7=EF=B8=8F
--=20
pw-bot: cr

