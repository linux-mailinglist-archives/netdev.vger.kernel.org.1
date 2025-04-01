Return-Path: <netdev+bounces-178666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1D4A781C4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 19:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692E2169917
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27420DD4B;
	Tue,  1 Apr 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lR+9llv8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAC20F080;
	Tue,  1 Apr 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530205; cv=none; b=DGsgoQsBN4vDjB6IDogGE8PSgSiR/cTPUiqxrPNmXcE/Ie265qHsjklri7IPzhOnXigOTLnsu1JuNzLwuHQ8jthQqQTaNwajgNn1eKZCs04CUZmTDtrRkBzgNuJsYnL5+ivd41WhVTTQonlYkSOCr4ISOnKPcG9b2N4XIfuj8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530205; c=relaxed/simple;
	bh=mVPJFdz1rjfDWi6PMax3qH62bmWT7r6prnH2g2vxswM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUvGAOPfmw8WarGNHu97j1K9xDheD6Ao9R51MwzKftV3VoBc8Tbkk3gI4ybXsl18LlBiE5VZOMNWgKLNRliyR0A861YRKd96eREqHytMN4oh6eS0CMCOPNqLoNN+MdEiNju1AtUuNwQfvYI6uIlfhECTkz4q8QnG2gb6BSBmGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lR+9llv8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KfxG9zER/CsQbwixwWuMGqZuKg6tmfxNplTMe1b8WXA=; b=lR+9llv8f6vihnsWNFFXN2kgT2
	TmKJLTuj5+m590+5/EvmK4ftwVdPzJU7ZcMbwmaQ+zcdfmgtYFHg8a9/MZKDM9dvFT28Ud0U7bpIb
	14KZD+KeV+r1yDzMbCQGikAYOPrPhgHBHznbThP/DVD0aIaiC/MH7nsA2m6kf52M1/REwuxFwBFXx
	Iyg7/FAIgE3B/+Dfu5fTuM07V/BJ8f77GpCHS8L5KD0aA5weuVnuAWeq3yniU9oYio3zHNL3jxrM1
	FHvniiWydMdAJDLdp6CsD8rKqoS4oGpjL1+lAxXCy+lFm9n3rkFyGEsARC1DkvOltzVx3VZkwkbaa
	WyDJIBVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzfqZ-0006l7-0W;
	Tue, 01 Apr 2025 18:56:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzfqT-0002tR-0o;
	Tue, 01 Apr 2025 18:56:17 +0100
Date: Tue, 1 Apr 2025 18:56:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v5 4/6] net: phy: introduce
 genphy_match_phy_device()
Message-ID: <Z-wowRLfOoNX00_F@shell.armlinux.org.uk>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
 <20250401114611.4063-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401114611.4063-5-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 01, 2025 at 01:46:05PM +0200, Christian Marangi wrote:
> Introduce new API, genphy_match_phy_device(), to provide a way to check
> to match a PHY driver for a PHY device based on the info stored in the
> PHY device struct.
> 
> The function generalize the logic used in phy_bus_match() to check the
> PHY ID whether if C45 or C22 ID should be used for matching.
> 
> This is useful for custom .match_phy_device function that wants to use
> the generic logic under some condition. (example a PHY is already setup
> and provide the correct PHY ID)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

