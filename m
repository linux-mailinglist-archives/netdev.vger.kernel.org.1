Return-Path: <netdev+bounces-188597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E1AADC6B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EEF9A1989
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0346212B0A;
	Wed,  7 May 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBrecuvR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C520FAA9;
	Wed,  7 May 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613593; cv=none; b=U1g8acIrjNO5/lslM46lk0PzobtdYFyow47slfIOVbpsBsAqE/8lbvd6uGnNZING9TjWVewQ9RVE4AINNxCLMAMqQfA9Gn1kRrg4jmrgR9vVpfzVQlMQdH8Q9a8/ovk/mbYRIeERY4wD2AXqOn/o/GiLlzOm3kdMjyPPQVd08SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613593; c=relaxed/simple;
	bh=O56ww4V02YzszECqo/3kEkhXguEs9Ci/cpYP36NMcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfvC5SWozMuvwLK+rjC3gCPqAZW+locPdythHbppZHXGPAozp7aYQTRATt+OShfWebRq/6dMzVWN1G74XMyjRwCNblxfGzM7UXWIBVZYEgeNQatD/WCZH52YAHzpa+8lGtsjUwqVKAh9a3A89MSqlXK9WCLyIwXvFDbtM+JqGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBrecuvR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746613592; x=1778149592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O56ww4V02YzszECqo/3kEkhXguEs9Ci/cpYP36NMcAM=;
  b=WBrecuvRejJbssVitky25jkbfI3low8nweZd/PELupkZkX/xhWx8HHLj
   +Ny4Kc1/6H1LpBui13TpBJBBc86B1K0p+HhYQWolh95YBNUcmLsFw1Ztc
   M+LHtsNjQlbRmOw68/Fx8xlWiSk8U529sAlq3/DWV8FqFz1yVlxdV3wKb
   IEYxU1zIJd9f64okdMF3IX0L0zbFq8KpQQ5+b8gzsh7XwYrmPfFEIM3Eh
   874gaPtgAOFs2Q1DTPxvMFNCxAlxGhnk6Bxp4gebWmnKP+SwrUocRPUr0
   /+LS769Wx7CHx0tx82NgksQVvGzf4w5mgf10POg4dMxA93pEb3cO+t7PK
   A==;
X-CSE-ConnectionGUID: SDXt7MfoQVSPWzpFS9Md4g==
X-CSE-MsgGUID: MYHWYXiEQWSQyD/kSg5yRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48484153"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48484153"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 03:26:16 -0700
X-CSE-ConnectionGUID: zIZt6oQ4Sl6WvFAAJlgL1Q==
X-CSE-MsgGUID: ip8sTLtRToWS54CzEeUhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135819763"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2025 03:26:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCbyc-0007b1-23;
	Wed, 07 May 2025 10:26:10 +0000
Date: Wed, 7 May 2025 18:25:23 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
Message-ID: <202505071827.nbdcs1rW-lkp@intel.com>
References: <20250505142427.9601-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-3-wahrenst@gmx.net>

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wahren/dt-bindings-vertexcom-mse102x-Fix-IRQ-type-in-example/20250505-222628
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250505142427.9601-3-wahrenst%40gmx.net
patch subject: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about IRQ trigger type
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250507/202505071827.nbdcs1rW-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071827.nbdcs1rW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071827.nbdcs1rW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/vertexcom/mse102x.c: In function 'mse102x_net_open':
>> drivers/net/ethernet/vertexcom/mse102x.c:525:37: error: implicit declaration of function 'irq_get_irq_data'; did you mean 'irq_set_irq_wake'? [-Wimplicit-function-declaration]
     525 |         struct irq_data *irq_data = irq_get_irq_data(ndev->irq);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     irq_set_irq_wake
>> drivers/net/ethernet/vertexcom/mse102x.c:525:37: error: initialization of 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> drivers/net/ethernet/vertexcom/mse102x.c:535:17: error: implicit declaration of function 'irqd_get_trigger_type'; did you mean 'led_get_trigger_data'? [-Wimplicit-function-declaration]
     535 |         switch (irqd_get_trigger_type(irq_data)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 led_get_trigger_data
>> drivers/net/ethernet/vertexcom/mse102x.c:536:14: error: 'IRQ_TYPE_LEVEL_HIGH' undeclared (first use in this function)
     536 |         case IRQ_TYPE_LEVEL_HIGH:
         |              ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/vertexcom/mse102x.c:536:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/vertexcom/mse102x.c:537:14: error: 'IRQ_TYPE_LEVEL_LOW' undeclared (first use in this function)
     537 |         case IRQ_TYPE_LEVEL_LOW:
         |              ^~~~~~~~~~~~~~~~~~


vim +525 drivers/net/ethernet/vertexcom/mse102x.c

   522	
   523	static int mse102x_net_open(struct net_device *ndev)
   524	{
 > 525		struct irq_data *irq_data = irq_get_irq_data(ndev->irq);
   526		struct mse102x_net *mse = netdev_priv(ndev);
   527		struct mse102x_net_spi *mses = to_mse102x_spi(mse);
   528		int ret;
   529	
   530		if (!irq_data) {
   531			netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
   532			return -EINVAL;
   533		}
   534	
 > 535		switch (irqd_get_trigger_type(irq_data)) {
 > 536		case IRQ_TYPE_LEVEL_HIGH:
 > 537		case IRQ_TYPE_LEVEL_LOW:
   538			break;
   539		default:
   540			netdev_warn_once(ndev, "Only IRQ type level recommended, please update your firmware.\n");
   541			break;
   542		}
   543	
   544		ret = request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
   545					   ndev->name, mse);
   546		if (ret < 0) {
   547			netdev_err(ndev, "Failed to get irq: %d\n", ret);
   548			return ret;
   549		}
   550	
   551		netif_dbg(mse, ifup, ndev, "opening\n");
   552	
   553		netif_start_queue(ndev);
   554	
   555		netif_carrier_on(ndev);
   556	
   557		/* The SPI interrupt can stuck in case of pending packet(s).
   558		 * So poll for possible packet(s) to re-arm the interrupt.
   559		 */
   560		mutex_lock(&mses->lock);
   561		mse102x_rx_pkt_spi(mse);
   562		mutex_unlock(&mses->lock);
   563	
   564		netif_dbg(mse, ifup, ndev, "network device up\n");
   565	
   566		return 0;
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

