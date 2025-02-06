Return-Path: <netdev+bounces-163536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA7A2A9F9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF497A135B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE011EA7E3;
	Thu,  6 Feb 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLtN2An8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BED1EA7D7;
	Thu,  6 Feb 2025 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848689; cv=none; b=Tlgh5C3Z9wEZLQq2dcaRl+cJt0EH/xr2oFBegaTVNn/HR1jt5NqWKyoZypqLghIDVxoSTuuq+8c32YWmiJdnqAPjB9fyW1ehQUA8f4Avno9X0eRMiNnuF4l0iu+lclMSWpmN2Y8whJL91zMpDndiqLsjzlkeTJBgzz7ZarKv/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848689; c=relaxed/simple;
	bh=UvKy4mZrPC8JYTufGCS5mcN3Cwb0i4boDW9z3KaHTf4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g1uzTnBWfCwAiTOkNMOBZjLTV4UGM/M1FeUig6uklk9Zr63ZK7DXkPsIjhWjXc7tVqynEHI586TmvnQt10rUcvpbWjbkw7aqlREARCt5ehV4TAH6cCKdfaIHVWcIx/fbsnhhwbyZuHPVxtnRVKiwjNJkHD5Dmlk9AL4sdn9tebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLtN2An8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738848688; x=1770384688;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UvKy4mZrPC8JYTufGCS5mcN3Cwb0i4boDW9z3KaHTf4=;
  b=OLtN2An8/w/u37IDKn3YnKk7QpgKugx+WXa5l2zGR6lopC5Yq/mkjN9S
   s3oIP/6j2iPt3vge9uMjw/yt3t/fqoJn8Haq5NOOel6L12MYPBsyHcfNp
   XVjQDuV2MxWWkH7GCuPLQRV9GyqOf20aD689/R4K1XWon6EPfijypGzvn
   7cuJe8RihKlJbv/Fb5ANTswOS/lAakWly0K1fMu9AZ32QCo6f0K97lECI
   wHl/XepX9S64WhHkxvoh8r9ZogHA8pawAzhfJyStw865svoBU17ECowIW
   odgXeIRFujwExQ/m+tCYYBlofog4fklNx9xAWuUX2JlF9tdr2kURmlqzO
   g==;
X-CSE-ConnectionGUID: 7tVkhoOJQqWOVfvW7qrIYg==
X-CSE-MsgGUID: AI9LUI2iTM2DcGOJYQv8wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50438701"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="50438701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 05:31:27 -0800
X-CSE-ConnectionGUID: 6wNgtWa/SG6rDVMtMIhggA==
X-CSE-MsgGUID: yi0yOvUlQh+wxtzF/iDp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111062150"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.165])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 05:31:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Feb 2025 15:31:14 +0200 (EET)
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
    Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 4/7] stmmac: intel: configure SerDes according
 to the interface mode
In-Reply-To: <20250206131859.2960543-5-yong.liang.choong@linux.intel.com>
Message-ID: <c15078bf-b6f3-5b4b-82ca-668d47168ce0@linux.intel.com>
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com> <20250206131859.2960543-5-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Feb 2025, Choong Yong Liang wrote:

