Return-Path: <netdev+bounces-130933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317398C1EB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3511282E45
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B81C8FC1;
	Tue,  1 Oct 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWa9aVsc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F131C2DA4;
	Tue,  1 Oct 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797528; cv=none; b=HKD2aU4/pRKMMMg0Zb6yrMfea5q4OB5nh87a7Y2jtjZ+JmoRtEOVCzaBA+CubVRuhjDxNdrAlAmAFgQmmLeDnpIIfCIkg/tdsn6MWDfoIZpr62gPN0C+yv2locRKeE64+GFy4Rb8iuWAW5UtIHOPJD6DCsb+kMGBdxTiw7zMC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797528; c=relaxed/simple;
	bh=HKxl86d6npKrI4kMMT4X35cwFBejD519E/tSaDfV/Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrhvrQkC+oaKW1fWPXwkhcWFHUKEPonYUjhKBSi49kQaa0av8v3havPLnvniuRsBe9KsqlLnELjTIomEj5onzMlCdLtxENIScXDMEcGkSKE6pw4JirsybDa1IM4u19GOwpPI2gV7r6N76XfELU1jWyOEJMtcUrEKzazhcoveJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWa9aVsc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727797527; x=1759333527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HKxl86d6npKrI4kMMT4X35cwFBejD519E/tSaDfV/Qo=;
  b=DWa9aVsc8ySoxDaWFdrvVPVUqXZ4SQMi0ic7jq4aFvhRxFag6EO+guwE
   PL7cR4c/higOQmS+hYYvTxYnwu9jAKv5SwEBJHmsFVHTYZ3KSCzlX41iP
   wkBmsG8Eno4GFfKZ6pqEdG5iZZjRtv7Y+/C55U6lfPOJGB9wnbGk4S0NJ
   Y87qASBy8XomnlDUhZFRhoW23If6W/okinhOAxVw+CRfXZ8hgSylCxCDC
   fUQUSucg+7/LOfDJji3z1mYcVHIrJl2Nwj0/AZXGhsXaUqhwa0FYLu2ao
   yWM66YJieQWqfx/BatxOWYc4Xb1TIjE9S1a8hDmtSQGjr8MBZjVJZPiTr
   Q==;
X-CSE-ConnectionGUID: gMz7v7zvQiueFXjWRUB+gw==
X-CSE-MsgGUID: LVRiKxXiTIm5Kw/ujXTzDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37534558"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37534558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:45:26 -0700
X-CSE-ConnectionGUID: I2x18V+oT9COg4Vh27+nAg==
X-CSE-MsgGUID: qQdbZXNbRxWKoHR1qCNeTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104530965"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 08:45:24 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svf3x-000Qpx-0m;
	Tue, 01 Oct 2024 15:45:21 +0000
Date: Tue, 1 Oct 2024 23:44:33 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, steve.glendinning@shawell.net
Subject: Re: [PATCH net-next 7/8] net: smsc91xx: move down struct members
Message-ID: <202410012317.iGlUJQY9-lkp@intel.com>
References: <20240930224056.354349-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930224056.354349-8-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-smsc911x-use-devm_platform_ioremap_resource/20241001-064430
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930224056.354349-8-rosenp%40gmail.com
patch subject: [PATCH net-next 7/8] net: smsc91xx: move down struct members
config: i386-randconfig-001-20241001 (https://download.01.org/0day-ci/archive/20241001/202410012317.iGlUJQY9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410012317.iGlUJQY9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410012317.iGlUJQY9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/smsc/smsc911x.c: In function 'smsc911x_request_resources':
>> drivers/net/ethernet/smsc/smsc911x.c:378:27: warning: variable 'reset_gpiod' set but not used [-Wunused-but-set-variable]
     378 |         struct gpio_desc *reset_gpiod;
         |                           ^~~~~~~~~~~


vim +/reset_gpiod +378 drivers/net/ethernet/smsc/smsc911x.c

   368	
   369	/*
   370	 * Request resources, currently just regulators.
   371	 *
   372	 * The SMSC911x has two power pins: vddvario and vdd33a, in designs where
   373	 * these are not always-on we need to request regulators to be turned on
   374	 * before we can try to access the device registers.
   375	 */
   376	static int smsc911x_request_resources(struct platform_device *pdev)
   377	{
 > 378		struct gpio_desc *reset_gpiod;
   379		struct clk *clk;
   380	
   381		/* Request optional RESET GPIO */
   382		reset_gpiod =
   383			devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
   384	
   385		/* Request clock */
   386		clk = devm_clk_get_optional(&pdev->dev, NULL);
   387		if (IS_ERR(clk))
   388			return dev_err_probe(&pdev->dev, PTR_ERR(clk),
   389					     "couldn't get clock");
   390	
   391		return 0;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

