Return-Path: <netdev+bounces-247423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49BACF9F4F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861DF33B440B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1883364057;
	Tue,  6 Jan 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="abOyxxeH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964428850E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721882; cv=none; b=MGXlOA90zUvkxr8SNafSt1kserD/3bYixmqp+krtzKQIZsa4AIfQ+GdfGNXBb8BchjAmJTVkKRqlMx7c7BaXmYP3W84iIusXFB/7ZOfrJs1mOr8KYC30Fuzsj/Ev2kyYfPneqGgquDufzsinIkSWmHVHjm1FnQ+3UyU1SA8P8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721882; c=relaxed/simple;
	bh=yve5zPgmJlbU/krY/+G5JpW2J/SOK0Vyk3k3HY/ujeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7eQwzp2mtRT9h4ZuTciijIdpE93N4TGwysGgtxfHnVLvwtTWBqUYkpw/x8MSvi1tfM7kjip7FUGxxgKlyiidL170Pc13x0yb2/IlJkDvCOJtPNyz0YoySocQsce0HYROV9DVfRmkfH8Vz7FdESQSF8aTWRnIRiM9cwDY7VcOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=abOyxxeH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lA30C+IkBiFihH+uWXQQBFGmo5HPkIXE9WPMRXMFHYI=; b=abOyxxeHrAcjutHzQe4DE1IP8O
	nptLadeXHdiDtiZmXONEa8G6Fx4Ph6pxZixKsoMveswZLiltsBqWUGp5jfBOEfDRrPAAWNkjLhldy
	BvVoRlcE+fVU4l6i3qq6suG4y/TccnFnzoSRe7ODaa78Cp5hO3EtsWrV0DwxIDv/W0Sm3es45Zi2k
	wYq/ZFvYrm/KdDHNjmP/pXd1ccvLIvi9Ikngj2+uOuSc4TGB8uc9cmpFFN/TIRZrN5V0Y9kdLU1vy
	Q16o0/2SD+PaBCFkCyyEUyVUroLb3XnHA9ZaLU6Ka5zBuVbCTfYvUW2CMNFTynzGibBQpzh82HHrF
	wOb2n5Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vdBD1-000000000sH-3URS;
	Tue, 06 Jan 2026 17:51:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vdBCz-000000000by-1v06;
	Tue, 06 Jan 2026 17:51:05 +0000
Date: Tue, 6 Jan 2026 17:51:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed PHYs
 with static array
Message-ID: <aV1LiYIK9WxBN5qo@shell.armlinux.org.uk>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 06, 2026 at 05:56:26PM +0100, Heiner Kallweit wrote:
> Due to max 32 PHY addresses being available per mii bus, using a list
> can't support more fixed PHY's. And there's no known use case for as
> much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
> so use an array of that size instead of a list. This allows to
> significantly reduce the code size and complexity.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

