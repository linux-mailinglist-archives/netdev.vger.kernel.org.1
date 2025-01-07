Return-Path: <netdev+bounces-155744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74BA038C8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1567A23C4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4EE19ABCE;
	Tue,  7 Jan 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBJfvWWO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02586338
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234960; cv=none; b=JlTR1kt8ogjN793hZbsd9zqQrRHziios/p7Mro6xTM4ZsOKKDysEAL2Y020A2yJDk0+VeKuioJrSl9ohMiqfQne6WDTHrVay2xDQ6jwXXysE7h/pSW7WWDyqppZTeni1OyymY7nd6/H0O9ZcwKwZ+X522wgV816jo7GtRtf94G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234960; c=relaxed/simple;
	bh=uat2YMlEc7Xp6j7gAomimDsLGJKKKHa/p6RKV8tc0a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYsWZDba627wopg4FUPFBYSyWPMQIrtSDhH+qRYYqmCZv26lz7cIy7h+77KJpk0SzGOvHKOQ1JnFcCys3Qja7NJVQEwJCDT0t0X5k+6WNOhyVtQSoSyL++/OXvnx4e2VR9ALF9M52nJ2EzDJomZSyNHuhc35xzjTOEG7BH0Jz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBJfvWWO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736234957; x=1767770957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uat2YMlEc7Xp6j7gAomimDsLGJKKKHa/p6RKV8tc0a8=;
  b=LBJfvWWOAoFuw/1eEc1OwoHgnmE0hShiFgzqNkEpsVsegsdhvZ/f2uur
   CNGeu/j4XfJceZuzET10PXQfOgUJcmtQrhntvZP0+d9F7sfd8Df5dkCFX
   PT2SHOGL8wN3d39gVKAph/V8oQw8HTl3odgitXzoST9FeKJi5uZSKhQYv
   V8OmxLBx1wb9yGN4H2tJcUToIAHJ2nz0l6EGex4wQx0KsgxdbSMVy4gWd
   nLDs8dUrYFHsiHiikU8cH7m1muWhAFz90FpelkEUXghDSUyrH/xSYLHy4
   YgNpuJlvqBNRJw9m+dolsth1tKCbWBclNKTi9o3eVtbGlRR/V9NJ84nuf
   A==;
X-CSE-ConnectionGUID: xFD5aOcnTHi1Z69JAGlgVw==
X-CSE-MsgGUID: uO46DxwwQomImAJfGMUmTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40174513"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="40174513"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 23:29:16 -0800
X-CSE-ConnectionGUID: 1FALSZDjTGunzAkFKziNaQ==
X-CSE-MsgGUID: v8zTB9WhTaWnmmAkffTGsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102573726"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jan 2025 23:29:13 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tV41W-000EMZ-31;
	Tue, 07 Jan 2025 07:29:10 +0000
Date: Tue, 7 Jan 2025 15:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 12/17] net: stmmac: move priv->eee_active
 into stmmac_eee_init()
