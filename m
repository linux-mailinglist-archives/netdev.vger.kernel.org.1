Return-Path: <netdev+bounces-238194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED0C55B21
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A5342E84
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33D309EE9;
	Thu, 13 Nov 2025 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReM0lS5u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E9305077
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009429; cv=none; b=PO9m1x1Xoz2FyhE0/k+nAWSR646WuRe6J6/kxNO1FaI9yob4DaDjfizgdpcD6Uj4g05SY/l/CMbH/C60l3gUlP4wQ9/qb9FHh8tw5kVwdqLRVOfa3EzHbZxspw4koY0Gi4l2EZMB00fJlCOFfTC4vZiKAIxHKost3hiLLlYAA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009429; c=relaxed/simple;
	bh=omOaESTzC5JdyNOxcqj8pYklVvUg+2CQxKky1CjcYzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIh95HKC7cu/5Mxhu2dGlM7+NA0fYeInGEyaYZByx4tfQwk+e6fFvUDaDP/DSPw0OJ1rpOyZgH5besWK5Nb/OCThKorY3ze37LqWDEQsp6Cbg24IhFFaSzthwqR74xeeEECmZBuTLlD4asgirE2eBs4qvQjebZrXi/SqDR9rtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReM0lS5u; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009428; x=1794545428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omOaESTzC5JdyNOxcqj8pYklVvUg+2CQxKky1CjcYzE=;
  b=ReM0lS5ulfkzu9b+6arMlT6wPnxTnejmEbdewwx9U13BjrfSx4oKzHCr
   SCxTioUVZdc4CMDnUvO6M6WHRH4cKskebltnjkSICy1qW/xE73XllDy66
   URmpAWLmZbUQAfWza6GLYz3AmZmXG6To+47b1+PXd6VywFsn18xmUpls3
   vsGZrehffuRgeGhyQitsDawA05E/PzooF9CmgAnq+wYafLjHXgHQ57CQI
   cqI29ZK0Bc/hlqufPZ9dzC0DKpKE4sJsrcUxFj7Yhrl+xFKF4RuexC0ag
   bw3FQ6GPktbSEtdjnh6hsyySZoT0p2xVGx8YZg827i74V/CYU7FaIYe9r
   w==;
X-CSE-ConnectionGUID: zp0oXkSKSSmT6Mr8NgwRCw==
X-CSE-MsgGUID: 54w9msXgSZiG5ZEvWSunzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68947863"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="68947863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:50:25 -0800
X-CSE-ConnectionGUID: ecAteJ/4Sxa1ScmBr/C/kQ==
X-CSE-MsgGUID: 4xufap9JQJmtAoHNzMPqyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="212789121"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2025 20:50:20 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPHm-0004sh-2H;
	Thu, 13 Nov 2025 04:50:18 +0000
Date: Thu, 13 Nov 2025 12:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 1/8] phy: add hwtstamp_get callback to retrieve
 config
