Return-Path: <netdev+bounces-215317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B386B2E140
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E58B18992BD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EC221F15;
	Wed, 20 Aug 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hT4tLLCo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1936CE0A;
	Wed, 20 Aug 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703573; cv=none; b=ZaXt7LE9OCg65lHLSOr4sJBCZgrjDY/+l/sSROQ9W2B5IvXugW4Vn/P9igmIcTrmZOsAp2E7rZy4eWAo6DiEsNkadI4osn+n7WnY1KN4dkyiuRowIHCI4UwcjaofSyMsOZNVhZc1lJwJbIXV79cVn37x4Bj6YYnACM498YHBmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703573; c=relaxed/simple;
	bh=UKsT/uOiNEwUjDVanX/gjmwf4DfudF9I6p37X5ia2ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3F5Nzn2hhOUkiRAXn9CcY7hJiC+MLkk2MC0t5izvhDVRslul2yCHtMfy2pSrRVeslYIvsozlfIiW4Y2pxKcQ0WmON1tqEzZHboMil6tQBadIdBvZULg0UK5OVoONfFJ28v6g4zigqY8HUrlIbc1AjDoPHjVHky8LjTgXdyAZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hT4tLLCo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D12hxmFmFM9loDOUzOMSaKyZa2Ga8k1rsHytR3xCixo=; b=hT4tLLCoi7gMkYSW7jpvz1IJbw
	A9jPca9W97CkEqJCKT7KabsZW7vVFEzVo40lZCJ7NDrAwsVCVBh98vfK9dFFRpyPbVwsGo+ftW+YD
	xBC/pi0FkrJDUq+hvyUFTFcvgtUCjCuJ8n9egfyBx8cFPbAPYAUjSCoZzMMfdOa/IcZFycs0pAbBj
	HyGCFhCE10JRWZMlb2SfTpPOeQurFOxJikgHwYs3FeP02DBSGjjSomiYjMd8k5UgN2KPiz/xM3Kcn
	bguurHeA58FCBciMSyzlDxk0cQgYOhRplTCNhZX5Kt+HEsQdABnzGT95yFWAcZCith89MOeQk8VZh
	3OrVbkwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uokhG-0004yn-0R;
	Wed, 20 Aug 2025 16:25:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uokhC-000000000Kq-0kCG;
	Wed, 20 Aug 2025 16:25:50 +0100
Date: Wed, 20 Aug 2025 16:25:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Harini Katakam <harini.katakam@xilinx.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH net v4 5/5] net: macb: avoid double endianness swap in
 macb_set_hwaddr()
Message-ID: <aKXo_jihNKyJmxVQ@shell.armlinux.org.uk>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-5-23c399429164@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-macb-fixes-v4-5-23c399429164@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 20, 2025 at 04:55:09PM +0200, Théo Lebrun wrote:
> writel() does a CPU->LE conversion. Drop manual cpu_to_le*() calls.
> 
> On little-endian system:
>  - cpu_to_le32() is a no-op (LE->LE),
>  - writel() is a no-op (LE->LE),
>  - dev_addr will therefore not be swapped and written as-is.
> 
> On big-endian system:
>  - cpu_to_le32() is a swap (BE->LE),
>  - writel() is a swap (BE->LE),
>  - dev_addr will therefore be swapped twice and written as a BE value.

I'm not convinced by this, I think you're missing something.

writel() on a BE or LE system will give you bits 7:0 of the CPU value
written to LE bit 7:0 of the register. It has to be this way, otherwise
we would need to do endian conversions everwhere where we write simple
numbers to device registers.

Why?

Remember that on a LE system with a 32-bit bus, a hex value of
0x76543210 at the CPU when written without conversion will appear
as:
	0 on bus bits 0:3
	1 on bus bits 4:7
	...
	6 on bus bits 24:27
	7 on bus bits 28:31

whereas on a BE system, this is reversed:
	6 on bus bits 0:3
	7 on bus bits 4:7
	...
	0 on bus bits 24:27
	1 on bus bits 28:31

The specification is that writel() will write in LE format even on
BE systems, so there is a need to do an endian conversion for BE
systems.

So, if a device expects bits 0:7 on the bus to be the first byte of
the MAC address (high byte of the OUI) then this must be in CPU
bits 0:7 as well.


Now, assuming that a MAC address of AA:BB:CC:DD:EE:FF gets read as
0xDDCCBBAA by the first read on a LE machine, it will get read as
0xAABBCCDD on a BE machine.

We can now see that combining these two, getting rid of the
cpu_to_le32() is likely wrong.


Therefore, I am not convinced this patch is actually correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

