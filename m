Return-Path: <netdev+bounces-229876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B18FFBE181D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59F1A4F2233
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B522F75E;
	Thu, 16 Oct 2025 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3XF/YVO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B322A4F8;
	Thu, 16 Oct 2025 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592079; cv=none; b=Fxkr0lAEwD3unPCZrPaObl2yHnDoiWnyMpEiZy7OIRotGR0w9FZ00cOhyBaUtX/L2yEmLvdWdzLYNXLL0L6fnOVUI7shbhPWQ4anOG25hK6dkxsu6equPMcwxhyj82S08AqWMxMU8l+B/U88RII7rverVo/Yu4d80S9zaW4Jr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592079; c=relaxed/simple;
	bh=u4kWyffIFWBDn5LKpz9r1St9mwhWVRcUo5b9qE+A0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW2Xm3A3yPPH77E9/GJgGqzGOpcb3qzzNra472TQI9wyqDkfjLbMwLlw3BKpmfLx58IqkmhEcpyVzpp51mQCpDrkyUCDhtocO+jhGtrkao0aEzgvE8HNRqtKhPJsRIcNsNeeRK6sL1vMWGQ5VnVnDl5u/uMFU3Qcsgq/GnQ8u6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3XF/YVO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760592078; x=1792128078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4kWyffIFWBDn5LKpz9r1St9mwhWVRcUo5b9qE+A0fg=;
  b=Y3XF/YVO1Oz1alSmPhnKuelmLSKAe3RM9lm+eOyfEjmF32ktacYf0TDp
   tTiPsAvrOrRhRUvKApv+E9dM8saTDfHW0MPCmUHhDxGYupvkBqgFy14hV
   9i5mVHgb2LHocyANuKDxtDp0LZ5HNf1iBldJ623dE9Kyx3Sv7Nx2pwxUY
   6AQhUyVsFhsC8xA/gRwnrmGu3A69tJxsPHSEyfqOfJyZ40grDWPxk3dMG
   W9ktDrGan/y+piF+GfNjbB/rT5fTMZ6xUYlAojaE4QoVfWoOuy38Q0oP8
   cp1EMiHeNgZ5m6/zDQ5eYtE3ESF9Q0Bq7S7z+vuyEvHu5oM019V/+DXBL
   w==;
X-CSE-ConnectionGUID: 8yPKUKr/SpGWrCReRK9PEw==
X-CSE-MsgGUID: wHxW+MfDQrmWsui0nw6x5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="88244348"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="88244348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:21:17 -0700
X-CSE-ConnectionGUID: DwCxjvItR5ueJ7gnjlR6PQ==
X-CSE-MsgGUID: WFfkG0EDScG99kcVfZJXmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="219508795"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Oct 2025 22:21:13 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9GQF-0004TV-1d;
	Thu, 16 Oct 2025 05:21:09 +0000
Date: Thu, 16 Oct 2025 13:20:51 +0800
From: kernel test robot <lkp@intel.com>
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Buday Csaba <buday.csaba@prolan.hu>
Subject: Re: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <202510161216.OMDTHD0v-lkp@intel.com>
References: <20251015134503.107925-4-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015134503.107925-4-buday.csaba@prolan.hu>

Hi Buday,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.18-rc1 next-20251015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Buday-Csaba/net-mdio-change-property-read-from-fwnode_property_read_u32-to-device_property_read_u32/20251015-214614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251015134503.107925-4-buday.csaba%40prolan.hu
patch subject: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
config: arc-randconfig-002-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161216.OMDTHD0v-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161216.OMDTHD0v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161216.OMDTHD0v-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/mdio/fwnode_mdio.c:121 function parameter 'bus' not described in 'fwnode_reset_phy'
>> Warning: drivers/net/mdio/fwnode_mdio.c:121 function parameter 'addr' not described in 'fwnode_reset_phy'
>> Warning: drivers/net/mdio/fwnode_mdio.c:121 function parameter 'phy_node' not described in 'fwnode_reset_phy'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

