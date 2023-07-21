Return-Path: <netdev+bounces-19783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DA75C41C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD12821E7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9199318C2D;
	Fri, 21 Jul 2023 10:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378A3234
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4389C433C8;
	Fri, 21 Jul 2023 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689934295;
	bh=k8eV/3qHdnbYgcZI2X9fFCwH8gqs3YzalZZPqB9YJ08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K7zk8MwQYLqclUypLaTrXMCzvlgETP5wEUWYH0H/6hRQCVlJ2XF8oY1b2h0EY0uRn
	 qGH6fUjQz9xO3zkx9Ef4VLHWU8jiD9CtFogqDBwrTdIrA2rlAiF7t0sLqGfWMBJ06N
	 sd+tv+6e6gLU0xZZ7K+kl5RSz3I8Gk1mR36ZRrVUKpER3jHGaJu7uPgtzFJqSbRt9u
	 24aHlOVN+bmSPukO3e79iQUiANVgAdvct/SgdK88yqoVHlphiDOJJjTpODhfz6Z/6e
	 4MoV3J7h8ISpE3hwy0qAl4T2Dm+rguLoiTFK/keQqTv5crxgOCzcqv7SwLKYj6E/vA
	 jd/LUNYKARcLQ==
Message-ID: <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
Date: Fri, 21 Jul 2023 12:11:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Content-Language: en-US
To: Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
 "Ng <boon.khai.ng"@intel.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Boon Khai Ng <boon.khai.ng@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@intel.com>,
 Mun Yew Tham <mun.yew.tham@intel.com>,
 Leong Ching Swee <leong.ching.swee@intel.com>,
 G Thomas Rohan <rohan.g.thomas@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721062617.9810-3-boon.khai.ng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> 
> Currently, VLAN tag stripping is done by software driver in
> stmmac_rx_vlan(). This patch is to Add support for VLAN tag
> stripping by the MAC hardware and MAC drivers to support it.
> This is done by adding rx_hw_vlan() and set_hw_vlan_mode()
> callbacks at stmmac_ops struct which are called from upper
> software layer.
...

>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 23d53ea04b24..bd7f3326a44c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  			plat->flags |= STMMAC_FLAG_TSO_EN;
>  	}
>  
> +	/* Rx VLAN HW Stripping */
> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");

Why? Drop.



Best regards,
Krzysztof


