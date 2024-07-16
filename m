Return-Path: <netdev+bounces-111699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A779321B7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE868B20D7E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78DE41A8E;
	Tue, 16 Jul 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kGFX5Yqq"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7F3224;
	Tue, 16 Jul 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117803; cv=none; b=EJk36eSMYiu4v1ipdDLpFTIUJPUVSasKgsaEwI8teTdSshDWLSrOPfUwtmkFLCHq74vyAMqt7QOQup//Gunc5j0lmYSbW5Um2xkVYlrFxUWnPzhp7GkPPfDUYRAkGJQ0nwcMlYiOQikXy6ZYh8x6Yt5s0TDqOgRZhozMkccrxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117803; c=relaxed/simple;
	bh=bzJleRkGe5bie+4dwYnuxQwPeMOYqR2pAVZW50qiFg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8kqzM+FhpOypNKetwea8IZNt5e5Nm3zFMJQYFHB/qQN/OULF/Kx4i7SOFi0CN5Z4Uoj1f1DJZA3AzbOlEqWu4tE5JKTQ4RoE5yM5sP+rJ7TaiU3whpqUzwxiwUeqDRP9s2WVqU86u1gbjZ7NjDcvJk17+2D82bC4mxRF9A57WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kGFX5Yqq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50031E000A;
	Tue, 16 Jul 2024 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721117792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyOpsaGpzP+QBRPn7diz7pq1SsPMwCpyOp0GZCKOw1Y=;
	b=kGFX5YqqwwQT942zrMiy7EGFAsfNSOxtvM3CWzTO+SXuFq4SzIMCvm3SwzrcyYzOpBjfE7
	6axOvP5S8n1yaXfrE5CEArnuTIWr1BRHADN1Ai1a6lEvtnkqNEKMS7acM6ay6O6im0Ld5C
	Q/r55q+QielUdAjSgzXnfN0cM+eq7P7wVlR60643f97lnQg8FBdu+lPXjHBnJGtB4V2lSk
	eJAPa0Nc61YT4RcXRwk6jzWnEfMbhV4GXH2MxpOFF3dpO/iu0osZPCUwRWVw7znMfLmbZf
	ubu2OiQ/C2gh14J2HH3mHaiRx7nTiSHLbvmWCJAyuzzG6hj1SgN32elcNdNtZg==
Date: Tue, 16 Jul 2024 10:16:26 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240716101626.3d54a95d@fedora-2.home>
In-Reply-To: <20240715083106.479093a6@kernel.org>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240715083106.479093a6@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Mon, 15 Jul 2024 08:31:06 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue,  9 Jul 2024 08:30:23 +0200 Maxime Chevallier wrote:
> > This is V17 of the phy_link_topology series, aiming at improving support
> > for multiple PHYs being attached to the same MAC.
> > 
> > V17 is mostly a rebase of V16 on net-next, as the addition of new
> > features in the PSE-PD command raised a conflict on the ethtool netlink
> > spec, and patch 10 was updated :
> > 
> > 	("net: ethtool: pse-pd: Target the command to the requested PHY")
> > 
> > The new code was updated to make use of the new helpers to retrieve the
> > PHY from the ethnl request, and an error message was also updated to
> > better reflect the fact that we don't only rely on the attached PHY for
> > configuration.  
> 
> I lack the confidence to take this during the merge window, without
> Russell's acks. So Deferred, sorry :(

Understood. Is there anything I can make next time to make that series
more digestable and easy to review ? I didn't want to split the netlink
part from the core part, as just the phy_link_topology alone doesn't
make much sense for now, but it that makes the lives of reviewers
easier I could submit these separately.

Thanks,

Maxime

