Return-Path: <netdev+bounces-179235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34CA7B720
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A53B84BD
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 05:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BD14EC5B;
	Fri,  4 Apr 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeHExF6r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABE376;
	Fri,  4 Apr 2025 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744406; cv=none; b=DjumwgnrP4Qy9aZ6P5PSmqbtFdkVpR2QVzQlzo1kcJxo89LWBCC+2GaGnaj/Sc80lkx53USyyZDMkNTXDsKBzl29K/AyMuzODS4lcfKCGo61Vx6Ezh0krhQYnVMMnNFGyvMkbqWx6gCMbhysuetfdEgCoAchrlbobFb/xO71zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744406; c=relaxed/simple;
	bh=hxG7XUIYapHRht25SbZ3ZRVuIMEJ3wDob6N+23gcygo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuJQ93Aw4hN/ZHO4RB6d1gPV+kWvhGLGZW+2HqjluJv+8/6yLZlNk6v+OxbebiQJVrMFlM2dBHVS+Kb9FDlRH2bnzn0hWo5OjD3x0RbWCuSjSR6tkqFNuv0Y6lzamPlXx8yO1p8Xf2JFfNdkgOV/kv1tVwJwa1j9REk18MVbSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeHExF6r; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743744405; x=1775280405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxG7XUIYapHRht25SbZ3ZRVuIMEJ3wDob6N+23gcygo=;
  b=EeHExF6rbDU4GXpFVvTluMrCyUW5UpgW3/7ezHjKgIgq3WkPUgYFtcIu
   PvlsO7uhg09BA9oAZM68Vo+AgnOyiodPa35s8BsomKV99FbJ2bKp4atrZ
   wbv2v/FV2S+5iqlQfTCuCN/cPLBMadp0w6v3u4Ee/ePC8ZEVU/8KHLHOL
   7DCffrCq/WcXjU+aegNZ8+7xNY6A2oB/N3ZC9XE3myFIhW/kvFXBWlSjo
   5bGZ+wJ7sGpKP/YOA6gB4YbOa+8MvOOkheEwfYTuul93yyLeO0ZRw8ZQJ
   3T3z6DpEo4LcCgwPSkzkIfZ57ymqoM77ohKmuGEC11+YkgTD4PfDWzELD
   w==;
X-CSE-ConnectionGUID: pTs9/s7BThmvpGGijanK4Q==
X-CSE-MsgGUID: 7ZoDtRujQo2oeO/x9rGRqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45317193"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="45317193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:26:44 -0700
X-CSE-ConnectionGUID: F4BjJeSBQMiY54SPtgeH7Q==
X-CSE-MsgGUID: IFo6QtE0STu5tmvl0TDz/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="127020693"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:26:40 -0700
Date: Fri, 4 Apr 2025 07:26:29 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/7] net: hibmcge: fix incorrect pause frame
 statistics issue
Message-ID: <Z+9thcHaDkdAOX01@mev-dev.igk.intel.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
 <20250403135311.545633-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403135311.545633-2-shaojijie@huawei.com>

On Thu, Apr 03, 2025 at 09:53:05PM +0800, Jijie Shao wrote:
> The driver supports pause frames,
> but does not pass pause frames based on rx pause enable configuration,
> resulting in incorrect pause frame statistics.
> 
> like this:
> mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
> 	-p 64 -c 100
> 
> ethtool -S enp132s0f2 | grep -v ": 0"
> NIC statistics:
>      rx_octets_total_filt_cnt: 6800
>      rx_filt_pkt_cnt: 100
> 
> The rx pause frames are filtered by the MAC hardware.
> 
> This patch configures pass pause frames based on the
> rx puase enable status to ensure that
> rx pause frames are not filtered.
> 
> mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
>         -p 64 -c 100
> 
> ethtool --include-statistics -a enp132s0f2
> Pause parameters for enp132s0f2:
> Autonegotiate:	on
> RX:		on
> TX:		on
> RX negotiated: on
> TX negotiated: on
> Statistics:
>   tx_pause_frames: 0
>   rx_pause_frames: 100
> 
> Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Add more details in commit log, suggested by Simon Horman.
>   v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c  | 3 +++
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> index 74a18033b444..7d3bbd3e2adc 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> @@ -242,6 +242,9 @@ void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
>  			    HBG_REG_PAUSE_ENABLE_TX_B, tx_en);
>  	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
>  			    HBG_REG_PAUSE_ENABLE_RX_B, rx_en);
> +
> +	hbg_reg_write_field(priv, HBG_REG_REC_FILT_CTRL_ADDR,
> +			    HBG_REG_REC_FILT_CTRL_PAUSE_FRM_PASS_B, rx_en);
>  }
>  
>  void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en)
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
> index cc2cc612770d..fd623cfd13de 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
> @@ -68,6 +68,7 @@
>  #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
>  #define HBG_REG_REC_FILT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0064)
>  #define HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B	BIT(0)
> +#define HBG_REG_REC_FILT_CTRL_PAUSE_FRM_PASS_B	BIT(4)
>  #define HBG_REG_RX_OCTETS_TOTAL_OK_ADDR		(HBG_REG_SGMII_BASE + 0x0080)
>  #define HBG_REG_RX_OCTETS_BAD_ADDR		(HBG_REG_SGMII_BASE + 0x0084)
>  #define HBG_REG_RX_UC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0088)
> -- 

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.33.0

