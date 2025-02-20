Return-Path: <netdev+bounces-168122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FFDA3D918
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7216218846F3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18241F37CE;
	Thu, 20 Feb 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xt5DFqDv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6679CD;
	Thu, 20 Feb 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051881; cv=none; b=U+LVJkzYhIZcQhj9KWe0SCG3Wh1w8lHnAKskADmHzc93W3Gaw8UueGDTVwTovpqkgpMuu2Ege/Vw1itS8TMHmYao4tz03l1voXVOtdOIquU3CElmpLUwIuM16zw13L2tKJV6EhEbcTHQYPkVsURA4Lp4dhdvY5xb+SlVC/0oG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051881; c=relaxed/simple;
	bh=dRD2Z+QEueUpm7pZtyoK8qbcEyBONj0ZELWYH9A92MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPEXLiALlHFHTN7V8SRKfDuyMHw+pHZJXpld1mJuSrOdnt03yFbHB2V1GvfodiWE6EH1JBEKWkhvXW/GpFGwC4B3TsfcSrIwgSTRB9SI3HTFJABlGDVxapSlz/HHawJv8E6Dk3dPRhM+9GsCpNMD8HOP/EaMAISwF65HoXcbKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xt5DFqDv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OMt4+h4M2hi9bh1j74Xva35n6PD/Vbe0tDN67Tdnx4w=; b=xt5DFqDvVS+9dt404mDOkGLP+E
	1fyXCW3pqplrlhIIjhaQEICw6ArRyUhDDKMZd21/ALbjtqYBc1DvJQNHlIjHP4EiSUy8obeO4BviH
	/h5rYxya6ZA0d0sJl3WgV32fccXeoV0Xo+2C+IH34+2DYD3tig4tX44Pk7yfPkaYEXG1Jz3SdpUse
	9ghw7gaj3bvKMnwLV5qkZQFtr+2eE89jzJhJ16pUw374/yDw38JMMEjOWGn3w7OLSnbZMxnvIaV+L
	2AM3Sz3//5OAL0/lES7735aRaZ3YsKDPgM9o0Pa/EQwZBE6cSFyFztT2qtR/XfIflhAbW67EFjW95
	ylRToIDQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tl4yg-0000om-0U;
	Thu, 20 Feb 2025 11:44:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tl4yd-0000x2-1n;
	Thu, 20 Feb 2025 11:44:23 +0000
Date: Thu, 20 Feb 2025 11:44:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <Z7cVlwPDtJ2fdTbY@shell.armlinux.org.uk>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
 <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
 <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
 <BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 20, 2025 at 11:30:52AM +0000, Gupta, Suraj wrote:
> Sorry for picking up this thread after long time, we checked
> internally with AMD IP and hardware experts and it is true that you
> can use this MAC and PCS to operate at 1G and 2.5G both. It is also
> possible to switch between these two speeds dynamically using
> external GT and/or if an external RTL logic is implemented in the
> FPGA. That will include some GPIO or register based selections to
> change the clock and configurations to switch between the speeds.
> Our current solution does not support this and is meant for a
> static speed selection only.

Thanks for getting back on this.

Okay, so it's a synthesis option, where that may be one of:

1. SGMII/1000base-X only
2. 2500base-X only
3. dynamically switching between (1) and (2).

> We'll use MAC ability register to detect if MAC is configured for
> 2.5G. Will it be fine to advertise both 1G and 2.5G in that case?

Please document in a comment that the above are synthesis options,
and that dynamically changing between them is possible but not
implemented by the driver. Note that should anyone use axienet for
SFP modules, then (1) is essentially the base functionality, (2) is
very limiting, and (3) would be best.

Not only will one want to limit the MAC capabilities, but also the
supported interface modes. As it's been so long since the patch was
posted, I don't remember whether it did that or not.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

