Return-Path: <netdev+bounces-190640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA23AB7FED
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD14C6DFF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AE28540B;
	Thu, 15 May 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0lIbzheC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F18284677;
	Thu, 15 May 2025 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296754; cv=none; b=S+d8OPapvjkpSkp1KWfSf/SyTwrWVdtDswMvUCSi3tCCOOvndp2MHnGfKLsWW3itd8/iaD8XG7Lf+jU/26U97fGGE9kCnUlTujSQaTvwa++4t6cf+23zIR8XFGKQRLxwiMVvVra79V4CfNSwrxdByX+0aMjyjDOYjE16EOSyyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296754; c=relaxed/simple;
	bh=kWo+ToFF1scYUVeSyc8TwNFBY9nZbRC6g7JdJ9AQB2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRATyPTmoNO3S4mfsVvGqQ/a+eDWtBTE5LwvbNE5doWWNn97DPiXz35uaBAYPLu2Dxz9ESvEshJD3z42AdOZRSGTTy6vcCEjFonLT9EFibXsVIFNiZWM8MP56H9KYJRsE47LecaUvc33yUYdmh/gTdZLhplGg7FA2zNwjDF5qlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0lIbzheC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oRapiM1CWDlIcv8b3zVCV3xtuGGZyLXnUZE3mLx5drU=; b=0lIbzheCLzKzWUqTPcmSq+sLNX
	q3TX8RKtKpuprFTYp5nM3YZxfyvF3ijHjXNMMqcbeA1vf3W/nnHp2ehOZTTMj+7eL0/oGNWVrfPci
	PPB30wekvGfohLjb2dC6K/M+81wG9p5H6/a40kSZO6+QTq2NxW67yJSOlD/xrtFzw7xOUPCx8AmHi
	VIbcx5pW9mAl9ej6NIzeThkxcLeLqAvrJlNUoILwlblF5rM27n7Qu3SpF7kS7Bqu8Bv5kAvdnON2G
	8AhxdBLXsB1qLuGIO4BMhNdVjIfemoL8W1WOcvad07lgXP1NKncTnC6oD/UiVpgwzfsLUDrq9q4BL
	ily8ZL2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uFThY-0000FD-3D;
	Thu, 15 May 2025 09:12:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uFThU-00057u-0T;
	Thu, 15 May 2025 09:12:20 +0100
Date: Thu, 15 May 2025 09:12:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	upstream@airoha.com, Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [net-next PATCH v4 06/11] net: phy: Export some functions
Message-ID: <aCWh48ckDDCttbe-@shell.armlinux.org.uk>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-7-sean.anderson@linux.dev>
 <20250514195716.5ec9d927@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514195716.5ec9d927@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 14, 2025 at 07:57:16PM -0700, Jakub Kicinski wrote:
> On Mon, 12 May 2025 12:10:08 -0400 Sean Anderson wrote:
> > Export a few functions so they can be used outside the phy subsystem:
> > 
> > get_phy_c22_id is useful when probing MDIO devices which present a
> > phy-like interface despite not using the Linux ethernet phy subsystem.
> > 
> > mdio_device_bus_match is useful when creating MDIO devices manually
> > (e.g. on non-devicetree platforms).
> > 
> > At the moment the only (future) user of these functions selects PHYLIB,
> > so we do not need fallbacks for when CONFIG_PHYLIB=n.
> 
> This one does not apply cleanly.

In any case, we *still* have two competing implementations for PCS
support, and the authors have been asked to work together, but there's
been no sign of that with both authors posting their patch sets within
the last week.

Plus, I had asked for the patches to be posted as RFC because I'm not
going to have time to review them for a while (you may have noticed a
lack of patches from myself - because I don't have time to post them
as I'm working on stuff directed by my employer.)

Sadly, being employed means there will be times that I don't have the
bandwidth to look at mainline stuff.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

