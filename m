Return-Path: <netdev+bounces-168159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25BA3DD09
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CD816E7BB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02251F8EFF;
	Thu, 20 Feb 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4IzDVfOP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E0EEB1;
	Thu, 20 Feb 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062145; cv=none; b=XvpOgAeHc4kMebgeITWdQgwObmP/noe1iXGsD/wB6+oSpe6An6G/WCEOZxUiWHE1xsouZUeMAcFjEfGo5UdQkSKd8xKOQWwScvMEBi6PGjTLKLzxKwS89r6RrndiO0Zpx+ZviPv/T+Rh4gAClDeD37S9CvZNSw9APOzSOyGByQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062145; c=relaxed/simple;
	bh=ugP5jpr99O6sw+tgBK3MU2bsccWPuwqOlA7XywGTajM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUQl26p3OJ8hpA6Vp9qvwWrV/ivE8JhFhI1a/R42XD8PHwSS3vF8nci4NiswGmdK6d7OtwT9Fr3Xwj9zYUqbjOluMQkbZ3JSIxE7/UmuLnkdwb7yMrtI9Mdoc0UiCV4rRyad3roHvJ5Ta57zi33Dh6TFwno0y45cDA0utYyWM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4IzDVfOP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ha1L+JSDqQv8B+82Y2MC2nDI3xCTQBY+yLysouv2OK0=; b=4IzDVfOPmSVlGIsLL+yrvsv89i
	bVNU4TLuoAbSiyGAk/j16COvtDV0EWp5K3ncGaZk/VHlCJIjZV51x+Bd5esZ5o6kYYUiJPNW9/Zfh
	cJz4zQCcBD9PrasMLVFdvdU4KAIWSk2EsRGNGesOofRBMFL5EqyCMouDvh8yV4iI0E5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tl7eA-00FzMD-B4; Thu, 20 Feb 2025 15:35:26 +0100
Date: Thu, 20 Feb 2025 15:35:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Sean Anderson <sean.anderson@linux.dev>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <ebf49977-fba7-4848-9a07-c187cabe6b17@lunn.ch>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
 <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
 <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
 <BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z7cVlwPDtJ2fdTbY@shell.armlinux.org.uk>
 <BL3PR12MB6571DD63F0AEE29BF2CDFC00C9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571DD63F0AEE29BF2CDFC00C9C42@BL3PR12MB6571.namprd12.prod.outlook.com>

> > Okay, so it's a synthesis option, where that may be one of:
> >
> > 1. SGMII/1000base-X only
> > 2. 2500base-X only
> > 3. dynamically switching between (1) and (2).
> >
> > > We'll use MAC ability register to detect if MAC is configured for
> > > 2.5G. Will it be fine to advertise both 1G and 2.5G in that case?
> >
> > Please document in a comment that the above are synthesis options, and that
> > dynamically changing between them is possible but not implemented by the driver.
> > Note that should anyone use axienet for SFP modules, then (1) is essentially the
> > base functionality, (2) is very limiting, and (3) would be best.
> >
> > Not only will one want to limit the MAC capabilities, but also the supported interface
> > modes. As it's been so long since the patch was posted, I don't remember whether it
> > did that or not.
> >
> 
> Sure, will document in the comment and limit both mac capabilities and supported interfaces accordingly.
> Thank you for your quick response and guidance. I really appreciate your support!

It is likely somebody will want 3 sometime in the future, since the
current limitation is pretty silly. So please think about this, try
not to put in any roadblocks to that extension.

	Andrew

