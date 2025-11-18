Return-Path: <netdev+bounces-239570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C773C69CBC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E093357DBC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46CA364E97;
	Tue, 18 Nov 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RHkFEYAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CE363C7C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474384; cv=none; b=ksIcU3qM5ew3gL2LRx2YgUQagfTGscRfcofBQNO4zS/TA2atF9GJZzAPPtUE5vKlXTgg82hNj6nhf4i/fEEqqbPsCy+e+nprmTG8cfekkPJh8XuvWCBKq3pkz8uO1b2SJmq8E4TSO+6XdDWFL16jkQWgpTfHCTtwDDh9SmA7k4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474384; c=relaxed/simple;
	bh=PyOst1SC86ljxaXdW45eJHmE93G73hJanf6ER/E/UBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuTQcFg+/gX8AdVN7KDlxxtkHC32VYr9yXEukCZKAbbyHWEImC2qloRtRW+jCp13HJs03yuBczXRk8PupNx/njjSzxulqAGRU0SALbzP2uVqNxHshPtegWdDmNFB6m3/rzUQwQWFH20NpRGKlFOBGtRRNxbz5pQG11MS7hZ8ts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RHkFEYAg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7E4891A1B86;
	Tue, 18 Nov 2025 13:59:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C183606FE;
	Tue, 18 Nov 2025 13:59:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC53E10371DD3;
	Tue, 18 Nov 2025 14:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763474378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MLKf1QB8zzifyWM44fyRAxO5E+WCOo3I8lg4wmBAeoM=;
	b=RHkFEYAgyvVY3y1++cyuIhzJKbhWpST/loRXeeznyalkCTe1lwAelo6gzFkKb9dYN7mMOM
	TSsAHdZy9s7j1/t9e8LMYeBqkViUbelLRJiaAboYCgeYZeqe7OpZCVu8QEnnpEakFEkr+v
	FlJFNKN5x5mCPTHY0RHqx36K6wL5E5dnD1KeItl0tAe2hTFZOwtdD0EOEH5umBO59V9xtm
	/HQM74ZMXuLLNPG9rWEJZ2O7XVLF9FGfHagICoxkB2yme2HA4OaS+X4l0Kf9/56WoJLoEd
	icnAGgfTMmTKtgMe9ijDg8HvL5D8n1T03/3iLb0GX+7mthKc6S+LrqUKIBcTKQ==
Message-ID: <a1f1ad21-fb73-4f30-b428-8cec5ff53ed6@bootlin.com>
Date: Tue, 18 Nov 2025 14:59:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: stmmac_is_jumbo_frm() len
 should be unsigned
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
 <E1vLIWR-0000000Ewkf-1Tdx@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vLIWR-0000000Ewkf-1Tdx@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 18/11/2025 11:01, Russell King (Oracle) wrote:
> stmmac_is_jumbo_frm() and the is_jumbo_frm() methods take skb->len
> which is an unsigned int. Avoid an implicit cast to "int" via the
> method parameter and then incorrectly doing signed comparisons on
> this unsigned value.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> index fb55efd52240..d14b56e5ed40 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -83,7 +83,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  	return entry;
>  }
>  
> -static unsigned int is_jumbo_frm(int len, int enh_desc)
> +static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
>  {
>  	unsigned int ret = 0;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index d359722100fa..4953e0fab547 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -541,7 +541,7 @@ struct stmmac_rx_queue;
>  struct stmmac_mode_ops {
>  	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
>  		      unsigned int extend_desc);
> -	unsigned int (*is_jumbo_frm) (int len, int ehn_desc);
> +	unsigned int (*is_jumbo_frm)(unsigned int len, int ehn_desc);
>  	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  			 int csum);
>  	int (*set_16kib_bfsize)(int mtu);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> index d218412ca832..039903c424df 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> @@ -91,7 +91,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  	return entry;
>  }
>  
> -static unsigned int is_jumbo_frm(int len, int enh_desc)
> +static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
>  {
>  	unsigned int ret = 0;
>  


