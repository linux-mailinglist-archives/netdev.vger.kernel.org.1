Return-Path: <netdev+bounces-162419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7CA26D3B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88807A1383
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6652066E8;
	Tue,  4 Feb 2025 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHIBxyeb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09486358;
	Tue,  4 Feb 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657531; cv=none; b=sghkfkCUufzFPpQZNx89XP87ajRWzkSpk2I6Y5jCEwVKPnN5BioQzPgHgkDYaCOWcd2XgImUWvah9RHj1ZmXh57xdz1qrw0BGt4JuIt08wBHzAleCF6C5RcVBptlSoskxTpOHmB6qKOkEEMzCDWWtmqj2vwv+cuPrUY3gnKEOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657531; c=relaxed/simple;
	bh=tA7E1mVpIymY3Lc0nR1S/UyBaq3G0W3boEmT/JwVfMw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nuHv9LT0QJw6in/Jw05PwZSbwt2NV/WqyYZsfnNOReUkvKcx+jZdzJdWFFK5ve+d6eGfeA2B0D+dfd6P75+7OL0NpKn5IT3G5SQg+Oxlc/EougehyvVE+yxd7z9zh2vQs0ghXrFR8czRQJujpn34aoYnoPJN85O1q7dIQzBZoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHIBxyeb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738657530; x=1770193530;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tA7E1mVpIymY3Lc0nR1S/UyBaq3G0W3boEmT/JwVfMw=;
  b=aHIBxyebZiASxG3TVpkU8Yk4NWohMfATC2xcsj49urEFq2DAxGCblvNo
   4H88LuJVGz/idqdDB0U7Mn/n5F2sQXh6VZ9j55qL4/aEitmKSuceTQX6U
   +AMZboMG+eEHLQ06SXFrb6p35Ond+E0mm41fyJnRAjX6xNPr/hPQrIAiC
   YZ19imNJYS7bPZ25TvldUbvYEB+YJjihHRb4EaGHImdQvXvHgF2aPeC7B
   3b05tqgN5Uvz/Nl5WIElsNCUnqKcXWZI45LSgetEz1r1AyYWTUTIBfafn
   KN/ikHKfQ79unMxqXrAcDQmdP3kzE4+1kd4jaQsqil5kHYzHsKANMGg/P
   Q==;
X-CSE-ConnectionGUID: /PY/6JHVQUirnZbJPCsuOw==
X-CSE-MsgGUID: fHT1Jff8Rd6fg3/COIAHFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="64524799"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="64524799"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:25:29 -0800
X-CSE-ConnectionGUID: LTlwhQG9RVqR9pLXW0mgtw==
X-CSE-MsgGUID: x3roqXnEQH+JzJtGCuS/0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="115543375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:25:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Feb 2025 10:25:12 +0200 (EET)
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
    Jose Abreu <Jose.Abreu@synopsys.com>, 
    David E Box <david.e.box@linux.intel.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, 
    Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jiawen Wu <jiawenwu@trustnetic.com>, 
    Mengyuan Lou <mengyuanlou@net-swift.com>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Andrew Halaney <ahalaney@redhat.com>, 
    Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes according
 to the interface mode
In-Reply-To: <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
Message-ID: <71b15c65-4790-50e0-fa96-dbc42c90079f@linux.intel.com>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com> <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Choong Yong Liang wrote:

> Intel platform will configure the SerDes through PMC api based on the

API