> Intel platform will configure the SerDes through PMC API based on the
> provided interface mode.
> 
> This patch adds several new functions below:-
> - intel_tsn_lane_is_available(): This new function reads FIA lane
>   ownership registers and common lane registers through IPC commands
>   to know which lane the mGbE port is assigned to.
> - intel_mac_finish(): To configure the SerDes based on the assigned
>   lane and latest interface mode, it sends IPC command to the PMC through
>   PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
> - intel_set_reg_access(): Set the register access to the available TSN
>   interface.
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   2 +
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 146 +++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  29 ++++
>  include/linux/stmmac.h                        |   4 +
>  4 files changed, 179 insertions(+), 2 deletions(-)
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
> index 48acba5eb178..837fd3fbaedb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -5,15 +5,30 @@
>  #include <linux/clk-provider.h>
>  #include <linux/pci.h>
>  #include <linux/dmi.h>
> +#include <linux/platform_data/x86/intel_pmc_ipc.h>
>  #include "dwmac-intel.h"
>  #include "dwmac4.h"
>  #include "stmmac.h"
>  #include "stmmac_ptp.h"
>  
> +struct pmc_serdes_regs {
> +	u8 index;
> +	u32 val;
> +};
> +
> +struct pmc_serdes_reg_info {
> +	const struct pmc_serdes_regs *regs;
> +	u8 num_regs;
> +};
> +
>  struct intel_priv_data {
>  	int mdio_adhoc_addr;	/* mdio address for serdes & etc */
>  	unsigned long crossts_adj;
>  	bool is_pse;
> +	const int *tsn_lane_regs;
> +	int max_tsn_lane_regs;
> +	struct pmc_serdes_reg_info pid_1g;
> +	struct pmc_serdes_reg_info pid_2p5g;
>  };
>  
>  /* This struct is used to associate PCI Function of MAC controller on a board,
> @@ -35,6 +50,42 @@ struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>  };
>  
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
> +
>  static int stmmac_pci_find_phy_addr(struct pci_dev *pdev,
>  				    const struct dmi_system_id *dmi_list)
>  {
> @@ -93,7 +144,7 @@ static int intel_serdes_powerup(struct net_device *ndev, void *priv_data)
>  	data &= ~SERDES_RATE_MASK;
>  	data &= ~SERDES_PCLK_MASK;
>  
> -	if (priv->plat->max_speed == 2500)
> +	if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
>  		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
>  			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
>  	else
> @@ -415,6 +466,95 @@ static void intel_mgbe_pse_crossts_adj(struct intel_priv_data *intel_priv,
>  	}
>  }
>  
> +static int intel_tsn_lane_is_available(struct net_device *ndev,
> +				       struct intel_priv_data *intel_priv)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct pmc_ipc_cmd tmp = {};
> +	u32 rbuf[4] = {};
> +	int ret = 0, i, j;
> +	const int max_fia_regs = 5;
> +
> +	tmp.cmd = IPC_SOC_REGISTER_ACCESS;
> +	tmp.sub_cmd = IPC_SOC_SUB_CMD_READ;
> +
> +	for (i = 0; i < max_fia_regs; i++) {

Usually, defines are used for true consts.

> +		tmp.wbuf[0] = R_PCH_FIA_15_PCR_LOS1_REG_BASE + i;
> +
> +		ret = intel_pmc_ipc(&tmp, rbuf);
> +		if (ret < 0) {
> +			netdev_info(priv->dev, "Failed to read from PMC.\n");
> +			return ret;
> +		}
> +
> +		for (j = 0; j <= intel_priv->max_tsn_lane_regs; j++)
> +			if ((rbuf[0] >>
> +				(4 * (intel_priv->tsn_lane_regs[j] % 8)) &
> +					B_PCH_FIA_PCR_L0O) == 0xB)
> +				return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs)
> +{
> +	int ret = 0, i;
> +
> +	for (i = 0; i < max_regs; i++) {
> +		struct pmc_ipc_cmd tmp = {};
> +		u32 buf[4] = {};
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
> +static int intel_mac_finish(struct net_device *ndev,
> +			    void *intel_data,
> +			    unsigned int mode,
> +			    phy_interface_t interface)
> +{
> +	struct intel_priv_data *intel_priv = intel_data;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	const struct pmc_serdes_regs *regs;
> +	int max_regs = 0;
> +	int ret = 0;
> +
> +	ret = intel_tsn_lane_is_available(ndev, intel_priv);
> +	if (ret < 0) {
> +		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
> +		return ret;
> +	}
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		regs = intel_priv->pid_2p5g.regs;
> +		max_regs = intel_priv->pid_2p5g.num_regs;
> +	} else {
> +		regs = intel_priv->pid_1g.regs;
> +		max_regs = intel_priv->pid_1g.num_regs;
> +	}
> +
> +	ret = intel_set_reg_access(regs, max_regs);
> +	if (ret < 0)
> +		return ret;

This looks much cleaner now, thanks the update.

However, the intel_priv fields you introduced are not setup until patch 
6/7? Will this cause NULL ptr deref issues in between the two changes? By 
introducing the reg arrays in this patch but only use them after patch 6, 
you'll also get unused variable warnings out of them in between the 
changes which is unacceptable.

> +
> +	priv->plat->phy_interface = interface;
> +
> +	intel_serdes_powerdown(ndev, intel_priv);
> +	intel_serdes_powerup(ndev, intel_priv);
> +
> +	return ret;
> +}


-- 
 i.


