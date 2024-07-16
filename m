Return-Path: <netdev+bounces-111654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E839A931F4A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176C71C20DBD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A86D2FA;
	Tue, 16 Jul 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mmht6lpg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921218633;
	Tue, 16 Jul 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100750; cv=none; b=rJ9xwPGMhXj622etkbdbrElbUEZ2CSeYFhMYJiMmIyjZ0a8v6yZlKcuwSEaYY7kAiB+ecfftAjOOB8TifmbUdn4B/PYHm1l6And4z1hwnl0EFXPvcEbjmNkMe4gpbHoz4JUFqdGc11mpc2EIr+Lwg8/NsDNkimlHCHbqCgULI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100750; c=relaxed/simple;
	bh=GY/1zz50NBZ5rMHvmCnJe4c5+oCSLR2igpJJdQM9su0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqyWetfIdjpaWqlJ8yBbPzCo7BOMedWP1dHhmfqzTyemHG4qDfqpb6xhTUNp2aEvGczWrhXYbb9DCZlKQaffyx8Iwb3wbCRaB6I04lprOnREb5F/nn/kN6VFXGbtI0T16FjYlPvrJuF5bJGvTPnR+ChbO0pF3lcP6JQBVDrTi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mmht6lpg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721100748; x=1752636748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GY/1zz50NBZ5rMHvmCnJe4c5+oCSLR2igpJJdQM9su0=;
  b=Mmht6lpg7SHxkVrodfYoG8hRF0g5QuhPTmEM8YrEqTHyXjnOqOF6R0mf
   RDJnUZfBnaj9fay/0gulaZYoaZgiwWrhOMCDVVKnXo24tCMycpItmDRRG
   9keF6DDKW9g9++aW9jga8AjM13oBWWMAR8hk3CvlepchJ5iY77nj3m4xh
   ey2dK5HKRldOIKikirltrd7bNvfrIeW773KnXBAC/gHC3fgLTfsaKmnZu
   PdtwQcutk9m8NtQVe66imOgj1dxqM8YGMMwNbgzH+JW4A6vUJDkkUOW7C
   7dSt817aIeKD9Kyw1DeFEeX17lqnYuefBc6dyid3UfOoCH5xWXTbEuAhE
   Q==;
X-CSE-ConnectionGUID: 4mw17WovQU+TyEwh4i7BFQ==
X-CSE-MsgGUID: KPGB6VfrRtCkPwX9SKMgmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18646216"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18646216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 20:32:28 -0700
X-CSE-ConnectionGUID: DyVHE1PWQhCwnPJdTEGnnA==
X-CSE-MsgGUID: sodaZD6uRwSgia+JRpf+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50482525"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Jul 2024 20:32:24 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTYvO-000ery-05;
	Tue, 16 Jul 2024 03:32:22 +0000
Date: Tue, 16 Jul 2024 11:32:09 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	richard.hughes@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 10/15] cxl: define a driver interface for DPA
 allocation
Message-ID: <202407161159.KA2METLk-lkp@intel.com>
References: <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-11-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10 next-20240715]
[cannot apply to cxl/next cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20240716-015920
base:   linus/master
patch link:    https://lore.kernel.org/r/20240715172835.24757-11-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v2 10/15] cxl: define a driver interface for DPA allocation
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240716/202407161159.KA2METLk-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407161159.KA2METLk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407161159.KA2METLk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/hdm.c:612: warning: Function parameter or struct member 'is_ram' not described in 'cxl_request_dpa'
>> drivers/cxl/core/hdm.c:612: warning: Excess function parameter 'mode' description in 'cxl_request_dpa'


vim +612 drivers/cxl/core/hdm.c

   589	
   590	/**
   591	 * cxl_request_dpa - search and reserve DPA given input constraints
   592	 * @endpoint: an endpoint port with available decoders
   593	 * @mode: DPA operation mode (ram vs pmem)
   594	 * @min: the minimum amount of capacity the call needs
   595	 * @max: extra capacity to allocate after min is satisfied
   596	 *
   597	 * Given that a region needs to allocate from limited HPA capacity it
   598	 * may be the case that a device has more mappable DPA capacity than
   599	 * available HPA. So, the expectation is that @min is a driver known
   600	 * value for how much capacity is needed, and @max is based the limit of
   601	 * how much HPA space is available for a new region.
   602	 *
   603	 * Returns a pinned cxl_decoder with at least @min bytes of capacity
   604	 * reserved, or an error pointer. The caller is also expected to own the
   605	 * lifetime of the memdev registration associated with the endpoint to
   606	 * pin the decoder registered as well.
   607	 */
   608	struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
   609						     bool is_ram,
   610						     resource_size_t min,
   611						     resource_size_t max)
 > 612	{
   613		struct cxl_endpoint_decoder *cxled;
   614		enum cxl_decoder_mode mode;
   615		struct device *cxled_dev;
   616		resource_size_t alloc;
   617		int rc;
   618	
   619		if (!IS_ALIGNED(min | max, SZ_256M))
   620			return ERR_PTR(-EINVAL);
   621	
   622		down_read(&cxl_dpa_rwsem);
   623	
   624		cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
   625		if (!cxled_dev)
   626			cxled = ERR_PTR(-ENXIO);
   627		else
   628			cxled = to_cxl_endpoint_decoder(cxled_dev);
   629	
   630		up_read(&cxl_dpa_rwsem);
   631	
   632		if (IS_ERR(cxled))
   633			return cxled;
   634	
   635		if (is_ram)
   636			mode = CXL_DECODER_RAM;
   637		else
   638			mode = CXL_DECODER_PMEM;
   639	
   640		rc = cxl_dpa_set_mode(cxled, mode);
   641		if (rc)
   642			goto err;
   643	
   644		down_read(&cxl_dpa_rwsem);
   645		alloc = cxl_dpa_freespace(cxled, NULL, NULL);
   646		up_read(&cxl_dpa_rwsem);
   647	
   648		if (max)
   649			alloc = min(max, alloc);
   650		if (alloc < min) {
   651			rc = -ENOMEM;
   652			goto err;
   653		}
   654	
   655		rc = cxl_dpa_alloc(cxled, alloc);
   656		if (rc)
   657			goto err;
   658	
   659		return cxled;
   660	err:
   661		put_device(cxled_dev);
   662		return ERR_PTR(rc);
   663	}
   664	EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
   665	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

