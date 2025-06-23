Return-Path: <netdev+bounces-200337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D6AE496D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDAF3ACDBA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273928BAAF;
	Mon, 23 Jun 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="klqEhPVu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53343253B67;
	Mon, 23 Jun 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694316; cv=none; b=iJENpd7gwzQyFU2Cij5jwMXVgIf++D2AvDhXYsYun2xZ1z/qPiLMcGYAvsX68PSVjlwZd13dG6VYel36U+ffnyP9af4fLp0q4fNR9QkeOBIcha7BQA0mne5IwQUcD7KGNSmJxPopgEDFZjkpn/aeXVAqqd8vUDb3vGWA5S3BgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694316; c=relaxed/simple;
	bh=+gnHtm2Xm/AQkHsS012Lke7TKUT19K3x/CmgqHYwJIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeKtOv8lX0Napozg0B/RnzqXNCVqwyCtWZ/qF5rujhHFbKriYgXq9t6QzeBpkQgdELAu3F9gLz01Hy1qR8WVtvbyw00MDhe7a12b2s7bNjZRznABQBa/Rf8RpwR/M+968Eet11QloVYmP1i7PBHDdFDELbnUAK7pFAuTjD5pfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=klqEhPVu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z9yxtwVTuu9+nWIOqzKx4H8/wNr3LFIBV48QefUFSGM=; b=klqEhPVuEIx1LkXon5v/AVlYy9
	97ku757xqnJ+e18+0H74sd4uk9Am5SghuEhZc/eQzJl1t7FYlt1IyB5GDrWDyJ5R7J5WFkK+V7czL
	Y5HPPYgw2AGwSJxu9ZaWRYEVBDVOErJ78TNLSfNecOJjVZsWQ1RahZC7BxZvZ2srhBXZGil3Oz4Be
	6FfSeb9ZuzXCJQIEJTiz245LzyADlfZ6KgtcEaOHr9b2rblXSQkGy4LUGtGttl0ZbCe+wgM/E2Hll
	F7CgLB8HLO0T9RupS6/+x3RdQ4nAAAK8uZWD6D2w18d+7uvWHmff8dvQJYvycl4xSxr+o+lqSFvuR
	/PA9ybSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uTjYx-0004Nk-0A;
	Mon, 23 Jun 2025 16:58:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uTjYv-0003Zp-2S;
	Mon, 23 Jun 2025 16:58:25 +0100
Date: Mon, 23 Jun 2025 16:58:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
Message-ID: <aFl5obpjq8Zvw-gd@shell.armlinux.org.uk>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623151048.2391730-2-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 23, 2025 at 05:10:46PM +0200, Kamil Horák - 2N wrote:
> +	priv->mii_lite_mode = of_property_read_bool(np, "mii-lite-mode");

Do we really want a property for this, or is it really a separate
interface mode? Should we introduce PHY_INTERFACE_MODE_MII_LITE ?

> +	if (!phy_interface_is_rgmii(phydev) ||
> +	    phydev->interface == PHY_INTERFACE_MODE_MII) {

Same comment on this as in patch 1.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

