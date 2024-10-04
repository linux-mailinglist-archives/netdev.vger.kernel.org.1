Return-Path: <netdev+bounces-132089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04919905D5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764691F2265C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949C215F48;
	Fri,  4 Oct 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NYXJ1CQU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDC2139DA;
	Fri,  4 Oct 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051569; cv=none; b=EQKFi08Tp9BGDknDzTSESYofLrRlfXwdxg/6l/hORJ5gleZ/pBy0usWjIZ5c+xKhGp2/NfSoaCz8ybWtZhrOF5HvClUGod5UDfr1JTh/IZuLUu1mYUZuA00QjCJtFXHwhjHWPLC8Wkt291iIkrfrZMak9N8yBIsAu6OCrFZiYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051569; c=relaxed/simple;
	bh=2BLWGkCi9IuXDLYDzEKfW7ieDXxkrD9eyPr/svUeaL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nzCqEbPMy9wnjGYHH5loNeVHRrCvWA7v04L9HQgPD/v4qzEKTZ0yU8N4VDgMShPjbX476Bv0lhlZbo4U9n0y49bCL1584VGhKgJM50VoztRzknosa+KEwvhozHTmNRSPPQleaqu7xjdzNHH2bfCjeE59F2b4pG/Na1R8x8ou5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NYXJ1CQU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728051567; x=1759587567;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2BLWGkCi9IuXDLYDzEKfW7ieDXxkrD9eyPr/svUeaL4=;
  b=NYXJ1CQUeZDU3bmeoPXRXpH4wXSUC8X99arGiXJf+KuX5n+Z2sD4h4vP
   TUlIajcdAxtaadOzT/WqI/cb1sjnldjeh2avnhQSrw8Eel5nlMehbkx7h
   kTjWnNDqA6M28eve1v2IAOyTmHlqHzeLEvfCayMkvHc1yR9TxC5/L/CBr
   yoNGmpoYGZj3Xuc9Q4ftBHPoMc4E7CMm3qVqUqitvdr5tfjsdJkJc37tT
   aMRAPqo5IJC8UYMQC7mWvjZSjguShhuIAcrUXqlit4UdVaEe/Mh+wGwk/
   d17CC4El9K/ds271qVSSQg7mr9pndz1Gb0Sl/QriD3We08DWxxYzp5Y/i
   A==;
X-CSE-ConnectionGUID: gI4jLvESQWmk89b6me/PGQ==
X-CSE-MsgGUID: NwJtQ0+/RNGly4b7rAsyww==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35905329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 07:19:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 07:19:03 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 4 Oct 2024 07:19:01 -0700
Message-ID: <1cba974d-492e-49f0-8d43-1a75672861d0@microchip.com>
Date: Fri, 4 Oct 2024 16:19:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: macb: Adding support for Jumbo Frames up to
 10240 Bytes in SAMA5D2
Content-Language: en-US, fr-FR
To: Aleksander Jan Bajkowski <olek2@wp.pl>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
References: <20241003171941.8814-1-olek2@wp.pl>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241003171941.8814-1-olek2@wp.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2024 at 19:19, Aleksander Jan Bajkowski wrote:
> As per the SAMA5D2 device specification it supports Jumbo frames.
> But the suggested flag and length of bytes it supports was not updated
> in this driver config_structure.
> The maximum jumbo frames the device supports:
> 10240 bytes as per the device spec.
> 
> While changing the MTU value greater than 1500, it threw error:
> sudo ifconfig eth1 mtu 9000
> SIOCSIFMTU: Invalid argument
> 
> Add this support to driver so that it works as expected and designed.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Looks good indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f06babec04a0..9fda16557509 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4841,10 +4841,11 @@ static const struct macb_config pc302gem_config = {
>   };
> 
>   static const struct macb_config sama5d2_config = {
> -       .caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
> +       .caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
>          .dma_burst_length = 16,
>          .clk_init = macb_clk_init,
>          .init = macb_init,
> +       .jumbo_max_len = 10240,
>          .usrio = &macb_default_usrio,
>   };
> 
> --
> 2.39.5
> 


