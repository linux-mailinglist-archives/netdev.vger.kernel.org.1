Return-Path: <netdev+bounces-216009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF9B3176F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF18CAE372B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770592FD7A3;
	Fri, 22 Aug 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LAYLKyig"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB642FCBE8;
	Fri, 22 Aug 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864878; cv=none; b=XSmABL5myv7s38wSVti8Qud9hQuFFyU6CzQhb6tOWXGBI2Nc1rDiL73VXua1ooXcR2CgdD6893v/rZXN18PyuynjmEasa5w4MydBb4IwLS5DXm9tPW/mCu6gCS7cegJCdEqhTULGsDC+fD+ubnNyM25jEzVhn5tU0AYpTWBC5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864878; c=relaxed/simple;
	bh=xUzCqw8G2JO1bhdytol3kfokW1GSmJ1/SVm3V50NR/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XexFkd716uxhmHVoM1gfIUfTJeJPuLpCA8HMmgzKuwGQPjE5e9zQ8QqLEOPa/vYxnHTwlHZpFXtbJ4funFZdwzSZR23XICEOK/7/rHS8uFOk64OQ/+RxtDqhbApdJqCwWp0dVPmuiqfybHVKlkCdipwi4S63oehAKTudC7peQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LAYLKyig; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755864877; x=1787400877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xUzCqw8G2JO1bhdytol3kfokW1GSmJ1/SVm3V50NR/g=;
  b=LAYLKyigeTTjvC34kfVLH4i9EbjGdZko/yCTxg1NLSTWxnkwbLhDiE96
   rmkCYHU/6nsb7XlRJnUDre2RKyLvmCf/L/XMzgYpDLIrYM//xkSVmVuHc
   Y5hsB5F82+Y4aO6KeFxCY1IO7d1jde/3HCYdU2XTLt42UrCpZFo+/nKqe
   W8nY5a/XEKcHulou0s5FEeubJXT4igk4KLqKBfn3gnkz7bqlsYSuBqWnA
   o+D7gIt0T2o270kI0uTklHUXCvVI6bBz5gYsvbZ0N1jmRA7ySmsQcO89P
   GPJwsKEe0l9CLNfN4B81cg1bvgj3VKqv5NZFks7U9pcTPgmlKtQTChsG2
   w==;
X-CSE-ConnectionGUID: UKvKOVZXRqugqNL71FaA+g==
X-CSE-MsgGUID: /uRisEj6RXar0b2HQ8WGoQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45527384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 05:14:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 05:13:59 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 22 Aug 2025 05:13:55 -0700
Message-ID: <364fadbd-20fd-4f89-8a86-ed5b8d87ab42@microchip.com>
Date: Fri, 22 Aug 2025 14:13:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
To: Stanimir Varbanov <svarbanov@suse.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
	<jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250822093440.53941-4-svarbanov@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 at 11:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 36717e7e5811..260fdac46f4b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5135,6 +5135,17 @@ static const struct macb_config versal_config = {
>          .usrio = &macb_default_usrio,
>   };
> 
> +static const struct macb_config raspberrypi_rp1_config = {
> +       .caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
> +               MACB_CAPS_JUMBO |
> +               MACB_CAPS_GEM_HAS_PTP,
> +       .dma_burst_length = 16,
> +       .clk_init = macb_clk_init,
> +       .init = macb_init,
> +       .usrio = &macb_default_usrio,
> +       .jumbo_max_len = 10240,
> +};
> +
>   static const struct of_device_id macb_dt_ids[] = {
>          { .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
>          { .compatible = "cdns,macb" },
> @@ -5155,6 +5166,7 @@ static const struct of_device_id macb_dt_ids[] = {
>          { .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
>          { .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
>          { .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
> +       { .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
>          { .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
>          { .compatible = "xlnx,zynq-gem", .data = &zynq_config },
>          { .compatible = "xlnx,versal-gem", .data = &versal_config},
> --
> 2.47.0
> 


