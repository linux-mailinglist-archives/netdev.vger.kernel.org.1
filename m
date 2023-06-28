Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11974187B
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjF1S72 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 14:59:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:31378 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbjF1S5y (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 14:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687978674; x=1719514674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jh6Yo68JB6oWFdtn/7iL8FqvlLcXmL6Fp0vlENpUr+0=;
  b=JXAWgxXO/IPmWVr0JmXU7wbWIrILizHRa6eD7h0xB8Eiouk26C6jk5s7
   tEFaeOaJfgl7GI81B2CFJMqjX3wET7QGxSXIbhpAGEvtYlFctPVsYO4BP
   yVHxI59JbJvhgHcHixu+uKJr9Prf69AiUephnNHOoS80li8Lg0pnymkWB
   ogWabBoZP7Gnws5SaEj0hiVQJOxnPaH6m0/WxgwdBL2POoLB+E5F36FE2
   TbO3TZknbtHH7qZFKULnINlhs5rs/agB+FNQqbFD0oz4OKa2C2/+xou6W
   g/JzQIRi2iRQRcWrdjJiQUQI5PHVeHpStegjcab5JMzoxaqNU6w7yfN5a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="427946144"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="427946144"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="717069119"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="717069119"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2023 11:57:51 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEaMQ-000DRd-38;
        Wed, 28 Jun 2023 18:57:50 +0000
Date:   Thu, 29 Jun 2023 02:57:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Revanth Kumar Uppala <ruppala@nvidia.com>, linux@armlinux.org.uk,
        andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Message-ID: <202306290253.b8D3gQf8-lkp@intel.com>
References: <20230628124326.55732-4-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-4-ruppala@nvidia.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

Hi Revanth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.4 next-20230628]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Revanth-Kumar-Uppala/net-phy-aquantia-Enable-MAC-Controlled-EEE/20230628-204746
base:   net/main
patch link:    https://lore.kernel.org/r/20230628124326.55732-4-ruppala%40nvidia.com
patch subject: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
config: i386-randconfig-i013-20230628 (https://download.01.org/0day-ci/archive/20230629/202306290253.b8D3gQf8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306290253.b8D3gQf8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306290253.b8D3gQf8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/phy/aquantia_main.c: In function 'aqr_handle_interrupt':
>> drivers/net/phy/aquantia_main.c:476:29: warning: unused variable 'priv' [-Wunused-variable]
     476 |         struct aqr107_priv *priv = phydev->priv;
         |                             ^~~~


vim +/priv +476 drivers/net/phy/aquantia_main.c

   473	
   474	static irqreturn_t aqr_handle_interrupt(struct phy_device *phydev)
   475	{
 > 476		struct aqr107_priv *priv = phydev->priv;
   477		int irq_status;
   478		int ret;
   479	
   480		ret = phy_read_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_SGMII_TX_ALARM1);
   481		if (ret < 0) {
   482			phy_error(phydev);
   483			return IRQ_NONE;
   484		}
   485	
   486		if ((ret & MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK) ==
   487		    MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK) {
   488			/* Disable the WoL */
   489			ret = aqr113c_wol_disable(phydev);
   490			if (ret < 0)
   491				return IRQ_NONE;
   492		}
   493	
   494		irq_status = phy_read_mmd(phydev, MDIO_MMD_AN,
   495					  MDIO_AN_TX_VEND_INT_STATUS2);
   496		if (irq_status < 0) {
   497			phy_error(phydev);
   498			return IRQ_NONE;
   499		}
   500	
   501		if (!(irq_status & MDIO_AN_TX_VEND_INT_STATUS2_MASK))
   502			return IRQ_NONE;
   503	
   504		phy_trigger_machine(phydev);
   505	
   506		return IRQ_HANDLED;
   507	}
   508	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
