Return-Path: <netdev+bounces-175276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66CA64BFB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002253A5616
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DE2356A8;
	Mon, 17 Mar 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L3ANOjmC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2681459F7;
	Mon, 17 Mar 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209791; cv=none; b=ZlPyjiFsyJ6+LviQmDiugj1vJ7KIhGweb29pj1j2E+8OLAonOSkzfnQoNdmb0oOyr/68S6UHHT2i+/HvdmOCCInCNlxhQ5vx4YrB0vqkl+Hogl0luCpupuelDcau7458jsWA7dSQxBCOPxYYyH35v9vAwIGaPf/HK7i8exJvXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209791; c=relaxed/simple;
	bh=k/BM4FwwagS7ER/y5fUKx6y06iSE8U8+RTLffCOxvAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeYx+bCEPOhWY2Oa2sbdHsvrVwD8gnAc/1AeNk9xm/AP3ku4r5VW3B/ozehPf2tSCbCoVUcze/jV7zCUPskzFA0U5K4iZhjCu5uCHeYgincikaSjJU/0qnHDKaz3Sym1tffD7JIWYjCpjlPGl0TskD8zV2mrDZ1PF7t/vZXEN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L3ANOjmC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CucQxAMz4q00rKoqMFkXW/rTlFZs/81VWM2dWuS9iPE=; b=L3ANOjmC4JYjNEDTGSFlYSj+EY
	lDMUKIAPuul1T4GUZ6puKUkV8BzHq5WJJG6+uQGshRelm43SbzWOXlnmp3+t9vl5U/CCIqrkoFocf
	0CLTtY4lXl6Aov3FiPFUso512czcMF1HO/Kfq/XAlzRMnW/HXJL2jAIjFrAL1OAvRukC77bqdyIAv
	vnzXTJERSI/rnvJZYtJBQUhNFNs9z9CSA7BH9VOZ2jnPlNjMcvT0nKfMAOf3fOK49uAvKalEejjFu
	SziT/8P/6JFZWVLYKFbO8dKi4HTjASat0y9ujjRXOzcAOdpA22UH87wRqpGq1Z7yFEyP30SG71LHf
	YJq6KtAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59148)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu8LT-0003PO-0x;
	Mon, 17 Mar 2025 11:09:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu8LL-0003W9-0k;
	Mon, 17 Mar 2025 11:09:15 +0000
Date: Mon, 17 Mar 2025 11:09:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	ratbert@faraday-tech.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	BMC-SW@aspeedtech.com
Subject: Re: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Message-ID: <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317095229.6f8754dd@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 09:53:33AM +0100, Maxime Chevallier wrote:
> So this goes completely against the naming of the property. It has the
> -ps suffix, so you would expect to have picoseconds values passed, and
> not an arbiraty index.
> 
> Take a look at other drivers, you should accept picseconds values from
> these properties, then compute the relevant index in the driver. That
> index should be something internal to your driver.
> 
> An example here :
> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c#L51

Another example would be drivers/net/phy/adin.c::adin_get_reg_value()
and associated functions - these lookup a DT property and then look
that up in a table to convert it to a register value.

I suspect that's something which could become generic, as I suspect
most hardware isn't going to accept a picosecond value, but be a
choice of N different options.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

