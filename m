Return-Path: <netdev+bounces-232919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC3BC09ED5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56EAA4E2C29
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D134302774;
	Sat, 25 Oct 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lhs6jECY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BD18E1F;
	Sat, 25 Oct 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418555; cv=none; b=m9R1WKD9fiKCPt2WFIchJQNiFTPOojEeVrdN05rO4aoy3VmMlTokLERxFa25BJWM46Mw2r/VfLn2HfPnhzsmpxswLwOGgvyfe/1hHiGFBsJ34lFODT2GUnh2pJWG127eafHqlQ1PSsGRwxYt5LMnQisaaQO1KI6QpGXVmrM8iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418555; c=relaxed/simple;
	bh=QWo/JPySbyxVO3fXTgZc+sw96V/mqwKryKXLIO4f2t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnPMKztS/SMtS49SCXcmTwF22Oky+xN58KXSKigpgAIun33YQ6n4LXeUT/zdioSakSA2uq0lSbEByejOS75G18E8wZBtE2XmWkuoSgwd4gAb/t8/Tj1KkWN6TNbwKtcHM7OtTEdyyztGPWACAvEIDY0JMJ4iN+rohHUJewkju4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lhs6jECY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HTLUk2cykw6OFLMC01Dpv7tO1vfeV3GRVIgXsjbKndY=; b=Lhs6jECYFlVfRfYyszEQDhrJrq
	jg1Fd892lnyCUXfBbncAgp8wNRGa+K8ldAOvSc37+1mY8N7cBmgyoQQX1/dCIrOB/G38Nq1XANWdH
	9n89I6dSINhe4p3iswDnfIyqY+lEtoNcc4u7orw4+361uzqVvZBWfrYXcvTMOQZUU68TG5jHJ9RGa
	ec7DDl0fE3L2ZU5bhxI8HliaGmzWMQBwQA19HDc6jMR8Ek+0Y9BdAsPyBu77ck3xXPNcuwYtytH+5
	PGxQgJeijxXPQVw0Qw9UBYhXquKd1JgewO9wsRX2JQ5ThzwCKvFpUKkizcttlSrXEGbo1cPUI8dcn
	X4K7mrpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42836)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCjQU-000000000JQ-2u3H;
	Sat, 25 Oct 2025 19:55:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCjQS-000000003u4-2n3X;
	Sat, 25 Oct 2025 19:55:40 +0100
Date: Sat, 25 Oct 2025 19:55:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 01/10] net: stmmac: dwmac-socfpga: don't set has_gmac
Message-ID: <aP0dLKF8rXk6gU8j@shell.armlinux.org.uk>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 01:49:53PM +0200, Steffen Trumtrar wrote:
> Instead of setting the has_gmac or has_xgmac fields, let
> stmmac_probe_config_dt()) fill these fields according to the more
> generic compatibles.
> 
> Without setting the has_xgmac/has_gmac field correctly, even basic
> functions will fail, because the register offsets are different.

net-next no longer has these has_xgmac/has_gmac fields. This changed
on 22nd October. Please ensure you test your patches against the
latest tree to which you wish them to be applied.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 354f01184e6cc..7ed125dcc73ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -497,7 +497,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>  	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>  	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
> -	plat_dat->has_gmac = true;
>  
>  	plat_dat->riwt_off = 1;

In net-next, this code currently looks like:

        plat_dat->pcs_init = socfpga_dwmac_pcs_init;
        plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
        plat_dat->select_pcs = socfpga_dwmac_select_pcs;
        plat_dat->core_type = DWMAC_CORE_GMAC;

        plat_dat->riwt_off = 1;

Thus, this patch will not apply to net-next.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

