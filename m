Return-Path: <netdev+bounces-153124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF29F6E9F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7151218909F7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC11FA8CE;
	Wed, 18 Dec 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt2Alfw3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE7157E82
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551848; cv=none; b=WtkbvDezY4AQ072P4kVFvf57IC0ipWeSofqRW3UqyboCQDOi5zrYEoML22r0JIqhYQLsDOVCVYmRCSQSx0jC/9ujFUyf/lyEo3E5taGqnKQ+2leLESGq+MmPkYHVZXTfDnDCGGTnFry7Lq+JS5T6DhkJoU6Z4jPA9FrorNX/fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551848; c=relaxed/simple;
	bh=dYweTV5AJyl8AG9T7K7pRgEiBrEQJN0995ZLP5q7Srk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRgAKH0wuqHw6mKarMtPHtkG+R7mueNys+ZCB4rHcgDKOZUYVArSbvpmjL483NgmjzA7qgWkoPQdwexn0d7ndse3jUbsJsLdFniFLBnBQ8HPAEI3a9uYohbhn9hFtYbwhyF4wS+o4HjvbbWCjkLeCUWDz1w4YYNJixwNWiLj1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt2Alfw3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734551846; x=1766087846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYweTV5AJyl8AG9T7K7pRgEiBrEQJN0995ZLP5q7Srk=;
  b=dt2Alfw3lYtkKdDokDGJfA8R2Cf4IZ+gPTQQqlN4LEYj5DB3HvMVEqzV
   cK1qDjjFh/e+vLAh08iRVZk1glODt2gW2+EydLYUCKevu48ElwnZW13wL
   WrPIvo2zeX5Qmd+OdejH7fGSm9MQojyprmZvvWq5eznP/8n/1EtDFNANM
   5AvSyeLCqkQVrDbcsQpYu11K/Rii4GuAlbP8idVh63LORhUVkDamrcHmk
   rTt/R97a5WGV309sfnpLqvVWpLE0hTTSgL1c/GYmchXFzrmgbVA3N3Xhe
   CA7q4ThYclXI/8KgRk1z7bYEyiQFcbcjlgZR2JWDll5Ex81RHRk0FtGAW
   w==;
X-CSE-ConnectionGUID: OznQiVUhSXKTB6alwzbILw==
X-CSE-MsgGUID: 2SrGRpGxRHyXB58OmPwrTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38981113"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="38981113"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 11:57:26 -0800
X-CSE-ConnectionGUID: R6HGhAR7S5G4Z5zm1RkpAw==
X-CSE-MsgGUID: fCRAHulBS8iVV7ABURROHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102967539"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Dec 2024 11:57:22 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tO0AZ-000Gb8-2X;
	Wed, 18 Dec 2024 19:57:19 +0000
Date: Thu, 19 Dec 2024 03:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 2/8] net: allow ARFS rmap
 management in core
Message-ID: <202412190318.OR90xHNu-lkp@intel.com>
References: <20241218165843.744647-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218165843.744647-3-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-napi-add-irq_flags-to-napi-struct/20241219-010125
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241218165843.744647-3-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v2 2/8] net: allow ARFS rmap management in core
config: arm-randconfig-002-20241219 (https://download.01.org/0day-ci/archive/20241219/202412190318.OR90xHNu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241219/202412190318.OR90xHNu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412190318.OR90xHNu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/dev.c:92:
   include/linux/netdevice.h:361:1: error: empty enum is invalid
     361 | };
         | ^
   include/linux/netdevice.h:367:1: error: empty enum is invalid
     367 | };
         | ^
   net/core/dev.c: In function 'netif_napi_set_irq':
>> net/core/dev.c:6710:14: warning: unused variable 'rc' [-Wunused-variable]
    6710 |         int  rc;
         |              ^~


vim +/rc +6710 net/core/dev.c

  6707	
  6708	void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
  6709	{
> 6710		int  rc;
  6711	
  6712		napi->irq = irq;
  6713		napi->irq_flags = flags;
  6714	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

