Return-Path: <netdev+bounces-204650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8241AFB9BE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B857A1DE7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6B289E0F;
	Mon,  7 Jul 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYnlZkOG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30023220F54;
	Mon,  7 Jul 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908752; cv=none; b=XgHFXoIIZTjsTHMFpp7qJ7UnBFZ8/5EB+cOUSKNk3CYYm/jgGBg4bcYdBP+e6j5/XIex5t3UOx+if00DPKGMrY0+dXU4TyugKGdv0G//vE/z3n0l/JkIQG3ciDxNTZc16RWe4v98WmaHDBLaZzdAU2h7u6a4JInEhFY0KlJp17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908752; c=relaxed/simple;
	bh=fXzBKXuR3NQ84TdgSrOCOcgXOkVhIuTgoIqGSJvOaSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNVCtl9FBfE5l4ULxetakZI3GevZ2K655IYjls2nvJVmfshim9cArqArISX3NdffmPUrWFEECWIcWxwqkORJPDmaZjBMEtbfi/lCse2H5WrNu8X5dV5dwWne7DOUCR65q9Gc+epLRkOB7nB/MFABxjgULXYRfskqSNMHGzS/SUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYnlZkOG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751908751; x=1783444751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXzBKXuR3NQ84TdgSrOCOcgXOkVhIuTgoIqGSJvOaSw=;
  b=RYnlZkOGahmB3LMEM0WiZXZ1v8aWFlgV+GPq+COC3RakVRQ1wtuX0b3u
   3JZNGUITOw6t0Kqq2jvaS0j7wHf9kd+PMhY+XzfdmBAYZl/oWhIEOCnPn
   2bz31nJ1qqps7Ggt7wbbAG0ICXN3yPDMI2qI2WILnFdwTwoxTuxIdtO5H
   Yhg770thtra8boqSH/XWZQmleUnPVDDjbiSe8FZZZto1Mm2NkKfihUt2k
   cdE0bq0VjEkm4bia9A13c3j+Axv/P3xVGblNG1MmCvsHCXAy+yjgokPbV
   n/+k6K5aYsE0DNsXuUqKFxIr8gD5I5QdarnaPJITJeRDamznBE3qHNatk
   w==;
X-CSE-ConnectionGUID: /F9WW+vZRreDKSLRR06Fpw==
X-CSE-MsgGUID: IKtBPw/ETQy/5r6+5B+zWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53848809"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="53848809"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 10:19:11 -0700
X-CSE-ConnectionGUID: iKQ2Asy4QiC7kCTrM6jgJA==
X-CSE-MsgGUID: THBY1FFJRGyG3ZNMsPyJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="155367924"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jul 2025 10:19:06 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYpUe-0000bP-1r;
	Mon, 07 Jul 2025 17:19:04 +0000
Date: Tue, 8 Jul 2025 01:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <202507080143.yV44OC2v-lkp@intel.com>
References: <20250703020155.10331-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703020155.10331-3-Tristram.Ha@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tristram-Ha-microchip-com/dt-bindings-net-dsa-microchip-Add-KSZ8463-switch-support/20250703-100324
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250703020155.10331-3-Tristram.Ha%40microchip.com
patch subject: [PATCH net-next 2/2] net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
config: i386-randconfig-r132-20250707 (https://download.01.org/0day-ci/archive/20250708/202507080143.yV44OC2v-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507080143.yV44OC2v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507080143.yV44OC2v-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/microchip/ksz_common.c:2987:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] storm_mask @@     got restricted __be16 [usertype] @@
   drivers/net/dsa/microchip/ksz_common.c:2987:28: sparse:     expected unsigned short [assigned] [usertype] storm_mask
   drivers/net/dsa/microchip/ksz_common.c:2987:28: sparse:     got restricted __be16 [usertype]
>> drivers/net/dsa/microchip/ksz_common.c:2988:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] storm_rate @@     got restricted __be16 [usertype] @@
   drivers/net/dsa/microchip/ksz_common.c:2988:28: sparse:     expected unsigned short [assigned] [usertype] storm_rate
   drivers/net/dsa/microchip/ksz_common.c:2988:28: sparse:     got restricted __be16 [usertype]

