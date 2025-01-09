Return-Path: <netdev+bounces-156807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C3A07E12
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BDA7A110F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6417557C;
	Thu,  9 Jan 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5dZnLCN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29482B9BF;
	Thu,  9 Jan 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441405; cv=none; b=UydTd6yTAztj06E32CYVkB+Z6H+zPAnPscFR0j8rvH+vMrpg/wWPmf5EFxGX8N6rptDkktcz+bY+sB60n7zRzdfSxAm7k521si7rP/crS9jv5fbCi2Fx83FwRqlGxE3fJ2ZjLLDUWPmAIFcBtZ2q+Y7fhTCvWR2MvB4GK0Rn1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441405; c=relaxed/simple;
	bh=S8rwKFOvyflEr0R8Ts5q3F/jP0ym6aYxPZCSsxOYjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/RwEOx354rydWHXYBjW+XA2MKfQpC9nQaxoeb4yMt2DHkynGqCkig6GRNX6K9C+5BGiNlF1M5xjzO2KuiP+AJFEtgJ/HWxOUzjo6OXN3OOoLz2s+z5gR4zHqDG8nOeWOv5I07kX5FidaQ16moydJulmouOjJ6xsP32TgIM6gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5dZnLCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C80C4CED2;
	Thu,  9 Jan 2025 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736441404;
	bh=S8rwKFOvyflEr0R8Ts5q3F/jP0ym6aYxPZCSsxOYjSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5dZnLCNhhQifAZBY0EcBq77j5ccmAAAEJ72JPvrByfJQ5OYZjUhtWWj4MD+mclVc
	 +yAWH4WIx1rXd3qNQ4Rmo0ma63tBy9M08DEbi9KfrmfLete8g57MjZ7O7W+lIB0fDL
	 0fGvSwPWVifxE7EKyINdXmeLVnW1WwItLeHPVRPpSxdjjnaRoMsl/Ega0egPplTMoJ
	 C51b0NFkXD+wtr2ns9V5+9YXTshGOqPQNeuAObDvbvaVdHPKrsDZngKDRJhj7gCMP2
	 G5/thFnSWp2TZyv+TZ5Q21lg+LPG+f1FYIgwIXV9nRzx/ysudnC5bvS66ePYzbzJcE
	 XFYqnf31vit3Q==
Date: Thu, 9 Jan 2025 08:50:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn
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
Message-ID: <20250109085002.74b6931c@kernel.org>
In-Reply-To: <Z3_415FoqTn_sV87@pengutronix.de>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
	<20250109075926.52a699de@kernel.org>
	<20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
	<Z3_415FoqTn_sV87@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 17:27:03 +0100 Oleksij Rempel wrote:
> > > This index is not used in the series, I see later on you'll add power
> > > evaluation strategy but that also seems to be within a domain not
> > > device?
> > > 
> > > Doesn't it make sense to move patches 11-14 to the next series?
> > > The other 11 patches seem to my untrained eye to reshuffle existing
> > > stuff, so they would make sense as a cohesive series.  
> > 
> > Indeed PSE index is used only as user information but there is nothing
> > correlated. You are right maybe we can add PSE index when we have something
> > usable for it.  

Oh, maybe you want to do the devlink-y thing then?
Devlink identifies its devices by what I'd call "sysfs name" -
bus name and device name.
This is more meaningful to user than an artificial ID.
Downside is it won't work well if you have multiple objects
under a single struct device, or multiple struct device for
one ASIC (e.g. multiple PCIe PFs on one PCIe card)

> No user, means, it is not exposed to the user space, it is not about
> actual user space users.

Can't parse this :)

