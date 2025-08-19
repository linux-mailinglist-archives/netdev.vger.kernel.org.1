Return-Path: <netdev+bounces-214908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579EAB2BBE3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136703A8988
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40C21254C;
	Tue, 19 Aug 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V0dpLbuY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1A23CB;
	Tue, 19 Aug 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592233; cv=none; b=uNtLbALPlwKvVCBzWTX5zL/PkpdDJciOt6GHT4FyFbT3fcbcWoFqAwi9/C/klFoCb0qvVt6hEvIATOhtayVmOBUAaVUJ0bgrx1zDRrQWJ7hV9PTpLZPJQy/OSQZcrEK40KWqtyo7MyumQz0T6OxEXMANxZ3kZqNJKQynhFBEqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592233; c=relaxed/simple;
	bh=RCjGVgTB8l95FWGgUIkCSEdSoekdlF0bPAY4W69fdFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bo3K+AbGHV9lhkOXhBOHehxeWbnH+a4AI0aqIzhpWvfPaSvKCVWmTn+S9b/ntyYBMYydZ0HydxkcrhgiC5vBzYhEq3x4xZnmE2NVV3QXa8C46jYX9KWSFx9Dhw/NBCjoFfy9FVu8jWOsD0xS+W8uY8vkHNbwd4kIecjGq3pK+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V0dpLbuY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755592230; x=1787128230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RCjGVgTB8l95FWGgUIkCSEdSoekdlF0bPAY4W69fdFE=;
  b=V0dpLbuYbaTcnJuTlq6iql2S7uEWZAtZoUmR27oPoryEXDCiREeDNS5B
   9dc8iSiAuoBWkhWUOs2F8jy/m9gFnc2VdCVYIwPxxI8rqrsM17hVP0Zqc
   TeNtrEbulaDrDFF4/03Xr6b+CANy4EIB+IpF77PAipOpHUxkAcx7R+aGa
   /snIfAE3ueOiTNr20kKRyM1p8iLFLGy7cdC4uUBDzK0YgSsUe0MPWJ3AZ
   JHpANhnEKAQhCjsXDLBBmb+rAOaltk8ZCqDhEnm883JDWBJwpa6FzrCVa
   15wQlJ9p0wn8N1thJpnSmaLRh/IEmGCQ30aBiNZChyvV4aB2oj/bzHSKu
   g==;
X-CSE-ConnectionGUID: rGxQvEkNTVWkP7VgrAZeXA==
X-CSE-MsgGUID: DQGDlEKeSEK7EQOEE1yQUw==
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="50924494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2025 01:30:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 19 Aug 2025 01:29:45 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 19 Aug 2025 01:29:41 -0700
Message-ID: <37427c1a-68af-4c50-ac6d-da5ee135c260@microchip.com>
Date: Tue, 19 Aug 2025 10:29:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
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
	<jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-2-svarbanov@suse.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250815135911.1383385-2-svarbanov@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 at 15:59, Stanimir Varbanov wrote:
> In case of rx queue reset and 64bit capable hardware, set the upper
> 32bits of DMA ring buffer address.

Very nice finding! Thanks.

> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

A "Fixes" tag might be interesting here.

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd..41c0cbb5262e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1635,6 +1635,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
> 
>                  macb_init_rx_ring(queue);
>                  queue_writel(queue, RBQP, queue->rx_ring_dma);

For the sake of consistency, I would add lower_32_bits() to this call, 
as I see it for each use of RBQP or TBQP.

> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> +                       macb_writel(bp, RBQPH,
> +                                   upper_32_bits(queue->rx_ring_dma));
> +#endif
> 
>                  macb_writel(bp, NCR, ctrl | MACB_BIT(RE));

Best regards,
   Nicolas


