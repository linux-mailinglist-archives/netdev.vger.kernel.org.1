Return-Path: <netdev+bounces-185570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D5A9AEBC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC2E1884B71
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064622A7FF;
	Thu, 24 Apr 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nmXsIYc5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59E38382;
	Thu, 24 Apr 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500570; cv=none; b=Pt97+0U8dbi71+W2lXU+viLPCbfIJ8d9gk7hKYRtMRSUUFY13CKpjPfyIAllOOPlw8LentawzjkFQlZ8u59m/3bGABC8ovx9tqu7KZHmY0Orygd8wmQX3LmqgnP2ERNpI8KCk78+uhju0xfhKPMvw8dSxIBLwTK9mD44N9w7Mgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500570; c=relaxed/simple;
	bh=qzUsdhyiDAim2N+Z2iPJ48vlRURb+HIsCR7o6LjpGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hESwzeqCx9ga/mTzDJuksnuamBdCuwLE6wc0cZKPk3IYVWar5pP5DVLcRv2VDRPUsfOf6mGZy/DHozFtXgd/4BwepGkWatqb7B7yzq+g14rzu7253IwwtRQTaY2ndd4N4eIBQ9v5KdFI6ys1F+CfTMYJwts5gPp7RtagIHFH6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nmXsIYc5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c7bLomCZpqDubF9RdsvnzZ8Fg/C45eKGcMI2hsfw8O4=; b=nmXsIYc5SUcs/AQUOBvVMQRQgO
	UjnEYbvGUaAmOfT9+gacJgtJea5caekfgm5MkYXCWrByLTdEMpBc8IbIZdqlfKXETAy0Bv8dBOzhS
	cP9FMJjK5TnUbyD6habxLPrlBSia8ETQBb3ysmrGImWR+VA4CxSOR1gKsGsAc7YOZmYui1u7RYBUf
	VPWnYJkPsh6+wbGquxJJjAkQZEl/rJR/yrzmX077ZTryfFL2+5wgRXiB16+iYdmF2dhOw/EEe4p7q
	SeFxaupjB6IhdJK5xXJgch+4QsHCryY96E2MKyoYOAH6RRZD+AtXkZSlR+gjKrNyGJ6ej81BryEyx
	gvRFHLPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7wQs-0007QW-22;
	Thu, 24 Apr 2025 14:16:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7wQr-00017w-0u;
	Thu, 24 Apr 2025 14:16:01 +0100
Date: Thu, 24 Apr 2025 14:16:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 4/4] net: phy: Always read EEE LPA in
 genphy_c45_ethtool_get_eee()
Message-ID: <aAo5keWOAVWxj9_o@shell.armlinux.org.uk>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424130222.3959457-5-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 24, 2025 at 03:02:22PM +0200, Oleksij Rempel wrote:
> Previously, genphy_c45_ethtool_get_eee() used genphy_c45_eee_is_active(),
> which skips reading the EEE LPA register if local EEE is disabled. This
> prevents ethtool from reporting the link partner's EEE capabilities in
> that case.
> 
> Replace it with genphy_c45_read_eee_lpa(), which always reads the LPA
> register regardless of local EEE state. This allows users to see the
> link partner's EEE advertisement even when EEE is disabled locally.
> 
> Example before the patch:
> 
>   EEE settings for lan1:
>           EEE status: disabled
>           Tx LPI: disabled
>           Supported EEE link modes:  100baseT/Full
>                                      1000baseT/Full
>           Advertised EEE link modes:  Not reported
>           Link partner advertised EEE link modes:  Not reported
> 
> After the patch:
> 
>   EEE settings for lan1:
>           EEE status: disabled
>           Tx LPI: disabled
>           Supported EEE link modes:  100baseT/Full
>                                      1000baseT/Full
>           Advertised EEE link modes:  Not reported
>           Link partner advertised EEE link modes:  100baseT/Full
>                                                    1000baseT/Full

Seems to me this takes the opposite view to patch 3... not sure there's
much consistency here.

However, I've no objection to reading the LPA EEE state and
reporting it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

