Return-Path: <netdev+bounces-12769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF8738DF8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B608E1C20F30
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6019E4E;
	Wed, 21 Jun 2023 18:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122919BDA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:00:46 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546891738;
	Wed, 21 Jun 2023 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687370442; x=1718906442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1o7c22ogjix8/UMzT1uyJ+SlopylsPQrSnXMByN0VwI=;
  b=jfmhTXVVRYJSuF8vQVk/5ZQdRlLTEWZ9Rp2gSu1u0mbb4vdXGoHcJeFr
   +NwbB4FMhtRIHmsYUiU9uYfK4DiZoxK6R1TEFYC2P8gSOwqqjUNc0VpmZ
   bheQITChEb6T+fHeIIvxShTaa8o99LCT5HFqu4/4SyAwsw2x+Zyqvn4ez
   4hlq0Gva+aBsYlr/qvb/t+dut0Y6b64IIgMIjkyAROx4lpvbZhQRWxKUx
   Xpuv9Mb54zwHz/xoPRgqhCQx+332EwmaLGtRim3ZTauzLUWx4b7LKNOWk
   Xcj861GLq4Qd5NCjiJKOcaXO1KKZCZfxkRo1RL1zIgoOt4jadzrw8/I1q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359124988"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359124988"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 11:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717757059"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="717757059"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 11:00:15 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qC27q-00070F-0y;
	Wed, 21 Jun 2023 18:00:14 +0000
Date: Thu, 22 Jun 2023 02:00:04 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v4 04/12] can: m_can: Add rx coalescing ethtool support
Message-ID: <202306220129.pZuUUlrk-lkp@intel.com>
References: <20230621092350.3130866-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092350.3130866-5-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ac9a78681b921877518763ba0e89202254349d1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/can-m_can-Write-transmit-header-and-data-in-one-transaction/20230621-173848
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230621092350.3130866-5-msp%40baylibre.com
patch subject: [PATCH v4 04/12] can: m_can: Add rx coalescing ethtool support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306220129.pZuUUlrk-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220129.pZuUUlrk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306220129.pZuUUlrk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/m_can/m_can.c: In function 'm_can_tx_handler':
   drivers/net/can/m_can/m_can.c:1697:27: warning: unused variable 'fifo_header' [-Wunused-variable]
    1697 |         struct id_and_dlc fifo_header;
         |                           ^~~~~~~~~~~
   drivers/net/can/m_can/m_can.c: In function 'm_can_set_coalesce':
>> drivers/net/can/m_can/m_can.c:1978:45: warning: suggest parentheses around comparison in operand of '!=' [-Wparentheses]
    1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/net/can/m_can/m_can.c:1978:50: warning: suggest parentheses around comparison in operand of '==' [-Wparentheses]
    1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1978 drivers/net/can/m_can/m_can.c

  1959	
  1960	static int m_can_set_coalesce(struct net_device *dev,
  1961				      struct ethtool_coalesce *ec,
  1962				      struct kernel_ethtool_coalesce *kec,
  1963				      struct netlink_ext_ack *ext_ack)
  1964	{
  1965		struct m_can_classdev *cdev = netdev_priv(dev);
  1966	
  1967		if (cdev->can.state != CAN_STATE_STOPPED) {
  1968			netdev_err(dev, "Device is in use, please shut it down first\n");
  1969			return -EBUSY;
  1970		}
  1971	
  1972		if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
  1973			netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
  1974				   ec->rx_max_coalesced_frames_irq,
  1975				   cdev->mcfg[MRAM_RXF0].num);
  1976			return -EINVAL;
  1977		}
> 1978		if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
  1979			netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
  1980			return -EINVAL;
  1981		}
  1982	
  1983		cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
  1984		cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
  1985	
  1986		return 0;
  1987	}
  1988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

