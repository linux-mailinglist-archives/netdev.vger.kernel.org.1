Return-Path: <netdev+bounces-240068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C81C703D3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610184FA3A9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAD33A709;
	Wed, 19 Nov 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BRLKTIep"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6D33A713;
	Wed, 19 Nov 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568810; cv=none; b=ITjryjt7cSTHIc76/aCEeNxJ7xxk5JdgAGW98d+WgCXpVfbpGhBOw5SmXK37ZMxR8nhcpEFKUkR2N3HudbPX88tr4bAL1HvYy1crQervclSp+5EnfQ5XWkwtaY8FooqUIfqMUvsPdyd0n3C0JEyBh77OH9IWVWjYMhpoN9EHxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568810; c=relaxed/simple;
	bh=VrqQU9LTD/17OAmHEq8JGfmrEPMEeQQqPOvWT7IcTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4ZtX7RrC5U08JgOt9CT5NH9r7pn4LjDN6sCgG4zvWH2qfMQ/WEIn7ex+v9+SopJ9vBWmJy7EmhNyBmBuM7Fs1h4NqXX+nhuYr6UsH4WXQuL9DsRNSVsF0T9PoNg6gdvFxO8WpYG7Wb11ME23sL8sJ1mmQKcgXfuiSjO0jTVvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BRLKTIep; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I2Z8/xcjTHwwelfJUI+eSlYaVGFYtTXFWiaz6vN1dqc=; b=BRLKTIepSCsk2GgXJg5XJJxzcW
	Q01F6+TnlEaz2bHGlKhI12kgEN1NM7BDaQppp5zAAEQgLiaRYg1O8m3hrzul7eWn3PeUTAEyNQOpa
	Rgx0+25rJnZ+ulN9XZymfV0agn8derlOjokbo4zNIdphtx5TCR/mRxSrDnlp8i+i0nKmehDwFPUh5
	wCiOZr9B+8svl8RWRnQAv4a7S5L+t4Ywut5foMAGHWsPDrty6gcPagQvHCDtrhcOxfMou91DOitEY
	et5g38666G9rqA8DRHBDFSgfKlGwdg5LklhRdBbShOvASvSTou/TSBZ6hhPE1dz82M9F44q8Kr8CQ
	VvsZowzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLko3-0000000058C-3sRn;
	Wed, 19 Nov 2025 16:13:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLko1-000000003Yg-3fGV;
	Wed, 19 Nov 2025 16:13:17 +0000
Date: Wed, 19 Nov 2025 16:13:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] net: stmmac: add support for dwmac 5.20
Message-ID: <aR3snSb1YUFh9Dwp@shell.armlinux.org.uk>
References: <20251119153526.13780-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119153526.13780-1-jszhang@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 11:35:26PM +0800, Jisheng Zhang wrote:
> The dwmac 5.20 IP can be found on some synaptics SoCs. 
> 
> The binding doc has been already upstreamed by
> commit 13f9351180aa ("dt-bindings: net: snps,dwmac: Add dwmac-5.20
> version")
> 
> So we just need to add a compatibility flag in dwmac generic driver.

Do we _need_ to add it to the generic driver? Do the platforms that are
using this really not need any additional code to support them?

Looking at all the DT that mention dwmac-5.20 in their compatible
strings, that is always after other compatibles that point to other
platform specific drivers.

So, can you point to a platform that doesn't have its own platform
glue, and would be functional when using the dwmac-generic driver?

For reference, the dts that refer to dwmac-5.20 are:

arch/arm64/boot/dts/renesas/r9a09g047.dtsi
arch/arm64/boot/dts/renesas/r9a09g056.dtsi
arch/arm64/boot/dts/renesas/r9a09g057.dtsi
arch/arm64/boot/dts/st/stm32mp251.dtsi
arch/arm64/boot/dts/st/stm32mp253.dtsi
arch/arm64/boot/dts/st/stm32mp233.dtsi
arch/arm64/boot/dts/st/stm32mp231.dtsi
arch/riscv/boot/dts/starfive/jh7110.dtsi

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

