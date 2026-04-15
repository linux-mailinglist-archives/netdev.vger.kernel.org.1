Return-Path: <netdev+bounces-278876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL8uIlMO4GmzcAAAu9opvQ
	(envelope-from <netdev+bounces-278876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:16:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F92408821
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8146830E2185
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1D3914FE;
	Wed, 15 Apr 2026 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c2mhktQu"
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC27329C48;
	Wed, 15 Apr 2026 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291317; cv=none; b=m3a/rqFYj8Dgpj29rrajQumKrmQqjt3umpEHQ1lB3PE8fHAAiTpOHbPx29terapNPNzUuqpFNvy1+kN0jKSsI97gH7e+mHPiy6Hourl5jsQ+596Njkyc+F4gRrWSyhM8X8+4ExNM5bSnnCKzXy2gW4hPpDFsjIMSREDl6Xr/GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291317; c=relaxed/simple;
	bh=z1b1UFxdUWXZgcyhqU/Rpd+VVcm1I88qx0F9mNxjsug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvYeOIPnJP0crKx+cC+2w3HSN+6ut1geYu9TpwZqdn+b9ZHRxU2OhSSvUAxVgV290uS5weN2/mN1EMQ9HEk3Su4CHRProK83JE91SWwldAnXKsbk4/OHqsTxdjJUB13o/BNcX2JA9ZVJk/6Ak4dc8jQgwFJ9j/LLVN6pGyM9fRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c2mhktQu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B63C2BC4;
	Wed, 15 Apr 2026 15:15:06 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770373F7D8;
	Wed, 15 Apr 2026 15:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776291311; bh=z1b1UFxdUWXZgcyhqU/Rpd+VVcm1I88qx0F9mNxjsug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2mhktQuHXMlQ3Vp0/splKbRfVHOUm3hLMrCSbP67GNPWY1TLIXoVn0KUsaBioJLs
	 ojRrx9hKbrMp+mpV9Zifj0BgIsdhRzC2WGhr4flEM9EE0BJbv/Pp5nK85Lcgz2IwjK
	 2vH4vOZ3pF47bKw3AeolyKTSLpMq98gdfgPs9ExA=
Date: Thu, 16 Apr 2026 00:14:46 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH RFC 7/8] clk: sunxi-ng: a733: Add bus clock gates
Message-ID: <646385ea-228b-46be-a199-02134cf76ed0@arm.com>
In-Reply-To: <20260310-a733-clk-v1-7-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
 <20260310-a733-clk-v1-7-36b4e9b24457@pigmoral.tech>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278876-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[pigmoral.tech,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.przywara@arm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid,pigmoral.tech:email]
X-Rspamd-Queue-Id: 05F92408821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

cheekily jumping in here, for the parts that are easy to verify ;-)

In general this series looks very good, and many thanks for splitting
this up in reviewable chunks, that's much appreciated!

