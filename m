Return-Path: <netdev+bounces-200365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47887AE4AB6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F022117BAF2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95A2BD59B;
	Mon, 23 Jun 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ok289bH4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8324BD0C;
	Mon, 23 Jun 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695408; cv=none; b=UfPiPC/LIbLOpziTqucZQYAuSj1tD+zaByfYpeShkCNaYqFNb5kd2xEYAPQfbioh0y9N5ED2QqSXEKt0Ajn1ukwis337KHdhfRgtkhkGgJ7rYt1NObE3dQkT3WHrJw1IYkeemIpx8M8L3//bIYWQ2DR9QJSDE1LmCNIVe/zbwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695408; c=relaxed/simple;
	bh=Ur0XOriXT1WlSZ1k17YMUC/sCAmjE++EAq3Cer6GQKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SQzRvZOsNQpuoWaEi9foI7HWW4A6Xsl6Ez85WDe8YBvyf4QvJrlMobfZM7aS/AQ6qzFpLxlKczuf2NpIPv14+SgGwswP4nRMR3Xi2EAMg93Tcoz6MqrXXGy+biPH4WuKxDPhJsKMVcF72uNyVarVWxY4/punCwXi1lri3wSmdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ok289bH4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750695407; x=1782231407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ur0XOriXT1WlSZ1k17YMUC/sCAmjE++EAq3Cer6GQKI=;
  b=Ok289bH4Itw6AdHHfh18UBRJ/nhOL4CY/1loDg9Kf3CsAziBw36z6qRr
   Q6Z+YwbOTvoVSHjhNheCmD6N2Dyx6BlxxYQKL4Zo3yXw/d2Wr2HX0ck3R
   nt/Lf8+Rp6q8108nv8GAVK3BTLRzgAuoMxJ5gK2c0ZE89B3B7VPgkT0PZ
   6AIGNpIbAGKCK4z4mNNuWddYSsBWGE0rn/cwEUE/4M2h00om2NFs8vf69
   XjtWRx7ug5LHxa2eE6lSkmUuR7x4l4AzDkq5hy0tFwtcOolPLPyqOwfdG
   gSdShPQSVHEMSDqx7raHsdm0hnxgwROH7J2xJe9y0d1yCZC2hhayTxER9
   Q==;
X-CSE-ConnectionGUID: YKKdZQvISxa431DUkbBFkA==
X-CSE-MsgGUID: EAlSJYjtTEK2VZ7v+xC1Ag==
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="43120166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 09:16:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Jun 2025 09:16:37 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 23 Jun 2025 09:16:37 -0700
Message-ID: <0aa6c9a4-4a65-4b55-a180-92c795499384@microchip.com>
Date: Mon, 23 Jun 2025 09:16:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Expose REFCLK for RMII and enable RMII
To: Andrew Lunn <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
 <4b1f601d-7a65-4252-8f04-62b5a952c001@lunn.ch>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <4b1f601d-7a65-4252-8f04-62b5a952c001@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 6/21/25 00:24, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Jun 19, 2025 at 10:04:12AM -0700, Ryan.Wanner@microchip.com wrote:
>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>
>> This set allows the REFCLK property to be exposed as a dt-property to
>> properly reflect the correct RMII layout. RMII can take an external or
>> internal provided REFCLK, since this is not SoC dependent but board
>> dependent this must be exposed as a DT property for the macb driver.
> 
> What board is going to use this? Do you have a patch for a .dts file?

Our SAMA7D65_curiosity board has a connector that allows us to change
ethernet phys. Since some of the phys we have provide their own REFCLK
while others do not, this property needs to be added so we are able to
use all of these.

I do not have an exact .dts patch for this since our default is MPU
provides the REFCLK, this property will be used with dt-overlays that
match each phy that is connected.

Ryan
> 
>         Andrew


