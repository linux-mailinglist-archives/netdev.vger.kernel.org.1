Return-Path: <netdev+bounces-25907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300277623C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DDF1C2122E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAEB19BB1;
	Wed,  9 Aug 2023 14:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CB198BB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:19:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194A10F5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691590778; x=1723126778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TpXGrrB6Ug3L1a/LM10sXDSeVXTVx2Dl5F9rqESXdKM=;
  b=O09ILTjbcAxK4sUpFsSnRWnEXxbMhzhwc2/2+UPUWUESV4LG3agJfwsV
   YiD+vZG5G5fhogZlnRGwYs0vh0uIgsBhcTTCYphkVrqpHRSfcNUCYnevV
   QaSZOr2uS1iJU/hd8TdB7K/CRsejU927rdM44ONBqMgCGjqnqYe7bXtO1
   GNpnTD4uMc9yLEPz1yHSxihHgwMkbT/P/25kGnZcrzOzgw87HXjHz1d2Q
   brbCleUNZ0o4VMb6l5cGj8tkjJhJxTuK0egIcssFeYo3GFq6AhmOzu2q7
   j3RRMzfUWkAj0VBHXAnC08n2U96CQ6AtZDZyVQVQy90DIljhLiLW4tIHs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351439853"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="351439853"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="681696988"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="681696988"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2023 07:19:34 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qTk2A-000696-04;
	Wed, 09 Aug 2023 14:19:34 +0000
Date: Wed, 9 Aug 2023 22:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <202308092253.LelgPpOb-lkp@intel.com>
References: <E1qTiMC-003FJP-V3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qTiMC-003FJP-V3@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-dsa-mv88e6060-add-phylink_get_caps-implementation/20230809-203318
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1qTiMC-003FJP-V3%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next] net: dsa: mv88e6060: add phylink_get_caps implementation
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230809/202308092253.LelgPpOb-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230809/202308092253.LelgPpOb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308092253.LelgPpOb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/dsa/mv88e6060.c:8:
   drivers/net/dsa/mv88e6060.c: In function 'mv88e6060_phylink_get_caps':
>> drivers/net/dsa/mv88e6060.c:262:39: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     262 |                         port, PTR_ERR(ret));
         |                                       ^~~
         |                                       |
         |                                       int
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/net/dsa/mv88e6060.c:260:17: note: in expansion of macro 'dev_err'
     260 |                 dev_err(ds->dev,
         |                 ^~~~~~~
   In file included from include/linux/rwsem.h:17,
                    from include/linux/mm_types.h:13,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17:
   include/linux/err.h:49:61: note: expected 'const void *' but argument is of type 'int'
      49 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~
>> drivers/net/dsa/mv88e6060.c:261:25: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
     261 |                         "port %d: unable to read status register: %pe\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/dsa/mv88e6060.c:260:17: note: in expansion of macro 'dev_err'
     260 |                 dev_err(ds->dev,
         |                 ^~~~~~~
   drivers/net/dsa/mv88e6060.c:261:68: note: format string is defined here
     261 |                         "port %d: unable to read status register: %pe\n",
         |                                                                   ~^
         |                                                                    |
         |                                                                    void *
         |                                                                   %ld


vim +/PTR_ERR +262 drivers/net/dsa/mv88e6060.c

   249	
   250	static void mv88e6060_phylink_get_caps(struct dsa_switch *ds, int port,
   251					       struct phylink_config *config)
   252	{
   253		unsigned long *interfaces = config->supported_interfaces;
   254		struct mv88e6060_priv *priv = ds->priv;
   255		int addr = REG_PORT(port);
   256		int ret;
   257	
   258		ret = reg_read(priv, addr, PORT_STATUS);
   259		if (ret < 0) {
   260			dev_err(ds->dev,
 > 261				"port %d: unable to read status register: %pe\n",
 > 262				port, PTR_ERR(ret));
   263			return;
   264		}
   265	
   266		if (!(ret & PORT_STATUS_PORTMODE)) {
   267			/* Port configured in SNI mode (acts as a 10Mbps PHY) */
   268			config->mac_capabilities = MAC_10 | MAC_SYM_PAUSE;
   269			/* I don't think SNI is SMII - SMII has a sync signal, and
   270			 * SNI doesn't.
   271			 */
   272			__set_bit(PHY_INTERFACE_MODE_SMII, interfaces);
   273			return;
   274		}
   275	
   276		config->mac_capabilities = MAC_100 | MAC_10 | MAC_SYM_PAUSE;
   277	
   278		if (port >= 4) {
   279			/* Ports 4 and 5 can support MII, REVMII and REVRMII modes */
   280			__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
   281			__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
   282			__set_bit(PHY_INTERFACE_MODE_REVRMII, interfaces);
   283		}
   284		if (port <= 4) {
   285			/* Ports 0 to 3 have internal PHYs, and port 4 can optionally
   286			 * use an internal PHY.
   287			 */
   288			/* Internal PHY */
   289			__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
   290			/* Default phylib interface mode */
   291			__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
   292		}
   293	}
   294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

