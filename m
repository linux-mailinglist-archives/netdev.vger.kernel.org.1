Return-Path: <netdev+bounces-219289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D9B40E9A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FC15E1542
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E52E7F0E;
	Tue,  2 Sep 2025 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m82HAgK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CD4A2D;
	Tue,  2 Sep 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845735; cv=none; b=RgyT0V7tYBGVpCbDeOSSZpn0TZT23iIFBr1RkWpn4ZHzxP+qk0cTf0RuVlqeBjCnOygybf7uiJJR7Eni+PIYSXLQI3rmY+uLrZjRhbzLSfEdUlelPfF3SLBXhjA5sqX0qQWSF2FAvJpyUWy50byWnruqPvJNIqLayMaWaiPzfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845735; c=relaxed/simple;
	bh=B06/borCoaX5DNnRHbLpFGdTIUxuU9TOZCZ4Dl6LKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cfgl+/Dkp6p+NROZDT5IxauO6/E5HViat/YEPSBP9LIN8B3j+6DriVUvLyDNsJ+ad+GvmUtJ1DbzNRprGvsXQr5He4TPtGVrgPMJ5/dplOt96uY1Wmzk3KPTDG3R8x9buZ1M6RUwLTBsKTrXZbhj6qlS3hElCwB+XzuDA/5UwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m82HAgK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD03C4CEED;
	Tue,  2 Sep 2025 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756845734;
	bh=B06/borCoaX5DNnRHbLpFGdTIUxuU9TOZCZ4Dl6LKTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m82HAgK1tXQQL1I9oyf4N9S2PAOCCB1/2d+kAaoVSPnvtY0iZH/TacVcIFzdMYzuJ
	 eKHA4NrrZxv5G/Ag3DK1QUpVCMvREuP3fVIzEojoBuGs/U69231VUMAPgs+eRk7skE
	 WoVluF2kLWNlj5KS3jE+OWzoN5DDBu+0/TLEcnU0llzz8/u4jbEDRKrYSYKr21M3Ye
	 fxukbd/4CvPJsuEIr6yGpnfrtqA3XPS2vKsExpZ6u9H1pSmK7aovkFdT3VJPOfUbwj
	 rxQ6Hu/wdlvJpk1jkvEjxp0Ph0fUz2S4x9bsC8inZO33mtApAAvdZ4whL1quPPrGtx
	 f9aRs2gudTGFg==
Date: Tue, 2 Sep 2025 13:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <20250902134212.4ceb5bc3@kernel.org>
In-Reply-To: <20250902164314.12ce43b4@kmaincent-XPS-13-7390>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
	<20250901133100.3108c817@kernel.org>
	<20250902164314.12ce43b4@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 16:43:14 +0200 Kory Maincent wrote:
> > On Fri, 29 Aug 2025 18:28:46 +0200 Kory Maincent wrote:  
> > > +The ``PD692x0`` drivers implement the following driver-specific parameters.
> > > +
> > > +.. list-table:: Driver-specific parameters implemented
> > > +   :widths: 5 5 5 85
> > > +
> > > +   * - Name
> > > +     - Type
> > > +     - Mode
> > > +     - Description
> > > +   * - ``save_conf``
> > > +     - bool
> > > +     - runtime
> > > +     - Save the current configuration to non-volatile memory using ``1``
> > > +       attribute value.
> > > +   * - ``reset_conf``
> > > +     - bool
> > > +     - runtime
> > > +     - Reset the current and saved configuration using ``1`` attribute
> > > +       value.    
> > 
> > Sorry for not offering a clear alternative, but I'm not aware of any
> > precedent for treating devlink params as action triggers. devlink params
> > should be values that can be set and read, which is clearly not
> > the case here:  
> 
> Ok.
> We could save the configuration for every config change and add a reset-conf
> action to devlink reload uAPI? The drawback it that it will bring a bit of
> latency (about 110ms) for every config change.
> 
> Or adding a new devlink uAPI like a devlink conf but maybe we don't have enough
> cases to add such generic new uAPI.
> Or get back to the first proposition to use sysfs. 
> 
> What do you think?

If you are asking for my real preference, abstracting away whether it's
doable and justifiable amount of effort for you -- I'd explore using
flags in the ethtool header to control whether setting is written to
the flash.