Message-ID: <202501071547.L5CjLObQ-lkp@intel.com>
References: <E1tUmAz-007VXn-0o@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAz-007VXn-0o@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-move-tx_lpi_timer-tracking-to-phylib/20250107-002808
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1tUmAz-007VXn-0o%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next v2 12/17] net: stmmac: move priv->eee_active into stmmac_eee_init()
config: i386-buildonly-randconfig-005-20250107 (https://download.01.org/0day-ci/archive/20250107/202501071547.L5CjLObQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250107/202501071547.L5CjLObQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501071547.L5CjLObQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:468: warning: Function parameter or struct member 'active' not described in 'stmmac_eee_init'


vim +468 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  458  
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  459  /**
732fdf0e5253e9 Giuseppe CAVALLARO       2014-11-18  460   * stmmac_eee_init - init EEE
32ceabcad3c8ab Giuseppe CAVALLARO       2013-04-08  461   * @priv: driver private structure
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  462   * Description:
732fdf0e5253e9 Giuseppe CAVALLARO       2014-11-18  463   *  if the GMAC supports the EEE (from the HW cap reg) and the phy device
732fdf0e5253e9 Giuseppe CAVALLARO       2014-11-18  464   *  can also manage EEE, this function enable the LPI state and start related
732fdf0e5253e9 Giuseppe CAVALLARO       2014-11-18  465   *  timer.
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  466   */
5ad24fd233fa83 Russell King (Oracle     2025-01-06  467) static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27 @468  {
5ad24fd233fa83 Russell King (Oracle     2025-01-06  469) 	priv->eee_active = active;
5ad24fd233fa83 Russell King (Oracle     2025-01-06  470) 
74371272f97fd1 Jose Abreu               2019-06-11  471  	/* Check if MAC core supports the EEE feature. */
418ee895284762 Russell King (Oracle     2025-01-06  472) 	if (!priv->dma_cap.eee) {
418ee895284762 Russell King (Oracle     2025-01-06  473) 		priv->eee_enabled = false;
418ee895284762 Russell King (Oracle     2025-01-06  474) 		return;
418ee895284762 Russell King (Oracle     2025-01-06  475) 	}
83bf79b6bb64e6 Giuseppe CAVALLARO       2014-03-10  476  
29555fa3de8656 Thierry Reding           2018-05-24  477  	mutex_lock(&priv->lock);
74371272f97fd1 Jose Abreu               2019-06-11  478  
74371272f97fd1 Jose Abreu               2019-06-11  479  	/* Check if it needs to be deactivated */
177d935a13703e Jon Hunter               2019-06-26  480  	if (!priv->eee_active) {
177d935a13703e Jon Hunter               2019-06-26  481  		if (priv->eee_enabled) {
38ddc59d65b6d9 LABBE Corentin           2016-11-16  482  			netdev_dbg(priv->dev, "disable EEE\n");
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  483  			stmmac_lpi_entry_timer_config(priv, 0);
83bf79b6bb64e6 Giuseppe CAVALLARO       2014-03-10  484  			del_timer_sync(&priv->eee_ctrl_timer);
26dbf37afd5d4b Russell King (Oracle     2025-01-06  485) 			stmmac_set_eee_timer(priv, priv->hw, 0,
26dbf37afd5d4b Russell King (Oracle     2025-01-06  486) 					     STMMAC_DEFAULT_TWT_LS);
d4aeaed80b0ebb Wong Vee Khee            2021-10-05  487  			if (priv->hw->xpcs)
d4aeaed80b0ebb Wong Vee Khee            2021-10-05  488  				xpcs_config_eee(priv->hw->xpcs,
d4aeaed80b0ebb Wong Vee Khee            2021-10-05  489  						priv->plat->mult_fact_100ns,
d4aeaed80b0ebb Wong Vee Khee            2021-10-05  490  						false);
177d935a13703e Jon Hunter               2019-06-26  491  		}
418ee895284762 Russell King (Oracle     2025-01-06  492) 		priv->eee_enabled = false;
0867bb9768deda Jon Hunter               2019-06-26  493  		mutex_unlock(&priv->lock);
418ee895284762 Russell King (Oracle     2025-01-06  494) 		return;
83bf79b6bb64e6 Giuseppe CAVALLARO       2014-03-10  495  	}
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  496  
74371272f97fd1 Jose Abreu               2019-06-11  497  	if (priv->eee_active && !priv->eee_enabled) {
74371272f97fd1 Jose Abreu               2019-06-11  498  		timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
74371272f97fd1 Jose Abreu               2019-06-11  499  		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
26dbf37afd5d4b Russell King (Oracle     2025-01-06  500) 				     STMMAC_DEFAULT_TWT_LS);
656ed8b015f19b Wong Vee Khee            2021-09-30  501  		if (priv->hw->xpcs)
656ed8b015f19b Wong Vee Khee            2021-09-30  502  			xpcs_config_eee(priv->hw->xpcs,
656ed8b015f19b Wong Vee Khee            2021-09-30  503  					priv->plat->mult_fact_100ns,
656ed8b015f19b Wong Vee Khee            2021-09-30  504  					true);
71965352eedd0c Giuseppe CAVALLARO       2014-08-28  505  	}
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  506  
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  507  	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  508  		del_timer_sync(&priv->eee_ctrl_timer);
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  509  		priv->tx_path_in_lpi_mode = false;
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  510  		stmmac_lpi_entry_timer_config(priv, 1);
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  511  	} else {
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  512  		stmmac_lpi_entry_timer_config(priv, 0);
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  513  		mod_timer(&priv->eee_ctrl_timer,
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  514  			  STMMAC_LPI_T(priv->tx_lpi_timer));
be1c7eae8c7dfc Vineetha G. Jaya Kumaran 2020-10-28  515  	}
388e201d41fa1e Vineetha G. Jaya Kumaran 2020-10-01  516  
418ee895284762 Russell King (Oracle     2025-01-06  517) 	priv->eee_enabled = true;
418ee895284762 Russell King (Oracle     2025-01-06  518) 
29555fa3de8656 Thierry Reding           2018-05-24  519  	mutex_unlock(&priv->lock);
38ddc59d65b6d9 LABBE Corentin           2016-11-16  520  	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  521  }
d765955d2ae0b8 Giuseppe CAVALLARO       2012-06-27  522  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

