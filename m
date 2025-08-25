Return-Path: <netdev+bounces-216678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C321B34ED4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556991A86E9E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07729BDA6;
	Mon, 25 Aug 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGKj6FhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17512211A35;
	Mon, 25 Aug 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160064; cv=none; b=Rj8ZiOizx+gGycV/OdonyAyl9TIAUfuaq+rx8+5qU9sDGhLOokKRE//rwfxT9oRaO+b0ZjMBF3sCxQdTgGrxsQmfeOlRgu73wxUjGJh4LkG3R+e8jEI8NHmSN6zMB1ilABrJ3kyi4tA+Vt3FqKT/xw6FYcxiYj0fM/wF07W06Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160064; c=relaxed/simple;
	bh=gEjXzN99Vo6U8XR2tZGTmD/LtzRsAFzaolvg8n58Mts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKTAybz0UWHYPaa2yaBiiBg/wXYhrGmaD0czITDdutWA8SLw6BOZmcuIvt3bMln06jr8Ja89gH7FjMRVyTe0QzbIngIbFcPWBpSRW5YcUgtVC5onveap97uCXtp3nUlFrHPBc74GoRPJK0hcZaswRvhXlj+ODDGCWdQc0F1n6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGKj6FhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1FAC4CEED;
	Mon, 25 Aug 2025 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756160063;
	bh=gEjXzN99Vo6U8XR2tZGTmD/LtzRsAFzaolvg8n58Mts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGKj6FhKIpORedLNiar+0w0dSCD8hFz8nyft5qW3nETuraXOxLrzbxuxmF2G7e5qE
	 ko8fiBLQC6gaXruN4uOuzkB4Q05JJsDdGNeFunTzRy01Rq+O3XOMjAK9KysI4MJXRm
	 fxtymNJHl70Y0INoi4C92urNLQfhCEUA6wEXynjH/qWdQ6zkFtWZcPsGIPoa+b9kDt
	 QPnZNyFMUUyZbNMziGxBy23e8AirPsOxudKGQiSVNI/Jj4Ali/9xj1IdJkhp9l+s+u
	 WHtRgT+rSZvMRkRAWrfI/+Uv2U1dcmLG8T/qLwYENz57E33pBHrQMcDIQLBa3+5lvR
	 FoqLnpYDIiakw==
Date: Mon, 25 Aug 2025 15:14:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <20250825151422.4cd1ea72@kernel.org>
In-Reply-To: <6317ad1e-7507-4a61-92d0-865c52736b1a@lunn.ch>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
	<d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
	<20250825104721.28f127a2@kmaincent-XPS-13-7390>
	<aKwpW-c-nZidEBe0@pengutronix.de>
	<6317ad1e-7507-4a61-92d0-865c52736b1a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 14:18:25 +0200 Andrew Lunn wrote:
> On Mon, Aug 25, 2025 at 11:14:03AM +0200, Oleksij Rempel wrote:
> > On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:  
> > > > I've not looked at the sysfs documentation. Are there other examples
> > > > of such a property?  
> > > 
> > > Not sure for that particular save/reset configuration case.
> > > Have you another implementation idea in mind?  
> > 
> > My personal preference would be to use devlink (netlink based)
> > interface.  
> 
> Yes, devlink also crossed my mind, probably devlink params. Although
> saving the current configuration to non-volatile memory is more a meta
> parameter.

This is a bit of a perennial topic. Most datacenter NIC vendors have 
a way to save link settings and alike to flash. None bothered with
adding upstream APIs tho. If the configs are fully within ethtool
I think we should be able to add an ethtool header flag that says 
"this config request is to be written to flash". And vice versa 
(get should read from flash)?

Resetting would work either via devlink reload, or ethtool --reset,
don't think we even need any API addition there.

