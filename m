Return-Path: <netdev+bounces-229896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E160BE1EB0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14B819A7DAF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CB2E36FB;
	Thu, 16 Oct 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QlSiy2z8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95711F418D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599606; cv=none; b=P3miipNlJGOoElkQIG+tTSyAunZ2vaG3rHoNY+nP51Cx2ec1gtPnLqShHTDEY2adO6gSQ7Uz15eCMkMeJl0sEjdd6cAj7Q+xX3KhBKILyPB3vVg0GtcVmJy3fWaM4RLtfK86SUEbIvc3yBc7JnLaCUxK35XAIQ4jx8R/4hr1IqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599606; c=relaxed/simple;
	bh=FdnU0bUtqoiG8wDqJtGF9hoDSQK6s5bLSWcW7AYXfgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L04My3xTsH3trLwH8wvHsmJCWp8aH84mseWqfN0bVehbtOqNaESiOgxQ/R8vT025aCyVHfsOZ51bi1GJmAJLCc8phcqgznMSDajBvN7DLpUsx1cr1n/jZG2mKMTFtzaJSBpj8EtUu8PD1lzTZWJhlPYA+cL47G3atZ+b3X3T9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QlSiy2z8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 753A21A1410;
	Thu, 16 Oct 2025 07:26:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B5756062C;
	Thu, 16 Oct 2025 07:26:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9147102F22ED;
	Thu, 16 Oct 2025 09:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760599602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SBvdFAlAi23UDp3ojHH2j4S4dE5DaAIeZoZagXYkEwU=;
	b=QlSiy2z8FRbylqOI5JK31H//tfXjG/m01GHMyopNZlnia8d5wYZsewwrDedc6gWliys3sD
	fPp9GCSSMoYnaNXpyLh4QGjRtXi+Xh5+wJt7lVcVzqwl8RWLVPl48qr1W33bQKcOhOVTZI
	MEqRyJLTHnIkLNsIeUHRYbPdmrK8GacEkBhl4nya5LTbR2fA0Gm7svxipgvANudElIDPK/
	D3n1zzDLOjzaxAjjHSfiUs7sbDthr9Bky7itfhnWsNmM7uVahnT1406L8rFXmZJy/hPFmo
	/EDz/QY7ov/lpSajdxtCVMSsM0tvCJs6G/Aez1kJyQN9vGqwd4C7t561HNTmCw==
Message-ID: <f78a625f-9138-41fe-827e-fe2e830a18b9@bootlin.com>
Date: Thu, 16 Oct 2025 09:26:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: stmmac: rename stmmac_phy_setup() to
 include phylink
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945d-0000000Ameh-3Bs7@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v945d-0000000Ameh-3Bs7@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 15/10/2025 18:11, Russell King (Oracle) wrote:
> stmmac_phy_setup() does not set up any PHY, but does setup phylink.
> Rename this function to stmmac_phylink_setup() to reflect more what
> it is doing.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 500cfd19e6b5..c9fa965c8566 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1185,7 +1185,7 @@ static int stmmac_init_phy(struct net_device *dev)
>  	return 0;
>  }
>  
> -static int stmmac_phy_setup(struct stmmac_priv *priv)
> +static int stmmac_phylink_setup(struct stmmac_priv *priv)
>  {
>  	struct stmmac_mdio_bus_data *mdio_bus_data;
>  	struct phylink_config *config;
> @@ -7642,7 +7642,7 @@ int stmmac_dvr_probe(struct device *device,
>  	if (ret)
>  		goto error_pcs_setup;
>  
> -	ret = stmmac_phy_setup(priv);
> +	ret = stmmac_phylink_setup(priv);
>  	if (ret) {
>  		netdev_err(ndev, "failed to setup phy (%d)\n", ret);
>  		goto error_phy_setup;


