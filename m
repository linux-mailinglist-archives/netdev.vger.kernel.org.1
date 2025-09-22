Return-Path: <netdev+bounces-225350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C73B9288A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 20:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3361904DCB
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D1310645;
	Mon, 22 Sep 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3/rDtC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12758285CA2;
	Mon, 22 Sep 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564142; cv=none; b=daumaz1uERir793tRZdYDyjc7IC0jj5Nm+S3wPYv8sLTYohdSJ5kHkK7n/MuqRWjZvwOSHie1A4j/3rwfYHKt21e/u6+PxrZBZi2WwAPq4glbiLZ9jDQ4TB2gEIIfLwnXQyPSwn9tAvct61a2tdYjArwT50KfYqs7GSFUOkIxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564142; c=relaxed/simple;
	bh=hqcYFdmQGHTd43tWX+HtkWYFfrsMuhVJNngoHln+C3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoLn1qznjnOmeAPVhLWD/zyKviDYUir8LKJRHlkI7ZO3doKen+EAV/tVTKqEGIRDLYEG2ifDYDqkvplaR2BuC/Ek4Cf31ERZjT3H+76FHwurVR0ymazsCLOrl1GiTQFErT8542HxbabfWQTxRKUtd1Xu1NeqwXu2bukpF+9G718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3/rDtC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101BC4CEF0;
	Mon, 22 Sep 2025 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564141;
	bh=hqcYFdmQGHTd43tWX+HtkWYFfrsMuhVJNngoHln+C3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3/rDtC09F2D7j5nsSE36Hh9igWt74TsxXzWN5xRvGxL30R5IfeLUt2JHOJde47Pg
	 SRyWEIfULyXRu2UR5MoYo0ZFLBJ6ssfNPv0UXzvsKUVZ7Ooh9Pv8xNrPCHVzAdTxV0
	 rWLW54H2pCz3KZGSgybvsSVo/+IvH06snSiQYsFFaDCvUlvo3fkr+gslKG8Ev0ylXA
	 raP7KfC8MkXOGRkSoUgaaB3SPOovJ6fxbvgotU0qJwhKr6Xgq4sKq4omS3FPlV6Gwg
	 WLKIpgbzM3FMPlvNIWNdAegT5ITsYx8YdIkxflOHnXX6cHm0rN9I/HAfxPlob7zyml
	 QQ+HrKcCIbIvw==
Date: Mon, 22 Sep 2025 11:02:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Luka Perkov <luka.perkov@sartura.hr>, Robert Marko
 <robert.marko@sartura.hr>, Sridhar Rao <srao@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250922110220.4909e58b@kernel.org>
In-Reply-To: <20250922182002.6948586f@kmaincent-XPS-13-7390>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
	<20250916165440.3d4e498a@kernel.org>
	<20250917114655.6ed579eb@kmaincent-XPS-13-7390>
	<20250917141912.314ea89b@kernel.org>
	<20250922182002.6948586f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 18:20:02 +0200 Kory Maincent wrote:
> > > I think the only reason to save the config in the NVM instead of the
> > > userspace is to improve boot time. As Oleksij described:    
> > > 
> > > He told me that he also had added support for switches in Barebox for the
> > > same reason, the boot time. I don't know if it is a reasonable reason to
> > > add it in Linux.    
> > 
> > Right, subjectively I focused on the last sentence of Oleksij's reply.
> > I vote we leave it out for now.  
> 
> I would like to restart the discussion as I have one more argument besides the
> boot time optimization coming from Luka Perkov in CC.
> 
> According to him, not having this feature supported also brings an issue across
> reboot:
> "When a network switch reboots, any devices receiving Power over
> Ethernet (PoE) from that switch will lose power unless the PoE
> configuration is persisted across the reboot cycle. This creates a
> significant operational impact: WiFi access points and other
> PoE-powered devices will experience an unplanned hard power loss,
> forcing them offline without any opportunity for graceful shutdown.
> 
> The critical issue is not the impact on the switch itself, but rather
> the cascading effect on all dependent infrastructure. Without
> kernel-level persistence of PoE settings, a simple switch reboot
> (whether for maintenance, updates, or recovery) forces all connected
> PoE devices into an abrupt power cycle. This results in extended
> downtime as these devices must complete their full boot sequence once
> power is restored, rather than remaining operational throughout the
> switch's reboot process."

Any sort of hot reset that maintains the pre-existing configuration 
and doesn't issue resets is orthogonal to storing the configuration
into the flash.

