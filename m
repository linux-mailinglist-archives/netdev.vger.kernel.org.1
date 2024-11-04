Return-Path: <netdev+bounces-141567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63689BB6CF
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73851283B4A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621D13B797;
	Mon,  4 Nov 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5bfzmPD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A073501;
	Mon,  4 Nov 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728460; cv=none; b=cHXUY7Fs1eIHCKPMmkil5ZIwyU4ScmbO0oEBYWOZe9kJ6Lv/tReLgv2koN91/+R+y2nFYNWqoH6EdKbyzbojHKZ/puzgn/bxMziQXeWPuoHx8ygAy+jit8yiQfo+E6RqEKKojQ6PdZcUPxVKah65KX+FlIMixLnzyt5Qw1I2bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728460; c=relaxed/simple;
	bh=J8SWxFwhLmi5kGwcliagFaoUdQGhE8/vEUYoLQ1CeM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1Z1mxdkXSXgKfcjoXI7GSpY3tgVMQl3Zyz0j6S8ZNRbe6oKte8WYu0W3UoJYkFdFAPxjser32w7Hd+JfoDXdQgnT7epbNs2LmlRy7vPV7XvlT29JubDbXTJFCtGbqoQEOkwVQfPawpDDTjkzWeGxvP9tjxx9q7PLQ+X2CanVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5bfzmPD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730728458; x=1762264458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8SWxFwhLmi5kGwcliagFaoUdQGhE8/vEUYoLQ1CeM0=;
  b=E5bfzmPDwsxMYdwvD+SOfFkxxXlDI1LyuRP8FWC7D9JOaJAsFvZ/wGmx
   6JZWZw1QzlUfDOuHIRUH73/RFxWQ8sYZi952yKGYP8CWew3Vbm3DCMgSD
   w6Xd8fWWHrhA8qy6MisoDXyBMY5gZGkbYzKOm7Pw7PCbj0I8YDW3trNA3
   E9q0DFrjsPpMCbynCnCcJ3eaUfxxkpL7n0C07m3RnI8FaFkY4RumCUakr
   eIyJGfOirqjGnKPwct5792yIVHsVw8k156qNzZAOCmaiyj4N6JhhKSZA9
   XXa67syVTCqJ4ZYBdYqFNPp2P7/+ebqtuqXAidpXhQPnL8uXoB1We374i
   g==;
X-CSE-ConnectionGUID: +uyLrhmTTTml9Go78FOnBA==
X-CSE-MsgGUID: MJqCbhgSTZqzrldISAF9mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33262564"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="33262564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:54:17 -0800
X-CSE-ConnectionGUID: MYqH0ZzcTw2zu3vjF7Pj6Q==
X-CSE-MsgGUID: sfacvHlCRqOP+Y2NzHSEvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84105436"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:54:14 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7xX2-000ksD-1W;
	Mon, 04 Nov 2024 13:54:12 +0000
Date: Mon, 4 Nov 2024 21:53:14 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair23@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@armlinux.org.uk,
	hkallweit1@gmail.com, andrew@lunn.ch, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
Message-ID: <202411042118.dhgElzHF-lkp@intel.com>
References: <20241104070950.502719-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104070950.502719-1-alistair.francis@wdc.com>

