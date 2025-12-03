Return-Path: <netdev+bounces-243388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 274BEC9EACD
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 11:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C67AD34736C
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228B2E2661;
	Wed,  3 Dec 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y+9U8uk0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA012E7BBA;
	Wed,  3 Dec 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757121; cv=none; b=ADPEaRHAhx8fXExTQYZoWozXIs5paHVpOTpl8yjybo/zaQCCQClDLGrYLwozeok7/qvTHk7yIDBHGuI1QCGJbCiWEpKaZ6pugEXlvyhJJw58gj6Y3ZJ8hMPBPKRuM3T7zeaNkhfl6spWAZ37cjMYjOAU7jGoDI9775ultZ7f8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757121; c=relaxed/simple;
	bh=/oMtZZTEjPmrbPWUPKOpaY7MnGseHocf6SkvJnLdwIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfy0njo2uqoycUGlrDGoUjQH1jJ9GULvnVWVRDiHGDd6v0zeD7K8UmjZPeP1o7LxhkJY6JS7WhP2Lrr3nAI44MrSDUcko5z2uphSKCF6pCsYFWla3wIs7jV4nw+wgJkeHUMDKapwWKUmjmCY89K25qJhkqTblRpJElaxxwUxABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y+9U8uk0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HFMBjM5oBIXuvpiI96OwRAGHStB87QYETVVCSTeevow=; b=Y+9U8uk08w2HrEhYQzugqitECG
	H5sY/eGNEiiamJBQrzJIof0GtnKQTCYnihq01ekxk4fzPt7gTyJQ9dyYIrSIR/HkC/xdstWQ3GVxB
	YboQ/rSeKMLPXlhUmrBNd0FQ8YIKNzlx9M+vD5TaNEwAKxMiZtx3ifqoww6y4xOjhKo7pvIGlVWeX
	MolFA42p1J86tCQkdRWsOB+rXhL63qa940tGhQAoeVz5Slk2lPPTcC9K1xG8INUjIdMz0rbevZzq0
	jJuWovJgqL2mno8ieYT6mEvWL/AEx3AFtzjhrBXwZ5fmCuPkYsQBWZecmCmfD0LZIYTDm07TdWi3C
	J/jOgrAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52200)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQjwT-000000002S5-1UI2;
	Wed, 03 Dec 2025 10:18:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQjwS-000000008NO-00FO;
	Wed, 03 Dec 2025 10:18:36 +0000
Date: Wed, 3 Dec 2025 10:18:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Message-ID: <aTAOe4c48zyIjVcb@shell.armlinux.org.uk>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130005843.234656-3-marek.vasut@mailbox.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> follows EMI improvement application note Rev. 1.2 for these PHYs.
> 
> The current implementation enables SSC for both RXC and SYSCLK clock
> signals. Introduce new DT property 'realtek,ssc-enable' to enable the
> SSC mode.

Should there be separate properties for CLKOUT SSC enable and RXC SSC
enable?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