> provided interface mode.
> 
> This patch adds several new functions below:-
> - intel_tsn_lane_is_available(): This new function reads FIA lane
>   ownership registers and common lane registers through IPC commands
>   to know which lane the mGbE port is assigned to.
> - intel_config_serdes(): To configure the SerDes based on the assigned
>   lane and latest interface mode, it sends IPC command to the PMC through
>   PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
> - intel_set_reg_access(): Set the register access to the available TSN
>   interface.
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   2 +
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 107 +++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  75 ++++++++++++
>  include/linux/stmmac.h                        |   3 +
>  4 files changed, 185 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 4cc85a36a1ab..25154b915b02 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -307,6 +307,8 @@ config DWMAC_INTEL
>  	default X86
>  	depends on X86 && STMMAC_ETH && PCI
>  	depends on COMMON_CLK
> +	depends on ACPI
> +	select INTEL_PMC_IPC
>  	help
>  	  This selects the Intel platform specific bus support for the
>  	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 48acba5eb178..347dd75bcdcd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -5,6 +5,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/pci.h>
>  #include <linux/dmi.h>
> +#include <linux/platform_data/x86/intel_pmc_ipc.h>
>  #include "dwmac-intel.h"
>  #include "dwmac4.h"
>  #include "stmmac.h"
> @@ -14,6 +15,9 @@ struct intel_priv_data {
>  	int mdio_adhoc_addr;	/* mdio address for serdes & etc */
>  	unsigned long crossts_adj;
>  	bool is_pse;
> +	const int *tsn_lane_registers;
> +	int max_tsn_lane_registers;
> +	int pid_modphy;
>  };
>  
>  /* This struct is used to associate PCI Function of MAC controller on a board,
> @@ -93,7 +97,7 @@ static int intel_serdes_powerup(struct net_device *ndev, void *priv_data)
>  	data &= ~SERDES_RATE_MASK;
>  	data &= ~SERDES_PCLK_MASK;
>  
> -	if (priv->plat->max_speed == 2500)
> +	if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
>  		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
>  			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
>  	else
> @@ -415,6 +419,103 @@ static void intel_mgbe_pse_crossts_adj(struct intel_priv_data *intel_priv,
>  	}
>  }
>  
> +static bool intel_tsn_lane_is_available(struct net_device *ndev,
> +					struct intel_priv_data *intel_priv)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct pmc_ipc_cmd tmp = {0};
> +	u32 rbuf[4] = {0};
> +	int ret, i, j;
> +
> +	if (priv->plat->serdes_powerup) {

The logic could be reversed + return immediately to reduce the indentation
of the block below.

> +		tmp.cmd = IPC_SOC_REGISTER_ACCESS;
> +		tmp.sub_cmd = IPC_SOC_SUB_CMD_READ;
> +
> +		for (i = 0; i < 5; i++) {

Name the magic 5 with a define?

> +			tmp.wbuf[0] = R_PCH_FIA_15_PCR_LOS1_REG_BASE + i;
> +
> +			ret = intel_pmc_ipc(&tmp, rbuf);
> +			if (ret < 0) {
> +				netdev_info(priv->dev,
> +					    "Failed to read from PMC.\n");
> +				return false;
> +			}
> +
> +			for (j = 0; j <= intel_priv->max_tsn_lane_registers; j++)
> +				if ((rbuf[0] >>
> +				    (4 * (intel_priv->tsn_lane_registers[j] % 8)) &
> +				     B_PCH_FIA_PCR_L0O) == 0xB)
> +					return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs)
> +{
> +	int ret = 0, i;
> +
> +	for (i = 0; i < max_regs; i++) {
> +		struct pmc_ipc_cmd tmp = {0};
> +		u32 buf[4] = {0};

If you just want to have them initialized, it's enough to use {}, no dummy 
0 is necessary.

> +
> +		tmp.cmd = IPC_SOC_REGISTER_ACCESS;
> +		tmp.sub_cmd = IPC_SOC_SUB_CMD_WRITE;
> +		tmp.wbuf[0] = (u32)regs[i].index;
> +		tmp.wbuf[1] = regs[i].val;
> +
> +		ret = intel_pmc_ipc(&tmp, buf);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int intel_config_serdes(struct net_device *ndev,
> +			       void *intel_data,
> +			       phy_interface_t interface)
> +{
> +	struct intel_priv_data *intel_priv = intel_data;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret = 0;
> +
> +	if (!intel_tsn_lane_is_available(ndev, intel_priv)) {
> +		netdev_info(priv->dev,
> +			    "No TSN lane available to set the registers.\n");
> +		goto pmc_read_error;
> +	}
> +
> +	if (intel_priv->pid_modphy == PID_MODPHY1) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +			ret = intel_set_reg_access(pid_modphy1_2p5g_regs,
> +						   ARRAY_SIZE(pid_modphy1_2p5g_regs));
> +		} else {
> +			ret = intel_set_reg_access(pid_modphy1_1g_regs,
> +						   ARRAY_SIZE(pid_modphy1_1g_regs));
> +		}
> +	} else {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +			ret = intel_set_reg_access(pid_modphy3_2p5g_regs,
> +						   ARRAY_SIZE(pid_modphy3_2p5g_regs));
> +		} else {
> +			ret = intel_set_reg_access(pid_modphy3_1g_regs,
> +						   ARRAY_SIZE(pid_modphy3_1g_regs));
> +		}
> +	}

This looks somewhat ugly. Perhaps it would be better if you make the call 
on main level of the function and use local variables to hold the regs 
array and its number of elements until then.

It would be even better if you could just store the pointer and # of 
elements into some platform info structure so that it wouldn't need to be 
calculated on the fly here (but I don't know this driver well enough to 
know if that's viable/easy to do).

> +	priv->plat->phy_interface = interface;
> +
> +	if (ret < 0)
> +		goto pmc_read_error;
> +
> +pmc_read_error:
> +	intel_serdes_powerdown(ndev, intel_priv);
> +	intel_serdes_powerup(ndev, intel_priv);
> +
> +	return ret;
> +}
> +
>  static void common_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> @@ -650,7 +751,7 @@ static int ehl_sgmii_data(struct pci_dev *pdev,
>  	plat->speed_mode_2500 = intel_speed_mode_2500;
>  	plat->serdes_powerup = intel_serdes_powerup;
>  	plat->serdes_powerdown = intel_serdes_powerdown;
> -
> +	plat->config_serdes = intel_config_serdes;
>  	plat->clk_ptp_rate = 204800000;
>  
>  	return ehl_common_data(pdev, plat);
> @@ -709,6 +810,7 @@ static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
>  	plat->speed_mode_2500 = intel_speed_mode_2500;
>  	plat->serdes_powerup = intel_serdes_powerup;
>  	plat->serdes_powerdown = intel_serdes_powerdown;
> +	plat->config_serdes = intel_config_serdes;
>  	return ehl_pse0_common_data(pdev, plat);
>  }
>  
> @@ -750,6 +852,7 @@ static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
>  	plat->speed_mode_2500 = intel_speed_mode_2500;
>  	plat->serdes_powerup = intel_serdes_powerup;
>  	plat->serdes_powerdown = intel_serdes_powerdown;
> +	plat->config_serdes = intel_config_serdes;
>  	return ehl_pse1_common_data(pdev, plat);
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
> index 0a37987478c1..79c35ba969ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
> @@ -50,4 +50,79 @@
>  #define PCH_PTP_CLK_FREQ_19_2MHZ	(GMAC_GPO0)
>  #define PCH_PTP_CLK_FREQ_200MHZ		(0)
>  
> +#define	PID_MODPHY1 0xAA
> +#define	PID_MODPHY3 0xA8
> +
> +#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
> +struct pmc_serdes_regs {
> +	u8 index;
> +	u32 val;
> +};
> +
> +/* Modphy Register index */
> +#define R_PCH_FIA_15_PCR_LOS1_REG_BASE			8
> +#define R_PCH_FIA_15_PCR_LOS2_REG_BASE			9
> +#define R_PCH_FIA_15_PCR_LOS3_REG_BASE			10
> +#define R_PCH_FIA_15_PCR_LOS4_REG_BASE			11
> +#define R_PCH_FIA_15_PCR_LOS5_REG_BASE			12
> +#define B_PCH_FIA_PCR_L0O				GENMASK(3, 0)
> +#define PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0		13
> +#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2		14
> +#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7		15
> +#define PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10		16
> +#define PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30	17
> +#define PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0		18
> +#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2		19
> +#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7		20
> +#define PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10		21
> +#define PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30	22
> +
> +#define B_MODPHY_PCR_LCPLL_DWORD0_1G		0x46AAAA41
> +#define N_MODPHY_PCR_LCPLL_DWORD2_1G		0x00000139
> +#define N_MODPHY_PCR_LCPLL_DWORD7_1G		0x002A0003
> +#define N_MODPHY_PCR_LPPLL_DWORD10_1G		0x00170008
> +#define N_MODPHY_PCR_CMN_ANA_DWORD30_1G		0x0000D4AC
> +#define B_MODPHY_PCR_LCPLL_DWORD0_2P5G		0x58555551
> +#define N_MODPHY_PCR_LCPLL_DWORD2_2P5G		0x0000012D
> +#define N_MODPHY_PCR_LCPLL_DWORD7_2P5G		0x001F0003
> +#define N_MODPHY_PCR_LPPLL_DWORD10_2P5G		0x00170008
> +#define N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G	0x8200ACAC
> +
> +static const struct pmc_serdes_regs pid_modphy3_1g_regs[] = {
> +	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
> +	{}
> +};
> +
> +static const struct pmc_serdes_regs pid_modphy3_2p5g_regs[] = {
> +	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
> +	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
> +	{}
> +};
> +
> +static const struct pmc_serdes_regs pid_modphy1_1g_regs[] = {
> +	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
> +	{}
> +};
> +
> +static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
> +	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
> +	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
> +	{}
> +};

Why are these arrays in a header and not in the C file that uses them???

> +#endif /* CONFIG_INTEL_PMC_IPC */
> +
>  #endif /* __DWMAC_INTEL_H__ */
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index c9878a612e53..dcfa5f423d1c 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -236,6 +236,9 @@ struct plat_stmmacenet_data {
>  	int (*serdes_powerup)(struct net_device *ndev, void *priv);
>  	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
>  	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
> +	int (*config_serdes)(struct net_device *ndev,
> +			     void *priv,
> +			     phy_interface_t interface);
>  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
>  	int (*init)(struct platform_device *pdev, void *priv);
>  	void (*exit)(struct platform_device *pdev, void *priv);
> 

-- 
 i.


