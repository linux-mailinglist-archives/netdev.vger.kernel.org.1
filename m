Return-Path: <netdev+bounces-129373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3597F151
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6D61C2171F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF501A0728;
	Mon, 23 Sep 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kfovu1K6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8019F413;
	Mon, 23 Sep 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120688; cv=none; b=shYao4okiO+xZWoeRoqz93ONJ8fpCuf+hEh28elzGFkXDsKWNjakDpblcjWzjqe/FeEag066mG+QkNSFmcBWr1Jsw9ImVMFg8RqUC+M0zsLut49PjvYuH7k7sBE3xL1ebckIoMSKT9hH41LFGE1658FhbpTd1jvDR0y9saJiK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120688; c=relaxed/simple;
	bh=Clkk71o0s79HGUcEPbrwaa9UXB/yqp1hOLGuoxrDjV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Sv6+FByc0v6A6GlkKOO5XIwiii/TQSlEUKWad8v4OQjIj0+VkHm8hawf3GeKaV4axwH9YioYqva1F0i8Q66f5L0kNpU0kdDMF607GYkhB4pj8nSrCveYznuzo5DAjgS3bpVAtK3wkgHQ9pIwk4b+WEUP8bGpvspTU4YWH9sZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kfovu1K6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727120687; x=1758656687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Clkk71o0s79HGUcEPbrwaa9UXB/yqp1hOLGuoxrDjV8=;
  b=Kfovu1K6/l9bIJeolUrNqu0zwJvtoIv0kwOwD0JkL6odZPsnG3ivyM2I
   OeLOB5SfIWhrHg5j54jxLMXwu2Hy7vz26fNuRUctfst1+HIqXPQQ1SbaR
   5WInqbATxC/JU+uo9Mj3fg/65/AD6zliSouaAzbjBVPoXqYwGJqFPqoQA
   lZNDJQHFgtDO9sOZ3V9tmKAYXKUCrr1rTAxw4ddyQuO9uLzhVGnNw6/Xw
   45je0n3ha02lMNlMXBUcmvF7JDqDnKazjI54kIFvAl/QzRD/6HHVQUH3z
   Zq78wuS17fYXBpMdspCfWISjVzwsrOYJ+AyMC4WY+WqG3d8KfXe4Tmolx
   Q==;
X-CSE-ConnectionGUID: NvErrL2AR56hbIpA+X31iA==
X-CSE-MsgGUID: UkxWt6pdTP6m9GHzuWFKag==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25602859"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="25602859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 12:44:45 -0700
X-CSE-ConnectionGUID: tEv9MQoSStOASbPCzWw2iQ==
X-CSE-MsgGUID: O+i2Mu1OSs+QdEZ2xYMJkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="75553711"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Sep 2024 12:44:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssozA-000HYI-05;
	Mon, 23 Sep 2024 19:44:40 +0000
Date: Tue, 24 Sep 2024 03:44:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, andrew@lunn.ch,
	florian.fainelli@broadcom.com, davem@davemloft.net,
	edumazet@google.com, bcm-kernel-feedback-list@broadcom.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
Message-ID: <202409240305.PgIkDx1K-lkp@intel.com>
References: <20240923053900.1310-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923053900.1310-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/net-Add-error-pointer-check-in-bcmsysport-c/20240923-134407
base:   net/main
patch link:    https://lore.kernel.org/r/20240923053900.1310-1-kdipendra88%40gmail.com
patch subject: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240924/202409240305.PgIkDx1K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240305.PgIkDx1K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240305.PgIkDx1K-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bcmsysport.c: In function 'bcm_sysport_map_queues':
>> drivers/net/ethernet/broadcom/bcmsysport.c:2341:24: error: implicit declaration of function 'PRT_ERR'; did you mean 'PTR_ERR'? [-Werror=implicit-function-declaration]
    2341 |                 return PRT_ERR(dp);
         |                        ^~~~~~~
         |                        PTR_ERR
   cc1: some warnings being treated as errors


vim +2341 drivers/net/ethernet/broadcom/bcmsysport.c

  2330	
  2331	static int bcm_sysport_map_queues(struct net_device *dev,
  2332					  struct net_device *slave_dev)
  2333	{
  2334		struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
  2335		struct bcm_sysport_priv *priv = netdev_priv(dev);
  2336		struct bcm_sysport_tx_ring *ring;
  2337		unsigned int num_tx_queues;
  2338		unsigned int q, qp, port;
  2339	
  2340		if (IS_ERR(dp))
> 2341			return PRT_ERR(dp);
  2342	
  2343		/* We can't be setting up queue inspection for non directly attached
  2344		 * switches
  2345		 */
  2346		if (dp->ds->index)
  2347			return 0;
  2348	
  2349		port = dp->index;
  2350	
  2351		/* On SYSTEMPORT Lite we have twice as less queues, so we cannot do a
  2352		 * 1:1 mapping, we can only do a 2:1 mapping. By reducing the number of
  2353		 * per-port (slave_dev) network devices queue, we achieve just that.
  2354		 * This need to happen now before any slave network device is used such
  2355		 * it accurately reflects the number of real TX queues.
  2356		 */
  2357		if (priv->is_lite)
  2358			netif_set_real_num_tx_queues(slave_dev,
  2359						     slave_dev->num_tx_queues / 2);
  2360	
  2361		num_tx_queues = slave_dev->real_num_tx_queues;
  2362	
  2363		if (priv->per_port_num_tx_queues &&
  2364		    priv->per_port_num_tx_queues != num_tx_queues)
  2365			netdev_warn(slave_dev, "asymmetric number of per-port queues\n");
  2366	
  2367		priv->per_port_num_tx_queues = num_tx_queues;
  2368	
  2369		for (q = 0, qp = 0; q < dev->num_tx_queues && qp < num_tx_queues;
  2370		     q++) {
  2371			ring = &priv->tx_rings[q];
  2372	
  2373			if (ring->inspect)
  2374				continue;
  2375	
  2376			/* Just remember the mapping actual programming done
  2377			 * during bcm_sysport_init_tx_ring
  2378			 */
  2379			ring->switch_queue = qp;
  2380			ring->switch_port = port;
  2381			ring->inspect = true;
  2382			priv->ring_map[qp + port * num_tx_queues] = ring;
  2383			qp++;
  2384		}
  2385	
  2386		return 0;
  2387	}
  2388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

