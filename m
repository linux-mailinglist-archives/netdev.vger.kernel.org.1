Return-Path: <netdev+bounces-197037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC726AD76B0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C63B78E6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D322BCF6A;
	Thu, 12 Jun 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wPP525W0"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2229CB49
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742472; cv=none; b=IlWL6Z7cu1vIg37YwF7FEjJuuM4/VrvkUeJMOYxelldWRYa7530W3nhdoGrqoJfZ/NfDy4KQvCxMV6SrYve74KQAWndxFEroZp4+UFIGKx3aCxCinq8EiUbgRGU9bGgam5iQkRuBB9GFhWCKlXbQ31vzGWQlYSt/lc28I9CF0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742472; c=relaxed/simple;
	bh=7lZ21bSBGeyGQ/SwS5L8GOvhz5J/nxCcUYOhf7jAcVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDn25GNS/8ZQBRfYTTvvHeRO1H+D1yX0k3J1IvgGFHRJtGZU34s5l8bAeJz2wcNa8uj6CSTVAWgaiMzNBltH6yoiqaP23wFUj5u6n90nC1trx9UVIRpjah+oGYXeB46PrHrAHKXXCXOQ5RHMVefyrt/fcNKG1P3CwibBSQTsJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wPP525W0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55f97736-495e-43a3-ad3c-ad84c138dd03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749742465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNpCvm3hfb0gToPq1x4OuSvE8zYv6anebvZhgOON29s=;
	b=wPP525W08r6pHJXIdMZDJ/+dabFTBAVd810cDqbMxr7INOGlx8gs4FzqoyFnPeVgpgb2w7
	pyTO0qfvqkaKPHznKqx8iBdwO6RXdeEEAYWtePsnOhwVPtUnXqEuvqPMWCuIDCTPgHYbRQ
	n8CBeLpt2we6nQVjFuTKM20PVoPbopA=
Date: Thu, 12 Jun 2025 11:34:16 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v6 06/10] net: pcs: Add Xilinx PCS driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Horman <horms@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>,
 linux-arm-kernel@lists.infradead.org
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
 <20250610233134.3588011-7-sean.anderson@linux.dev>
 <20250611071114.325fb630@fedora.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250611071114.325fb630@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/11/25 01:11, Maxime Chevallier wrote:
> Hi Sean,
> 
> I only 
> 
> On Tue, 10 Jun 2025 19:31:30 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> This adds support for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
>> This is a soft device which converts between GMII and either SGMII,
>> 1000Base-X, or 2500Base-X. If configured correctly, it can also switch
>> between SGMII and 1000BASE-X at runtime. Thoretically this is also possible
>> for 2500Base-X, but that requires reconfiguring the serdes. The exact
>> capabilities depend on synthesis parameters, so they are read from the
>> devicetree.
>> 
>> This device has a c22-compliant PHY interface, so for the most part we can
>> just use the phylink helpers. This device supports an interrupt which is
>> triggered on autonegotiation completion. I'm not sure how useful this is,
>> since we can never detect a link down (in the PCS).
>> 
>> This device supports sharing some logic between different implementations
>> of the device. In this case, one device contains the "shared logic" and the
>> clocks are connected to other devices. To coordinate this, one device
>> registers a clock that the other devices can request.  The clock is enabled
>> in the probe function by releasing the device from reset. There are no othe
>> software controls, so the clock ops are empty.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v6:
>> - Move axienet_pcs_fixup to AXI Ethernet commit
>> - Use an empty statement for next label
>> 
>> Changes in v5:
>> - Export get_phy_c22_id when it is used
>> - Expose bind attributes, since there is no issue in doing so
>> - Use MDIO_BUS instead of MDIO_DEVICE
>> 
>> Changes in v4:
>> - Re-add documentation for axienet_xilinx_pcs_get that was accidentally
>>   removed
>> 
>> Changes in v3:
>> - Adjust axienet_xilinx_pcs_get for changes to pcs_find_fwnode API
>> - Call devm_pcs_register instead of devm_pcs_register_provider
>> 
>> Changes in v2:
>> - Add support for #pcs-cells
>> - Change compatible to just xlnx,pcs
>> - Drop PCS_ALTERA_TSE which was accidentally added while rebasing
>> - Rework xilinx_pcs_validate to just clear out half-duplex modes instead
>>   of constraining modes based on the interface.
>> 
>>  MAINTAINERS                  |   6 +
>>  drivers/net/pcs/Kconfig      |  22 ++
>>  drivers/net/pcs/Makefile     |   2 +
>>  drivers/net/pcs/pcs-xilinx.c | 427 +++++++++++++++++++++++++++++++++++
>>  drivers/net/phy/phy_device.c |   3 +-
>>  include/linux/phy.h          |   1 +
>>  6 files changed, 460 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/net/pcs/pcs-xilinx.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0ac6ba5c40cb..496513837921 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27060,6 +27060,12 @@ L:	netdev@vger.kernel.org
>>  S:	Orphan
>>  F:	drivers/net/ethernet/xilinx/ll_temac*
>>  
>> +XILINX PCS DRIVER
>> +M:	Sean Anderson <sean.anderson@linux.dev>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/net/xilinx,pcs.yaml
>> +F:	drivers/net/pcs/pcs-xilinx.c
>> +
>>  XILINX PWM DRIVER
>>  M:	Sean Anderson <sean.anderson@seco.com>
>>  S:	Maintained
>> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
>> index f42839a0c332..e0223914362b 100644
>> --- a/drivers/net/pcs/Kconfig
>> +++ b/drivers/net/pcs/Kconfig
>> @@ -52,4 +52,26 @@ config PCS_RZN1_MIIC
>>  	  on RZ/N1 SoCs. This PCS converts MII to RMII/RGMII or can be set in
>>  	  pass-through mode for MII.
>>  
>> +config PCS_XILINX
>> +	tristate "Xilinx PCS driver"
>> +	default XILINX_AXI_EMAC
>> +	select COMMON_CLK
>> +	select GPIOLIB
>> +	select MDIO_BUS
>> +	select OF
>> +	select PCS
>> +	select PHYLINK
>> +	help
>> +	  PCS driver for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
>> +	  This device can either act as a PCS+PMA for 1000BASE-X or 2500BASE-X,
>> +	  or as a GMII-to-SGMII bridge. It can also switch between 1000BASE-X
>> +	  and SGMII dynamically if configured correctly when synthesized.
>> +	  Typical applications use this device on an FPGA connected to a GEM or
>> +	  TEMAC on the GMII side. The other side is typically connected to
>> +	  on-device gigabit transceivers, off-device SERDES devices using TBI,
>> +	  or LVDS IO resources directly.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pcs-xilinx.
>> +
>>  endmenu
>> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
>> index 35e3324fc26e..347afd91f034 100644
>> --- a/drivers/net/pcs/Makefile
>> +++ b/drivers/net/pcs/Makefile
>> @@ -10,3 +10,5 @@ obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
>>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
>>  obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
>> +obj-$(CONFIG_PCS_ALTERA_TSE)	+= pcs-altera-tse.o
> 
> There's something strange going-on here, as pcs-altera-tse was removed
> in v6.4 :)

Ah, well as it happens I have been working on this series since at least
5.10, so I guess it is left over. I will remove it for v7.

--Sean