On 3/10/26 09:34, Junhui Liu wrote:
> Add the bus clock gates that control access to the devices' register
> interface on the Allwinner A733 SoC. These clocks are typically
> single-bit controls in the BGR registers, covering UARTs, SPI, I2C, and
> various multimedia engines. It also includes bus gates for system
> components like the IOMMU and MSI-lite interfaces.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> 
> ---
> The parents of some bus clocks are difficult to determine, as the user
> manual only describes the clock source for a few instances. The current
> configurations are based on references to previous Allwinner SoCs and
> information gathered from the manual. Where documentation is lacking,
> vendor practices are followed by setting the parent to "hosc" for now.
> ---
>   drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 475 ++++++++++++++++++++++++++++++++-
>   1 file changed, 474 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> index 36b44568a56f..c0b09f9197d1 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> @@ -408,16 +408,19 @@ static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
>   				 0, 5,		/* M */
>   				 24, 2,		/* mux */
>   				 0);
> +static const struct clk_hw *ahb_hws[] = { &ahb_clk.common.hw };
>   
>   static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
>   				 0, 5,		/* M */
>   				 24, 2,		/* mux */
>   				 0);
> +static const struct clk_hw *apb0_hws[] = { &apb0_clk.common.hw };
>   
>   static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
>   				 0, 5,		/* M */
>   				 24, 2,		/* mux */
>   				 0);
> +static const struct clk_hw *apb1_hws[] = { &apb1_clk.common.hw };
>   
>   static const struct clk_parent_data apb_uart_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -430,6 +433,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x5
>   				 0, 5,		/* M */
>   				 24, 3,		/* mux */
>   				 0);
> +static const struct clk_hw *apb_uart_hws[] = {
> +	&apb_uart_clk.common.hw
> +};
>   
>   static const struct clk_parent_data trace_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -463,6 +469,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(cpu_peri_clk, "cpu-peri", gic_cpu_peri_par
>   				      BIT(31),	/* gate */
>   				      0);
>   
> +static SUNXI_CCU_GATE_DATA(bus_its_pcie_clk, "bus-its-pcie", hosc, 0x574, BIT(1), 0);
> +
>   static const struct clk_parent_data nsi_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
>   	{ .hw = &pll_ddr_clk.common.hw },
> @@ -477,6 +485,7 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(nsi_clk, "nsi", nsi_parents, 0x580,
>   					    24, 3,	/* mux */
>   					    BIT(31),	/* gate */
>   					    0, CCU_FEATURE_UPDATE_BIT);
> +static SUNXI_CCU_GATE_DATA(bus_nsi_clk, "bus-nsi", hosc, 0x584, BIT(0), 0);
>   
>   static const struct clk_parent_data mbus_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -493,9 +502,117 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x58
>   					    BIT(31),	/* gate */
>   					    CLK_IS_CRITICAL,
>   					    CCU_FEATURE_UPDATE_BIT);
> +static const struct clk_hw *mbus_hws[] = { &mbus_clk.common.hw };
> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", mbus_hws, 0x58c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb0_hws, 0x58c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb_hws, 0x58c, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc, 0x594, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc, 0x59c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc, 0x5a4, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbus_hws, 0x5b4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb_iommu1-sys", apb0_hws, 0x5b4, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb_iommu1-sys", ahb_hws, 0x5b4, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
> +			  0x5c0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
> +			  0x5c0, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
> +			  0x5c0, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_hws,
> +			  0x5c0, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_hws,
> +			  0x5c0, BIT(4), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
> +			  0x5c0, BIT(5), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
> +			  0x5c0, BIT(6), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
> +			  0x5c0, BIT(7), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
> +			  0x5c0, BIT(8), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
> +			  0x5c0, BIT(9), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_hws,
> +			  0x5c0, BIT(16), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
> +			  0x5c0, BIT(24), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
> +			  0x5c0, BIT(28), 0);
> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
> +			  0x5e0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
> +			  0x5e0, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
> +			  0x5e0, BIT(11), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc_gate_clk, "mbus-ve-enc-gate", mbus_hws,
> +			  0x5e0, BIT(12), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec_gate_clk, "mbus-ve-dec-gate", mbus_hws,
> +			  0x5e0, BIT(14), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
> +			  0x5e0, BIT(16), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
> +			  0x5e0, BIT(18), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
> +			  0x5e0, BIT(24), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
> +			  0x5e0, BIT(28), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbus_hws,
> +			  0x5e0, BIT(29), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
> +			  0x5e0, BIT(30), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbus_hws,
> +			  0x5e0, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
> +			  0x5e4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc_clk, "mbus-ve-enc", mbus_hws,
> +			  0x5e4, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
> +			  0x5e4, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
> +			  0x5e4, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
> +			  0x5e4, BIT(5), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
> +			  0x5e4, BIT(8), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
> +			  0x5e4, BIT(9), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
> +			  0x5e4, BIT(11), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
> +			  0x5e4, BIT(12), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec_clk, "mbus-ve-dec", mbus_hws,
> +			  0x5e4, BIT(18), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dma0_clk, "bus-dma0", ahb_hws,
> +			  0x704, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_dma1_clk, "bus-dma1", ahb_hws,
> +			  0x70c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_spinlock_clk, "bus-spinlock", ahb_hws,
> +			  0x724, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws,
> +			  0x744, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_pwm0_clk, "bus-pwm0", apb0_hws,
> +			  0x784, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_pwm1_clk, "bus-pwm1", apb0_hws,
> +			  0x78c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dbg_clk, "bus-dbg", sys_24M_hws,
> +			  0x7a4, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_sysdap_clk, "bus-sysdap", apb1_hws,
> +			  0x88c, BIT(0), 0);
>   
>   /**************************************************************************
> - *                          mod clocks                                    *
> + *                          mod clocks with gates                         *
>    **************************************************************************/
>   
>   static const struct clk_parent_data timer_parents[] = {
> @@ -565,6 +682,7 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer9_clk, "timer9", timer_parents, 0x82
>   				       24, 3,		/* mux */
>   				       BIT(31),		/* gate */
>   				       0);
> +static SUNXI_CCU_GATE_HWS(bus_timer_clk, "bus-timer", ahb_hws, 0x850, BIT(0), 0);
>   
>   static const struct clk_parent_data avs_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -589,6 +707,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_parents, 0xa00,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE_HWS(bus_de_clk, "bus-de", ahb_hws, 0xa04, BIT(0), 0);
>   
>   static const struct clk_hw *di_parents[] = {
>   	&pll_periph0_600M_clk.hw,
> @@ -602,6 +721,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0xa20,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE_HWS(bus_di_clk, "bus-di", ahb_hws, 0xa24, BIT(0), 0);
>   
>   static const struct clk_hw *g2d_parents[] = {
>   	&pll_periph0_400M_clk.hw,
> @@ -614,6 +734,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0xa40,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE_HWS(bus_g2d_clk, "bus-g2d", ahb_hws, 0xa44, BIT(0), 0);
>   
>   static const struct clk_hw *eink_parents[] = {
>   	&pll_periph0_480M_clk.common.hw,
> @@ -637,6 +758,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_panel_clk, "eink-panel", eink_panel_par
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE_HWS(bus_eink_clk, "bus-eink", ahb_hws, 0xa6c, BIT(0), 0);
>   
>   static const struct clk_hw *ve_enc_parents[] = {
>   	&pll_ve0_clk.common.hw,
> @@ -668,6 +790,9 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_dec_clk, "ve-dec", ve_dec_parents, 0xa88,
>   				    BIT(31),	/* gate */
>   				    CLK_SET_RATE_PARENT);
>   
> +static SUNXI_CCU_GATE_HWS(bus_ve_enc_clk, "bus-ve-enc", ahb_hws, 0xa8c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_ve_dec_clk, "bus-ve-dec", ahb_hws, 0xa8c, BIT(2), 0);
> +
>   static const struct clk_hw *ce_parents[] = {
>   	&sys_24M_clk.hw,
>   	&pll_periph0_400M_clk.hw,
> @@ -678,6 +803,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0xac0,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_HWS(bus_ce_clk, "bus-ce", ahb_hws, 0xac4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_ce_sys_clk, "bus-ce-sys", ahb_hws, 0xac4, BIT(1), 0);
>   
>   static const struct clk_hw *npu_parents[] = {
>   	&pll_npu_clk.common.hw,
> @@ -693,6 +820,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0xb00,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_DATA(bus_npu_clk, "bus-npu", hosc, 0xb04, BIT(0), 0);
>   
>   /*
>    * GPU_CLK = ClockSource * ((16 - M) / 16)
> @@ -725,6 +853,7 @@ static struct ccu_div gpu_clk = {
>   							   &ccu_div_ops, 0),
>   	}
>   };
> +static SUNXI_CCU_GATE_HWS(bus_gpu_clk, "bus-gpu", ahb_hws, 0xb24, BIT(0), 0);
>   
>   static const struct clk_parent_data dram_parents[] = {
>   	{ .hw = &pll_ddr_clk.common.hw, },
> @@ -740,6 +869,7 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(dram_clk, "dram", dram_parents, 0xc0
>   					    BIT(31),	/* gate */
>   					    CLK_IS_CRITICAL,
>   					    CCU_FEATURE_UPDATE_BIT);
> +static SUNXI_CCU_GATE_HWS(bus_dram_clk, "bus-dram", ahb_hws, 0xc0c, BIT(0), 0);
>   
>   static const struct clk_parent_data nand_mmc_parents[] = {
>   	{ .hw = &sys_24M_clk.hw, },
> @@ -758,6 +888,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_mmc_parents, 0xc8
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_HWS(bus_nand_clk, "bus-nand", ahb_hws, 0xc8c, BIT(0), 0);
>   
>   static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc0_clk, "mmc0", nand_mmc_parents, 0xd00,
>   					     0, 5,	/* M */
> @@ -796,6 +927,11 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc3_clk, "mmc3", mmc2_mmc3_parents
>   					     2,		/* post div */
>   					     0);
>   
> +static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", ahb_hws, 0xd0c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_mmc1_clk, "bus-mmc1", ahb_hws, 0xd1c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_mmc2_clk, "bus-mmc2", ahb_hws, 0xd2c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_mmc3_clk, "bus-mmc3", ahb_hws, 0xd3c, BIT(0), 0);
> +
>   static const struct clk_hw *ufs_axi_parents[] = {
>   	&pll_periph0_300M_clk.hw,
>   	&pll_periph0_200M_clk.hw,
> @@ -815,6 +951,29 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ufs_cfg_clk, "ufs-cfg", ufs_cfg_parents, 0
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_DATA(bus_ufs_clk, "bus-ufs", hosc, 0xd8c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_uart0_clk, "bus-uart0", apb_uart_hws, 0xe00, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart1_clk, "bus-uart1", apb_uart_hws, 0xe04, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart2_clk, "bus-uart2", apb_uart_hws, 0xe08, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart3_clk, "bus-uart3", apb_uart_hws, 0xe0c, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart4_clk, "bus-uart4", apb_uart_hws, 0xe10, BIT(4), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart5_clk, "bus-uart5", apb_uart_hws, 0xe14, BIT(5), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart6_clk, "bus-uart6", apb_uart_hws, 0xe18, BIT(6), 0);

According to the manual the gate bits are always BIT(0), since each
UART has its own bus gate register.

> +static SUNXI_CCU_GATE_HWS(bus_i2c0_clk, "bus-i2c0", apb1_hws, 0xe80, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c1_clk, "bus-i2c1", apb1_hws, 0xe84, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws, 0xe88, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws, 0xe8c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c4_clk, "bus-i2c4", apb1_hws, 0xe90, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c5_clk, "bus-i2c5", apb1_hws, 0xe94, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c6_clk, "bus-i2c6", apb1_hws, 0xe98, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c7_clk, "bus-i2c7", apb1_hws, 0xe9c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c8_clk, "bus-i2c8", apb1_hws, 0xea0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c9_clk, "bus-i2c9", apb1_hws, 0xea4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c10_clk, "bus-i2c10", apb1_hws, 0xea8, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c11_clk, "bus-i2c11", apb1_hws, 0xeac, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c12_clk, "bus-i2c12", apb1_hws, 0xeb0, BIT(0), 0);
>   
>   static const struct clk_parent_data spi_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -856,6 +1015,11 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(spi4_clk, "spi4", spi_parents, 0xf28,
>   				  24, 3,	/* mux */
>   				  BIT(31),	/* gate */
>   				  0);
> +static SUNXI_CCU_GATE_HWS(bus_spi0_clk, "bus-spi0", ahb_hws, 0xf04, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi1_clk, "bus-spi1", ahb_hws, 0xf0c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi2_clk, "bus-spi2", ahb_hws, 0xf14, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi3_clk, "bus-spi3", ahb_hws, 0xf24, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi4_clk, "bus-spi4", ahb_hws, 0xf2c, BIT(0), 0);
>   
>   static const struct clk_parent_data spif_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -873,6 +1037,7 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(spif_clk, "spif", spif_parents, 0xf18,
>   				  24, 3,	/* mux */
>   				  BIT(31),	/* gate */
>   				  0);
> +static SUNXI_CCU_GATE_HWS(bus_spif_clk, "bus-spif", ahb_hws, 0xf1c, BIT(0), 0);

Can you please move that line into the other SPI gates above, so that
it is ordered by address?

>   
>   static const struct clk_parent_data gpadc_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -883,6 +1048,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gpadc_clk, "gpadc", gpadc_parents, 0xfc0,
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_HWS(bus_gpadc_clk, "bus-gpadc", ahb_hws, 0xfc4, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_ths_clk, "bus-ths", apb0_hws, 0xfe4, BIT(0), 0);
>   
>   static const struct clk_parent_data irrx_parents[] = {
>   	{ .fw_name = "losc"},
> @@ -894,6 +1062,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irrx_clk, "irrx", irrx_parents, 0x1000,
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_HWS(bus_irrx_clk, "bus-irrx", apb0_hws, 0x1004, BIT(0), 0);
>   
>   static const struct clk_parent_data irtx_parents[] = {
>   	{ .fw_name = "losc"},
> @@ -905,6 +1074,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irtx_clk, "irtx", irtx_parents, 0x1008,
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_HWS(bus_irtx_clk, "bus-irtx", apb0_hws, 0x100c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_lradc_clk, "bus-lradc", apb0_hws, 0x1024, BIT(0), 0);
>   
>   static const struct clk_parent_data sgpio_parents[] = {
>   	{ .fw_name = "losc"},
> @@ -915,6 +1087,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(sgpio_clk, "sgpio", sgpio_parents, 0x1060,
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_DATA(bus_sgpio_clk, "bus-sgpio", hosc, 0x1064, BIT(0), 0);
>   
>   static const struct clk_hw *lpc_parents[] = {
>   	&pll_video0_3x_clk.common.hw,
> @@ -927,6 +1100,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(lpc_clk, "lpc", lpc_parents, 0x1080,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_DATA(bus_lpc_clk, "bus-lpc", hosc, 0x1084, BIT(0), 0);

where do these two clocks come from? They are not mentioned in the 
version of the manual I am looking at. If they come from BSP sources, 
please add a comment about that.

>   
>   static const struct clk_hw *i2spcm_parents[] = {
>   	&pll_audio0_4x_clk.common.hw,
> @@ -959,6 +1133,11 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm4_clk, "i2spcm4", i2spcm_parents, 0x12
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_DATA(bus_i2spcm0_clk, "bus-i2spcm0", hosc, 0x120c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2spcm1_clk, "bus-i2spcm1", hosc, 0x121c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2spcm2_clk, "bus-i2spcm2", hosc, 0x122c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2spcm3_clk, "bus-i2spcm3", hosc, 0x123c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2spcm4_clk, "bus-i2spcm4", hosc, 0x124c, BIT(0), 0);
>   
>   static const struct clk_hw *i2spcm2_asrc_parents[] = {
>   	&pll_audio0_4x_clk.common.hw,
> @@ -995,6 +1174,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(owa_rx_clk, "owa_rx", owa_rx_parents, 0x1284
>   				    BIT(31),	/* gate */
>   				    0);
>   
> +static SUNXI_CCU_GATE_HWS(bus_owa_clk, "bus-owa", apb1_hws, 0x128c, BIT(0), 0);

In mainline we use "spdif" instead of "owa", compare the other drivers.

> +
>   static const struct clk_hw *dmic_parents[] = {
>   	&pll_audio0_4x_clk.common.hw,
>   	&pll_audio1_div2_clk.common.hw,
> @@ -1006,6 +1187,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dmic_clk, "dmic", dmic_parents, 0x12c0,
>   				    BIT(31),	/* gate */
>   				    0);
>   
> +static SUNXI_CCU_GATE_HWS(bus_dmic_clk, "bus-dmic", apb1_hws, 0x12cc, BIT(0), 0);
> +
>   /*
>    * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
>    * a 2x multiplier from pll-ref synchronized by pll-periph0, and is also used by
> @@ -1037,6 +1220,9 @@ static struct ccu_mux usb_ohci0_clk = {
>   							   &ccu_mux_ops, 0),
>   	},
>   };
> +static SUNXI_CCU_GATE_HWS(bus_ohci0_clk, "bus-ohci0", ahb_hws, 0x1304, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_ehci0_clk, "bus-ehci0", ahb_hws, 0x1304, BIT(4), 0);
> +static SUNXI_CCU_GATE_HWS(bus_otg_clk, "bus-otg", ahb_hws, 0x1304, BIT(8), 0);
>   
>   static struct ccu_mux usb_ohci1_clk = {
>   	.enable		= BIT(31),
> @@ -1053,6 +1239,8 @@ static struct ccu_mux usb_ohci1_clk = {
>   							   &ccu_mux_ops, 0),
>   	},
>   };
> +static SUNXI_CCU_GATE_HWS(bus_ohci1_clk, "bus-ohci1", ahb_hws, 0x130c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_ehci1_clk, "bus-ehci1", ahb_hws, 0x130c, BIT(4), 0);
>   
>   static const struct clk_parent_data usb_ref_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -1159,6 +1347,8 @@ static SUNXI_CCU_M_HWS_WITH_GATE(gmac1_phy_clk, "gmac1-phy", pll_periph0_150M_hw
>   				 0, 5,		/* M */
>   				 BIT(31),	/* gate */
>   				 0);
> +static SUNXI_CCU_GATE_HWS(bus_gmac0_clk, "bus-gmac0", ahb_hws, 0x141c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_gmac1_clk, "bus-gmac1", ahb_hws, 0x142c, BIT(0), 0);

That GMAC1 clock is not in the manual, where does it come from?

>   
>   static const struct clk_hw *tcon_lcd_parents[] = {
>   	&pll_video0_4x_clk.common.hw,
> @@ -1181,6 +1371,9 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd2_clk, "tcon-lcd2", tcon_lcd_parents
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd0_clk, "bus-tcon-lcd0", ahb_hws, 0x1504, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd1_clk, "bus-tcon-lcd1", ahb_hws, 0x150c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd2_clk, "bus-tcon-lcd2", ahb_hws, 0x1514, BIT(0), 0);

Same here, LCD2 is not listed.

The rest looks alright when comparing to the manual, also the whole
boilerplate with the SUNXI_CC_GATE_HWS macro, the list of hw clocks
below and the assignment of the clock IDs to the clocks.

Cheers,
Andre

>   
>   static const struct clk_hw *dsi_parents[] = {
>   	&sys_24M_clk.hw,
> @@ -1197,6 +1390,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi1_clk, "dsi1", dsi_parents, 0x1588,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_HWS(bus_dsi0_clk, "bus-dsi0", ahb_hws, 0x1584, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_dsi1_clk, "bus-dsi1", ahb_hws, 0x158c, BIT(0), 0);
>   
>   static const struct clk_hw *combphy_parents[] = {
>   	&pll_video0_4x_clk.common.hw,
> @@ -1216,6 +1411,9 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy1_clk, "combphy1", combphy_parents, 0
>   				    BIT(31),	/* gate */
>   				    0);
>   
> +static SUNXI_CCU_GATE_HWS(bus_tcon_tv0_clk, "bus-tcon-tv0", ahb_hws, 0x1604, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_tcon_tv1_clk, "bus-tcon-tv1", ahb_hws, 0x160c, BIT(0), 0);
> +
>   static const struct clk_hw *edp_tv_parents[] = {
>   	&pll_video0_4x_clk.common.hw,
>   	&pll_video1_4x_clk.common.hw,
> @@ -1227,6 +1425,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_tv_clk, "edp-tv", edp_tv_parents, 0x1640
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_HWS(bus_edp_tv_clk, "bus-edp-tv", ahb_hws, 0x164c, BIT(0), 0);
>   
>   static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k", pll_periph0_2x_hws, 0x1680,
>   				      BIT(30),	/* gate */
> @@ -1254,6 +1453,7 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(hdmi_tv_clk, "hdmi-tv", hdmi_tv_parents, 0x168
>   				  24, 3,	/* mux */
>   				  BIT(31),	/* gate */
>   				  0);
> +static SUNXI_CCU_GATE_HWS(bus_hdmi_tv_clk, "bus-hdmi-tv", ahb_hws, 0x168c, BIT(0), 0);
>   
>   static const struct clk_parent_data hdmi_sfr_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -1266,6 +1466,9 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_sfr_clk, "hdmi-sfr", hdmi_sfr_parents,
>   
>   static SUNXI_CCU_GATE_HWS(hdmi_esm_clk, "hdmi-esm", pll_periph0_300M_hws, 0x1694, BIT(31), 0);
>   
> +static SUNXI_CCU_GATE_HWS(bus_dpss_top0_clk, "bus-dpss-top0", ahb_hws, 0x16c4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_dpss_top1_clk, "bus-dpss-top1", ahb_hws, 0x16cc, BIT(0), 0);
> +
>   static const struct clk_parent_data ledc_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
>   	{ .hw = &pll_periph0_600M_clk.hw },
> @@ -1276,6 +1479,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0x1700,
>   				      24, 3,	/* mux */
>   				      BIT(31),	/* gate */
>   				      0);
> +static SUNXI_CCU_GATE_HWS(bus_ledc_clk, "bus-ledc", apb0_hws, 0x1704, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dsc_clk, "bus-dsc", ahb_hws, 0x1744, BIT(0), 0);
>   
>   static const struct clk_parent_data csi_master_parents[] = {
>   	{ .hw = &sys_24M_clk.hw },
> @@ -1317,6 +1523,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_clk, "csi", csi_parents, 0x1840,
>   				    24, 3,	/* mux */
>   				    BIT(31),	/* gate */
>   				    0);
> +static SUNXI_CCU_GATE_HWS(bus_csi_clk, "bus-csi", ahb_hws, 0x1844, BIT(0), 0);
>   
>   static const struct clk_hw *isp_parents[] = {
>   	&pll_video2_4x_clk.common.hw,
> @@ -1446,8 +1653,62 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
>   	&trace_clk.common,
>   	&gic_clk.common,
>   	&cpu_peri_clk.common,
> +	&bus_its_pcie_clk.common,
>   	&nsi_clk.common,
> +	&bus_nsi_clk.common,
>   	&mbus_clk.common,
> +	&mbus_iommu0_sys_clk.common,
> +	&apb_iommu0_sys_clk.common,
> +	&ahb_iommu0_sys_clk.common,
> +	&bus_msi_lite0_clk.common,
> +	&bus_msi_lite1_clk.common,
> +	&bus_msi_lite2_clk.common,
> +	&mbus_iommu1_sys_clk.common,
> +	&apb_iommu1_sys_clk.common,
> +	&ahb_iommu1_sys_clk.common,
> +	&ahb_ve_dec_clk.common,
> +	&ahb_ve_enc_clk.common,
> +	&ahb_vid_in_clk.common,
> +	&ahb_vid_cout0_clk.common,
> +	&ahb_vid_cout1_clk.common,
> +	&ahb_de_clk.common,
> +	&ahb_npu_clk.common,
> +	&ahb_gpu0_clk.common,
> +	&ahb_serdes_clk.common,
> +	&ahb_usb_sys_clk.common,
> +	&ahb_msi_lite0_clk.common,
> +	&ahb_store_clk.common,
> +	&ahb_cpus_clk.common,
> +	&mbus_iommu0_clk.common,
> +	&mbus_iommu1_clk.common,
> +	&mbus_desys_clk.common,
> +	&mbus_ve_enc_gate_clk.common,
> +	&mbus_ve_dec_gate_clk.common,
> +	&mbus_gpu0_clk.common,
> +	&mbus_npu_clk.common,
> +	&mbus_vid_in_clk.common,
> +	&mbus_serdes_clk.common,
> +	&mbus_msi_lite0_clk.common,
> +	&mbus_store_clk.common,
> +	&mbus_msi_lite2_clk.common,
> +	&mbus_dma0_clk.common,
> +	&mbus_ve_enc_clk.common,
> +	&mbus_ce_clk.common,
> +	&mbus_dma1_clk.common,
> +	&mbus_nand_clk.common,
> +	&mbus_csi_clk.common,
> +	&mbus_isp_clk.common,
> +	&mbus_gmac0_clk.common,
> +	&mbus_gmac1_clk.common,
> +	&mbus_ve_dec_clk.common,
> +	&bus_dma0_clk.common,
> +	&bus_dma1_clk.common,
> +	&bus_spinlock_clk.common,
> +	&bus_msgbox_clk.common,
> +	&bus_pwm0_clk.common,
> +	&bus_pwm1_clk.common,
> +	&bus_dbg_clk.common,
> +	&bus_sysdap_clk.common,
>   	&timer0_clk.common,
>   	&timer1_clk.common,
>   	&timer2_clk.common,
> @@ -1458,48 +1719,111 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
>   	&timer7_clk.common,
>   	&timer8_clk.common,
>   	&timer9_clk.common,
> +	&bus_timer_clk.common,
>   	&avs_clk.common,
>   	&de_clk.common,
> +	&bus_de_clk.common,
>   	&di_clk.common,
> +	&bus_di_clk.common,
>   	&g2d_clk.common,
> +	&bus_g2d_clk.common,
>   	&eink_clk.common,
>   	&eink_panel_clk.common,
> +	&bus_eink_clk.common,
>   	&ve_enc_clk.common,
>   	&ve_dec_clk.common,
> +	&bus_ve_enc_clk.common,
> +	&bus_ve_dec_clk.common,
>   	&ce_clk.common,
> +	&bus_ce_clk.common,
> +	&bus_ce_sys_clk.common,
>   	&npu_clk.common,
> +	&bus_npu_clk.common,
>   	&gpu_clk.common,
> +	&bus_gpu_clk.common,
>   	&dram_clk.common,
> +	&bus_dram_clk.common,
>   	&nand0_clk.common,
>   	&nand1_clk.common,
> +	&bus_nand_clk.common,
>   	&mmc0_clk.common,
>   	&mmc1_clk.common,
>   	&mmc2_clk.common,
>   	&mmc3_clk.common,
> +	&bus_mmc0_clk.common,
> +	&bus_mmc1_clk.common,
> +	&bus_mmc2_clk.common,
> +	&bus_mmc3_clk.common,
>   	&ufs_axi_clk.common,
>   	&ufs_cfg_clk.common,
> +	&bus_ufs_clk.common,
> +	&bus_uart0_clk.common,
> +	&bus_uart1_clk.common,
> +	&bus_uart2_clk.common,
> +	&bus_uart3_clk.common,
> +	&bus_uart4_clk.common,
> +	&bus_uart5_clk.common,
> +	&bus_uart6_clk.common,
> +	&bus_i2c0_clk.common,
> +	&bus_i2c1_clk.common,
> +	&bus_i2c2_clk.common,
> +	&bus_i2c3_clk.common,
> +	&bus_i2c4_clk.common,
> +	&bus_i2c5_clk.common,
> +	&bus_i2c6_clk.common,
> +	&bus_i2c7_clk.common,
> +	&bus_i2c8_clk.common,
> +	&bus_i2c9_clk.common,
> +	&bus_i2c10_clk.common,
> +	&bus_i2c11_clk.common,
> +	&bus_i2c12_clk.common,
>   	&spi0_clk.common,
>   	&spi1_clk.common,
>   	&spi2_clk.common,
>   	&spi3_clk.common,
>   	&spi4_clk.common,
> +	&bus_spi0_clk.common,
> +	&bus_spi1_clk.common,
> +	&bus_spi2_clk.common,
> +	&bus_spi3_clk.common,
> +	&bus_spi4_clk.common,
>   	&spif_clk.common,
> +	&bus_spif_clk.common,
>   	&gpadc_clk.common,
> +	&bus_gpadc_clk.common,
> +	&bus_ths_clk.common,
>   	&irrx_clk.common,
> +	&bus_irrx_clk.common,
>   	&irtx_clk.common,
> +	&bus_irtx_clk.common,
> +	&bus_lradc_clk.common,
>   	&sgpio_clk.common,
> +	&bus_sgpio_clk.common,
>   	&lpc_clk.common,
> +	&bus_lpc_clk.common,
>   	&i2spcm0_clk.common,
>   	&i2spcm1_clk.common,
>   	&i2spcm2_clk.common,
>   	&i2spcm3_clk.common,
>   	&i2spcm4_clk.common,
> +	&bus_i2spcm0_clk.common,
> +	&bus_i2spcm1_clk.common,
> +	&bus_i2spcm2_clk.common,
> +	&bus_i2spcm3_clk.common,
> +	&bus_i2spcm4_clk.common,
>   	&i2spcm2_asrc_clk.common,
>   	&owa_tx_clk.common,
>   	&owa_rx_clk.common,
> +	&bus_owa_clk.common,
>   	&dmic_clk.common,
> +	&bus_dmic_clk.common,
>   	&usb_ohci0_clk.common,
> +	&bus_otg_clk.common,
> +	&bus_ehci0_clk.common,
> +	&bus_ohci0_clk.common,
>   	&usb_ohci1_clk.common,
> +	&bus_ehci1_clk.common,
> +	&bus_ohci1_clk.common,
>   	&usb_ref_clk.common,
>   	&usb2_u2_ref_clk.common,
>   	&usb2_suspend_clk.common,
> @@ -1512,24 +1836,40 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
>   	&gmac_ptp_clk.common,
>   	&gmac0_phy_clk.common,
>   	&gmac1_phy_clk.common,
> +	&bus_gmac0_clk.common,
> +	&bus_gmac1_clk.common,
>   	&tcon_lcd0_clk.common,
>   	&tcon_lcd1_clk.common,
>   	&tcon_lcd2_clk.common,
> +	&bus_tcon_lcd0_clk.common,
> +	&bus_tcon_lcd1_clk.common,
> +	&bus_tcon_lcd2_clk.common,
>   	&dsi0_clk.common,
>   	&dsi1_clk.common,
> +	&bus_dsi0_clk.common,
> +	&bus_dsi1_clk.common,
>   	&combphy0_clk.common,
>   	&combphy1_clk.common,
> +	&bus_tcon_tv0_clk.common,
> +	&bus_tcon_tv1_clk.common,
>   	&edp_tv_clk.common,
> +	&bus_edp_tv_clk.common,
>   	&hdmi_cec_32k_clk.common,
>   	&hdmi_cec_clk.common,
>   	&hdmi_tv_clk.common,
> +	&bus_hdmi_tv_clk.common,
>   	&hdmi_sfr_clk.common,
>   	&hdmi_esm_clk.common,
> +	&bus_dpss_top0_clk.common,
> +	&bus_dpss_top1_clk.common,
>   	&ledc_clk.common,
> +	&bus_ledc_clk.common,
> +	&bus_dsc_clk.common,
>   	&csi_master0_clk.common,
>   	&csi_master1_clk.common,
>   	&csi_master2_clk.common,
>   	&csi_clk.common,
> +	&bus_csi_clk.common,
>   	&isp_clk.common,
>   	&apb2jtag_clk.common,
>   	&fanout_24M_clk.common,
> @@ -1596,8 +1936,62 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   		[CLK_TRACE]		= &trace_clk.common.hw,
>   		[CLK_GIC]		= &gic_clk.common.hw,
>   		[CLK_CPU_PERI]		= &cpu_peri_clk.common.hw,
> +		[CLK_BUS_ITS_PCIE]	= &bus_its_pcie_clk.common.hw,
>   		[CLK_NSI]		= &nsi_clk.common.hw,
> +		[CLK_BUS_NSI]		= &bus_nsi_clk.common.hw,
>   		[CLK_MBUS]		= &mbus_clk.common.hw,
> +		[CLK_MBUS_IOMMU0_SYS]	= &mbus_iommu0_sys_clk.common.hw,
> +		[CLK_APB_IOMMU0_SYS]	= &apb_iommu0_sys_clk.common.hw,
> +		[CLK_AHB_IOMMU0_SYS]	= &ahb_iommu0_sys_clk.common.hw,
> +		[CLK_BUS_MSI_LITE0]	= &bus_msi_lite0_clk.common.hw,
> +		[CLK_BUS_MSI_LITE1]	= &bus_msi_lite1_clk.common.hw,
> +		[CLK_BUS_MSI_LITE2]	= &bus_msi_lite2_clk.common.hw,
> +		[CLK_MBUS_IOMMU1_SYS]	= &mbus_iommu1_sys_clk.common.hw,
> +		[CLK_APB_IOMMU1_SYS]	= &apb_iommu1_sys_clk.common.hw,
> +		[CLK_AHB_IOMMU1_SYS]	= &ahb_iommu1_sys_clk.common.hw,
> +		[CLK_AHB_VE_DEC]	= &ahb_ve_dec_clk.common.hw,
> +		[CLK_AHB_VE_ENC]	= &ahb_ve_enc_clk.common.hw,
> +		[CLK_AHB_VID_IN]	= &ahb_vid_in_clk.common.hw,
> +		[CLK_AHB_VID_COUT0]	= &ahb_vid_cout0_clk.common.hw,
> +		[CLK_AHB_VID_COUT1]	= &ahb_vid_cout1_clk.common.hw,
> +		[CLK_AHB_DE]		= &ahb_de_clk.common.hw,
> +		[CLK_AHB_NPU]		= &ahb_npu_clk.common.hw,
> +		[CLK_AHB_GPU0]		= &ahb_gpu0_clk.common.hw,
> +		[CLK_AHB_SERDES]	= &ahb_serdes_clk.common.hw,
> +		[CLK_AHB_USB_SYS]	= &ahb_usb_sys_clk.common.hw,
> +		[CLK_AHB_MSI_LITE0]	= &ahb_msi_lite0_clk.common.hw,
> +		[CLK_AHB_STORE]		= &ahb_store_clk.common.hw,
> +		[CLK_AHB_CPUS]		= &ahb_cpus_clk.common.hw,
> +		[CLK_MBUS_IOMMU0]	= &mbus_iommu0_clk.common.hw,
> +		[CLK_MBUS_IOMMU1]	= &mbus_iommu1_clk.common.hw,
> +		[CLK_MBUS_DESYS]	= &mbus_desys_clk.common.hw,
> +		[CLK_MBUS_VE_ENC_GATE]	= &mbus_ve_enc_gate_clk.common.hw,
> +		[CLK_MBUS_VE_DEC_GATE]	= &mbus_ve_dec_gate_clk.common.hw,
> +		[CLK_MBUS_GPU0]		= &mbus_gpu0_clk.common.hw,
> +		[CLK_MBUS_NPU]		= &mbus_npu_clk.common.hw,
> +		[CLK_MBUS_VID_IN]	= &mbus_vid_in_clk.common.hw,
> +		[CLK_MBUS_SERDES]	= &mbus_serdes_clk.common.hw,
> +		[CLK_MBUS_MSI_LITE0]	= &mbus_msi_lite0_clk.common.hw,
> +		[CLK_MBUS_STORE]	= &mbus_store_clk.common.hw,
> +		[CLK_MBUS_MSI_LITE2]	= &mbus_msi_lite2_clk.common.hw,
> +		[CLK_MBUS_DMA0]		= &mbus_dma0_clk.common.hw,
> +		[CLK_MBUS_VE_ENC]	= &mbus_ve_enc_clk.common.hw,
> +		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
> +		[CLK_MBUS_DMA1]		= &mbus_dma1_clk.common.hw,
> +		[CLK_MBUS_NAND]		= &mbus_nand_clk.common.hw,
> +		[CLK_MBUS_CSI]		= &mbus_csi_clk.common.hw,
> +		[CLK_MBUS_ISP]		= &mbus_isp_clk.common.hw,
> +		[CLK_MBUS_GMAC0]	= &mbus_gmac0_clk.common.hw,
> +		[CLK_MBUS_GMAC1]	= &mbus_gmac1_clk.common.hw,
> +		[CLK_MBUS_VE_DEC]	= &mbus_ve_dec_clk.common.hw,
> +		[CLK_BUS_DMA0]		= &bus_dma0_clk.common.hw,
> +		[CLK_BUS_DMA1]		= &bus_dma1_clk.common.hw,
> +		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
> +		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
> +		[CLK_BUS_PWM0]		= &bus_pwm0_clk.common.hw,
> +		[CLK_BUS_PWM1]		= &bus_pwm1_clk.common.hw,
> +		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
> +		[CLK_BUS_SYSDAP]	= &bus_sysdap_clk.common.hw,
>   		[CLK_TIMER0]		= &timer0_clk.common.hw,
>   		[CLK_TIMER1]		= &timer1_clk.common.hw,
>   		[CLK_TIMER2]		= &timer2_clk.common.hw,
> @@ -1608,48 +2002,111 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   		[CLK_TIMER7]		= &timer7_clk.common.hw,
>   		[CLK_TIMER8]		= &timer8_clk.common.hw,
>   		[CLK_TIMER9]		= &timer9_clk.common.hw,
> +		[CLK_BUS_TIMER]		= &bus_timer_clk.common.hw,
>   		[CLK_AVS]		= &avs_clk.common.hw,
>   		[CLK_DE]		= &de_clk.common.hw,
> +		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
>   		[CLK_DI]		= &di_clk.common.hw,
> +		[CLK_BUS_DI]		= &bus_di_clk.common.hw,
>   		[CLK_G2D]		= &g2d_clk.common.hw,
> +		[CLK_BUS_G2D]		= &bus_g2d_clk.common.hw,
>   		[CLK_EINK]		= &eink_clk.common.hw,
>   		[CLK_EINK_PANEL]	= &eink_panel_clk.common.hw,
> +		[CLK_BUS_EINK]		= &bus_eink_clk.common.hw,
>   		[CLK_VE_ENC]		= &ve_enc_clk.common.hw,
>   		[CLK_VE_DEC]		= &ve_dec_clk.common.hw,
> +		[CLK_BUS_VE_ENC]	= &bus_ve_enc_clk.common.hw,
> +		[CLK_BUS_VE_DEC]	= &bus_ve_dec_clk.common.hw,
>   		[CLK_CE]		= &ce_clk.common.hw,
> +		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
> +		[CLK_BUS_CE_SYS]	= &bus_ce_sys_clk.common.hw,
>   		[CLK_NPU]		= &npu_clk.common.hw,
> +		[CLK_BUS_NPU]		= &bus_npu_clk.common.hw,
>   		[CLK_GPU]		= &gpu_clk.common.hw,
> +		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
>   		[CLK_DRAM]		= &dram_clk.common.hw,
> +		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
>   		[CLK_NAND0]		= &nand0_clk.common.hw,
>   		[CLK_NAND1]		= &nand1_clk.common.hw,
> +		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
>   		[CLK_MMC0]		= &mmc0_clk.common.hw,
>   		[CLK_MMC1]		= &mmc1_clk.common.hw,
>   		[CLK_MMC2]		= &mmc2_clk.common.hw,
>   		[CLK_MMC3]		= &mmc3_clk.common.hw,
> +		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_MMC3]		= &bus_mmc3_clk.common.hw,
>   		[CLK_UFS_AXI]		= &ufs_axi_clk.common.hw,
>   		[CLK_UFS_CFG]		= &ufs_cfg_clk.common.hw,
> +		[CLK_BUS_UFS]		= &bus_ufs_clk.common.hw,
> +		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
> +		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
> +		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
> +		[CLK_BUS_UART5]		= &bus_uart5_clk.common.hw,
> +		[CLK_BUS_UART6]		= &bus_uart6_clk.common.hw,
> +		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
> +		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
> +		[CLK_BUS_I2C4]		= &bus_i2c4_clk.common.hw,
> +		[CLK_BUS_I2C5]		= &bus_i2c5_clk.common.hw,
> +		[CLK_BUS_I2C6]		= &bus_i2c6_clk.common.hw,
> +		[CLK_BUS_I2C7]		= &bus_i2c7_clk.common.hw,
> +		[CLK_BUS_I2C8]		= &bus_i2c8_clk.common.hw,
> +		[CLK_BUS_I2C9]		= &bus_i2c9_clk.common.hw,
> +		[CLK_BUS_I2C10]		= &bus_i2c10_clk.common.hw,
> +		[CLK_BUS_I2C11]		= &bus_i2c11_clk.common.hw,
> +		[CLK_BUS_I2C12]		= &bus_i2c12_clk.common.hw,
>   		[CLK_SPI0]		= &spi0_clk.common.hw,
>   		[CLK_SPI1]		= &spi1_clk.common.hw,
>   		[CLK_SPI2]		= &spi2_clk.common.hw,
>   		[CLK_SPI3]		= &spi3_clk.common.hw,
>   		[CLK_SPI4]		= &spi4_clk.common.hw,
> +		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
> +		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
> +		[CLK_BUS_SPI2]		= &bus_spi2_clk.common.hw,
> +		[CLK_BUS_SPI3]		= &bus_spi3_clk.common.hw,
> +		[CLK_BUS_SPI4]		= &bus_spi4_clk.common.hw,
>   		[CLK_SPIF]		= &spif_clk.common.hw,
> +		[CLK_BUS_SPIF]		= &bus_spif_clk.common.hw,
>   		[CLK_GPADC]		= &gpadc_clk.common.hw,
> +		[CLK_BUS_GPADC]		= &bus_gpadc_clk.common.hw,
> +		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
>   		[CLK_IRRX]		= &irrx_clk.common.hw,
> +		[CLK_BUS_IRRX]		= &bus_irrx_clk.common.hw,
>   		[CLK_IRTX]		= &irtx_clk.common.hw,
> +		[CLK_BUS_IRTX]		= &bus_irtx_clk.common.hw,
> +		[CLK_BUS_LRADC]		= &bus_lradc_clk.common.hw,
>   		[CLK_SGPIO]		= &sgpio_clk.common.hw,
> +		[CLK_BUS_SGPIO]		= &bus_sgpio_clk.common.hw,
>   		[CLK_LPC]		= &lpc_clk.common.hw,
> +		[CLK_BUS_LPC]		= &bus_lpc_clk.common.hw,
>   		[CLK_I2SPCM0]		= &i2spcm0_clk.common.hw,
>   		[CLK_I2SPCM1]		= &i2spcm1_clk.common.hw,
>   		[CLK_I2SPCM2]		= &i2spcm2_clk.common.hw,
>   		[CLK_I2SPCM3]		= &i2spcm3_clk.common.hw,
>   		[CLK_I2SPCM4]		= &i2spcm4_clk.common.hw,
> +		[CLK_BUS_I2SPCM0]	= &bus_i2spcm0_clk.common.hw,
> +		[CLK_BUS_I2SPCM1]	= &bus_i2spcm1_clk.common.hw,
> +		[CLK_BUS_I2SPCM2]	= &bus_i2spcm2_clk.common.hw,
> +		[CLK_BUS_I2SPCM3]	= &bus_i2spcm3_clk.common.hw,
> +		[CLK_BUS_I2SPCM4]	= &bus_i2spcm4_clk.common.hw,
>   		[CLK_I2SPCM2_ASRC]	= &i2spcm2_asrc_clk.common.hw,
>   		[CLK_OWA_TX]		= &owa_tx_clk.common.hw,
>   		[CLK_OWA_RX]		= &owa_rx_clk.common.hw,
> +		[CLK_BUS_OWA]		= &bus_owa_clk.common.hw,
>   		[CLK_DMIC]		= &dmic_clk.common.hw,
> +		[CLK_BUS_DMIC]		= &bus_dmic_clk.common.hw,
>   		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
> +		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
> +		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
> +		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
>   		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
> +		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
> +		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
>   		[CLK_USB_REF]		= &usb_ref_clk.common.hw,
>   		[CLK_USB2_U2_REF]	= &usb2_u2_ref_clk.common.hw,
>   		[CLK_USB2_SUSPEND]	= &usb2_suspend_clk.common.hw,
> @@ -1662,24 +2119,40 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   		[CLK_GMAC_PTP]		= &gmac_ptp_clk.common.hw,
>   		[CLK_GMAC0_PHY]		= &gmac0_phy_clk.common.hw,
>   		[CLK_GMAC1_PHY]		= &gmac1_phy_clk.common.hw,
> +		[CLK_BUS_GMAC0]		= &bus_gmac0_clk.common.hw,
> +		[CLK_BUS_GMAC1]		= &bus_gmac1_clk.common.hw,
>   		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
>   		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
>   		[CLK_TCON_LCD2]		= &tcon_lcd2_clk.common.hw,
> +		[CLK_BUS_TCON_LCD0]	= &bus_tcon_lcd0_clk.common.hw,
> +		[CLK_BUS_TCON_LCD1]	= &bus_tcon_lcd1_clk.common.hw,
> +		[CLK_BUS_TCON_LCD2]	= &bus_tcon_lcd2_clk.common.hw,
>   		[CLK_DSI0]		= &dsi0_clk.common.hw,
>   		[CLK_DSI1]		= &dsi1_clk.common.hw,
> +		[CLK_BUS_DSI0]		= &bus_dsi0_clk.common.hw,
> +		[CLK_BUS_DSI1]		= &bus_dsi1_clk.common.hw,
>   		[CLK_COMBPHY0]		= &combphy0_clk.common.hw,
>   		[CLK_COMBPHY1]		= &combphy1_clk.common.hw,
> +		[CLK_BUS_TCON_TV0]	= &bus_tcon_tv0_clk.common.hw,
> +		[CLK_BUS_TCON_TV1]	= &bus_tcon_tv1_clk.common.hw,
>   		[CLK_EDP_TV]		= &edp_tv_clk.common.hw,
> +		[CLK_BUS_EDP_TV]	= &bus_edp_tv_clk.common.hw,
>   		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
>   		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
>   		[CLK_HDMI_TV]		= &hdmi_tv_clk.common.hw,
> +		[CLK_BUS_HDMI_TV]	= &bus_hdmi_tv_clk.common.hw,
>   		[CLK_HDMI_SFR]		= &hdmi_sfr_clk.common.hw,
>   		[CLK_HDMI_ESM]		= &hdmi_esm_clk.common.hw,
> +		[CLK_BUS_DPSS_TOP0]	= &bus_dpss_top0_clk.common.hw,
> +		[CLK_BUS_DPSS_TOP1]	= &bus_dpss_top1_clk.common.hw,
>   		[CLK_LEDC]		= &ledc_clk.common.hw,
> +		[CLK_BUS_LEDC]		= &bus_ledc_clk.common.hw,
> +		[CLK_BUS_DSC]		= &bus_dsc_clk.common.hw,
>   		[CLK_CSI_MASTER0]	= &csi_master0_clk.common.hw,
>   		[CLK_CSI_MASTER1]	= &csi_master1_clk.common.hw,
>   		[CLK_CSI_MASTER2]	= &csi_master2_clk.common.hw,
>   		[CLK_CSI]		= &csi_clk.common.hw,
> +		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
>   		[CLK_ISP]		= &isp_clk.common.hw,
>   		[CLK_APB2JTAG]		= &apb2jtag_clk.common.hw,
>   		[CLK_FANOUT_24M]	= &fanout_24M_clk.common.hw,
> 


