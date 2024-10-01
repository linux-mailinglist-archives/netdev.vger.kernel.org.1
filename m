Return-Path: <netdev+bounces-131088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371B98C95E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4871328BDB9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32C1CEEB4;
	Tue,  1 Oct 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z7Sy0FX4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BC2207A;
	Tue,  1 Oct 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824460; cv=none; b=WyhgSwrF2fxx69e/FCCU4nKkrIjqI5urLahBzoc4vseo7t2cLAs0kRFzJ++JdLwpZk5/vhbANjfptK3NalOkwMo0rbotXA5q2uX4AyW3L3c5SakIYUXMTnhmcyeXut7KDSFQqyuqNuYWUGVKqx3HhHkGtKiZo8ZbZfJRAcnskdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824460; c=relaxed/simple;
	bh=oDJtK4cNxYxq5AYlpI9jhDIlyab8ODOkgx+r0yGpxa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI9G4r6tsKN4oKWZ57El7CO9R0DQFPjB3w690fPQ5TBojlLIfeZhCuJuCE4TpSCTdND/dRm1XcsLheExETdFnVrdARx46rkf1Teczx95y0LFmhOANpesZA/uJ7yDweoUIacA4kx0vUNofLWr5jKTXpSIO4Njay7JJQw7Lfetmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z7Sy0FX4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SvmHdDNFN6b59tuW6qBvsEXIyWd5sLKDZWcPZWw7ZPo=; b=Z7Sy0FX4cUkFI8YXYQyqiN8xwP
	TL8WDMn+iKp/ZhwKYj6vy6/HsO4H/4oTCKvCKth6lL5SPoSJcXyWsbu3Me+5N5SujDl+KmH2xHIr3
	XAAczyjPdoSdG19IayDqLrbIkDb7rzr6n0G6R+6sBjGlCStGqFmfeWj85ypCzH7I4CHIpCaA8ouqc
	25709dabQFXEjnGkkM1nMxS/9MdjHJ5gfRaJprKl/AA3OylkE7bKcXRMGVUxQRLJw+DOpCTpXuzXL
	N/D6hC8X8sUn6VEuuDD8gWHMuozRWGKqW2CUk/25ur/xkRrRGFezkQKm/KzIf6eUk7WAbo3fMpN/G
	A3/g+duw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svm4D-0006Zi-1B;
	Wed, 02 Oct 2024 00:14:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svm45-0005LU-2n;
	Wed, 02 Oct 2024 00:13:57 +0100
Date: Wed, 2 Oct 2024 00:13:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v6 0/2] Fix AQR PMA capabilities
Message-ID: <ZvyCNfDqwbwnjb0X@shell.armlinux.org.uk>
References: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 01, 2024 at 03:46:24PM -0700, Abhishek Chauhan wrote:
> Patch 1:- 
> AQR115c reports incorrect PMA capabilities which includes
> 10G/5G and also incorrectly disables capabilities like autoneg
> and 10Mbps support.
> 
> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
> with autonegotiation.
> 
> Patch 2:- 
> Remove the use of phy_set_max_speed in phy driver as the
> function is mainly used in MAC driver to set the max
> speed.
> 
> Instead use get_features to fix up Phy PMA capabilities for
> AQR111, AQR111B0, AQR114C and AQCS109

For both patches:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

