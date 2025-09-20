Return-Path: <netdev+bounces-224968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D07B8C412
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0384D1B256B8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04307286D56;
	Sat, 20 Sep 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DS7HG/wX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AD78C9C;
	Sat, 20 Sep 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357777; cv=none; b=bMgerXAeKL2uAyiciaQAJPg1uHtqhyWZIJ6jlUcUDUAoNMNIden4gaWhEz6pXbBtMZLADvk4Rx3F8kS1d8auaSqcugPg/bYtxgrQC4qI36N9x2UpJTI+RiY6dxx/9W94EyN0eO6EcGhR0yo4+op4CMGsW76ewyWPgmNRGK8pYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357777; c=relaxed/simple;
	bh=t29V9AgX/NKmPHjTgaedf7R9252R6wr9WoYCntM+Lvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dma0B7PlgiVI/t+JGigMFK5zKPcYPfCEPaPoMKhACSCd66m1SUHCgiWHQ95DqCG95EMSuvq1FOIkRrycDwhD4wzdiDFxy5kOchL97+JKHEbZ1Qq9BY5uzfZQ5Daj7nTCeImTSDERbyvsGhW5B91dTRnSlKQ+Yr2ReWt6RmUo/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DS7HG/wX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xBF9CyZWiKiOxeJFSHS98uiQ2p7XF52s9xV5fyUWZwo=; b=DS7HG/wX/9KVMrGrwe6t6++FzJ
	0QiMmw8de9ipH73yC4hEbVnJr4ZR7td34n+Q4bKcn8jz3p3tMqWM4V3x+8Ya/OwgE8R3tOsB+9w3p
	GHugrGfuwjl8sXMc7/xhG+RJmPZozx3BAWkAhKjuajrYZxw1woc72pq/zLxj4N8qXiQwyfaG12RuM
	XVcGbWSrqjUvSqI1FK/W0Ovmvf78oZM++wKmujE2S6CfDLcK0LEs8txdEsYOtxN2JjQ90lMq3kG/u
	aiYrxkX0+5bNtMnhYZZTz1okHYgbMuvo+vARbE0KMJ62fJo8xgt5+zx3BUp1V13dtC54zF9nsykLV
	mTasN8SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48600)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uztBC-000000008CR-2fDj;
	Sat, 20 Sep 2025 09:42:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uztBA-000000002zo-0Qam;
	Sat, 20 Sep 2025 09:42:48 +0100
Date: Sat, 20 Sep 2025 09:42:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <aM5pB-c-AR_E4U8k@shell.armlinux.org.uk>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
 <20250919094234.1491638-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919094234.1491638-3-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 19, 2025 at 05:42:27PM +0800, David Yang wrote:
> The "reverse SGMII" protocol name is a personal invention, derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Thanks. This is also going to be needed for stmmac, which can operate in
SGMII mode acting as if it were a PHY to allow a SGMII MAC-to-MAC
connection to be established.

As noted by the kernel build bot, there are several other locations that
need to be updated whenever a new phy interface is added.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