vim +2987 drivers/net/dsa/microchip/ksz_common.c

  2950	
  2951	static int ksz_setup(struct dsa_switch *ds)
  2952	{
  2953		struct ksz_device *dev = ds->priv;
  2954		u16 storm_mask, storm_rate;
  2955		struct dsa_port *dp;
  2956		struct ksz_port *p;
  2957		const u16 *regs;
  2958		int ret;
  2959	
  2960		regs = dev->info->regs;
  2961	
  2962		dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
  2963					       dev->info->num_vlans, GFP_KERNEL);
  2964		if (!dev->vlan_cache)
  2965			return -ENOMEM;
  2966	
  2967		ret = dev->dev_ops->reset(dev);
  2968		if (ret) {
  2969			dev_err(ds->dev, "failed to reset switch\n");
  2970			return ret;
  2971		}
  2972	
  2973		ret = ksz_parse_drive_strength(dev);
  2974		if (ret)
  2975			return ret;
  2976	
  2977		if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
  2978			ret = dev->dev_ops->pcs_create(dev);
  2979			if (ret)
  2980				return ret;
  2981		}
  2982	
  2983		/* set broadcast storm protection 10% rate */
  2984		storm_mask = BROADCAST_STORM_RATE;
  2985		storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
  2986		if (ksz_is_ksz8463(dev)) {
> 2987			storm_mask = htons(storm_mask);
> 2988			storm_rate = htons(storm_rate);
  2989		}
  2990		regmap_update_bits(ksz_regmap_16(dev),
  2991				   reg16(dev, regs[S_BROADCAST_CTRL]),
  2992				   storm_mask, storm_rate);
  2993	
  2994		dev->dev_ops->config_cpu_port(ds);
  2995	
  2996		dev->dev_ops->enable_stp_addr(dev);
  2997	
  2998		ds->num_tx_queues = dev->info->num_tx_queues;
  2999	
  3000		regmap_update_bits(ksz_regmap_8(dev),
  3001				   reg8(dev, regs[S_MULTICAST_CTRL]),
  3002				   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
  3003	
  3004		ksz_init_mib_timer(dev);
  3005	
  3006		ds->configure_vlan_while_not_filtering = false;
  3007		ds->dscp_prio_mapping_is_global = true;
  3008	
  3009		if (dev->dev_ops->setup) {
  3010			ret = dev->dev_ops->setup(ds);
  3011			if (ret)
  3012				return ret;
  3013		}
  3014	
  3015		/* Start with learning disabled on standalone user ports, and enabled
  3016		 * on the CPU port. In lack of other finer mechanisms, learning on the
  3017		 * CPU port will avoid flooding bridge local addresses on the network
  3018		 * in some cases.
  3019		 */
  3020		p = &dev->ports[dev->cpu_port];
  3021		p->learning = true;
  3022	
  3023		if (dev->irq > 0) {
  3024			ret = ksz_girq_setup(dev);
  3025			if (ret)
  3026				return ret;
  3027	
  3028			dsa_switch_for_each_user_port(dp, dev->ds) {
  3029				ret = ksz_pirq_setup(dev, dp->index);
  3030				if (ret)
  3031					goto out_girq;
  3032	
  3033				if (dev->info->ptp_capable) {
  3034					ret = ksz_ptp_irq_setup(ds, dp->index);
  3035					if (ret)
  3036						goto out_pirq;
  3037				}
  3038			}
  3039		}
  3040	
  3041		if (dev->info->ptp_capable) {
  3042			ret = ksz_ptp_clock_register(ds);
  3043			if (ret) {
  3044				dev_err(dev->dev, "Failed to register PTP clock: %d\n",
  3045					ret);
  3046				goto out_ptpirq;
  3047			}
  3048		}
  3049	
  3050		ret = ksz_mdio_register(dev);
  3051		if (ret < 0) {
  3052			dev_err(dev->dev, "failed to register the mdio");
  3053			goto out_ptp_clock_unregister;
  3054		}
  3055	
  3056		ret = ksz_dcb_init(dev);
  3057		if (ret)
  3058			goto out_ptp_clock_unregister;
  3059	
  3060		/* start switch */
  3061		regmap_update_bits(ksz_regmap_8(dev), reg8(dev, regs[S_START_CTRL]),
  3062				   SW_START, SW_START);
  3063	
  3064		return 0;
  3065	
  3066	out_ptp_clock_unregister:
  3067		if (dev->info->ptp_capable)
  3068			ksz_ptp_clock_unregister(ds);
  3069	out_ptpirq:
  3070		if (dev->irq > 0 && dev->info->ptp_capable)
  3071			dsa_switch_for_each_user_port(dp, dev->ds)
  3072				ksz_ptp_irq_free(ds, dp->index);
  3073	out_pirq:
  3074		if (dev->irq > 0)
  3075			dsa_switch_for_each_user_port(dp, dev->ds)
  3076				ksz_irq_free(&dev->ports[dp->index].pirq);
  3077	out_girq:
  3078		if (dev->irq > 0)
  3079			ksz_irq_free(&dev->girq);
  3080	
  3081		return ret;
  3082	}
  3083	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

