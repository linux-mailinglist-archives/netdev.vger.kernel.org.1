Return-Path: <netdev+bounces-59384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E011A81ABD5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4E1F23473
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E42589;
	Thu, 21 Dec 2023 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4iXzBhY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEB257B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703119333; x=1734655333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNz8v9ly1ZAE7nrayl+DLYXjaraFfzmrbI/RsyYpY5M=;
  b=P4iXzBhYG/SWSAAPjv35KEHPHLk35gT9ux/5IveJ8zIXNogW+2ckVqQC
   0pC5RmBWUWfwtocXUj6tUFlPue+nw/XFK85m4q0B863Uz4wSzuqlYMFED
   WIIC3U31TTJv3uP06GtnX1LGxiXl2lbh3oow9qOQYCIpbCaKkx3dzdhRe
   t3+zmf9cjV+N8QE/mIAsAMaG7sFI4brE3owtj9yMWhlcUxcM0LjNDStKo
   x3oqMke5Wbk/eEQeOlxnATkI+WGFUfVyMmxYflyKWSTff1F62Y0ELbbLg
   +SL2KbzAPPMTRtyl44b0bL11dn2iLLdHwUPdf8o3RUyxJ62jUkPTkmEDT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482079852"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="482079852"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:42:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805428344"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="805428344"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2023 16:42:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG78Y-0007i9-2A;
	Thu, 21 Dec 2023 00:42:06 +0000
Date: Thu, 21 Dec 2023 08:41:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: Re: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
Message-ID: <202312210853.t6DhuvdS-lkp@intel.com>
References: <20231220042632.26825-8-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220042632.26825-8-luizluca@gmail.com>

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Angelo-Daros-de-Luca/net-dsa-realtek-drop-cleanup-from-realtek_ops/20231220-122907
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231220042632.26825-8-luizluca%40gmail.com
patch subject: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231221/202312210853.t6DhuvdS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210853.t6DhuvdS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210853.t6DhuvdS-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/dsa/dsa.c: In function 'dsa_switch_setup':
>> net/dsa/dsa.c:667:60: error: macro "mdiobus_register" passed 2 arguments, but takes just 1
     667 |                 err = mdiobus_register(ds->user_mii_bus, dn);
         |                                                            ^
   In file included from include/linux/of_net.h:9,
                    from net/dsa/dsa.c:18:
   include/linux/phy.h:456: note: macro "mdiobus_register" defined here
     456 | #define mdiobus_register(bus) __mdiobus_register(bus, THIS_MODULE)
         | 
>> net/dsa/dsa.c:667:23: error: 'mdiobus_register' undeclared (first use in this function); did you mean 'mdiobus_unregister'?
     667 |                 err = mdiobus_register(ds->user_mii_bus, dn);
         |                       ^~~~~~~~~~~~~~~~
         |                       mdiobus_unregister
   net/dsa/dsa.c:667:23: note: each undeclared identifier is reported only once for each function it appears in


vim +/mdiobus_register +667 net/dsa/dsa.c

   625	
   626	static int dsa_switch_setup(struct dsa_switch *ds)
   627	{
   628		int err;
   629	
   630		if (ds->setup)
   631			return 0;
   632	
   633		/* Initialize ds->phys_mii_mask before registering the user MDIO bus
   634		 * driver and before ops->setup() has run, since the switch drivers and
   635		 * the user MDIO bus driver rely on these values for probing PHY
   636		 * devices or not
   637		 */
   638		ds->phys_mii_mask |= dsa_user_ports(ds);
   639	
   640		err = dsa_switch_devlink_alloc(ds);
   641		if (err)
   642			return err;
   643	
   644		err = dsa_switch_register_notifier(ds);
   645		if (err)
   646			goto devlink_free;
   647	
   648		ds->configure_vlan_while_not_filtering = true;
   649	
   650		err = ds->ops->setup(ds);
   651		if (err < 0)
   652			goto unregister_notifier;
   653	
   654		err = dsa_switch_setup_tag_protocol(ds);
   655		if (err)
   656			goto teardown;
   657	
   658		if (!ds->user_mii_bus && ds->ops->phy_read) {
   659			ds->user_mii_bus = mdiobus_alloc();
   660			if (!ds->user_mii_bus) {
   661				err = -ENOMEM;
   662				goto teardown;
   663			}
   664	
   665			dsa_user_mii_bus_init(ds);
   666	
 > 667			err = mdiobus_register(ds->user_mii_bus, dn);
   668			if (err < 0)
   669				goto free_user_mii_bus;
   670		}
   671	
   672		dsa_switch_devlink_register(ds);
   673	
   674		ds->setup = true;
   675		return 0;
   676	
   677	free_user_mii_bus:
   678		if (ds->user_mii_bus && ds->ops->phy_read)
   679			mdiobus_free(ds->user_mii_bus);
   680	teardown:
   681		if (ds->ops->teardown)
   682			ds->ops->teardown(ds);
   683	unregister_notifier:
   684		dsa_switch_unregister_notifier(ds);
   685	devlink_free:
   686		dsa_switch_devlink_free(ds);
   687		return err;
   688	}
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

