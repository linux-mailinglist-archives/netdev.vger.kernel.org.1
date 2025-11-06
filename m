Return-Path: <netdev+bounces-236240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20EC3A105
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626733AE497
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E32DE200;
	Thu,  6 Nov 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3IcTBqO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1B1EF36E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423192; cv=none; b=E2MurQco9sb5vkOOYq92jtVK2T+cU7EQGtLHYN1jZX5bg1kCEg3UaSAVy17acZ8vU9kX2op6DnTiSdailIZAtGjdV4MHUSBkXhd3z5A6LhROny80KekGVRNdwDYuXbfYziEMzQgIhqg7QmRZzHiAT6PvzkntCLJoYGrvVYPTaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423192; c=relaxed/simple;
	bh=4nEQz26rAh10n5fbBdyVIwwOaqWQstlSPf9u4VyC0Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4M4ftBYPDGOJTzHFo2yJDSIQGHhCqsxv/SMRypLwU3cXCY+Mepy5y79GhcInr3CZ209a6ecrRNlbsXPMS2x5kNAGQO8+IuAV1a5BPkBw8us7nXJ5aHYegTyxTDFZ+zcegLWi9d9EzHkW/7n7TF5X13HLOaQsSiRXRMQJGUUGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3IcTBqO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3D5364E41562;
	Thu,  6 Nov 2025 09:59:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CDCD6068C;
	Thu,  6 Nov 2025 09:59:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12B131185084B;
	Thu,  6 Nov 2025 10:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sjkbsLOk1J1qbLCFsYmPb8UirWX2oJ8irk9dUQoB4+U=;
	b=B3IcTBqO/gW+Sgfrc4K+C+Ppa0WmthcAcwmEc8d/tYlh16a9N864/hF+pdvPZ6OFLuq/Ka
	EqH+nU0tmFWYA3tXH7EMnUkdrzDEuWdnYSSp+4+Il2ZZ40C6US3YIEgwVGYekStUM2sLch
	Ie02IvL8iVR3iZflib2CttF3wnYu21CPxeqrpDFEE4AKLS7vvN7xAWEyQO7Xthungwk0+3
	G/vK72aetJmuX5n4MUPRtGLecgnthw0ckfhEyhTzJ5GfLd4oLYfxEom0CILmd/Lg89wAE2
	lldxPxFZd8ucyFh88orHbZfNfmEXEKC0p2yjG+rARrta4IfmkAqvmbTMbihvfQ==
Message-ID: <79e02a0f-b426-40a6-8927-cf029d72e7fd@bootlin.com>
Date: Thu, 6 Nov 2025 10:59:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/11] net: stmmac: ingenic: use
 PHY_INTF_SEL_xxx to select PHY interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <E1vGvoA-0000000DWoV-064n@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <E1vGvoA-0000000DWoV-064n@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:57, Russell King (Oracle) wrote:
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


