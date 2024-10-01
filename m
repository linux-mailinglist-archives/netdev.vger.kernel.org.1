Return-Path: <netdev+bounces-130764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E801198B6DB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178091C221A4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359A19AA5A;
	Tue,  1 Oct 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMoaTJ9J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B119AA68;
	Tue,  1 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771107; cv=none; b=aPARmixNbldVqAj5926VEBwBVsf6ETuHoWIirAqM7svJ196jehzWsi6b29UvWUZhTbvAS6Zu6AhgjLPYjiXWd/pxpwue5Qm/ZCdelIKzXul1gFf9aYglw4t/zZ8oXgKDD7ucp0uPqXdR8VM7ErR57KzVQRqZtMVaw6TGC58+4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771107; c=relaxed/simple;
	bh=b+AcDnEGb8LdEXd0c2T2qtZIELfJ7T27ILtRG0/kCLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7hnjRJUgfQrEAQ+bcTqEkPtvezmGRX2KX1mu7QT+IkMiyU2HtYOr1FrAjMei/g771yke4Zu3DiLKEEnPmUSGs1gZKKprtzdD19u8shf2z4lP6/tQNccBEp89oCOOhIQ1GfJjm6yW0Xm3jVuCygmd0cjueTMpCTdl/PQe0OHZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMoaTJ9J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727771106; x=1759307106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+AcDnEGb8LdEXd0c2T2qtZIELfJ7T27ILtRG0/kCLY=;
  b=QMoaTJ9J78MjSyZeDfQHUaoU7gY01h88x2c6hSjJNZ1rnkUf8bG7aF0t
   /YepkoZIBGpcAH2FuWY/w01ZqEzQ/wTJUDk501SsXnOJwn0+ICk94q4FV
   vIdfR4hkzMrXezvBIIRa4TPNfpSjDVX8K6BJP068mtkdLEyiBkZbagRYt
   bj2DXbcykCwz1uPjhU2Yi97ofsicuJmgFZ5lLeyU1r/OoMHc1v6DDwWLf
   +2vLqBTSBo0yzcPVAPFT+/jvvIA3FLRHfoYA36ZmXG0eaIXaLzUNpFLIo
   Fb9AI9kxbg7qj6DENuKQpRPfxmor0HrVi3ky1tMlQ+uwBMA+DbElP3oc/
   g==;
X-CSE-ConnectionGUID: xIE4NqRjR3abZgNJtUlMfg==
X-CSE-MsgGUID: kdDjTUy6T0WCNeZhJ5MlJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26346000"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26346000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:25:05 -0700
X-CSE-ConnectionGUID: CmIVYcjpRQS3nt0Myd2/yQ==
X-CSE-MsgGUID: wnSj9acpSn64b1C21OAnCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73995499"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2024 01:25:02 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svYBn-000QQd-1b;
	Tue, 01 Oct 2024 08:24:59 +0000
Date: Tue, 1 Oct 2024 16:24:39 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	horms@kernel.org, sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCH net-next 09/13] net: ibm: emac: rgmii:
 devm_platform_get_resource
Message-ID: <202410011636.QtBtiUKi-lkp@intel.com>
References: <20240930180036.87598-10-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930180036.87598-10-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-remove-custom-init-exit-functions/20241001-020553
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930180036.87598-10-rosenp%40gmail.com
patch subject: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platform_get_resource
config: powerpc-fsp2_defconfig (https://download.01.org/0day-ci/archive/20241001/202410011636.QtBtiUKi-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011636.QtBtiUKi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011636.QtBtiUKi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ibm/emac/rgmii.c: In function 'rgmii_probe':
>> drivers/net/ethernet/ibm/emac/rgmii.c:229:21: error: implicit declaration of function 'devm_platform_get_resource'; did you mean 'platform_get_resource'? [-Wimplicit-function-declaration]
     229 |         dev->base = devm_platform_get_resource(ofdev, 0);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                     platform_get_resource
>> drivers/net/ethernet/ibm/emac/rgmii.c:229:19: error: assignment to 'struct rgmii_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     229 |         dev->base = devm_platform_get_resource(ofdev, 0);
         |                   ^


vim +229 drivers/net/ethernet/ibm/emac/rgmii.c

   215	
   216	
   217	static int rgmii_probe(struct platform_device *ofdev)
   218	{
   219		struct rgmii_instance *dev;
   220	
   221		dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
   222				   GFP_KERNEL);
   223		if (!dev)
   224			return -ENOMEM;
   225	
   226		mutex_init(&dev->lock);
   227		dev->ofdev = ofdev;
   228	
 > 229		dev->base = devm_platform_get_resource(ofdev, 0);
   230		if (IS_ERR(dev->base)) {
   231			dev_err(&ofdev->dev, "can't map device registers");
   232			return PTR_ERR(dev->base);
   233		}
   234	
   235		/* Check for RGMII flags */
   236		if (of_property_read_bool(ofdev->dev.of_node, "has-mdio"))
   237			dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
   238	
   239		/* CAB lacks the right properties, fix this up */
   240		if (of_device_is_compatible(ofdev->dev.of_node, "ibm,rgmii-axon"))
   241			dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
   242	
   243		DBG2(dev, " Boot FER = 0x%08x, SSR = 0x%08x\n",
   244		     in_be32(&dev->base->fer), in_be32(&dev->base->ssr));
   245	
   246		/* Disable all inputs by default */
   247		out_be32(&dev->base->fer, 0);
   248	
   249		printk(KERN_INFO
   250		       "RGMII %pOF initialized with%s MDIO support\n",
   251		       ofdev->dev.of_node,
   252		       (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
   253	
   254		wmb();
   255		platform_set_drvdata(ofdev, dev);
   256	
   257		return 0;
   258	}
   259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