Hi Alistair,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on horms-ipvs/master v6.12-rc6 next-20241104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/include-mdio-Guard-inline-function-with-CONFIG_MDIO/20241104-151211
base:   linus/master
patch link:    https://lore.kernel.org/r/20241104070950.502719-1-alistair.francis%40wdc.com
patch subject: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241104/202411042118.dhgElzHF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411042118.dhgElzHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411042118.dhgElzHF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/mdio.c:183:6: warning: no previous prototype for 'mdio45_ethtool_gset_npage' [-Wmissing-prototypes]
     183 | void mdio45_ethtool_gset_npage(const struct mdio_if_info *mdio,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/mdio.c:355:6: warning: no previous prototype for 'mdio45_ethtool_ksettings_get_npage' [-Wmissing-prototypes]
     355 | void mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mdio45_ethtool_gset_npage +183 drivers/net/mdio.c

1b1c2e95103ce3 Ben Hutchings   2009-04-29  168  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  169  /**
1b1c2e95103ce3 Ben Hutchings   2009-04-29  170   * mdio45_ethtool_gset_npage - get settings for ETHTOOL_GSET
1b1c2e95103ce3 Ben Hutchings   2009-04-29  171   * @mdio: MDIO interface
1b1c2e95103ce3 Ben Hutchings   2009-04-29  172   * @ecmd: Ethtool request structure
1b1c2e95103ce3 Ben Hutchings   2009-04-29  173   * @npage_adv: Modes currently advertised on next pages
1b1c2e95103ce3 Ben Hutchings   2009-04-29  174   * @npage_lpa: Modes advertised by link partner on next pages
1b1c2e95103ce3 Ben Hutchings   2009-04-29  175   *
8ae6daca85c8bb David Decotigny 2011-04-27  176   * The @ecmd parameter is expected to have been cleared before calling
8ae6daca85c8bb David Decotigny 2011-04-27  177   * mdio45_ethtool_gset_npage().
8ae6daca85c8bb David Decotigny 2011-04-27  178   *
1b1c2e95103ce3 Ben Hutchings   2009-04-29  179   * Since the CSRs for auto-negotiation using next pages are not fully
1b1c2e95103ce3 Ben Hutchings   2009-04-29  180   * standardised, this function does not attempt to decode them.  The
1b1c2e95103ce3 Ben Hutchings   2009-04-29  181   * caller must pass them in.
1b1c2e95103ce3 Ben Hutchings   2009-04-29  182   */
1b1c2e95103ce3 Ben Hutchings   2009-04-29 @183  void mdio45_ethtool_gset_npage(const struct mdio_if_info *mdio,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  184  			       struct ethtool_cmd *ecmd,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  185  			       u32 npage_adv, u32 npage_lpa)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  186  {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  187  	int reg;
707394972093e2 David Decotigny 2011-04-27  188  	u32 speed;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  189  
9c4df53bc3f9c7 Ben Hutchings   2012-02-29  190  	BUILD_BUG_ON(MDIO_SUPPORTS_C22 != ETH_MDIO_SUPPORTS_C22);
9c4df53bc3f9c7 Ben Hutchings   2012-02-29  191  	BUILD_BUG_ON(MDIO_SUPPORTS_C45 != ETH_MDIO_SUPPORTS_C45);
9c4df53bc3f9c7 Ben Hutchings   2012-02-29  192  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  193  	ecmd->transceiver = XCVR_INTERNAL;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  194  	ecmd->phy_address = mdio->prtad;
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  195  	ecmd->mdio_support =
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  196  		mdio->mode_support & (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  197  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  198  	reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  199  			      MDIO_CTRL2);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  200  	switch (reg & MDIO_PMA_CTRL2_TYPE) {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  201  	case MDIO_PMA_CTRL2_10GBT:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  202  	case MDIO_PMA_CTRL2_1000BT:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  203  	case MDIO_PMA_CTRL2_100BTX:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  204  	case MDIO_PMA_CTRL2_10BT:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  205  		ecmd->port = PORT_TP;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  206  		ecmd->supported = SUPPORTED_TP;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  207  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  208  				      MDIO_SPEED);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  209  		if (reg & MDIO_SPEED_10G)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  210  			ecmd->supported |= SUPPORTED_10000baseT_Full;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  211  		if (reg & MDIO_PMA_SPEED_1000)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  212  			ecmd->supported |= (SUPPORTED_1000baseT_Full |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  213  					    SUPPORTED_1000baseT_Half);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  214  		if (reg & MDIO_PMA_SPEED_100)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  215  			ecmd->supported |= (SUPPORTED_100baseT_Full |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  216  					    SUPPORTED_100baseT_Half);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  217  		if (reg & MDIO_PMA_SPEED_10)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  218  			ecmd->supported |= (SUPPORTED_10baseT_Full |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  219  					    SUPPORTED_10baseT_Half);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  220  		ecmd->advertising = ADVERTISED_TP;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  221  		break;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  222  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  223  	case MDIO_PMA_CTRL2_10GBCX4:
894b19a6b343ce Ben Hutchings   2009-04-29  224  		ecmd->port = PORT_OTHER;
894b19a6b343ce Ben Hutchings   2009-04-29  225  		ecmd->supported = 0;
894b19a6b343ce Ben Hutchings   2009-04-29  226  		ecmd->advertising = 0;
894b19a6b343ce Ben Hutchings   2009-04-29  227  		break;
894b19a6b343ce Ben Hutchings   2009-04-29  228  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  229  	case MDIO_PMA_CTRL2_10GBKX4:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  230  	case MDIO_PMA_CTRL2_10GBKR:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  231  	case MDIO_PMA_CTRL2_1000BKX:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  232  		ecmd->port = PORT_OTHER;
894b19a6b343ce Ben Hutchings   2009-04-29  233  		ecmd->supported = SUPPORTED_Backplane;
894b19a6b343ce Ben Hutchings   2009-04-29  234  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
894b19a6b343ce Ben Hutchings   2009-04-29  235  				      MDIO_PMA_EXTABLE);
894b19a6b343ce Ben Hutchings   2009-04-29  236  		if (reg & MDIO_PMA_EXTABLE_10GBKX4)
894b19a6b343ce Ben Hutchings   2009-04-29  237  			ecmd->supported |= SUPPORTED_10000baseKX4_Full;
894b19a6b343ce Ben Hutchings   2009-04-29  238  		if (reg & MDIO_PMA_EXTABLE_10GBKR)
894b19a6b343ce Ben Hutchings   2009-04-29  239  			ecmd->supported |= SUPPORTED_10000baseKR_Full;
894b19a6b343ce Ben Hutchings   2009-04-29  240  		if (reg & MDIO_PMA_EXTABLE_1000BKX)
894b19a6b343ce Ben Hutchings   2009-04-29  241  			ecmd->supported |= SUPPORTED_1000baseKX_Full;
894b19a6b343ce Ben Hutchings   2009-04-29  242  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
894b19a6b343ce Ben Hutchings   2009-04-29  243  				      MDIO_PMA_10GBR_FECABLE);
894b19a6b343ce Ben Hutchings   2009-04-29  244  		if (reg & MDIO_PMA_10GBR_FECABLE_ABLE)
894b19a6b343ce Ben Hutchings   2009-04-29  245  			ecmd->supported |= SUPPORTED_10000baseR_FEC;
894b19a6b343ce Ben Hutchings   2009-04-29  246  		ecmd->advertising = ADVERTISED_Backplane;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  247  		break;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  248  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  249  	/* All the other defined modes are flavours of optical */
1b1c2e95103ce3 Ben Hutchings   2009-04-29  250  	default:
1b1c2e95103ce3 Ben Hutchings   2009-04-29  251  		ecmd->port = PORT_FIBRE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  252  		ecmd->supported = SUPPORTED_FIBRE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  253  		ecmd->advertising = ADVERTISED_FIBRE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  254  		break;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  255  	}
1b1c2e95103ce3 Ben Hutchings   2009-04-29  256  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  257  	if (mdio->mmds & MDIO_DEVS_AN) {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  258  		ecmd->supported |= SUPPORTED_Autoneg;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  259  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_AN,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  260  				      MDIO_CTRL1);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  261  		if (reg & MDIO_AN_CTRL1_ENABLE) {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  262  			ecmd->autoneg = AUTONEG_ENABLE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  263  			ecmd->advertising |=
1b1c2e95103ce3 Ben Hutchings   2009-04-29  264  				ADVERTISED_Autoneg |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  265  				mdio45_get_an(mdio, MDIO_AN_ADVERTISE) |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  266  				npage_adv;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  267  		} else {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  268  			ecmd->autoneg = AUTONEG_DISABLE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  269  		}
1b1c2e95103ce3 Ben Hutchings   2009-04-29  270  	} else {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  271  		ecmd->autoneg = AUTONEG_DISABLE;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  272  	}
1b1c2e95103ce3 Ben Hutchings   2009-04-29  273  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  274  	if (ecmd->autoneg) {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  275  		u32 modes = 0;
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  276  		int an_stat = mdio->mdio_read(mdio->dev, mdio->prtad,
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  277  					      MDIO_MMD_AN, MDIO_STAT1);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  278  
1b1c2e95103ce3 Ben Hutchings   2009-04-29  279  		/* If AN is complete and successful, report best common
1b1c2e95103ce3 Ben Hutchings   2009-04-29  280  		 * mode, otherwise report best advertised mode. */
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  281  		if (an_stat & MDIO_AN_STAT1_COMPLETE) {
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  282  			ecmd->lp_advertising =
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  283  				mdio45_get_an(mdio, MDIO_AN_LPA) | npage_lpa;
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  284  			if (an_stat & MDIO_AN_STAT1_LPABLE)
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  285  				ecmd->lp_advertising |= ADVERTISED_Autoneg;
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  286  			modes = ecmd->advertising & ecmd->lp_advertising;
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  287  		}
0c09c1a49cc7b8 Ben Hutchings   2009-04-29  288  		if ((modes & ~ADVERTISED_Autoneg) == 0)
1b1c2e95103ce3 Ben Hutchings   2009-04-29  289  			modes = ecmd->advertising;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  290  
894b19a6b343ce Ben Hutchings   2009-04-29  291  		if (modes & (ADVERTISED_10000baseT_Full |
894b19a6b343ce Ben Hutchings   2009-04-29  292  			     ADVERTISED_10000baseKX4_Full |
894b19a6b343ce Ben Hutchings   2009-04-29  293  			     ADVERTISED_10000baseKR_Full)) {
707394972093e2 David Decotigny 2011-04-27  294  			speed = SPEED_10000;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  295  			ecmd->duplex = DUPLEX_FULL;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  296  		} else if (modes & (ADVERTISED_1000baseT_Full |
894b19a6b343ce Ben Hutchings   2009-04-29  297  				    ADVERTISED_1000baseT_Half |
894b19a6b343ce Ben Hutchings   2009-04-29  298  				    ADVERTISED_1000baseKX_Full)) {
707394972093e2 David Decotigny 2011-04-27  299  			speed = SPEED_1000;
894b19a6b343ce Ben Hutchings   2009-04-29  300  			ecmd->duplex = !(modes & ADVERTISED_1000baseT_Half);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  301  		} else if (modes & (ADVERTISED_100baseT_Full |
1b1c2e95103ce3 Ben Hutchings   2009-04-29  302  				    ADVERTISED_100baseT_Half)) {
707394972093e2 David Decotigny 2011-04-27  303  			speed = SPEED_100;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  304  			ecmd->duplex = !!(modes & ADVERTISED_100baseT_Full);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  305  		} else {
707394972093e2 David Decotigny 2011-04-27  306  			speed = SPEED_10;
1b1c2e95103ce3 Ben Hutchings   2009-04-29  307  			ecmd->duplex = !!(modes & ADVERTISED_10baseT_Full);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  308  		}
1b1c2e95103ce3 Ben Hutchings   2009-04-29  309  	} else {
1b1c2e95103ce3 Ben Hutchings   2009-04-29  310  		/* Report forced settings */
1b1c2e95103ce3 Ben Hutchings   2009-04-29  311  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
1b1c2e95103ce3 Ben Hutchings   2009-04-29  312  				      MDIO_CTRL1);
707394972093e2 David Decotigny 2011-04-27  313  		speed = (((reg & MDIO_PMA_CTRL1_SPEED1000) ? 100 : 1)
707394972093e2 David Decotigny 2011-04-27  314  			 * ((reg & MDIO_PMA_CTRL1_SPEED100) ? 100 : 10));
1b1c2e95103ce3 Ben Hutchings   2009-04-29  315  		ecmd->duplex = (reg & MDIO_CTRL1_FULLDPLX ||
707394972093e2 David Decotigny 2011-04-27  316  				speed == SPEED_10000);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  317  	}
d005ba6cc82440 Ben Hutchings   2009-06-10  318  
707394972093e2 David Decotigny 2011-04-27  319  	ethtool_cmd_speed_set(ecmd, speed);
707394972093e2 David Decotigny 2011-04-27  320  
d005ba6cc82440 Ben Hutchings   2009-06-10  321  	/* 10GBASE-T MDI/MDI-X */
707394972093e2 David Decotigny 2011-04-27  322  	if (ecmd->port == PORT_TP
707394972093e2 David Decotigny 2011-04-27  323  	    && (ethtool_cmd_speed(ecmd) == SPEED_10000)) {
d005ba6cc82440 Ben Hutchings   2009-06-10  324  		switch (mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
d005ba6cc82440 Ben Hutchings   2009-06-10  325  					MDIO_PMA_10GBT_SWAPPOL)) {
d005ba6cc82440 Ben Hutchings   2009-06-10  326  		case MDIO_PMA_10GBT_SWAPPOL_ABNX | MDIO_PMA_10GBT_SWAPPOL_CDNX:
d005ba6cc82440 Ben Hutchings   2009-06-10  327  			ecmd->eth_tp_mdix = ETH_TP_MDI;
d005ba6cc82440 Ben Hutchings   2009-06-10  328  			break;
d005ba6cc82440 Ben Hutchings   2009-06-10  329  		case 0:
d005ba6cc82440 Ben Hutchings   2009-06-10  330  			ecmd->eth_tp_mdix = ETH_TP_MDI_X;
d005ba6cc82440 Ben Hutchings   2009-06-10  331  			break;
d005ba6cc82440 Ben Hutchings   2009-06-10  332  		default:
d005ba6cc82440 Ben Hutchings   2009-06-10  333  			/* It's complicated... */
d005ba6cc82440 Ben Hutchings   2009-06-10  334  			ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
d005ba6cc82440 Ben Hutchings   2009-06-10  335  			break;
d005ba6cc82440 Ben Hutchings   2009-06-10  336  		}
d005ba6cc82440 Ben Hutchings   2009-06-10  337  	}
1b1c2e95103ce3 Ben Hutchings   2009-04-29  338  }
1b1c2e95103ce3 Ben Hutchings   2009-04-29  339  EXPORT_SYMBOL(mdio45_ethtool_gset_npage);
1b1c2e95103ce3 Ben Hutchings   2009-04-29  340  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  341  /**
8e4881aa1d5d2f Philippe Reynes 2017-01-01  342   * mdio45_ethtool_ksettings_get_npage - get settings for ETHTOOL_GLINKSETTINGS
8e4881aa1d5d2f Philippe Reynes 2017-01-01  343   * @mdio: MDIO interface
8e4881aa1d5d2f Philippe Reynes 2017-01-01  344   * @cmd: Ethtool request structure
8e4881aa1d5d2f Philippe Reynes 2017-01-01  345   * @npage_adv: Modes currently advertised on next pages
8e4881aa1d5d2f Philippe Reynes 2017-01-01  346   * @npage_lpa: Modes advertised by link partner on next pages
8e4881aa1d5d2f Philippe Reynes 2017-01-01  347   *
8e4881aa1d5d2f Philippe Reynes 2017-01-01  348   * The @cmd parameter is expected to have been cleared before calling
8e4881aa1d5d2f Philippe Reynes 2017-01-01  349   * mdio45_ethtool_ksettings_get_npage().
8e4881aa1d5d2f Philippe Reynes 2017-01-01  350   *
8e4881aa1d5d2f Philippe Reynes 2017-01-01  351   * Since the CSRs for auto-negotiation using next pages are not fully
8e4881aa1d5d2f Philippe Reynes 2017-01-01  352   * standardised, this function does not attempt to decode them.  The
8e4881aa1d5d2f Philippe Reynes 2017-01-01  353   * caller must pass them in.
8e4881aa1d5d2f Philippe Reynes 2017-01-01  354   */
8e4881aa1d5d2f Philippe Reynes 2017-01-01 @355  void mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  356  					struct ethtool_link_ksettings *cmd,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  357  					u32 npage_adv, u32 npage_lpa)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  358  {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  359  	int reg;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  360  	u32 speed, supported = 0, advertising = 0, lp_advertising = 0;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  361  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  362  	BUILD_BUG_ON(MDIO_SUPPORTS_C22 != ETH_MDIO_SUPPORTS_C22);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  363  	BUILD_BUG_ON(MDIO_SUPPORTS_C45 != ETH_MDIO_SUPPORTS_C45);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  364  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  365  	cmd->base.phy_address = mdio->prtad;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  366  	cmd->base.mdio_support =
8e4881aa1d5d2f Philippe Reynes 2017-01-01  367  		mdio->mode_support & (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  368  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  369  	reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  370  			      MDIO_CTRL2);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  371  	switch (reg & MDIO_PMA_CTRL2_TYPE) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  372  	case MDIO_PMA_CTRL2_10GBT:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  373  	case MDIO_PMA_CTRL2_1000BT:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  374  	case MDIO_PMA_CTRL2_100BTX:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  375  	case MDIO_PMA_CTRL2_10BT:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  376  		cmd->base.port = PORT_TP;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  377  		supported = SUPPORTED_TP;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  378  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  379  				      MDIO_SPEED);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  380  		if (reg & MDIO_SPEED_10G)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  381  			supported |= SUPPORTED_10000baseT_Full;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  382  		if (reg & MDIO_PMA_SPEED_1000)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  383  			supported |= (SUPPORTED_1000baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  384  					    SUPPORTED_1000baseT_Half);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  385  		if (reg & MDIO_PMA_SPEED_100)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  386  			supported |= (SUPPORTED_100baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  387  					    SUPPORTED_100baseT_Half);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  388  		if (reg & MDIO_PMA_SPEED_10)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  389  			supported |= (SUPPORTED_10baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  390  					    SUPPORTED_10baseT_Half);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  391  		advertising = ADVERTISED_TP;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  392  		break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  393  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  394  	case MDIO_PMA_CTRL2_10GBCX4:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  395  		cmd->base.port = PORT_OTHER;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  396  		supported = 0;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  397  		advertising = 0;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  398  		break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  399  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  400  	case MDIO_PMA_CTRL2_10GBKX4:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  401  	case MDIO_PMA_CTRL2_10GBKR:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  402  	case MDIO_PMA_CTRL2_1000BKX:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  403  		cmd->base.port = PORT_OTHER;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  404  		supported = SUPPORTED_Backplane;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  405  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  406  				      MDIO_PMA_EXTABLE);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  407  		if (reg & MDIO_PMA_EXTABLE_10GBKX4)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  408  			supported |= SUPPORTED_10000baseKX4_Full;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  409  		if (reg & MDIO_PMA_EXTABLE_10GBKR)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  410  			supported |= SUPPORTED_10000baseKR_Full;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  411  		if (reg & MDIO_PMA_EXTABLE_1000BKX)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  412  			supported |= SUPPORTED_1000baseKX_Full;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  413  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  414  				      MDIO_PMA_10GBR_FECABLE);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  415  		if (reg & MDIO_PMA_10GBR_FECABLE_ABLE)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  416  			supported |= SUPPORTED_10000baseR_FEC;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  417  		advertising = ADVERTISED_Backplane;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  418  		break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  419  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  420  	/* All the other defined modes are flavours of optical */
8e4881aa1d5d2f Philippe Reynes 2017-01-01  421  	default:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  422  		cmd->base.port = PORT_FIBRE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  423  		supported = SUPPORTED_FIBRE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  424  		advertising = ADVERTISED_FIBRE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  425  		break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  426  	}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  427  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  428  	if (mdio->mmds & MDIO_DEVS_AN) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  429  		supported |= SUPPORTED_Autoneg;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  430  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_AN,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  431  				      MDIO_CTRL1);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  432  		if (reg & MDIO_AN_CTRL1_ENABLE) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  433  			cmd->base.autoneg = AUTONEG_ENABLE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  434  			advertising |=
8e4881aa1d5d2f Philippe Reynes 2017-01-01  435  				ADVERTISED_Autoneg |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  436  				mdio45_get_an(mdio, MDIO_AN_ADVERTISE) |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  437  				npage_adv;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  438  		} else {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  439  			cmd->base.autoneg = AUTONEG_DISABLE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  440  		}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  441  	} else {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  442  		cmd->base.autoneg = AUTONEG_DISABLE;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  443  	}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  444  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  445  	if (cmd->base.autoneg) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  446  		u32 modes = 0;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  447  		int an_stat = mdio->mdio_read(mdio->dev, mdio->prtad,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  448  					      MDIO_MMD_AN, MDIO_STAT1);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  449  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  450  		/* If AN is complete and successful, report best common
8e4881aa1d5d2f Philippe Reynes 2017-01-01  451  		 * mode, otherwise report best advertised mode.
8e4881aa1d5d2f Philippe Reynes 2017-01-01  452  		 */
8e4881aa1d5d2f Philippe Reynes 2017-01-01  453  		if (an_stat & MDIO_AN_STAT1_COMPLETE) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  454  			lp_advertising =
8e4881aa1d5d2f Philippe Reynes 2017-01-01  455  				mdio45_get_an(mdio, MDIO_AN_LPA) | npage_lpa;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  456  			if (an_stat & MDIO_AN_STAT1_LPABLE)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  457  				lp_advertising |= ADVERTISED_Autoneg;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  458  			modes = advertising & lp_advertising;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  459  		}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  460  		if ((modes & ~ADVERTISED_Autoneg) == 0)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  461  			modes = advertising;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  462  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  463  		if (modes & (ADVERTISED_10000baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  464  			     ADVERTISED_10000baseKX4_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  465  			     ADVERTISED_10000baseKR_Full)) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  466  			speed = SPEED_10000;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  467  			cmd->base.duplex = DUPLEX_FULL;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  468  		} else if (modes & (ADVERTISED_1000baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  469  				    ADVERTISED_1000baseT_Half |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  470  				    ADVERTISED_1000baseKX_Full)) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  471  			speed = SPEED_1000;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  472  			cmd->base.duplex = !(modes & ADVERTISED_1000baseT_Half);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  473  		} else if (modes & (ADVERTISED_100baseT_Full |
8e4881aa1d5d2f Philippe Reynes 2017-01-01  474  				    ADVERTISED_100baseT_Half)) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  475  			speed = SPEED_100;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  476  			cmd->base.duplex = !!(modes & ADVERTISED_100baseT_Full);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  477  		} else {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  478  			speed = SPEED_10;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  479  			cmd->base.duplex = !!(modes & ADVERTISED_10baseT_Full);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  480  		}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  481  	} else {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  482  		/* Report forced settings */
8e4881aa1d5d2f Philippe Reynes 2017-01-01  483  		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  484  				      MDIO_CTRL1);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  485  		speed = (((reg & MDIO_PMA_CTRL1_SPEED1000) ? 100 : 1)
8e4881aa1d5d2f Philippe Reynes 2017-01-01  486  			 * ((reg & MDIO_PMA_CTRL1_SPEED100) ? 100 : 10));
8e4881aa1d5d2f Philippe Reynes 2017-01-01  487  		cmd->base.duplex = (reg & MDIO_CTRL1_FULLDPLX ||
8e4881aa1d5d2f Philippe Reynes 2017-01-01  488  				    speed == SPEED_10000);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  489  	}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  490  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  491  	cmd->base.speed = speed;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  492  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  493  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  494  						supported);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  495  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  496  						advertising);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  497  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  498  						lp_advertising);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  499  
8e4881aa1d5d2f Philippe Reynes 2017-01-01  500  	/* 10GBASE-T MDI/MDI-X */
8e4881aa1d5d2f Philippe Reynes 2017-01-01  501  	if (cmd->base.port == PORT_TP && (cmd->base.speed == SPEED_10000)) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  502  		switch (mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
8e4881aa1d5d2f Philippe Reynes 2017-01-01  503  					MDIO_PMA_10GBT_SWAPPOL)) {
8e4881aa1d5d2f Philippe Reynes 2017-01-01  504  		case MDIO_PMA_10GBT_SWAPPOL_ABNX | MDIO_PMA_10GBT_SWAPPOL_CDNX:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  505  			cmd->base.eth_tp_mdix = ETH_TP_MDI;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  506  			break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  507  		case 0:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  508  			cmd->base.eth_tp_mdix = ETH_TP_MDI_X;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  509  			break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  510  		default:
8e4881aa1d5d2f Philippe Reynes 2017-01-01  511  			/* It's complicated... */
8e4881aa1d5d2f Philippe Reynes 2017-01-01  512  			cmd->base.eth_tp_mdix = ETH_TP_MDI_INVALID;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  513  			break;
8e4881aa1d5d2f Philippe Reynes 2017-01-01  514  		}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  515  	}
8e4881aa1d5d2f Philippe Reynes 2017-01-01  516  }
8e4881aa1d5d2f Philippe Reynes 2017-01-01  517  EXPORT_SYMBOL(mdio45_ethtool_ksettings_get_npage);
8e4881aa1d5d2f Philippe Reynes 2017-01-01  518  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

