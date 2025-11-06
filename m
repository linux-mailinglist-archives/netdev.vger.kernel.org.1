Return-Path: <netdev+bounces-236235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD1C3A071
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EF6427899
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D431195A;
	Thu,  6 Nov 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WGba7Ffj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7C310629
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422813; cv=none; b=f+Me3NZpWwkaSy+tcJj4blfkzIRzJVy0DFOVLjQsmQrA1AcZu0kgmTZxpuAi8YW8VTXmsx1lLsdyQqCflXJ3e3ceZ/LU16ZrXZddCyEMs1HHTPZtvfXs/52wKR4yPFMP5Zj4YjVUZdUtv25Cak5PP0pj30KSRelCIkx/kEgaafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422813; c=relaxed/simple;
	bh=I3zN3TBM3qAvo4qgaPWGxq8KleSPc4yoMhbYwYHdSbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abTzcAm6a8syYGSUr9vgW/EMMJGbmvE7603+EJ1rwC1aRkQyRi+jwfH9FF5qkcVVwrzhaDRUI+GkUIn6dCGlSkntOSuwU6MysNNwbCpNJxpHkVdaJpu5zPt2xpAlBiYPbC5JKKrUyvtP+HWpybJCPT9Qu8KkTNHlXy+y4eUGLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WGba7Ffj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C25D11A18F0;
	Thu,  6 Nov 2025 09:53:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 989D86068C;
	Thu,  6 Nov 2025 09:53:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2733811850340;
	Thu,  6 Nov 2025 10:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762422808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pw5SlnDVGg7XnK8uA3BZSl59TvohLK7BdiQD5CmzpRU=;
	b=WGba7FfjxUihzh5NJ092gkGULz4A3iRfaOMgrATtvO0V+mEdHkt5mu5RcaVNdbwVCdzchD
	YTSbI5Z5C+q7DSadJT5kMyAlLaBj+IGJfrMEb1JnpFktZA/AtG/q8OkLKNcotGflqsCylO
	V/y/y9Cdr6wOAc7xpgqUs00jLgfnp/14Pk6bFZ49b7AMras6N1mnEVkyhu9iLsi+fMsRkd
	ACIDLypulDjblLVtCvGMeVNaDyDHtZBu25DYTzIGxP+ipFsrGBdrDP4OaTVQ9gX640P3hX
	BlyG0qWrvXF9UcrHrYBDuz8NJKhROBbJcwIfLHxubyfeqHwhwZsRHdBjZTVw3w==
Message-ID: <bc412e39-7286-426d-924b-49989434b9bb@bootlin.com>
Date: Thu, 6 Nov 2025 10:53:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] net: stmmac: ingenic: use PHY_INTF_SEL_xxx
 to select PHY interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
 <E1vGdWp-0000000Clna-18SE@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGdWp-0000000Clna-18SE@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 05/11/2025 14:26, Russell King (Oracle) wrote:
> Use the common dwmac definitions for the PHY interface selection field.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index c6c82f277f62..5de2bd984d34 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -35,10 +35,10 @@
>  #define MACPHYC_RX_DELAY_MASK		GENMASK(10, 4)
>  #define MACPHYC_SOFT_RST_MASK		GENMASK(3, 3)
>  #define MACPHYC_PHY_INFT_MASK		GENMASK(2, 0)
> -#define MACPHYC_PHY_INFT_RMII		0x4
> -#define MACPHYC_PHY_INFT_RGMII		0x1
> -#define MACPHYC_PHY_INFT_GMII		0x0
> -#define MACPHYC_PHY_INFT_MII		0x0
> +#define MACPHYC_PHY_INFT_RMII		PHY_INTF_SEL_RMII
> +#define MACPHYC_PHY_INFT_RGMII		PHY_INTF_SEL_RGMII
> +#define MACPHYC_PHY_INFT_GMII		PHY_INTF_SEL_GMII_MII
> +#define MACPHYC_PHY_INFT_MII		PHY_INTF_SEL_GMII_MII
>  
>  #define MACPHYC_TX_DELAY_PS_MAX		2496
>  #define MACPHYC_TX_DELAY_PS_MIN		20


