Return-Path: <netdev+bounces-237522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0BC4CD16
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07E4425B56
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B72F25F8;
	Tue, 11 Nov 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lpAMrkJk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBD2D130B;
	Tue, 11 Nov 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854550; cv=none; b=JvT2jSS0cRzN3K9W7S9zB6BX81W9A0lu/O2NDERSDrcke5giZWolHjoiD3DG43rQVOw/1SN9zVg0VKUqnUGcoYnAMFI+bOQrWuwhjOiD2+UnUdNaalIQgQwUu9eHHsl2n1bkvLyhEMqaymlI4dmc7AwuUlqE8H24Tpk6eCFCd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854550; c=relaxed/simple;
	bh=nvoWb3cd+VFNoskVX/9UBGBSWxsWZtmu+agDwT9H9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux3SZLCbJqF3LuT63fufpLjQ+wJk0BrsdK4FR8qD05mJQfiJUvy72/Ief5iFHIQcSWD3AQwPTRymx7UNWdsYBLuMvoSwYuFqFx6+7pxRzTmd35JXwB0omAEP8f9sI7YHt3nsrCJFngFTF1lxr3pm8zKCPichlshuCty6S8iGWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lpAMrkJk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3vHk8yv00/JQMYrmI8CKdJho/+2xxViBt86X+AiwkXs=; b=lpAMrkJkFiawgDhsUd7cK2vYGW
	HHuZnAakrmemk6S3lWl3WIxalRsV0Fxr6TsaMz743ajjVlUUk8WVJAXlPVJ4cjEayDYBDB8DFO2k+
	/t83snfNII/EsKt1zpPpqhB/UFTr86lPP433nbohp8PheXFfoQl1QMn3iLbIrURUN5rocusBJH1A+
	C+ab8nwdr5Z4uc1LqBrHaDwvLLGqT+flXKWN+gz9/A7udKvpVzW8CPyhMcxtUbETtgDIRnBzM0A0+
	E4sH7O377i+vT70DtUZvs6qJcZ2e7vHFUNY0l4ir1hy3qP+eKy5+rp/RbEZjUVLbfU21f0q3LsfEV
	d4kkO1rA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43662)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vIkzh-000000002It-12u1;
	Tue, 11 Nov 2025 09:48:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vIkzd-000000002qb-21yZ;
	Tue, 11 Nov 2025 09:48:53 +0000
Date: Tue, 11 Nov 2025 09:48:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: Disable EEE RX clock stop when
 VLAN is enabled
Message-ID: <aRMGhXohIK5swFSM@shell.armlinux.org.uk>
References: <20251111093000.58094-1-ovidiu.panait.rb@renesas.com>
 <20251111093000.58094-3-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111093000.58094-3-ovidiu.panait.rb@renesas.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 11, 2025 at 09:30:00AM +0000, Ovidiu Panait wrote:
> On the Renesas RZ/V2H EVK platform, where the stmmac MAC is connected to a
> Microchip KSZ9131RNXI PHY, creating or deleting VLAN interfaces may fail
> with timeouts:
> 
>     # ip link add link end1 name end1.5 type vlan id 5
>     15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>     RTNETLINK answers: Device or resource busy
> 
> Disabling EEE at runtime avoids the problem:
> 
>     # ethtool --set-eee end1 eee off
>     # ip link add link end1 name end1.5 type vlan id 5
>     # ip link del end1.5
> 
> The stmmac hardware requires the receive clock to be running when writing
> certain registers, such as those used for MAC address configuration or
> VLAN filtering. However, by default the driver enables Energy Efficient
> Ethernet (EEE) and allows the PHY to stop the receive clock when the link
> is idle. As a result, the RX clock might be stopped when attempting to
> access these registers, leading to timeouts and other issues.
> 
> Commit dd557266cf5fb ("net: stmmac: block PHY RXC clock-stop")
> addressed this issue for most register accesses by wrapping them in
> phylink_rx_clk_stop_block()/phylink_rx_clk_stop_unblock() calls.
> However, VLAN add/delete operations may be invoked with bottom halves
> disabled, where sleeping is not allowed, so using these helpers is not
> possible.
> 
> Therefore, to fix this, disable the RX clock stop feature in the phylink
> configuration if VLAN features are set. This ensures the RX clock remains
> active and register accesses succeed during VLAN operations.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Thanks for the patch. I guess there is no other way around this, since
as I've previously noted (and as you say above) we can't sleep in the
VLAN ops to access the PHY.

I would like a comment in the code above this if() to state that EEE
RX clock stop is disabled to allow access to VLAN registers to work.
With that added, please add:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

