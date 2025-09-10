Return-Path: <netdev+bounces-221775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B36B51D70
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98C51B271AB
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D9327A20;
	Wed, 10 Sep 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jC4TLgrH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F91DEFE8
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521333; cv=none; b=uyZaHFTdW4GznP6HnfW7QbIlJpMq0AV9wM8hHjQ0j7YSC9hHCIZhr11h0yVEg6GFKb2gojrOKTwXtWoviNeaqwmw7Ifa4cgb8gnbSR4okbopkuH6Ii22IF5GPyrDL1FIZtnICW7soCVivt5yLjVv2CGz6dgtt0b6RJyJoD3i6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521333; c=relaxed/simple;
	bh=PYI6dtOT/CwSIUL6uAP6xtAEqE1iA9VJzX34pPBFuwk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=S5RR7KEFVavTS+lRCwTME2UHjXVCgqyF92eom4eECJSzs81KiAryTknHnuNW8lbGPGrawABqpeGghL60Pk9dlnrgCTAPoxF5/zs/BQr1kGQdzjmz0oHm0+KCjIEMTJacs7di3i7Bs1kMyvy6AhV3Zhz+B9D71onzZs3BYM2G8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jC4TLgrH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 684F14E40BB1;
	Wed, 10 Sep 2025 16:22:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 451AE606D4;
	Wed, 10 Sep 2025 16:22:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28D50102F28CF;
	Wed, 10 Sep 2025 18:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757521328; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZctRQ7ts/8TVQPiO2r4kt975iBBgUJD5+xfPFF8APxs=;
	b=jC4TLgrHH0tSuMTXzghrf6gN9uTFLcQX1gNuQiind9B9slKj9lsPIcFJfqODhIDpQb10Rd
	rrxr5QiGq3cuB/TLVuGEoCdLetVHHBvpzxxwUtYxQjuc90/HlgbAHVqMKAoOGX51x3JsJT
	dc8aoTvd5NAZ8s6Q9OiZPNGKrjz1d0+uYz2U6BzohIxJjaw5UEcd+RlE+4rBFhUSLU2lBw
	nJHgWnm8zeAhMSy4LcZydyn0b//0KbpxDLWVsfWN7FZ37x+uWI2hgYR7n5p2ykT86+waYp
	gGMAWYaiAbLYmGNOIWz29nXdU6fHl+y205i9z9dcG53iASupTIGcEe5FBm1jOA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 18:22:03 +0200
Message-Id: <DCP9B9VNMQVW.2XKBF1MH15N91@bootlin.com>
Subject: Re: [PATCH net v4 4/5] net: macb: single dma_alloc_coherent() for
 DMA descriptors
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Sean Anderson" <sean.anderson@linux.dev>
To: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, "Harini Katakam" <harini.katakam@xilinx.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-4-23c399429164@bootlin.com>
 <010e0551-58b8-4b61-8ad7-2f03ecc6baa3@microchip.com>
In-Reply-To: <010e0551-58b8-4b61-8ad7-2f03ecc6baa3@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolas,

On Tue Aug 26, 2025 at 5:23 PM CEST, Nicolas Ferre wrote:
> On 20/08/2025 at 16:55, Th=C3=A9o Lebrun wrote:
>> Move from 2*NUM_QUEUES dma_alloc_coherent() for DMA descriptor rings to
>> 2 calls overall.
>>=20
>> Issue is with how all queues share the same register for configuring the
>> upper 32-bits of Tx/Rx descriptor rings. Taking Tx, notice how TBQPH
>> does *not* depend on the queue index:
>>=20
>>          #define GEM_TBQP(hw_q)          (0x0440 + ((hw_q) << 2))
>>          #define GEM_TBQPH(hw_q)         (0x04C8)
>>=20
>>          queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>>          #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>          if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>                  queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring=
_dma));
>>          #endif
>>=20
>> To maximise our chances of getting valid DMA addresses, we do a single
>> dma_alloc_coherent() across queues. This improves the odds because
>> alloc_pages() guarantees natural alignment. Other codepaths (IOMMU or
>> dev/arch dma_map_ops) don't give high enough guarantees
>> (even page-aligned isn't enough).
>>=20
>> Two consideration:
>>=20
>>   - dma_alloc_coherent() gives us page alignment. Here we remove this
>>     constraint meaning each queue's ring won't be page-aligned anymore.
>
> However... We must guarantee alignement depending on the controller's=20
> bus width (32 or 64 bits)... but being page aligned and having=20
> descriptors multiple of 64 bits anyway, we're good for each descriptor=20
> (might be worth explicitly adding).

Sorry, your comment was unclear to me.

 - I don't see how we can guarantee bus alignment using
   dma_alloc_coherent() which doesn't ask for desired alignment. In
   what case can the DMA APIs return something with less than the
   tolerated bus alignment?

 - What does "having descriptors multiple of 64 bits anyway" mean?

Thanks for your review and acks! V5 got published here:
https://lore.kernel.org/lkml/20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.=
com/

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


