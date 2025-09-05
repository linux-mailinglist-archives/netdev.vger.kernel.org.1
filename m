Return-Path: <netdev+bounces-220278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E48B4526C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36975177C42
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60530AACE;
	Fri,  5 Sep 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u3Hpc2fg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B4272E71
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062964; cv=none; b=VBr/pA80Ux55Agrwa+Hte1QVkkvOpgGlEoz4IFc73A9JuNhaqTnbXBhitBonPuvGfnUG0wGM2yV0vS/Jhtvl1Oyw3JQVhUCPnRtp3Q3IV4WnusPex1TBn1oDFN5xUf5zVU62wIpPNKC+axEOjFf69+wLq8L78PE7Kn/WySSbHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062964; c=relaxed/simple;
	bh=Y0krQ/dhwVEvyq75DSLzb/wzwZ/mZamFxcekM86ZgJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=U1g9hT0d4xdbmgoFlvJl556QbCVj2RLoGnoNAZFJwKKR3tYbP0FOPukrnMhteeJb40NZK0H5iuNIRB9UYP6T36iTChbBQ/IiMrFrnfmxj2VwQwpVx+c95IboSsePLKDru5wbfGmzup0GwqdwjcnGsvP9wpYLVAX9qcKmEoVpnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u3Hpc2fg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 162F51A0C23;
	Fri,  5 Sep 2025 09:02:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D54AA606C5;
	Fri,  5 Sep 2025 09:02:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A86AB102F1D40;
	Fri,  5 Sep 2025 11:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757062958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EDM06GeR+DIfdwsC7qFlc6kZpFptQC37v7RnCGNQQKY=;
	b=u3Hpc2fgxgudUL1L7iVhLC/HJ6hJFJp3owJHuqHzqSR/F+RFOeZQXHU++sPksWik/VpHZ7
	n4ThcCSUb9T/cnX4HUV7sXfu9taxSru6Qi4dGl3U5LrvPS/mrK+BFq9dOdx/SLi9Wlmlst
	DP2Ph0MTF1kSUQINhx0HqbWLYHyv5bqvcN8PN3eTiiNkYmoOghzrZ6Xk8yCrWLIA6IphKw
	LMuaVu869ncqTjA0Y6nbscZRKOszn1TfngNf6yubsHw4DbRUyz2UtEzbdqA5OSXj3hEr3k
	iBzF0T123MCy8QP1KH0dHfa1rP0UmnmFVuYRNZ0ywQMhuINwRD1M2ebq3jpnUQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 11:02:03 +0200
Message-Id: <DCKQTNSCJD5Q.BKVVU59U0MU@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Harini Katakam"
 <harini.katakam@xilinx.com>, "Richard Cochran" <richardcochran@gmail.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Sean Anderson" <sean.anderson@linux.dev>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v4 5/5] net: macb: avoid double endianness swap in
 macb_set_hwaddr()
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-5-23c399429164@bootlin.com>
 <aKXo_jihNKyJmxVQ@shell.armlinux.org.uk>
In-Reply-To: <aKXo_jihNKyJmxVQ@shell.armlinux.org.uk>
X-Last-TLS-Session-Version: TLSv1.3

Hello Russell,

