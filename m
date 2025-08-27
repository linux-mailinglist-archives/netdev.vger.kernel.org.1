Return-Path: <netdev+bounces-217439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A72B38B3D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18ED189DB77
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D630C606;
	Wed, 27 Aug 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B0QecO/A"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB030C617
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328981; cv=none; b=bt6eshveS5zHwzBsVafQmIc5vyORNhsZ7tafhU33ltqFh0YbVn1TptuG4kaTbIzwHyTNw0/F1IW6UXfpCPDxFN4PHt94Wl2ZQFh/HUzNlFvjHqG6V7XON5IEd0gmSuUY4tSAbUXlDU9dDVpgX67MdklKmNpUe6KX2k6UPL+rUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328981; c=relaxed/simple;
	bh=kzYYMdQng5whvP5KLwYzzN9EjmFcX1ytgi7Bns5A8h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCt27AK6jq4gSMIsdjxJhKXOkp6kAkc9Y5jTcQ6ryh6esNyeKUSA+0xDMfiyx0MuM9akkpgbcNXHXnSYs+suUMC+LAwprKteLt65YUxq8QdGmo6mJj2n2nu63NK0WVQwRwFy2evGTwp3MvYhCUrOZ7fZXxAfDAR0ZanKgy9n6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B0QecO/A; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BWWn5ZZNajcZMxOlv5+fpZzUTYc/2mcZ2e0Sy7qpcao=; b=B0QecO/AO3aOI8G4+Oa0s2RfUt
	khUBMpiN5duyl5on0NVXG85f6CeAAi9RxbYWZHpYH+8J79nS0ba5aQB0sUroWgpvvrcUPcaQU/SfM
	NzP6zqtWfv2F1YiPObGIz8cfEf7dSi37h4+UbIT6NakwSBWpsW/8i0S23L91kHaYJzLC3Kq1tC6F0
	x1yYcOpuhp90I6NrdbBuSbYU5Roe4NjYObaWeL92+hmJojCRHbxTC55Cdxml2S10+X4YiEheenBje
	4JAIAt4F1zdHF1EA02n06pfQb8c1CRrVzKHiWU7Wr9drOjsTkLr753ONVvRc+fyIwZC+JAwv5ZdqM
	iEMkihww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urNOb-000000000ww-20UV;
	Wed, 27 Aug 2025 22:09:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urNOY-000000002UT-01op;
	Wed, 27 Aug 2025 22:09:26 +0100
Date: Wed, 27 Aug 2025 22:09:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
Message-ID: <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 11:02:55PM +0200, Heiner Kallweit wrote:
> Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
> Easiest fix is to call fixed_phy_del() for each possible phy address.
> This may consume a few cpu cycles more, but is much easier to read.
> 
> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")

Here's a question that should be considered as well. Do we still need
to keep the link-gpios for fixed-phy?

$ grep -r link-gpios arch/*/boot/dts/
arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 2
arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 3

These are used with the mv88e6xxx DSA switch, and DSA being fully
converted to phylink, means that fixed-phy isn't used for these
link-gpios properties, and hasn't been for some time.

So, is this now redundant code that can be removed, or should we
consider updating it for another kernel cycle but print a deprecation
notice should someone use it (e.g. openwrt.)

Should we also describe the SFF modules on Zii rev B properly?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

