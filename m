Return-Path: <netdev+bounces-113932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94562940674
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B681C223B0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DF148302;
	Tue, 30 Jul 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0cZh5nr"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00FC8C0;
	Tue, 30 Jul 2024 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312920; cv=none; b=VvIwjTiaxK5OmE0tOMYO19K5uZ910RPw0eKb49msoAd4QzfFgVdkZgP9N82G9tktAO7yEUndLAdGmhDya9a8+9FRlT8nD7TiyadT0FjaLeiKwcoY0eFImiqmp4YG3bA259knyvz+6xeFuaPYVj1eEiLWEdOojLkIEXhwCn0xHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312920; c=relaxed/simple;
	bh=yKhGSofWwfAOF1j4MdDDoJDYbHpLaFaUDP3S/J1WTa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuIC8o9b6QeSuqkOSrdzK8znB57BoxJFbD0gYsa8tgrlEC08oq50TF+hrJsIEaotZRMI+9H1nxF3N0hPh3gz7cU1z1pk9sEkjeXsNEbCpCxbFkyrIWUPtr/OuxfqKAMPny1j7yMdjqhxX2NJVAdhKHkEofhUmPP4cYsLxfE46A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V0cZh5nr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u46sMFvuuMaySXNfye9HUANEHV0JVAtOo8sz3Uimg0k=; b=V0cZh5nrMOrz4Q4Z2tq82wW05b
	ZpWdT8ArO33FCsdebYq8iumnMIPDkfqDjswHRyUEfrPPbk6lcEx1PMiI33PcVbcS2CpR1Zk9IFJ4l
	dDezZgdUgfnp+YEJ9TPmj17vfg9QUxZBoal7moFYmvnazTS/ayrELLoOY+4uUNpxbNVrPXN39zl04
	bl/S7IX/TSsII5j+mxktOKW2RfaeC/HrVOesXF+UZzKrN33iJTaMP7b+GzNbg15mCx9TNFtZ8cJ5Q
	juFLr2xvsRcY3wTaUAZF5luIqhMg8JPDvApQEH54ppBRYYj415YEEmbn14/5Q9XTrcOICa09+aRey
	EbL4MdzA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYeGT-0000000DZOn-2JSl;
	Tue, 30 Jul 2024 04:15:09 +0000
Message-ID: <6750b19d-4af3-44c8-90a6-9cb70fcec385@infradead.org>
Date: Mon, 29 Jul 2024 21:15:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com, vladimir.oltean@nxp.com
Cc: masahiroy@kernel.org, alexanderduyck@fb.com, krzk+dt@kernel.org,
 robh@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
 Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
 Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
 linux@bigler.io
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 9:09 PM, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
> MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. The Ethernet
> Media Access Controller (MAC) module implements a 10 Mbps half duplex
> Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
> physical layer transceiver integrated is into the LAN8650/1. The PHY and
> MAC are connected via an internal Media Independent Interface (MII).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/net/ethernet/microchip/Kconfig        |   1 +
>  drivers/net/ethernet/microchip/Makefile       |   1 +
>  .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
>  .../net/ethernet/microchip/lan865x/Makefile   |   6 +
>  .../net/ethernet/microchip/lan865x/lan865x.c  | 391 ++++++++++++++++++
>  6 files changed, 424 insertions(+)
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
> 

> diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net/ethernet/microchip/lan865x/Kconfig
> new file mode 100644
> index 000000000000..f3d60d14e202
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Microchip LAN865x Driver Support
> +#
> +
> +if NET_VENDOR_MICROCHIP
> +
> +config LAN865X
> +	tristate "LAN865x support"
> +	depends on SPI
> +	depends on OA_TC6

Since OA_TC6 is described as a library, it would make sense to select OA_TC6 here instead
of depending on it.
OTOH, that might cause some Kconfig dependency issues... I haven't looked into that.

> +	help
> +	  Support for the Microchip LAN8650/1 Rev.B1 MACPHY Ethernet chip. It
> +	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called lan865x.
> +
> +endif # NET_VENDOR_MICROCHIP


-- 
~Randy