On Wed Aug 20, 2025 at 5:25 PM CEST, Russell King (Oracle) wrote:
> On Wed, Aug 20, 2025 at 04:55:09PM +0200, Th=C3=A9o Lebrun wrote:
>> writel() does a CPU->LE conversion. Drop manual cpu_to_le*() calls.
>>=20
>> On little-endian system:
>>  - cpu_to_le32() is a no-op (LE->LE),
>>  - writel() is a no-op (LE->LE),
>>  - dev_addr will therefore not be swapped and written as-is.
>>=20
>> On big-endian system:
>>  - cpu_to_le32() is a swap (BE->LE),
>>  - writel() is a swap (BE->LE),
>>  - dev_addr will therefore be swapped twice and written as a BE value.
>
> I'm not convinced by this, I think you're missing something.
>
> writel() on a BE or LE system will give you bits 7:0 of the CPU value
> written to LE bit 7:0 of the register. It has to be this way, otherwise
> we would need to do endian conversions everwhere where we write simple
> numbers to device registers.
>
> Why?
>
> Remember that on a LE system with a 32-bit bus, a hex value of
> 0x76543210 at the CPU when written without conversion will appear
> as:
> 	0 on bus bits 0:3
> 	1 on bus bits 4:7
> 	...
> 	6 on bus bits 24:27
> 	7 on bus bits 28:31
>
> whereas on a BE system, this is reversed:
> 	6 on bus bits 0:3
> 	7 on bus bits 4:7
> 	...
> 	0 on bus bits 24:27
> 	1 on bus bits 28:31
>
> The specification is that writel() will write in LE format even on
> BE systems, so there is a need to do an endian conversion for BE
> systems.
>
> So, if a device expects bits 0:7 on the bus to be the first byte of
> the MAC address (high byte of the OUI) then this must be in CPU
> bits 0:7 as well.
>
>
> Now, assuming that a MAC address of AA:BB:CC:DD:EE:FF gets read as
> 0xDDCCBBAA by the first read on a LE machine, it will get read as
> 0xAABBCCDD on a BE machine.
>
> We can now see that combining these two, getting rid of the
> cpu_to_le32() is likely wrong.
>
> Therefore, I am not convinced this patch is actually correct.

Thanks for the above, in-detail, explanation. I agree with it all.
I've always have had a hard time wrapping my head around endianness
conversion.

Indeed the patch is wrong: the swap is required on BE platforms.
My gripe is more with the semantic of the current code:

   bottom =3D cpu_to_le32(*((u32 *)bp->dev->dev_addr));
   macb_or_gem_writel(bp, SA1B, bottom);
   top =3D cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
   macb_or_gem_writel(bp, SA1T, top);

Notice how:
 - The type of the argument to cpu_to_le32(); pointer is to a CPU-endian
   value (u32) but in reality is to a BE32.
 - We apply cpu_to_le32() to get a swap but the semantic is wrong; input
   value is BE32 that we want to turn into CPU-endian.
 - Above two points apply to `u16 top` as well.
 - writel() are unrelated to the issue; they do the right thing by
   writing a CPU value into a LE device register.

Sparse is complaining about the second bulletpoint; it won't complain
about the first one because it trusts that you know what you are doing
with explicit casts.

   warning: incorrect type in assignment (different base types)
      expected unsigned int [usertype] bottom
      got restricted __le32 [usertype]

If we want to keep to the same structure, this does the exact same but
its semantic is more aligned to reality (to my eyes):

   bottom =3D le32_to_cpu(*((__le32 *)bp->dev->dev_addr));
   macb_or_gem_writel(bp, SA1B, bottom);
   top =3D le16_to_cpu(*((__le16 *)(bp->dev->dev_addr + 4)));
   macb_or_gem_writel(bp, SA1T, top);

Notice how:
 - Casts are fixed to signal proper types.
 - Use le32_to_cpu().

Sparse is happy and code has been tested on a BE platform.
Assembly generated is strictly identical.

However, I think we can do better. Second option:

   const unsigned char *addr =3D bp->dev->dev_addr;

   bottom =3D addr[0] << 0 | addr[1] << 8 | addr[2] << 16 | addr[3] << 24;
   top =3D addr[4] << 0 | addr[5] << 8;

This is a bit of a mouthful, what about this one?

   bottom =3D get_unaligned_le32(addr);
   top =3D get_unaligned_le16(addr + 4);

It is my preferred. I found those helpers reading more code that reads
the `unsigned char *dev_addr` field. Explicit and straight forward.

Can you confirm that last option fits well?

Thanks Russell,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


