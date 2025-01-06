Return-Path: <netdev+bounces-155586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D05A031AF
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4996E160913
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C31DF996;
	Mon,  6 Jan 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLuGcjE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5511AA783;
	Mon,  6 Jan 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197039; cv=none; b=ZswLNzcmZ/nydNnw7V4q4zJsQ9DWfMHvNJCrsNGyP4s9Syuct3BkTspvoG/LrjSEzvLhybsJKbtAyRhA+iU63V9FTqHNrYKkwf9cRMCWPHRLukJ6RZZeEKy2ZPTx6yMxjre2D7GfLeuQF9orbSZVNWZt+piCJS4v1NRqU/SkMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197039; c=relaxed/simple;
	bh=mzCxOj+kcggEA7/uteHRyFRGKLFJOkD0+udHuGvuY6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjf79p8G6oBMG4CTLKq8my7CQTxFWPESCa2slaX3O4imy3o+gTYDWqxQZk5168BSExOGChMrmcJTC+8DZpXgycgwzzxtVAxBZbU43GoppZ6CazdjlbEgDJpXrtX5t2mf+ml7FWQJva/9NKmO77TPs+9xCV17QLMu8CXEpF3n0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLuGcjE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F90C4CED6;
	Mon,  6 Jan 2025 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736197039;
	bh=mzCxOj+kcggEA7/uteHRyFRGKLFJOkD0+udHuGvuY6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qLuGcjE2iwCWJFVlNQzy1KDxwJva4ai1HxqJ31n2p60KPvBPt+BLwpNUv2Ej7YSTL
	 XVY2L7RgFDiCWUAwp9Ka3+KgjdQQ8wkkC2cUiCdop3KJjc2e3XzOxPyPgu8FJe9qlR
	 rAUTU1wGK3A2A5PiMtWutfL1pxOCepIsPdPpPGDEUPx35uccuVytGQsAmlQSro+TXR
	 NPuDnYO6r3q9EXOU7ocCs+re9IovmsAAzL65lU6FDx2ASo+0vDaz9rwzl6BXNW6kcB
	 9zG35cO/wYigx3KlvrZbT317Q4lG3buRq2m7w2Ngpk3rUSCPhHlNd1gZqEjnTj1tzu
	 l4XGtfyHKTPGA==
Date: Mon, 6 Jan 2025 12:57:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar
 <vimleshk@marvell.com>, "thaller@redhat.com" <thaller@redhat.com>,
 "wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
 <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com"
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, Satananda
 Burla <sburla@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v4 1/4] octeon_ep: fix race
 conditions in ndo_get_stats64
Message-ID: <20250106125717.1a11e522@kernel.org>
In-Reply-To: <PH0PR18MB473488467A2026CA30916528C7102@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20250102112246.2494230-1-srasheed@marvell.com>
	<20250102112246.2494230-2-srasheed@marvell.com>
	<20250104090105.185c08df@kernel.org>
	<PH0PR18MB473488467A2026CA30916528C7102@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 05:57:09 +0000 Shinas Rasheed wrote:
> > >  	struct octep_device *oct = netdev_priv(netdev);
> > >  	int q;
> > >
> > > -	if (netif_running(netdev))
> > > -		octep_ctrl_net_get_if_stats(oct,
> > > -					    OCTEP_CTRL_NET_INVALID_VFID,
> > > -					    &oct->iface_rx_stats,
> > > -					    &oct->iface_tx_stats);
> > > -
> > >  	tx_packets = 0;
> > >  	tx_bytes = 0;
> > >  	rx_packets = 0;
> > >  	rx_bytes = 0;
> > > +
> > > +	if (!netif_running(netdev))
> > > +		return;  
> > 
> > So we'll provide no stats when the device is down? That's not correct.
> > The driver should save the stats from the freed queues (somewhere in
> > the oct structure). Also please mention how this is synchronized
> > against netif_running() changing its state, device may get closed while
> > we're running..  
> 
> I ACK the 'save stats from freed queues and emit out stats when device is down'.
> 
> About the synchronization, the reason I changed to simple netif_running check was to avoid
> locks (as per previous patch version comments). Please do correct me if I'm wrong, but isn't the case
> you mentioned protected by the rtnl_lock held by the netdev stack when it calls the ndo_op ?

I don't see rtnl_lock being taken in the procfs path.

FWIW I posted a test for the problem you're fixing in octeon, 
since it's relatively common among drivers:
 https://lore.kernel.org/20250105011525.1718380-1-kuba@kernel.org
see also:
 https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

