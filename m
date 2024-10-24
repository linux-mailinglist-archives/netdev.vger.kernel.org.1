Return-Path: <netdev+bounces-138566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3C9AE22B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24852824E2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279061C07DF;
	Thu, 24 Oct 2024 10:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114591B6CED
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764707; cv=none; b=aKModdiWuHgMr9Sj2WcooLzY8xaUw0hZbo4dxe+QBFbFUB0S/odGXyBy8/S/x/cMSB5lwYjMV1QEXnf2SFojPHr4VVerRqXFO1hLawGgtQzyv4OPcXhP/116q3mihRFr86WoMFt9JJUncJGs8O5Mf//hgW8KVJphXv08L7gD+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764707; c=relaxed/simple;
	bh=/GnD+djndyd2q7+yLzPImvqEhz8rpds0vzJGIgv3eUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1l+jvzQZjYdoLhGDij3auXlLQmr0b4wgNIydku3FA4o5SBviL/If116g7MdQqb+wTrQ4ZXR5tnN1vzgMkiqMY5em1cN0vkckRK+jCWNPzhlBNAk8A1j+ICl0CqeSTlWQEZugnLQYFwUAPBRqRi5oOWvMUCizmAjQdGXUA0LSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1t3uoS-00027H-Me; Thu, 24 Oct 2024 12:11:28 +0200
Message-ID: <6af8035f-ae5e-48a2-a3d2-a640ff7fb999@pengutronix.de>
Date: Thu, 24 Oct 2024 12:11:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead
 of "ahb"
To: Mamta Shukla <mamta.shukla@leica-geosystems.com>, dinguyen@kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20241016074159.2723256-1-mamta.shukla@leica-geosystems.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241016074159.2723256-1-mamta.shukla@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Mamta,

Thanks for your fix.

On 16.10.24 09:41, Mamta Shukla wrote:
> The "stmmaceth-ocp" reset line in dwmac-socfpga driver is required
> to get EMAC controller out of reset on Arria10[1].
> Changed in Upstream to "ahb"(331085a423b  arm64: dts: socfpga: change the
> reset-name of "stmmaceth-ocp" to "ahb" ).

To ease automatic backporting, please add:

Fixes: 331085a423b ("arm64: dts: socfpga: change the reset-name of "stmmaceth-ocp" to "ahb")

before your S-o-b.

It's probably worth pointing out in the commit message that according
to the commit message title, the change was predominantly meant for ARM64
SoCFPGA and that at least for the Arria10, it's not applicable.

> If "ahb" reset-line is used, connection via ssh is found to be slow and significant
> packet loss observed with ping.

Nitpick: In the end it's the same underlying reset line, they are just toggled for
different purposes. The ahb reset is deasserted in probe before first register access,
while crucially the stmmacheth-ocp reset needs to be asserted every time during
PHY mode reconfiguration.

> This prominently happens with Real Time Kernel
> (PREEMPT_RT enabled). Further with STMMAC-SELFTEST Driver enabled, ethtool test
> also FAILS.

FTR: I observed the same regression on v6.6.57.

> Link:[1] https://www.intel.com/content/www/us/en/docs/programmable/683711/21-2/functional-description-of-the-emac.html
> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>

Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

With commit message reworded as described above (and --subject-prefix="PATCH net"):

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

> ---
>  arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
> index f36063c57c7f..72c55e5187ca 100644
> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
> @@ -440,7 +440,7 @@ gmac0: ethernet@ff800000 {
>  			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
>  			clock-names = "stmmaceth", "ptp_ref";
>  			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
> -			reset-names = "stmmaceth", "ahb";
> +			reset-names = "stmmaceth", "stmmaceth-ocp";
>  			snps,axi-config = <&socfpga_axi_setup>;
>  			status = "disabled";
>  		};
> @@ -460,7 +460,7 @@ gmac1: ethernet@ff802000 {
>  			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
>  			clock-names = "stmmaceth", "ptp_ref";
>  			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
> -			reset-names = "stmmaceth", "ahb";
> +			reset-names = "stmmaceth", "stmmaceth-ocp";
>  			snps,axi-config = <&socfpga_axi_setup>;
>  			status = "disabled";
>  		};
> @@ -480,7 +480,7 @@ gmac2: ethernet@ff804000 {
>  			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
>  			clock-names = "stmmaceth", "ptp_ref";
>  			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
> -			reset-names = "stmmaceth", "ahb";
> +			reset-names = "stmmaceth", "stmmaceth-ocp";
>  			snps,axi-config = <&socfpga_axi_setup>;
>  			status = "disabled";
>  		};


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