Message-ID: <202511130038.ODz0uTOK-lkp@intel.com>
References: <20251112000257.1079049-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112000257.1079049-2-vadim.fedorenko@linux.dev>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/phy-add-hwtstamp_get-callback-to-retrieve-config/20251112-080606
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251112000257.1079049-2-vadim.fedorenko%40linux.dev
patch subject: [PATCH net-next 1/8] phy: add hwtstamp_get callback to retrieve config
config: arm-defconfig (https://download.01.org/0day-ci/archive/20251113/202511130038.ODz0uTOK-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130038.ODz0uTOK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511130038.ODz0uTOK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/ti/netcp_ethss.c:2660:23: error: no member named 'hwtstamp' in 'struct mii_timestamper'
    2660 |                 return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
         |                        ~~~~~~~~~~~  ^
   1 error generated.


vim +2660 drivers/net/ethernet/ti/netcp_ethss.c

6246168b4a3835 WingMan Kwok    2016-12-08  2645  
3f02b82725576a Vadim Fedorenko 2025-11-03  2646  static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_config *cfg,
3f02b82725576a Vadim Fedorenko 2025-11-03  2647  			    struct netlink_ext_ack *extack)
6246168b4a3835 WingMan Kwok    2016-12-08  2648  {
3f02b82725576a Vadim Fedorenko 2025-11-03  2649  	struct gbe_intf *gbe_intf = intf_priv;
3f02b82725576a Vadim Fedorenko 2025-11-03  2650  	struct gbe_priv *gbe_dev;
3f02b82725576a Vadim Fedorenko 2025-11-03  2651  	struct phy_device *phy;
3f02b82725576a Vadim Fedorenko 2025-11-03  2652  
3f02b82725576a Vadim Fedorenko 2025-11-03  2653  	gbe_dev = gbe_intf->gbe_dev;
6246168b4a3835 WingMan Kwok    2016-12-08  2654  
3f02b82725576a Vadim Fedorenko 2025-11-03  2655  	if (!gbe_dev->cpts)
6246168b4a3835 WingMan Kwok    2016-12-08  2656  		return -EOPNOTSUPP;
6246168b4a3835 WingMan Kwok    2016-12-08  2657  
3f02b82725576a Vadim Fedorenko 2025-11-03  2658  	phy = gbe_intf->slave->phy;
3f02b82725576a Vadim Fedorenko 2025-11-03  2659  	if (phy_has_hwtstamp(phy))
3f02b82725576a Vadim Fedorenko 2025-11-03 @2660  		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
6246168b4a3835 WingMan Kwok    2016-12-08  2661  
3f02b82725576a Vadim Fedorenko 2025-11-03  2662  	switch (cfg->tx_type) {
6246168b4a3835 WingMan Kwok    2016-12-08  2663  	case HWTSTAMP_TX_OFF:
a9423120343cb5 Ivan Khoronzhuk 2018-11-12  2664  		gbe_dev->tx_ts_enabled = 0;
6246168b4a3835 WingMan Kwok    2016-12-08  2665  		break;
6246168b4a3835 WingMan Kwok    2016-12-08  2666  	case HWTSTAMP_TX_ON:
a9423120343cb5 Ivan Khoronzhuk 2018-11-12  2667  		gbe_dev->tx_ts_enabled = 1;
6246168b4a3835 WingMan Kwok    2016-12-08  2668  		break;
6246168b4a3835 WingMan Kwok    2016-12-08  2669  	default:
6246168b4a3835 WingMan Kwok    2016-12-08  2670  		return -ERANGE;
6246168b4a3835 WingMan Kwok    2016-12-08  2671  	}
6246168b4a3835 WingMan Kwok    2016-12-08  2672  
3f02b82725576a Vadim Fedorenko 2025-11-03  2673  	switch (cfg->rx_filter) {
6246168b4a3835 WingMan Kwok    2016-12-08  2674  	case HWTSTAMP_FILTER_NONE:
a9423120343cb5 Ivan Khoronzhuk 2018-11-12  2675  		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_NONE;
6246168b4a3835 WingMan Kwok    2016-12-08  2676  		break;
6246168b4a3835 WingMan Kwok    2016-12-08  2677  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
6246168b4a3835 WingMan Kwok    2016-12-08  2678  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
6246168b4a3835 WingMan Kwok    2016-12-08  2679  	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
a9423120343cb5 Ivan Khoronzhuk 2018-11-12  2680  		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
3f02b82725576a Vadim Fedorenko 2025-11-03  2681  		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
6246168b4a3835 WingMan Kwok    2016-12-08  2682  		break;
6246168b4a3835 WingMan Kwok    2016-12-08  2683  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
6246168b4a3835 WingMan Kwok    2016-12-08  2684  	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
6246168b4a3835 WingMan Kwok    2016-12-08  2685  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
6246168b4a3835 WingMan Kwok    2016-12-08  2686  	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
6246168b4a3835 WingMan Kwok    2016-12-08  2687  	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
6246168b4a3835 WingMan Kwok    2016-12-08  2688  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
6246168b4a3835 WingMan Kwok    2016-12-08  2689  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
6246168b4a3835 WingMan Kwok    2016-12-08  2690  	case HWTSTAMP_FILTER_PTP_V2_SYNC:
6246168b4a3835 WingMan Kwok    2016-12-08  2691  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
a9423120343cb5 Ivan Khoronzhuk 2018-11-12  2692  		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
3f02b82725576a Vadim Fedorenko 2025-11-03  2693  		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
6246168b4a3835 WingMan Kwok    2016-12-08  2694  		break;
6246168b4a3835 WingMan Kwok    2016-12-08  2695  	default:
6246168b4a3835 WingMan Kwok    2016-12-08  2696  		return -ERANGE;
6246168b4a3835 WingMan Kwok    2016-12-08  2697  	}
6246168b4a3835 WingMan Kwok    2016-12-08  2698  
6246168b4a3835 WingMan Kwok    2016-12-08  2699  	gbe_hwtstamp(gbe_intf);
6246168b4a3835 WingMan Kwok    2016-12-08  2700  
3f02b82725576a Vadim Fedorenko 2025-11-03  2701  	return 0;
6246168b4a3835 WingMan Kwok    2016-12-08  2702  }
6246168b4a3835 WingMan Kwok    2016-12-08  2703  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

