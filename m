Return-Path: <netdev+bounces-56582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112880F7D9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005FCB20E23
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95F63C0E;
	Tue, 12 Dec 2023 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpQZLdIS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92FBC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702412758; x=1733948758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShU3x8zcFhiiKxZVBruiDPx0rJANmV4IUQZtaK+tLG8=;
  b=DpQZLdIS22rYsm8CoVADAHRB/zoM0rUTbO2iewSt7FpmDIXopd35Kzrt
   cH4XSifNCTjsC2ShD2yt8lz3xOn4u877TB7ihA+iM0a6+wLb40tZLuPuQ
   CmElnmPLCJHZV7S9OFZteDfPdA7nh0UAghP72msfET73NOod2FWv0f4TF
   LKrAZtFPu8S1UBn7Z9AJoj/iZcxIrqs86mYHu1x8VikyHU8z20HzAEdKt
   keYP1Ed2FQpNW77sVL+YaRb8R2t1fEHegCi/j3ZnXpdRoeLO3spTabWQR
   Bqz28H0ffJGn06oCSt+Sush3tJqOek/xhiq9UArOrC+RCbaA9z8XK2q5N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="397650962"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="397650962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1020847391"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1020847391"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2023 12:25:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rD9KB-000JfH-1N;
	Tue, 12 Dec 2023 20:25:51 +0000
Date: Wed, 13 Dec 2023 04:25:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next v4 5/8] net: wangxun: add ethtool_ops for ring
 parameters
Message-ID: <202312130411.eLnRwdT9-lkp@intel.com>
References: <20231212080438.1361308-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212080438.1361308-6-jiawenwu@trustnetic.com>

Hi Jiawen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawen-Wu/net-libwx-add-phylink-to-libwx/20231212-161804
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231212080438.1361308-6-jiawenwu%40trustnetic.com
patch subject: [PATCH net-next v4 5/8] net: wangxun: add ethtool_ops for ring parameters
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231213/202312130411.eLnRwdT9-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130411.eLnRwdT9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130411.eLnRwdT9-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c: In function 'ngbe_set_ringparam':
>> drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:83:21: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
      83 |         temp_ring = vmalloc(i * sizeof(struct wx_ring));
         |                     ^~~~~~~
         |                     kvmalloc
>> drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:83:19: warning: assignment to 'struct wx_ring *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      83 |         temp_ring = vmalloc(i * sizeof(struct wx_ring));
         |                   ^
>> drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:90:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
      90 |         vfree(temp_ring);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c: In function 'txgbe_set_ringparam':
>> drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c:50:21: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
      50 |         temp_ring = vmalloc(i * sizeof(struct wx_ring));
         |                     ^~~~~~~
         |                     kvmalloc
>> drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c:50:19: warning: assignment to 'struct wx_ring *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      50 |         temp_ring = vmalloc(i * sizeof(struct wx_ring));
         |                   ^
>> drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c:57:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
      57 |         vfree(temp_ring);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +83 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c

    46	
    47	static int ngbe_set_ringparam(struct net_device *netdev,
    48				      struct ethtool_ringparam *ring,
    49				      struct kernel_ethtool_ringparam *kernel_ring,
    50				      struct netlink_ext_ack *extack)
    51	{
    52		struct wx *wx = netdev_priv(netdev);
    53		u32 new_rx_count, new_tx_count;
    54		struct wx_ring *temp_ring;
    55		int i, err = 0;
    56	
    57		if (ring->rx_mini_pending || ring->rx_jumbo_pending)
    58			return -EOPNOTSUPP;
    59	
    60		new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
    61		new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
    62	
    63		new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
    64		new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
    65	
    66		if (new_tx_count == wx->tx_ring_count &&
    67		    new_rx_count == wx->rx_ring_count)
    68			return 0;
    69	
    70		if (!netif_running(wx->netdev)) {
    71			for (i = 0; i < wx->num_tx_queues; i++)
    72				wx->tx_ring[i]->count = new_tx_count;
    73			for (i = 0; i < wx->num_rx_queues; i++)
    74				wx->rx_ring[i]->count = new_rx_count;
    75			wx->tx_ring_count = new_tx_count;
    76			wx->rx_ring_count = new_rx_count;
    77	
    78			return 0;
    79		}
    80	
    81		/* allocate temporary buffer to store rings in */
    82		i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
  > 83		temp_ring = vmalloc(i * sizeof(struct wx_ring));
    84		if (!temp_ring)
    85			return -ENOMEM;
    86	
    87		ngbe_down(wx);
    88	
    89		wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
  > 90		vfree(temp_ring);
    91	
    92		wx_configure(wx);
    93		ngbe_up(wx);
    94	
    95		return err;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

