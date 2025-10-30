Return-Path: <netdev+bounces-234463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED9C20E41
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11274E6492
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514136336A;
	Thu, 30 Oct 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hdYVS7H3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753C1F3B85
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837749; cv=none; b=RcpF3QVwP/FxYY+Uel9RJwLhubkRRSMl8raQiPTd1OhYGEdI13oh5zBzlinubpeG+0+3IxFMmbJOcFXb5Cemz5wDilAW/P/LQ9wKYubrIbaOe1ByAawpaE1niXXuSFSXy1KJe2WjdqEt8J78yshaseY3neNmk/JYz0U1X4ET4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837749; c=relaxed/simple;
	bh=B6A39tZzPR9y0FqfNHyAhljX6wGd8ndojAQTGjd9kJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgAePXJ4LQ737Ud6U2bjVAyM03dwaCsh5IYOUaGAiGa/J9HjQeKV7QiAKurX6aMd6nWJZNA/YmGpaeymfLDiP95X8WVlHaGW6bXr99f0vFpZFpbFPwK5lTvzQlVLQiOxX7Dsy9ufy+/TZAheDbMt/Ib+TNAIr3hneq6APIA+5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hdYVS7H3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2AA1lJsSjmlrTLpgL3yAu8bXZXBBQGx0RoKGKGhqf4A=; b=hdYVS7H3NH9dxPiem6I+4HtOcH
	6RC5CD+SpxaKRgVmdIcWRjOP6GDyzAUCXo5suEwQSAjBRlSGBFInmH/iP2X5mmZ9FET/z3a9wEb0C
	flzUmp51QHLQRtqQLAeX/lUJBpoNDIyC1j2/DDM/lD4ufTcWlcZjKJ71oAMJo7LVzkKQ1Ti/NK8Y4
	giwKTmyJZ+bkmrSih85krhfumritfGe7IIQUuaooy37ZdqrQoyRU09ixZkH7MptzFstEJLJ2GrJwa
	ZUnuw+ALVga4MMsCOh2N1H2Nj+QBV60VIyq+LZDwMz4w8XO1NTLxr8tjVBtwHirmJqFPUmn5C6FU1
	82NhBcHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEUTf-000000005rp-1ua6;
	Thu, 30 Oct 2025 15:22:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEUTc-0000000007I-2fqq;
	Thu, 30 Oct 2025 15:22:12 +0000
Date: Thu, 30 Oct 2025 15:22:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > 
> > This is probably fine since Bit(9) is self-clearing and its value just
> > after this is 0x00041000.
> 
> Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
> but the PHY says to the MAC "this is how I'm operating" and the MAC says
> "okay". Nothing more.
> 
> I'm afraid the presence of snps,ps-speed, this disrupts the test.

Note also that testing a 10M link, 100M, 1G and finally 100M again in
that order would also be interesting given my question about the RGMII
register changes that configure_sgmii does.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

