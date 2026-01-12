Return-Path: <netdev+bounces-248961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1D3D11C84
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4A883008748
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EDD2C08A1;
	Mon, 12 Jan 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JH2hNoqJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB0274B37;
	Mon, 12 Jan 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213058; cv=none; b=CbKr99Weop4zpAhSfBsiPZPlBKI71l/cA/xVW1vJXM9IEbl29thnweSsMZk8KzH6yIkJGDa3xwO0wgAz3KOZinubfhEyZl3Lk3jWHROWrvI59tJpdNu/jcwyL7T/aKbHbMD/HsPdtS6X+S4OYZdiFvsNb16ZNq65Dy7JTbtL+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213058; c=relaxed/simple;
	bh=sojE/hF9P2rFbqH1yGYhK6eOWnpJJpeTzOuESCm2AQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPfHSD9GraW2zeSixhVeekDvy/oms2PNIej0Lcc7EkcD+AQQar8L1od3OC/RrlcyOwzAxhzKQNWLmuef6iRxORfOevUnTjApQwnqVZyqVbdvYLm4ENYkajttEEgwgfauZQNA+WQjsSRiNck/IZfoA2ZW2po+ZbxdmANFkg2KKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JH2hNoqJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vyAScN/bo7bHZeEn/2S0pTYHziiwy17H4Nc5L9M3rSQ=; b=JH2hNoqJJ9NsQ8V2XXjWhlXQ1H
	1UxrOE2/jfm5QmPl6A5UhNkmhuNufrthGCkT8oCasMdDqoDmmhvaXR47ETqqi9rMybFhs9dV0W+5s
	o1xTHMxhIST1wx0KZqzKR+TYUXTsAKtus4AObLZKURnBCSyS83ofB2wP2i+rRagmtviSlJgTazOGy
	DigxHmxTXEUY/M45fYUkyvE4vPV4WzeUl/Zt02RbMWiJDIK863LI5tWH9zwJW9fshUWICGrMdfipL
	FXNyZDOAp2W/zFlnw4uELQ+vMKAbHyFzOWYHmZwEie3sm3rersGz8ye9xdcvS2OqVzvtE0F82RJju
	TWxbz3sA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49190)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vfEyz-0000000064z-3Pzw;
	Mon, 12 Jan 2026 10:17:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vfEyq-0000000080E-1aOS;
	Mon, 12 Jan 2026 10:17:00 +0000
Date: Mon, 12 Jan 2026 10:17:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: Yao Zi <me@ziyao.cc>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH RESEND net-next v6 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aWTKHAw-WlT_JyFF@shell.armlinux.org.uk>
References: <20260109093445.46791-2-me@ziyao.cc>
 <20260109093445.46791-4-me@ziyao.cc>
 <BYAPR18MB3735FED933ED0F7536C07A59A081A@BYAPR18MB3735.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB3735FED933ED0F7536C07A59A081A@BYAPR18MB3735.namprd18.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 12, 2026 at 06:10:26AM +0000, Sai Krishna Gajula wrote:
> > +static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv
> > *priv,
> > +				      u8 index,
> > +				      struct motorcomm_efuse_patch *patch) {
> Minor nit
> This format breaks  kernel style function definition, use as below ( "{" in next line)
> static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv
>                                                                           *priv,
> 				                 u8 index,
> 				                 struct motorcomm_efuse_patch *patch) 
> {

Your email client is lying to you. I received the patch with the curley
brace on the start of next line.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

