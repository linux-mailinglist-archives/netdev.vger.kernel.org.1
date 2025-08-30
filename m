Return-Path: <netdev+bounces-218523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D4B3CF94
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3307A38F1
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931F2586C9;
	Sat, 30 Aug 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ble5xxoL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA920E6F3;
	Sat, 30 Aug 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756590278; cv=none; b=j2wMFEW6Q9+LpSMaZCcVHYfrplVGp3trq8TbgkQepmAyz43VFeCrefXpHXUzlppXAa3R4rmgzwgHLsUoowpGL/TlutG5mm38l3pOQcGFPI7qbGushds1UPD2RcEfrl8uvC9rRFmABTwG4OyyXbQjC52ghG2m+7wVbgq67itMiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756590278; c=relaxed/simple;
	bh=MsvKBCLCV+6KSSnIJPzayYM8MUkHtE7TV3nETYrXeiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFCcDEZyaHXChUXEoJeW3gGp9Cll8kmlRcA82D63U9s4Px6kXIT7uLVE39trb8niD9x5ghDw9vbNXRMTO99VCChCe12vhnGOxmvxdTcZyNdrprGdiOxb9BYW/SJFJfGwDBwrg0cjbfNGNjQSZHgF3rSKBF/OIKM1fOferJ3Yc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ble5xxoL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lGPDXnyGYW0XoDW4eruhlRzw1Pka3lDz/kJqkb3Hz1k=; b=ble5xxoLGxUvv/PLnLcgzkto+N
	QjyWij/EswwddxjEC0pKfxn9Mp72yHI9nXr4naY+HhD6S/DRkrHLFRfBtG5OCWL4c8W63HD89DLsl
	IQxx7brRWJM65yvz1Iim0TqugnYM/xtgAt1N6zAy+43B/iU5gxR54LLDFm51izL0RaeOmocWZyJzP
	gCrtgUvbpJIt3TN6q3o0ujHpVSKOeyqQjsODhYmKdMXX2qx5BkdJZ1A7SSco9Yv7jfsAsCR2lA+00
	sluqE9cvgiHyK/S5wN/acApHVPY8cmkQr91/PyW1T5iK39KyefqMzJV4GIkgdG5lqvZg4S7WwNZ2m
	+QZlyZqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58744)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1usTN4-000000004U3-2172;
	Sat, 30 Aug 2025 22:44:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1usTN2-000000005QQ-1VSx;
	Sat, 30 Aug 2025 22:44:24 +0100
Date: Sat, 30 Aug 2025 22:44:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
Message-ID: <aLNwuEqSqrUM3dW6@shell.armlinux.org.uk>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
 <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
 <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
 <d2012185-0403-4bad-ad4a-e0468e11928d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2012185-0403-4bad-ad4a-e0468e11928d@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Aug 30, 2025 at 11:39:58PM +0200, Heiner Kallweit wrote:
> On 8/30/2025 11:27 PM, Russell King (Oracle) wrote:
> > On Sat, Aug 30, 2025 at 12:27:23PM +0200, Heiner Kallweit wrote:
> >> The old array-type fixed-link binding has been deprecated
> >> for more than 10 yrs. Switch to the new binding.
> > 
> > ... and the fact we have device trees that use it today means that we
> > can't remove support for it from the kernel.
> > 
> After this series there is no in-tree user of the old binding any longer.

Doesn't matter. Please read Documentation/devicetree/bindings/ABI.rst
particularly the but about "newer kernel will not break on an older
device tree".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

