Return-Path: <netdev+bounces-239123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB6C645C7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 130B534A746
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B75B32ED43;
	Mon, 17 Nov 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YtTwtdV6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B1248F64;
	Mon, 17 Nov 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385805; cv=none; b=mF5we+tNwxcpbIiwyQ0Y1xEHmAKqo4aZuhzFjppF1RV+tRCsdW14FYOJy9+26xSZOs1BNdHx0WT2pWBXCCYW0X0Im1cNzGtbttf0JR3M/kev3pREb/TAJ+SkehFaFb22WjzgVrb6GMzFeNYSTu72O2FifCeopseWHlIZUT08Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385805; c=relaxed/simple;
	bh=0xRsYfRwwvZEOnSLuS4fMdOkAxgzpZ9zP/vfsp2Pub0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUOFSNBY+Y/YdxqHVSuM8bCCjZ06W7PX6hZFLKfC1PhNEOW/qZVO7EWHJX838ecND5X2OMwhRp2r9MVeiIx1KdRssJbIUfeEhBURTjKitqUgyjVvrjIhm2phbuYrLLd2ZYvXxHqKyi3aG7NjqVVNTrkC756iynYKbxPQ9frAjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YtTwtdV6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xqejCIGkJ5sENGSMceu9HHpQdlX0H+SUk9LYUYfeBpo=; b=YtTwtdV6eZ8JCI4+9pdFjY8Piy
	lj6BTQ8GUJUK8FN99LBEnNL1zEpX5kyOOftsUZEPz89wSr+WlcItKVLoKPNKAqjH/tMGro6a4busl
	58X+/nZ4iA/WVul5b0f/e3jgncsm03s42qI8vaDUKw5ZcCSJ09Pc0oq4UOhckK4NN2tc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKzC5-00EF28-Ir; Mon, 17 Nov 2025 14:22:57 +0100
Date: Mon, 17 Nov 2025 14:22:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <9f9df3b3-ea08-43d7-8075-68b4fe19e6a0@lunn.ch>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
 <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Mon, Nov 17, 2025 at 03:23:05AM +0000, Wei Fang wrote:
> > This also seems like two fixes: a regression for the AUTONEG bit, and
> > allowing pause to be set. So maybe this should be two patches?
> 
> As Russell explained in the thread, one patch is enough.
> 
> > 
> > I'm also surprised TCP is collapsing. This is not an unusual setup,
> > e.g. a home wireless network feeding a cable modem. A high speed link
> > feeding a lower speed link. What RTT is there when TCP gets into
> 
> The below result is the RTT when doing the iperf TCtestP
> root@imx943evk:~# ./tcping -I swp2 10.193.102.224 5201
> TCPinging 10.193.102.224 on port 5201
> Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=2 time=1.004 ms
> Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3 time=0.958 ms

With 1ms ping times, you don't have buffer bloat problems, so that is
not the issue.

I still think you need to look at this some more. Both Russells
comments about it potentially blocking traffic for other ports, and
why TCP is doing so bad, maybe gets some traffic dumps and ask the TCP
experts.

	Andrew

