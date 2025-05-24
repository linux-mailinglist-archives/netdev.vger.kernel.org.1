Return-Path: <netdev+bounces-193200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FAAC2E48
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1DF1BA7163
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A313AA53;
	Sat, 24 May 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA9z5PS9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D72DCC1C;
	Sat, 24 May 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748076223; cv=none; b=sKuLenWzTqetFAkkpRm+mfp+JjIOkaj/msdWj2nuJdZbFcS4ec/kPiT1XCv2goCqZtLWQW3FjnGB4ACI8nhPocjy5QnglIzktoaBsqbPSaCGeamTBkMj2zJwXaTCJASxURa14N3/IrJIJqCOOdO7VEl1fbn1eCRiGLez+botQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748076223; c=relaxed/simple;
	bh=21TpRITYx8gCPyYtnS7+VMQMKDMX408Ws2PCZEAHMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej6f2fwpKZacgXGPnEGj83STP6alGV2lbJV4BRmAaQYZ89HXJL0FZkZs6pmh56s00ExFpOOFbcdwoCW/7u5ekMW/UUMEauZ6aRHLBQn0WUarAIyb9SZNiXvmpX3utv+FOaI4xrFrcW6RS4kaXzY3vgYg1tUDyGIy1szODe6ww/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA9z5PS9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748076221; x=1779612221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21TpRITYx8gCPyYtnS7+VMQMKDMX408Ws2PCZEAHMeo=;
  b=AA9z5PS9LMbhc4fnlsMM2jzuCrN7QmWdolHACR97RK1lPQQxvoa07tWV
   X7XqHAPG7EBVWj5sV+HG6C+DMVETCs51CjLENZQWUm0femuDSVzDZUyfV
   rQk+FXN7ya+lIh8jooFEv3IOfmafOoEEhjyUBIQRih7xO0cG5Q06Ss9Je
   d+QNkPYgYbMSwGxQ/1KzX801j834XgILrvWfeA5Pcbom3jF5Cqv2Td8FP
   RgE11GUp5KgJgmrf8giHXAknpuWGOEUz4fpfYBatU7OM1FjHdSmAAAT6P
   5rZ9Q4roq8XrO+9kQaPE+QrR4eNfojy1w2sqbUzDZ8TMd9mHew1Mc+cUs
   w==;
X-CSE-ConnectionGUID: A4rrmDtqR5SWmrzFxyxTTg==
X-CSE-MsgGUID: 5+YLrxgzQJmHJO3LUE2jFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50273653"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="50273653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 01:43:40 -0700
X-CSE-ConnectionGUID: 7Kqi4AGlTmisIlrL2d3T2Q==
X-CSE-MsgGUID: J3rguEQXTV68vf3OENoThw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="141403969"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 May 2025 01:43:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIkTd-000R3w-2R;
	Sat, 24 May 2025 08:43:33 +0000
Date: Sat, 24 May 2025 16:42:34 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <202505241618.qJrsEs8c-lkp@intel.com>
References: <20250523203339.1993685-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523203339.1993685-6-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250524-043901
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250523203339.1993685-6-sean.anderson%40linux.dev
patch subject: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO driver
config: x86_64-randconfig-074-20250524 (https://download.01.org/0day-ci/archive/20250524/202505241618.qJrsEs8c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505241618.qJrsEs8c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241618.qJrsEs8c-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/pcs/pcs-lynx.c:374:34: warning: 'lynx_pcs_of_match' defined but not used [-Wunused-const-variable=]
     374 | static const struct of_device_id lynx_pcs_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/lynx_pcs_of_match +374 drivers/net/pcs/pcs-lynx.c

   373	
 > 374	static const struct of_device_id lynx_pcs_of_match[] = {
   375		{ .compatible = "fsl,lynx-pcs" },
   376		{ },
   377	};
   378	MODULE_DEVICE_TABLE(of, lynx_pcs_of_match);
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

