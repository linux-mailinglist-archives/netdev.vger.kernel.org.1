Return-Path: <netdev+bounces-287795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO0MFnw2BWp9TQIAu9opvQ
	(envelope-from <netdev+bounces-287795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:42:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192E53D1F2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109D730209DF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D62E7185;
	Thu, 14 May 2026 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="JfegYDIN"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901433F413A;
	Thu, 14 May 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726519; cv=pass; b=KW3vTUmzbu0JZuYwNfkqiXHR8C+Lt8p3V1XmtGI0mAjDQgBp/6MhGtOaO+bltPjv1LfnoUgKBMkpfR7sAJ4C5bGgv1G/6HsGBtbda/pfcxYxCsl/oIQKniw2kikMstvxbR+uaqm0gexq2nod5cUhzlXi+v3ey1o+L+970Tw8Vns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726519; c=relaxed/simple;
	bh=GSTUi9r8Rm2Sz0PEhinBFhsqPBSJ7xLVnNiSPS/KJLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pdTUE75SyaqE27rJzEXBwd4VKojopbQRLnkYIzfRRnvULM260loMsBd92OkxDaeuDRFrWQS9nYTAcYSAILD9eVzCrnYjAFzEUS8eHDPKTGD8L2SlDf8X68Uj/Ls+VmWG+kxpXN3IBVuVu1/JQj2C4Y/RbDa3jx3RJuK+tD2s5lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=JfegYDIN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1778726477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Docj4EGI3Ug/msvdikxupE8lz7UGSUVoJJpumWdD4eTi8qgqFpfqp7D2H5t9tmEU3EuX/zWBhgdGT/Kb0V6YB8sgCJXNr5bI1171o4x+2NnklH7go6+oimb0JhVcisE2GnYPxENV+FzNu6SspN/S8pbo4QLuqCaz8me39W/MaD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778726477; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V5kLc3tBRnQNBWeKfM6szSwbyCBrMxDQ5Luf/VfXq5c=; 
	b=RtdVb+ZdergDJGJLu0Ki1tcdtGHVb0CDJyCJc231U+8MU6GTZY5wtcjpn+EPohxEyOAgJRkMc+o/Mpsy8VR7X7+ctq0CaTEu8FvJK2GAept5xJvoLRtw4yvCqwYrQUVXOLYcl0RntST/ixxgO4wfPAroI8JgriEPIDBQooTfwhQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778726477;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:References:In-Reply-To:Reply-To;
	bh=V5kLc3tBRnQNBWeKfM6szSwbyCBrMxDQ5Luf/VfXq5c=;
	b=JfegYDINIwg/6N+ugdeRkxpcKqPN+ScisKB0wJyvr2ap2/riUrji1MxxFsbK6MuJ
	atZkatO3WkfMT9ZGwxRCIsOtX8fOUHwYOjlhfDV3yZqsVx3pGlEB1loNFFUDATdrlX0
	P/edQNdD7VM6xWkVILNhZuk7zHeAPQPNLhvBCQtQ=
Received: by mx.zohomail.com with SMTPS id 1778726475791212.1556488266575;
	Wed, 13 May 2026 19:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 10:41:01 +0800
Message-Id: <DII1WNKP34TU.34MR7JQVKLTGJ@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Andre Przywara" <andre.przywara@arm.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>
Cc: "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Chen-Yu Tsai"
 <wens@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Richard Cochran" <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 8/8] clk: sunxi-ng: a733: Add reset lines
X-Mailer: aerc 0.21.0
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
 <20260310-a733-clk-v1-8-36b4e9b24457@pigmoral.tech>
 <20260514012226.691ae185@ryzen.lan>
In-Reply-To: <20260514012226.691ae185@ryzen.lan>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0192E53D1F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287795-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[pigmoral.tech];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pigmoral.tech:email,pigmoral.tech:mid,pigmoral.tech:dkim]
X-Rspamd-Action: no action

Hi Andre,
Thanks for your review.

On Thu May 14, 2026 at 7:22 AM CST, Andre Przywara wrote:
> On Tue, 10 Mar 2026 16:34:01 +0800
> Junhui Liu <junhui.liu@pigmoral.tech> wrote:
>
> Hi,
>
> compare the list below against my version of the manual. You list more
> than shown there, can you say where those extra reset bits come from?

They are from the vendor BSP, I will add comments to explain them in the
next version.

