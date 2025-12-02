Return-Path: <netdev+bounces-243317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4475C9CEC1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D084E35DD
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F721883E;
	Tue,  2 Dec 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zdDYvJom"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DC1FDA
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707548; cv=none; b=odVhxeXAfKrk0T8H/vuXEx0qgoSS+6aD8G3FhTIFgMl8X/gugFPp6yYf88qUwWLxyLjE1mYSftRwmhphT2DxC9N94Bnoa9Bb0OqTpaF13adbYcSwysvKAoOj0jcH+LXgSC8X2mmN4xEf9DxFgC8PzsXAUi1DGR2a0gxI0789Cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707548; c=relaxed/simple;
	bh=WjspXl7HEg9q/THVVdOV7LNbA0y096rUMLctKF/UW08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcncQRxRVbMFcveh4R0O2+LCmq/21C5u/KlY4RJi9EjzQUdeIVGIjrg9wsvqBsRE9/cgpTDgOPwKkr6AYJ/NEJL097VCEZHhLWBkQ/g7CGuAjDcMb1gi8azJIilDpmiir1N/DwZWrl21s9hC3Toe9P6pLPiGSv7XvDb3XGMAFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zdDYvJom; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dcYsF+quRHg2DIz2ljYwCa1orSYm0Ipf/kraC4Z+q68=; b=zdDYvJomwpVMZbRjiYX98M9JlC
	S7aP7/EbHtdcwt3CMAM3BxruV3WkpMxYd/nci46HIqAvR50jaQl0+c39e6GNlKlN81C6cHlzTbkAI
	BB7LbM6fLCqJtkvjp2FCaEzDL9OlKiBJsOdw0zUDfFxu5AtbiIHKZCNqJy/9ftDNJANI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQX2Q-00FjfV-2O; Tue, 02 Dec 2025 21:31:54 +0100
Date: Tue, 2 Dec 2025 21:31:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 01/15] net: stmmac: rk: add GMAC_CLK_xx
 constants, simplify RGMII definitions
Message-ID: <b732b6fd-0e69-459b-8337-ba60f5a56d47@lunn.ch>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <E1vQ5El-0000000GNvU-2sXL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vQ5El-0000000GNvU-2sXL@rmk-PC.armlinux.org.uk>

On Mon, Dec 01, 2025 at 02:50:47PM +0000, Russell King (Oracle) wrote:
> All the definitions of the RGMII related xxx_GMAC_CLK_xxx definitions
> use the same field values to select the clock rate. Provide common
> defintions for these field values, passing them in to a single macro
> for each variant that generates the appropriate values for the speed
> register.
> 
> No change to produced code on aarch64.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

