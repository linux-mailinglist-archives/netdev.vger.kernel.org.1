Return-Path: <netdev+bounces-176713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88089A6B8EF
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2863B6B47
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED521C9EE;
	Fri, 21 Mar 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GGV8D1vt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6251F2BA7;
	Fri, 21 Mar 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553644; cv=none; b=jekqsqWrzsGrhwJopUfcAA/uEX6rShPg14bcxtJq+3nZ+Bcy957srVp480nxd8eKFA6Kal0yhPOqI8MfRVBr1GPyNqoLI77wZoDioVVTGlUaWLiYlVuoF3MKvE3mUT+h8CdVIqrAEL/NRYaDaVqscg6bW/64ngAhCfoGtoSOu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553644; c=relaxed/simple;
	bh=HuRp+OgfKMnOdWEmJ1aMEoPxU4od8JYcXA6lcrR/l1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcxxVNKKx75lCiW8kBVDM4fps/RUqY791RWXj+V8DoHHjJ9R2WV4fV/t9GVFC5ukYDKgs3YF/h6zb2du8by1eebA6YPpunsgxONRPxk/B5QB4Ie0DUc2GoAHqfJ/RudwtKAT9Oqn9xs4yhG4I0YPFPGiWgdg4mc2dChK8Wx0MeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GGV8D1vt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w0LKCPTWLqOz0v0nFE+m771YyCcWhP2oMeKQU76uMec=; b=GGV8D1vtw9RNsDDh0sGL/X/tYv
	usnovAyelwqv0yDopXgbrW6cYz0L5Bs2S/E+Jvo0w1H4nbClisHkcSex6ceeD2aFDLNUM89EsFqwQ
	SshPS4xhujhu9WQoDE4SPoLqgs439O+PNOqOi52YnQPZdANuRf0qw/qYJMCBFJl7PqhOVA8r8h6Fo
	U2dF4m6s2JfRh4TID8XKCVac42mgFPDV5+Lhfn9BHz81vR+Cavkl29IrFUlVaC8MV5muLolcvTdiU
	j7bMAEnNwvpO/teQRE1uVsJcENho2xqr1OFywzPafJ2+6938uJNVoqeSkquEb4KH/rXI7cy/9FFvz
	J4VVLEeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53034)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tvZnm-0000S9-0C;
	Fri, 21 Mar 2025 10:40:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tvZni-0007aA-1A;
	Fri, 21 Mar 2025 10:40:30 +0000
Date: Fri, 21 Mar 2025 10:40:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Simon Horman <horms@kernel.org>, alexis.lothore@bootlin.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: Call xpcs_config_eee_mult_fact()
 only when xpcs is present
Message-ID: <Z91CHjqVc0-BmTPX@shell.armlinux.org.uk>
References: <20250321103502.1303539-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321103502.1303539-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 21, 2025 at 11:35:01AM +0100, Maxime Chevallier wrote:
> Some dwmac variants such as dwmac_socfpga don't use xpcs but lynx_pcs.
> 
> Don't call xpcs_config_eee_mult_fact() in this case, as this causes a
> crash at init :
> 
>  Unable to handle kernel NULL pointer dereference at virtual address 00000039 when write
> 
>  [...]
> 
>  Call trace:
>   xpcs_config_eee_mult_fact from stmmac_pcs_setup+0x40/0x10c
>   stmmac_pcs_setup from stmmac_dvr_probe+0xc0c/0x1244
>   stmmac_dvr_probe from socfpga_dwmac_probe+0x130/0x1bc
>   socfpga_dwmac_probe from platform_probe+0x5c/0xb0
> 
> Fixes: 060fb27060e8 ("net: stmmac: call xpcs_config_eee_mult_fact()")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Yes, I had noticed that but haven't had time to patch it, so thanks for
submitting the patch. However, I think the code structure could be
better in this function. Let's get the bug fixed, so:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