>
>> Add the reset lines for the Allwinner A733 SoC. These reset control bits
>> are integrated into the Bus Gate Reset (BGR) registers, typically
>> sharing the same register address with their corresponding bus clock
>> gates. Integrate them into the main CCU driver using the existing
>> sunxi-ng ccu_reset framework, allowing the CCU to also function as a
>> reset controller for the SoC.
>>=20
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 128 ++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 128 insertions(+)
>>=20
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-=
ng/ccu-sun60i-a733.c
>> index c0b09f9197d1..7d1ee9235436 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>> @@ -17,6 +17,7 @@
>>  #include "../clk.h"
>> =20
>>  #include "ccu_common.h"
>> +#include "ccu_reset.h"
>> =20
>>  #include "ccu_div.h"
>>  #include "ccu_gate.h"
>> @@ -2169,11 +2170,138 @@ static struct clk_hw_onecell_data sun60i_a733_h=
w_clks =3D {
>>  	.num	=3D CLK_FANOUT3 + 1,
>>  };
>> =20
>> +static struct ccu_reset_map sun60i_a733_ccu_resets[] =3D {
>> +	[RST_BUS_ITS_PCIE]		=3D { 0x574, BIT(16) },
>> +	[RST_BUS_NSI]			=3D { 0x580, BIT(30) },
>
> What is this NSI device? Some interconnect? Do we really want to handle
> this reset and clock? Is there some device referencing this? Otherwise
> the kernel will turn at least the clock off, which is probably fatal.
> Also the manual says this is a secure register, so I feel like the
> kernel must not mess with this.

Yes, NSI appears to be a high-speed interconnect. The vendor kernel
provides a sunxi-nsi driver for it accross sun8i, sun55i, and sun60i.
Since the mainline kernel doesn't manage this interconnect for the
already mainlined sun8i and sun55i platforms, I will drop the NSI clocks
and resets in the next version.

>
>> +	[RST_BUS_NSI_CFG]		=3D { 0x584, BIT(16) },
>
> Similar here, I guess, though this might not be secure only.
>
>> +	[RST_BUS_IOMMU0_SYS]		=3D { 0x58c, BIT(16) },
>> +	[RST_BUS_MSI_LITE0_AHB]		=3D { 0x594, BIT(16) },
>> +	[RST_BUS_MSI_LITE0_MBUS]	=3D { 0x594, BIT(17) },
>> +	[RST_BUS_MSI_LITE1_AHB]		=3D { 0x59c, BIT(16) },
>> +	[RST_BUS_MSI_LITE1_MBUS]	=3D { 0x59c, BIT(17) },
>> +	[RST_BUS_MSI_LITE2_AHB]		=3D { 0x5a4, BIT(16) },
>> +	[RST_BUS_MSI_LITE2_MBUS]	=3D { 0x5a4, BIT(17) },
>> +	[RST_BUS_IOMMU1_SYS]		=3D { 0x5b4, BIT(16) },
>> +	[RST_BUS_DMA0]			=3D { 0x704, BIT(16) },
>> +	[RST_BUS_DMA1]			=3D { 0x70c, BIT(16) },
>> +	[RST_BUS_SPINLOCK]		=3D { 0x724, BIT(16) },
>> +	[RST_BUS_MSGBOX]		=3D { 0x744, BIT(16) },
>> +	[RST_BUS_PWM0]			=3D { 0x784, BIT(16) },
>> +	[RST_BUS_PWM1]			=3D { 0x78c, BIT(16) },
>> +	[RST_BUS_DBG]			=3D { 0x7a4, BIT(16) },
>> +	[RST_BUS_SYSDAP]		=3D { 0x7ac, BIT(16) },
>> +	[RST_BUS_TIMER0]		=3D { 0x850, BIT(16) },
>> +	[RST_BUS_DE]			=3D { 0xa04, BIT(16) },
>> +	[RST_BUS_DI]			=3D { 0xa24, BIT(16) },
>> +	[RST_BUS_G2D]			=3D { 0xa44, BIT(16) },
>> +	[RST_BUS_EINK]			=3D { 0xa6c, BIT(16) },
>> +	[RST_BUS_DE_SYS]		=3D { 0xa74, BIT(16) },
>> +	[RST_BUS_VE_ENC]		=3D { 0xa8c, BIT(16) },
>
> The manual calls this ENC0, and since bit 17 is not documented, I
> wonder if there is an ENC1 used with some other packaging, maybe? So
> maybe calling it ENC0 would be safer here.

Okay, I will rename it to ENC0.

>
>> +	[RST_BUS_VE_DEC]		=3D { 0xa8c, BIT(18) },
>> +	[RST_BUS_CE]			=3D { 0xac4, BIT(16) },
>> +	[RST_BUS_CE_SYS]		=3D { 0xac4, BIT(17) },
>> +	[RST_BUS_NPU_CORE]		=3D { 0xb04, BIT(16) },
>> +	[RST_BUS_NPU_AXI]		=3D { 0xb04, BIT(17) },
>> +	[RST_BUS_NPU_AHB]		=3D { 0xb04, BIT(18) },
>> +	[RST_BUS_NPU_SRAM]		=3D { 0xb04, BIT(19) },
>> +	[RST_BUS_GPU]			=3D { 0xb24, BIT(16) },
>> +	[RST_BUS_DRAM]			=3D { 0xc0c, BIT(16) },
>> +	[RST_BUS_NAND]			=3D { 0xc8c, BIT(16) },
>> +	[RST_BUS_MMC0]			=3D { 0xd0c, BIT(16) },
>> +	[RST_BUS_MMC1]			=3D { 0xd1c, BIT(16) },
>> +	[RST_BUS_MMC2]			=3D { 0xd2c, BIT(16) },
>> +	[RST_BUS_MMC3]			=3D { 0xd3c, BIT(16) },
>> +	[RST_BUS_UFS_AHB]		=3D { 0xd8c, BIT(16) },
>> +	[RST_BUS_UFS_AXI]		=3D { 0xd8c, BIT(17) },
>> +	[RST_BUS_UFS_PHY]		=3D { 0xd8c, BIT(18) },
>> +	[RST_BUS_UFS_CORE]		=3D { 0xd8c, BIT(19) },
>> +	[RST_BUS_UART0]			=3D { 0xe00, BIT(16) },
>> +	[RST_BUS_UART1]			=3D { 0xe04, BIT(16) },
>> +	[RST_BUS_UART2]			=3D { 0xe08, BIT(16) },
>> +	[RST_BUS_UART3]			=3D { 0xe0c, BIT(16) },
>> +	[RST_BUS_UART4]			=3D { 0xe10, BIT(16) },
>> +	[RST_BUS_UART5]			=3D { 0xe14, BIT(16) },
>> +	[RST_BUS_UART6]			=3D { 0xe18, BIT(16) },
>> +	[RST_BUS_I2C0]			=3D { 0xe80, BIT(16) },
>> +	[RST_BUS_I2C1]			=3D { 0xe84, BIT(16) },
>> +	[RST_BUS_I2C2]			=3D { 0xe88, BIT(16) },
>> +	[RST_BUS_I2C3]			=3D { 0xe8c, BIT(16) },
>> +	[RST_BUS_I2C4]			=3D { 0xe90, BIT(16) },
>> +	[RST_BUS_I2C5]			=3D { 0xe94, BIT(16) },
>> +	[RST_BUS_I2C6]			=3D { 0xe98, BIT(16) },
>> +	[RST_BUS_I2C7]			=3D { 0xe9c, BIT(16) },
>> +	[RST_BUS_I2C8]			=3D { 0xea0, BIT(16) },
>> +	[RST_BUS_I2C9]			=3D { 0xea4, BIT(16) },
>> +	[RST_BUS_I2C10]			=3D { 0xea8, BIT(16) },
>> +	[RST_BUS_I2C11]			=3D { 0xeac, BIT(16) },
>> +	[RST_BUS_I2C12]			=3D { 0xeb0, BIT(16) },
>> +	[RST_BUS_SPI0]			=3D { 0xf04, BIT(16) },
>> +	[RST_BUS_SPI1]			=3D { 0xf0c, BIT(16) },
>> +	[RST_BUS_SPI2]			=3D { 0xf14, BIT(16) },
>> +	[RST_BUS_SPIF]			=3D { 0xf1c, BIT(16) },
>> +	[RST_BUS_SPI3]			=3D { 0xf24, BIT(16) },
>> +	[RST_BUS_SPI4]			=3D { 0xf2c, BIT(16) },
>
> SPI4 isn't mentioned in my version of the manual.
>
>> +	[RST_BUS_GPADC]			=3D { 0xfc4, BIT(16) },
>> +	[RST_BUS_THS]			=3D { 0xfe4, BIT(16) },
>> +	[RST_BUS_IRRX]			=3D { 0x1004, BIT(16) },
>> +	[RST_BUS_IRTX]			=3D { 0x100c, BIT(16) },
>> +	[RST_BUS_LRADC]			=3D { 0x1024, BIT(16) },
>> +	[RST_BUS_SGPIO]			=3D { 0x1064, BIT(16) },
>> +	[RST_BUS_LPC]			=3D { 0x1084, BIT(16) },
>
> Where do those two come from? There are not in my version of the manual.
>
>> +	[RST_BUS_I2SPCM0]		=3D { 0x120c, BIT(16) },
>> +	[RST_BUS_I2SPCM1]		=3D { 0x121c, BIT(16) },
>> +	[RST_BUS_I2SPCM2]		=3D { 0x122c, BIT(16) },
>> +	[RST_BUS_I2SPCM3]		=3D { 0x123c, BIT(16) },
>> +	[RST_BUS_I2SPCM4]		=3D { 0x124c, BIT(16) },
>> +	[RST_BUS_OWA]			=3D { 0x128c, BIT(16) },
>> +	[RST_BUS_DMIC]			=3D { 0x12cc, BIT(16) },
>> +	[RST_USB_PHY0]			=3D { 0x1300, BIT(30) },
>> +	[RST_BUS_OHCI0]			=3D { 0x1304, BIT(16) },
>> +	[RST_BUS_EHCI0]			=3D { 0x1304, BIT(20) },
>> +	[RST_BUS_OTG]			=3D { 0x1304, BIT(24) },
>> +	[RST_USB_PHY1]			=3D { 0x1308, BIT(30) },
>> +	[RST_BUS_OHCI1]			=3D { 0x130c, BIT(16) },
>> +	[RST_BUS_EHCI1]			=3D { 0x130c, BIT(20) },
>> +	[RST_BUS_USB2]			=3D { 0x135c, BIT(16) },
>> +	[RST_BUS_PCIE]			=3D { 0x138c, BIT(17) },
>> +	[RST_BUS_PCIE_PWRUP]		=3D { 0x138c, BIT(16) },
>
> Just a nit, but those two are ordered wrongly.

Will do.

>
>> +	[RST_BUS_SERDES]		=3D { 0x13c4, BIT(16) },
>> +	[RST_BUS_GMAC0]			=3D { 0x141c, BIT(16) },
>> +	[RST_BUS_GMAC0_AXI]		=3D { 0x141c, BIT(17) },
>> +	[RST_BUS_GMAC1]			=3D { 0x142c, BIT(16) },
>> +	[RST_BUS_GMAC1_AXI]		=3D { 0x142c, BIT(17) },
>
> GMAC1 is not listed in my manual, where does this come from?
>
>> +	[RST_BUS_TCON_LCD0]		=3D { 0x1504, BIT(16) },
>> +	[RST_BUS_TCON_LCD1]		=3D { 0x150c, BIT(16) },
>> +	[RST_BUS_TCON_LCD2]		=3D { 0x1514, BIT(16) },
>
> No LCD2 in my manual.
>
> The rest looks alright.
>
> Cheers,
> Andre
>
>> +	[RST_BUS_LVDS0]			=3D { 0x1544, BIT(16) },
>> +	[RST_BUS_LVDS1]			=3D { 0x154c, BIT(16) },
>> +	[RST_BUS_DSI0]			=3D { 0x1584, BIT(16) },
>> +	[RST_BUS_DSI1]			=3D { 0x158c, BIT(16) },
>> +	[RST_BUS_TCON_TV0]		=3D { 0x1604, BIT(16) },
>> +	[RST_BUS_TCON_TV1]		=3D { 0x160c, BIT(16) },
>> +	[RST_BUS_EDP]			=3D { 0x164c, BIT(16) },
>> +	[RST_BUS_HDMI_MAIN]		=3D { 0x168c, BIT(16) },
>> +	[RST_BUS_HDMI_SUB]		=3D { 0x168c, BIT(17) },
>> +	[RST_BUS_HDMI_HDCP]		=3D { 0x168c, BIT(18) },
>> +	[RST_BUS_DPSS_TOP0]		=3D { 0x16c4, BIT(16) },
>> +	[RST_BUS_DPSS_TOP1]		=3D { 0x16cc, BIT(16) },
>> +	[RST_BUS_VIDEO_OUT0]		=3D { 0x16e4, BIT(16) },
>> +	[RST_BUS_VIDEO_OUT1]		=3D { 0x16ec, BIT(16) },
>> +	[RST_BUS_LEDC]			=3D { 0x1704, BIT(16) },
>> +	[RST_BUS_DSC]			=3D { 0x1744, BIT(16) },
>> +	[RST_BUS_CSI]			=3D { 0x1844, BIT(16) },
>> +	[RST_BUS_VIDEO_IN]		=3D { 0x1884, BIT(16) },
>> +	[RST_BUS_APB2JTAG]		=3D { 0x1c04, BIT(16) },
>> +};
>> +
>>  static const struct sunxi_ccu_desc sun60i_a733_ccu_desc =3D {
>>  	.ccu_clks	=3D sun60i_a733_ccu_clks,
>>  	.num_ccu_clks	=3D ARRAY_SIZE(sun60i_a733_ccu_clks),
>> =20
>>  	.hw_clks	=3D &sun60i_a733_hw_clks,
>> +
>> +	.resets		=3D sun60i_a733_ccu_resets,
>> +	.num_resets	=3D ARRAY_SIZE(sun60i_a733_ccu_resets),
>>  };
>> =20
>>  static const u32 pll_regs[] =3D {
>>=20

--=20
Best regards,
Junhui Liu


