Return-Path: <netdev+bounces-202960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7929AEFEBD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116B817900C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D852798EC;
	Tue,  1 Jul 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LCf6D5nM"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D01277CA5
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385510; cv=none; b=rjkMXh0hNcwikGW86hC3sq2th93jbYkOBDquXzBuxvL8/38nqEUiI97/xYu0+Sd+pVf3uNQZ9aoxSgph2Ly3quk4sDWrv4BAOXmYGoZ9MvaUB+m7WdCSPmup9zkP7WWrIFs8NSVq7BYeRW1xNqzxCQ9tOEu1PB6A1rrsebXIbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385510; c=relaxed/simple;
	bh=syPUi+0YtPu1O+gGSw7VCpWonVdjEchNW4o+VNeuDEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlJ+KUkpD7yZeKXOE0ZhlMnBobhISG/xd5e7JMhuXiKqnjLmvcf2n9QWfEuT4pWyBc4puOBcOXNKhL+2iyD1tMRQ+jHXBjbBWhiYFb6pOIBclFopu8ekULWJ2lZgTHgPpdzbDH191IT4FKt1CtWGIC4pD2sH65gH/89fXh6zr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LCf6D5nM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da00c7cf-a433-4498-9deb-87c34c731413@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751385506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2kAki3XpnwBL+mLkNUk+5SoguiQ5CR7AwD5fcQ1qkE=;
	b=LCf6D5nMVousjPj22Yq9MIVuXuCsGUWRMJQL8yIpDDKKskQYVmtbtQKehikg9+R6TFSI+k
	VHbp+IJMsuRaF06E9UCcz8Xk6J2YufaEsM/Kt6ByOy/tzA1zK8q/YEVNNsLUApgBaGKAOY
	iAd+YdRiUPR3RcXq3EPn65URvIMBELM=
Date: Tue, 1 Jul 2025 11:58:17 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 09/18] net: macb: sort #includes
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Harini Katakam <harini.katakam@xilinx.com>,
 Rafal Ozieblo <rafalo@cadence.com>,
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Andrew Lunn <andrew@lunn.ch>
References: <20250627-macb-v2-0-ff8207d0bb77@bootlin.com>
 <20250627-macb-v2-9-ff8207d0bb77@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250627-macb-v2-9-ff8207d0bb77@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/27/25 05:08, Théo Lebrun wrote:
> Sort #include preprocessor directives.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 36 ++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index be667cb5acce85a9d11aaea1f5081a3380b60ef2..a6633e076644089c796453f856a766299bae2ec6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -6,36 +6,36 @@
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -#include <linux/clk.h>
> +#include <linux/circ_buf.h>
>  #include <linux/clk-provider.h>
> +#include <linux/clk.h>
>  #include <linux/crc32.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/etherdevice.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/inetdevice.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ip.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/circ_buf.h>
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/interrupt.h>
>  #include <linux/netdevice.h>
> -#include <linux/etherdevice.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/platform_device.h>
> -#include <linux/phylink.h>
>  #include <linux/of.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> -#include <linux/ip.h>
> -#include <linux/udp.h>
> -#include <linux/tcp.h>
> -#include <linux/iopoll.h>
>  #include <linux/phy/phy.h>
> +#include <linux/phylink.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/ptp_classify.h>
>  #include <linux/reset.h>
> -#include <linux/firmware/xlnx-zynqmp.h>
> -#include <linux/inetdevice.h>
> +#include <linux/slab.h>
> +#include <linux/tcp.h>
> +#include <linux/types.h>
> +#include <linux/udp.h>
>  #include "macb.h"
>  
>  /* This structure is only used for MACB on SiFive FU540 devices */
> 

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

