Return-Path: <netdev+bounces-227442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A971FBAF7BC
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDD16589E
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDA2750ED;
	Wed,  1 Oct 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EwIHvDe2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEC2701B6;
	Wed,  1 Oct 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304934; cv=none; b=HXI2055HzxMq8tynpFIiquVwKyXMzi3rodWJb+Dy6u/RdT0nKCOuOl7yHZclCHfp0TIaNjP0rxzi7FHfq9OX9q/eA7iVcEgCGrBDpMdDOeWrtZcZqaBi/m3IfkJ1ZLK2r3Ts9l1HyM0IcekIMwSV+u1Q0zcBO3O5dRgFzD1Jk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304934; c=relaxed/simple;
	bh=xanXrnd+paLIxbBH8CYU/83eubfWkVKYzJ5W+YVzdvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF60O2ylxxqb8MH1ienPZ6xSUGS7n9cGd2pcWLCCuWMDv+nhVj8hrBUTyXxcQIQf9yV69KKVuEEKUCHTWtOzCMp7QuOgC76wuzqNyTs0m/Pf0AaSgqpjB9ZOuVTTx1cHeOHhtrM6Bu4nTmR6BB/zqhouCqOH6OwAnZmRh3+5s/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EwIHvDe2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yWirnlgUqsih5agjfKLNMjvXyjJWT1GudlldLMjLJAE=; b=EwIHvDe29Y/0FaTlnyxYT5CQfP
	ml164IF5wdv/3j8q8YWcPrwHGW20AGyWUk81CksirHPTMUmDpWSwCdnKgTQgpwTJHQJ3rmbs8kOjG
	YJk8JOGNK3NKp6k8z+j75aCB5paTDJA60bCoHOfI2WMAZMPW3jdoAQeOOaDo5UV8nyCBTtb7Ks+ym
	oaqe6xR4e1Ne+68rElBtwSwCoEwczUHcu90Oc53yaL6aK6V4upb6MU9zdB+Vb0M/L0ucvLp5u1jQu
	P3ufPMZ5kg4ImM/9grAYs3aI76n3ovKFV9ll+jH0qj08I875wEveobVBve+PDGx4H4AVQoxagUO7q
	NM8Uq8Eg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33724)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3rZp-000000000BF-100I;
	Wed, 01 Oct 2025 08:48:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3rZn-000000005JE-3RiQ;
	Wed, 01 Oct 2025 08:48:39 +0100
Date: Wed, 1 Oct 2025 08:48:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <aNzc17ZW56gLX87v@shell.armlinux.org.uk>
References: <20250925191600.3306595-1-wens@kernel.org>
 <20250925191600.3306595-3-wens@kernel.org>
 <20250929180804.3bd18dd9@kernel.org>
 <20250930172022.3a6dd03e@kernel.org>
 <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 01, 2025 at 09:25:07AM +0200, Paolo Abeni wrote:
> On 10/1/25 2:20 AM, Jakub Kicinski wrote:
> > On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
> >> On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
> >>> The Allwinner A523 SoC family has a second Ethernet controller, called
> >>> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> >>> numbering. This controller, according to BSP sources, is fully
> >>> compatible with a slightly newer version of the Synopsys DWMAC core.
> >>> The glue layer around the controller is the same as found around older
> >>> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> >>> this is the second controller on the SoC, the register for the clock
> >>> delay controls is at a different offset. Last, the integration includes
> >>> a dedicated clock gate for the memory bus and the whole thing is put in
> >>> a separately controllable power domain.  
> >>
> >> Hi Andrew, does this look good ?
> >>
> >> thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org
> > 
> > Adding Heiner and Russell, in case Andrew is AFK.
> > 
> > We need an ack from PHY maintainers, the patch seems to be setting
> > delays regardless of the exact RMII mode. I don't know these things..
> 
> The net-next PR is upon us, let's defer even this series to the next cycle.

Would've been nice to have been given the opportunity to respond to
Jakub's email before that decision was made. Not all of us are in
the US timezone. (Jakub's email came in gone 1am my time.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

