Return-Path: <netdev+bounces-222034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F192B52D1D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491651C83DF1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A12E9754;
	Thu, 11 Sep 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OA9r9gaK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E722264B7;
	Thu, 11 Sep 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582595; cv=none; b=S5eHys9yLuUxvbceCMiryN6oUQRwIeZ2wm6wDekITMEPfs5NB2Tx3Hj+Ph6EFffEijZcxQidmHtB4VXe4g8rrWKAcBHytER/tN61EnpfiWyRMEq8OUBUD/mmQeAIFPxfOMPJIvLGRlaNG1/rKSjwWY/a4IaYIUQ95fSodDqwI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582595; c=relaxed/simple;
	bh=ZIWS4cCZ9X1LrbzdXugwi9X3kqvYCVo13XYBnoR94J8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=su3g3ox2nEDV2iV76iQyI0vl2NsmLICoSEN2U6VJ858rhOvVk8WyOvYITZx05bD8JLKrRY6SJMXtHwlSQ+XcVKv5EY7Vsxo7UFXGb7z13ZuV8bySfgaXRoL+oK5jR7n6Lntaa7GlJ8GlrfL3V4RZ19khOPVukHyJI2yCcw33yQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OA9r9gaK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 173874E40C84;
	Thu, 11 Sep 2025 09:23:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5161606BB;
	Thu, 11 Sep 2025 09:23:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EA1F102F2904;
	Thu, 11 Sep 2025 11:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757582584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ki23ZognW65DxF6/KtgGW2rTMo2gKXeDhFNtXzfdpJE=;
	b=OA9r9gaKOE/1Fq2l5OMAw+gosx7lmy/UMqm1lRuN7sp6bNaHdopW3wB9gn4dBTyo7Mekhv
	gauweeJaDM9ekJczrL4NVYi5X0d7LilnuZO29UIWd83gmr6qECqwMWmmRotsY+525t3HGt
	zkP+rDrQ45+tQwrqrtAhdOSHveRhA+IBJ2TaH6+tUzWogJi/NnS5ZePLz8K2Ll041ur2p3
	Sc8nxST2kIcBxng8R+qFhjKQLGx6lkenZo2DTWrDgqJp+G8o/ao5w9Eu/hCB6ZqjLfe+0N
	i3wzABsqRh8BJs426laU7ZODeEkGih/PRXcQ193MML/ts41wuFcrf8Li6givug==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 11:22:47 +0200
Message-Id: <DCPV0SVDR2J7.2FKMD5PD9S235@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v5 5/5] net: macb: avoid dealing with endianness in
 macb_set_hwaddr()
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Sean Anderson" <sean.anderson@linux.dev>
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
 <20250910-macb-fixes-v5-5-f413a3601ce4@bootlin.com>
 <17d518ca-d35a-4279-b4fe-6930c5e279cd@amd.com>
In-Reply-To: <17d518ca-d35a-4279-b4fe-6930c5e279cd@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Sep 11, 2025 at 5:13 AM CEST, Karumanchi, Vineeth wrote:
> On 9/10/2025 9:45 PM, Th=C3=A9o Lebrun wrote:
>> @@ -271,12 +271,10 @@ static bool hw_is_gem(void __iomem *addr, bool nat=
ive_io)
>>  =20
>>   static void macb_set_hwaddr(struct macb *bp)
>>   {
>> -	u32 bottom;
>> -	u16 top;
>> +	u32 bottom =3D get_unaligned_le32(bp->dev->dev_addr);
>> +	u16 top =3D get_unaligned_le16(bp->dev->dev_addr + 4);
>
> please change the order as per reverse xmas tree.

I had realised this before sending the patch but preferred keeping the
ordering as-is to access dev_addr+0 first then dev_addr+4.

RCT is a strict rule in net so I'll fix it in the next revision. Some
sneaky options were also considered: a spare space in the `u32 bottom`
line, express bottom using `dev_addr + 0`, or renaming variables. :-)

Thanks Vineeth,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


