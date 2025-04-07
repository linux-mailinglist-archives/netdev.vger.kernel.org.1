Return-Path: <netdev+bounces-179942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33CA7EF67
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F99316AAF4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46849221569;
	Mon,  7 Apr 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb4SpJ+q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6B205519
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058440; cv=none; b=gePDvlNG/iGkPBEvjJ2qegFQKiiK95tL6pYOcUXFChhNr3vlz6AHmL69Z3zhhs1O2Ih6iXMCf2K9fRl3Ybovf4r/jaZNMAhTA7yAK2S31KiXy5pshRD+PTklN40wBx2f2W7wbJY4pExlwW6pYKZ1cIGFtq5WAYZ367J2Ums0Dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058440; c=relaxed/simple;
	bh=K3PdnfX+s+h1I1zJiyQ/vXMnprLp0KaE229U+f1lhAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW0nEbpLiJES1nFrQX9HFUvjiLYkrPouvH41u6lCzwps2LlcMj6kHfshyVpMnaTwM4way9hMRxWUWx2SisU8IQz7hUyiuvjSw5dLBR1tffSLmxygn0Joz0l2dXJLwxYXJNmN579rMt3BLffDEAwkIzaspAatBr5YdvTRUl+Pyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb4SpJ+q; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744058438; x=1775594438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3PdnfX+s+h1I1zJiyQ/vXMnprLp0KaE229U+f1lhAY=;
  b=Bb4SpJ+qJ9K4yC3PCCxr4PxTSHtVGiuCyivlxE59HkwBBT59HNWwvnsU
   82Al9K4BKziqST/R7wscCXnygV3g+VeYTYlKjSnffbRDrOhOpwI4sIZrY
   00Pb41Br1lAn5JwV83wQKTQc+teA+mhf3ggQs0BNll4rknmwNwAS+UaTG
   zEEa+ph5uvxOTfcTlccEui2/XnqsJWbeGsDyrgEtCTKOnS2iylyTY6YOC
   RCDVbKHM6CqORa9McNXEXkF8IwR4FIkpsZNj3Fdphc6cIxyA9RHC8F6EB
   qWG3Y2pWlnc08Ut1+fEdSxb5Lr2HhSzgXHHhPLDZ0Dr81sCmNl79dgBgv
   w==;
X-CSE-ConnectionGUID: RD1FXvYtTPeJcjwC+7kRBg==
X-CSE-MsgGUID: 7yQpohg2S2yQr9Y4PX3x7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44716103"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="44716103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 13:40:38 -0700
X-CSE-ConnectionGUID: DDo2yfvjSoWlcdjsJe6z2g==
X-CSE-MsgGUID: QPEacZQTQxKDxVCWFfocEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="127929972"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Apr 2025 13:40:34 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1tGh-0003ot-25;
	Mon, 07 Apr 2025 20:40:31 +0000
Date: Tue, 8 Apr 2025 04:39:48 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <202504080314.X7qJw69Y-lkp@intel.com>
References: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/ice-use-DSN-instead-of-PCI-BDF-for-ice_adapter-index/20250407-192849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250407112005.85468-1-przemyslaw.kitszel%40intel.com
patch subject: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for ice_adapter index
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20250408/202504080314.X7qJw69Y-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250408/202504080314.X7qJw69Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504080314.X7qJw69Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_adapter.c: In function 'ice_adapter_index':
   drivers/net/ethernet/intel/ice/ice_adapter.c:21:27: error: expected expression before 'u32'
      21 |         return (u32)dsn ^ u32(dsn >> 32);
         |                           ^~~
>> drivers/net/ethernet/intel/ice/ice_adapter.c:23:1: warning: control reaches end of non-void function [-Wreturn-type]
      23 | }
         | ^


vim +23 drivers/net/ethernet/intel/ice/ice_adapter.c

0e2bddf9e5f926 Michal Schmidt     2024-03-26  15  
2d939bcd51ee97 Przemek Kitszel    2025-04-07  16  static unsigned long ice_adapter_index(u64 dsn)
0e2bddf9e5f926 Michal Schmidt     2024-03-26  17  {
2d939bcd51ee97 Przemek Kitszel    2025-04-07  18  #if BITS_PER_LONG == 64
2d939bcd51ee97 Przemek Kitszel    2025-04-07  19  	return dsn;
2d939bcd51ee97 Przemek Kitszel    2025-04-07  20  #else
2d939bcd51ee97 Przemek Kitszel    2025-04-07  21  	return (u32)dsn ^ u32(dsn >> 32);
2d939bcd51ee97 Przemek Kitszel    2025-04-07  22  #endif
fdb7f54700b1c8 Sergey Temerkhanov 2024-08-21 @23  }
0e2bddf9e5f926 Michal Schmidt     2024-03-26  24  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

