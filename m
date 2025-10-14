Return-Path: <netdev+bounces-229257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00386BD9E3D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C0B19A2BAD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F38314A8E;
	Tue, 14 Oct 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ3bIbbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D142FC025;
	Tue, 14 Oct 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450812; cv=none; b=PgA2W6q8QkZHJc2+TFHzQXQ52q4Aqk4f2oDcD0ddgAGe4+jt0qh8EPwu6Y99DWFBebAMcX22ERuoPaXq0W7JdkDOU0auY/k7W5mXQ+CGruWYNldYIm5l9ELZfoWcJIEj2ECBeLRdttQd08iPb/NrBAZ+y4eEUMUYpbe32g8IGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450812; c=relaxed/simple;
	bh=w9tTYK2yli0RK86hTbg570XA47pgHGHINBubz7rRa3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYcFjq/iiMB75gBKbC0k3djk9kXisRqIeIwZdWstBs4G+GHjpr3WaJM2/opSW+mgvy+ce8LSQbG+sjcZ/78ZEgj619frrOoMkuduueM67O+0NqowE3roaFIlrzxNSnGtSgRJKBPeS8v7oI0Bkz5RnQ2Xg5Pikt3NSPtflZ9oxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ3bIbbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF6C4CEE7;
	Tue, 14 Oct 2025 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450812;
	bh=w9tTYK2yli0RK86hTbg570XA47pgHGHINBubz7rRa3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZ3bIbbD6nkd8W5IVl3HfDuXGYs7srO4U+jUj9+dg4aSt9J09mf3p5rJt2Glt/f65
	 Hp8a7NXoAqk2em8EMdr97Qwl4aHuQWqfZUr6hxhxo18XeT4SRYY/rxBVfoIfXLFLkp
	 +pKhSeXVzAdQgyYeZL3hgmICo1pGE2KnIVG17TyFz6s45/Qd0ZLc0cESsQeBJwpS+W
	 srItru5EHM3Hk2PAdFv6DUARb3hjEJIVtOQFXyYAp/lI05LZy9sKZ/XFiwFQQ5Xqpn
	 pgEWN7NzMUISgvc8sLQ+7ZOjQEqnJR+GU/VDtsIaBIptoGNqq6jZ9V2EeFctPyaQjp
	 uvQ3TX7WlZNVw==
Date: Tue, 14 Oct 2025 15:06:47 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: pse-pd: pd692x0: Preserve PSE
 configuration across reboots
Message-ID: <aO5Y9_7OxF9mH8wb@horms.kernel.org>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
 <20251013-feature_pd692x0_reboot_keep_conf-v2-3-68ab082a93dd@bootlin.com>
 <aO4Q0HIZ_72fwRI2@horms.kernel.org>
 <20251014115659.0e6fd10c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014115659.0e6fd10c@kmaincent-XPS-13-7390>

On Tue, Oct 14, 2025 at 11:56:59AM +0200, Kory Maincent wrote:
> On Tue, 14 Oct 2025 09:58:56 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Mon, Oct 13, 2025 at 04:05:33PM +0200, Kory Maincent wrote:
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > 
> > > Detect when PSE hardware is already configured (user byte == 42) and
> > > skip hardware initialization to prevent power interruption to connected
> > > devices during system reboots.
> > > 
> > > Previously, the driver would always reconfigure the PSE hardware on
> > > probe, causing a port matrix reflash that resulted in temporary power
> > > loss to all connected devices. This change maintains power continuity
> > > by preserving existing configuration when the PSE has been previously
> > > initialized.
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > Hi Kory,
> > 
> > Perhaps I'm over thinking things here. But I'm wondering
> > what provision there is for a situation whereby:
> > 
> > 1. The driver configures the device
> > 2. A reboot occurs
> > 2. The (updated) driver wants to (re)configure the device
> >    with a different configuration, say because it turns
> >    out there was a bug in or enhancement to the procedure at 1.
> > 
> > ...
> 
> You have to find a way to turn off the power supply of the PSE
> controller.  As adding a devlink uAPI for this was not accepted, a hard
> reset for the PSE controller is the only way to clean the user byte
> register and (re)configure the controller at boot time.

Ok, as long as there is a way.
Maybe worth mentioning in the commit message.
But either way this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

