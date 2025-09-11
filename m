Return-Path: <netdev+bounces-222029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B3B52CC7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3371C20038
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E22E8E09;
	Thu, 11 Sep 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nNCQv+vh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA02E92B2;
	Thu, 11 Sep 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582121; cv=none; b=d0sv+RgtgpuPR/CNr57SueUT2fSrS4T65Bwmr6z0WVk9wEZ/UDBRugE1ZJhhyZVJa09bxo5zqCZOBHspwE5mXVfDpIO9sG5gXXG6ugB+buZRuMmZRBCn7JJyURf48RivS8Buml+9pmnW7IDGVNQ/ZSjKB54DRymuvb+oyiqiGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582121; c=relaxed/simple;
	bh=valIaFXJyqMk/gNwu9h7asJvee/648EdOf7YOOftI+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=kGjGQCWtcX12ELVXffoHUx6okhFlN6cMQ/UAWtc/EzoMQOw2rD5KdtLfSR2QTMl1lMfiWvoAcdAI5YGQzOxCLehen16lDaZJIyMgZmOKyHk5okYJHVDTDBhJN59zU6np9MNb66YpMO+VInR6xUy01Wpn+HJ9US0auUyodwN2Pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nNCQv+vh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A55EF1A0E1C;
	Thu, 11 Sep 2025 09:15:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F1CD606BB;
	Thu, 11 Sep 2025 09:15:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58A6F102F28E6;
	Thu, 11 Sep 2025 11:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757582116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BNuVqAy7Z/kWIWiNnRT9y90+rPVhH4DqDV6Cj+hDBBg=;
	b=nNCQv+vhqywb379yl8F0RRwXjYMezINKw5vfVmTgMjemnd0fz9vUtwofD9ImwKyW9GrRNG
	RpCkkLtAtb5TZckHe4G9OIgATVTw0ytz47XRP+n7I9GjFo8pROrSt4AhAjB/mpETzH9XiY
	FGi/mED1F5UcI2oqDcos2VthBn2PVj6ItPQcv/TwtvQfnTcAVGPL9E8lJ7KGlYsRxW+5Mo
	O0pcb0UKcRl4tOdVkhmIjo+gtdRBGqo/bmVKMH8UfeQliPKZ8G4QYY6X151Cg9c/QjBy8+
	oiEwxO506ImqNx6MF1TEF2MgnvkgR7zjK0Tb9+26PTvgdNApnM437KK/2Kp9Gw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 11:14:52 +0200
Message-Id: <DCPUUQHYSZGE.WH37VP8WHJ8E@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v5 3/5] net: macb: move ring size computation to
 functions
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Karumanchi, Vineeth" <vineeth@amd.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Harini Katakam" <harini.katakam@xilinx.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
 <20250910-macb-fixes-v5-3-f413a3601ce4@bootlin.com>
 <ba25cca0-adbf-435b-8c21-f03c567045b1@amd.com>
In-Reply-To: <ba25cca0-adbf-435b-8c21-f03c567045b1@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Thu Sep 11, 2025 at 8:43 AM CEST, Karumanchi, Vineeth wrote:
> On 9/10/2025 9:45 PM, Th=C3=A9o Lebrun wrote:
>>   #define DEFAULT_TX_RING_SIZE	512 /* must be power of 2 */
>>   #define MIN_TX_RING_SIZE	64
>>   #define MAX_TX_RING_SIZE	4096
>> -#define TX_RING_BYTES(bp) (macb_dma_desc_get_size(bp) \
>> - * (bp)->tx_ring_size)
>>  =20
>>   /* level of occupied TX descriptors under which we wake up TX process =
*/
>>   #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
>> @@ -2470,11 +2466,20 @@ static void macb_free_rx_buffers(struct macb *bp=
)
>>   	}
>>   }
>>  =20
>> +static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
>> +{
>> + return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp-=20
>>  >tx_bd_rd_prefetch;
>> +}
>> +
>> +static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
>> +{
>> + return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp-=20
>>  >rx_bd_rd_prefetch;
>> +}
>> +
>
> it would be good to have these functions as inline.
> May be as a separate patch.

I don't see why? Compilers are clever pieces, they'll know to inline it.

If we added inline to macb_{tx,rx}_ring_size_per_queue(), should we also
add it to macb_dma_desc_get_size()? I do not know, but my compiler
decided to inline it as well. It might make other decisions on other
platforms.

Last point I see: those two functions are not called in the hotpath,
only at alloc & free. If we talk about inline for the theoretical speed
gain, then it doesn't matter in that case. If it is a code size aspect,
then once again the compiler is more aware than myself.

I don't like the tone, but it is part of the kernel doc and is on topic:
https://www.kernel.org/doc/html/latest/process/coding-style.html#the-inline=
-disease

Thanks Vineeth!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


