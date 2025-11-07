Return-Path: <netdev+bounces-236779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5BDC401AE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4944EFE54
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B62DC76A;
	Fri,  7 Nov 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RuRWa6r0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3C2DCBF7
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522028; cv=none; b=rMw3lS3QjatGBgKdbUNvAMu0eNUycJSmmWdlK3iGlcniTJ4mkn859pbKsmdeGMaccGY5TrTxmmj5gC+wifLtlrAHcnsWjLJpq/fKHz1Vl2jAOpoamMR79t9VxyWRvvbnn//q99lXgOET8EKonaMJNDIkmS80C5+EasFnJfIZACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522028; c=relaxed/simple;
	bh=ggiLc3LlQ7lbR3z3zNcYhEBwmCAkHGIafHeVgYQPRTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntkEgjFRFLzIA956c3sdIkYitRv1ZzO645XJ6jbgXWMf/Noq29otmPHXZs5hx7LmJSy5EFydni4EfISjRTVVpFu0r8uqtdmTtKO6RUu+MvAZ6E9H1aXnBIyyrcDnSZKmo9vCLbws0U8l1BQKLigubo0X210eFo7ziroicL6AuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RuRWa6r0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0TlTDYtiaJ9miWBMsHG0UIX4wj2i6JSLkx+62UAG9Os=; b=RuRWa6r0yM+xgROPsTVfxzptWL
	q4VL6pg+040m145rQBtJjONpAUV0GjxW09thiJaxYTN/Tonj2FQA1LeoLSh1nAHzFjoqiCXeR6md0
	x8LkSHQOMO9xFgDeJt3k9WB4CoKER40H2zSca2HN8DxAPZdi7xjlBBn2Lij4sh1D4W2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMUa-00DEFs-Au; Fri, 07 Nov 2025 14:27:04 +0100
Date: Fri, 7 Nov 2025 14:27:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 1/6] net: phy: realtek: create
 rtl8211f_config_rgmii_delay()
Message-ID: <02ad7418-7043-4968-b34a-6fa9142e85ea@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107110817.324389-2-vladimir.oltean@nxp.com>

On Fri, Nov 07, 2025 at 01:08:12PM +0200, Vladimir Oltean wrote:
> The control flow in rtl8211f_config_init() has some pitfalls which were
> probably unintended. Specifically it has an early return:
> 
> 	switch (phydev->interface) {
> 	...
> 	default: /* the rest of the modes imply leaving delay as is. */
> 		return 0;
> 	}
> 
> which exits the entire config_init() function. This means it also skips
> doing things such as disabling CLKOUT or disabling PHY-mode EEE.
> 
> For the RTL8211FS, which uses PHY_INTERFACE_MODE_SGMII, this might be a
> problem. However, I don't know that it is, so there is no Fixes: tag.
> The issue was observed through code inspection.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Pulling this out into a helper makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

