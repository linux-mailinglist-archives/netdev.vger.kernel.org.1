Return-Path: <netdev+bounces-219553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E733DB41E63
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712851B25D75
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4232DCF65;
	Wed,  3 Sep 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np+4jTMi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331E2BD597;
	Wed,  3 Sep 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901263; cv=none; b=dZyGoyaFRo17o49qJ1LSlQ7cdmLTFrbaF6ZxNBurmGMyg3jmM4Zqfg+cp8OcFg1IvIR/nz05DRYYc+WOskWww6FUPxMw5uV9Zz98gsrX0aaQZIkNlMl3xBaky096tciqnZzQMIswfQVZDgveKNBU3Cy1/NJje6G9eAfbS3qq+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901263; c=relaxed/simple;
	bh=MgBZIiU63PhDZRAMVyVp9++ETTOL9/NSN/2iNcCA55o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJv5nAVvruzGOUfFYti10S1d3PeNuWP3qYXr8A69Pz6bzyB5ffuk5ASgvNPLdljkKA96CJJWUFtsvpJHaD+929gbSgTcigrQS84RwKLZ0mAkqHlehfj8aRQVBesnxhZVWH+MYymEoJd9xKpq7nN6N/qAJlEvN9myTwZY/e3ga34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np+4jTMi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756901262; x=1788437262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MgBZIiU63PhDZRAMVyVp9++ETTOL9/NSN/2iNcCA55o=;
  b=Np+4jTMi6dpF5XN8iFhl8Eck3qhxQPtJETxl4q4sxRMAKCmRWDYcgaKF
   2ombjZS162fOWNLczCkAH6n6FjSzxTaiEUI5OoQHX0pGmo2cXf1du9Fo9
   WClPUWbsyGMRMXPNz954icq5hBMfUfHpBZvTKjUXr9Z7ws+JuV8ZC7U5O
   dnNysvC+DVkyDYmmvU/H6bwaSBLkV17M5JXbReQmH9fndCrzwz2lv8I16
   0yu+IUg6NJY2U/M81hN+tA3Xc2MSik0ZgTDCq5ojgIw1bQI928MuBCSoP
   rT770yLs45MDiccYp3RXU4J0/PnoGTtBpAHeD89hNyF2jtEbDdSlGep33
   A==;
X-CSE-ConnectionGUID: Pm6nojv3QyuCODBd8i0rcw==
X-CSE-MsgGUID: ZyXtbbjoRa+mPbGtYNwozQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59355718"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="59355718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:06:30 -0700
X-CSE-ConnectionGUID: xnoEev97Q2SK1BNCRg1grQ==
X-CSE-MsgGUID: eVdKWMdaT4ywl7c+Qn4mMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="172024814"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Sep 2025 05:06:23 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utmEs-0003nj-0s;
	Wed, 03 Sep 2025 12:05:50 +0000
Date: Wed, 3 Sep 2025 20:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Xin Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>,
	Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
	Fan Gong <gongfan1@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Suman Anna <s-anna@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/8] net: rpmsg-eth: Register device as netdev
Message-ID: <202509031942.reUez3UI-lkp@intel.com>
References: <20250902090746.3221225-6-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902090746.3221225-6-danishanwar@ti.com>

Hi MD,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

url:    https://github.com/intel-lab-lkp/linux/commits/MD-Danish-Anwar/dt-bindings-net-ti-rpmsg-eth-Add-DT-binding-for-RPMSG-ETH/20250902-171411
base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
patch link:    https://lore.kernel.org/r/20250902090746.3221225-6-danishanwar%40ti.com
patch subject: [PATCH net-next v2 5/8] net: rpmsg-eth: Register device as netdev
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250903/202509031942.reUez3UI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031942.reUez3UI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031942.reUez3UI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/of_reserved_mem.h:5,
                    from drivers/net/ethernet/rpmsg_eth.c:8:
   drivers/net/ethernet/rpmsg_eth.c: In function 'rpmsg_eth_validate_handshake':
>> drivers/net/ethernet/rpmsg_eth.c:26:44: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
      26 |                 dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%lu, received_buf_size=%d\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/ethernet/rpmsg_eth.c:26:17: note: in expansion of macro 'dev_err'
      26 |                 dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%lu, received_buf_size=%d\n",
         |                 ^~~~~~~
   drivers/net/ethernet/rpmsg_eth.c:26:109: note: format string is defined here
      26 |                 dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%lu, received_buf_size=%d\n",
         |                                                                                                           ~~^
         |                                                                                                             |
         |                                                                                                             long unsigned int
         |                                                                                                           %u
>> drivers/net/ethernet/rpmsg_eth.c:42:44: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
      42 |                 dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%llx\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/ethernet/rpmsg_eth.c:42:17: note: in expansion of macro 'dev_err'
      42 |                 dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%llx\n",
         |                 ^~~~~~~
   drivers/net/ethernet/rpmsg_eth.c:42:127: note: format string is defined here
      42 |                 dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%llx\n",
         |                                                                                                                            ~~~^
         |                                                                                                                               |
         |                                                                                                                               long long unsigned int
         |                                                                                                                            %x


vim +26 drivers/net/ethernet/rpmsg_eth.c

   > 8	#include <linux/of_reserved_mem.h>
     9	#include <linux/remoteproc.h>
    10	#include "rpmsg_eth.h"
    11	
    12	/**
    13	 * rpmsg_eth_validate_handshake - Validate handshake parameters from remote
    14	 * @port: Pointer to rpmsg_eth_port structure
    15	 * @shm_info: Pointer to shared memory info received from remote
    16	 *
    17	 * Checks buffer size, magic numbers, and TX/RX offsets in the handshake
    18	 * response to ensure they match expected values and are within valid ranges.
    19	 *
    20	 * Return: 0 on success, -EINVAL on validation failure.
    21	 */
    22	static int rpmsg_eth_validate_handshake(struct rpmsg_eth_port *port,
    23						struct rpmsg_eth_shm *shm_info)
    24	{
    25		if (shm_info->buff_slot_size != RPMSG_ETH_BUFFER_SIZE) {
  > 26			dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%lu, received_buf_size=%d\n",
    27				RPMSG_ETH_BUFFER_SIZE,
    28				shm_info->buff_slot_size);
    29			return -EINVAL;
    30		}
    31	
    32		if (readl(port->shm + port->tx_offset + HEAD_MAGIC_NUM_OFFSET) != RPMSG_ETH_SHM_MAGIC_NUM ||
    33		    readl(port->shm + port->rx_offset + HEAD_MAGIC_NUM_OFFSET) != RPMSG_ETH_SHM_MAGIC_NUM ||
    34		    readl(port->shm + port->tx_offset + TAIL_MAGIC_NUM_OFFSET(port->tx_max_buffers)) != RPMSG_ETH_SHM_MAGIC_NUM ||
    35		    readl(port->shm + port->rx_offset + TAIL_MAGIC_NUM_OFFSET(port->rx_max_buffers)) != RPMSG_ETH_SHM_MAGIC_NUM) {
    36			dev_err(port->common->dev, "Magic number mismatch in handshake at head/tail\n");
    37			return -EINVAL;
    38		}
    39	
    40		if (shm_info->tx_offset >= port->buf_size ||
    41		    shm_info->rx_offset >= port->buf_size) {
  > 42			dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%llx\n",
    43				shm_info->tx_offset,
    44				shm_info->rx_offset,
    45				port->buf_size);
    46			return -EINVAL;
    47		}
    48	
    49		return 0;
    50	}
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

