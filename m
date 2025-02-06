Return-Path: <netdev+bounces-163641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEBA2B207
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0551889A15
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9381A265E;
	Thu,  6 Feb 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7PObECF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F319F111;
	Thu,  6 Feb 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869187; cv=none; b=sz672zabSLeknvLlU4R2U/+tJTGAakq9G00Bbl9EEfeSqct/WM50ioT8fXQoW+gvbqh6q4y9UPfQENP6BHn2CN8mSIHVS+wi2EI9iE+RoNG+wu1sE5P1+2YAxfoVfBK6PWXCOE1/yaWm6EEmovgJUYFmYrwBRe49+Ap7A31NL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869187; c=relaxed/simple;
	bh=zwh7LYQ2PcG7Pp6G4r7bjhGRplqUju5h9X/U+t1IADI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW8Dn7pl/XB2aXXk/3e2jtStIx3SgIkalqHO7T6zEbXNqzcTsXrMLcpe9km4gCmR5h5g0Cl8q7U2IAdNsAov5geVOr2Z2RvXNQCSuWV4YDqLeG7u7h9M+ADjNd456MSS9bRCkTp8ieBJ4uL5jbNCvIZgIeZ0fp17CuJ12LMP/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7PObECF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738869185; x=1770405185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwh7LYQ2PcG7Pp6G4r7bjhGRplqUju5h9X/U+t1IADI=;
  b=J7PObECFE24E/c9CB7kMA40ZMcVFJEfoEsh4uQMlI01b82MZJA7DmtTJ
   vTp5SlWgo1atrD5rn5fNXgNOuoytt42gqMlP1YwEPX/pYshqCpD+Xn04B
   mzVt4SnU/2uzkYJsrk5DUhWyaCcNiyW3X6nXfPL9eL6PLWXZSUM2o3ij5
   LCTcdL3Kf2zMJPjFEdHMZOJftKsBS3ynLsbEkKdDlhK5WCUEHldL33POh
   Yxaxe6qlND4CT/rWqB4Q3mTLs2eX9tgkFYnQLn/aXt+bYTjL73Jeg0kuK
   eHFNEGa5W9KOe7QlRSpv6Ff11fIKZj0fVPb2pkELKVkPsTZH7DSsBdSa7
   w==;
X-CSE-ConnectionGUID: zZjq9V93QMSAQqlVTmOTdg==
X-CSE-MsgGUID: TkUo1Qn9Q3WPuWSQUIVVIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39517019"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39517019"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:13:05 -0800
X-CSE-ConnectionGUID: ouTKhg2GROCuruDiLSADyQ==
X-CSE-MsgGUID: +5KCRvisS8iZrvfBwYEw6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111915148"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Feb 2025 11:13:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tg7J6-000xEt-0p;
	Thu, 06 Feb 2025 19:13:00 +0000
Date: Fri, 7 Feb 2025 03:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 16/26] cxl: define a driver interface for DPA
 allocation
Message-ID: <202502070213.8GNIAg8A-lkp@intel.com>
References: <20250205151950.25268-17-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-17-alucerop@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46]

url:    https://github.com/intel-lab-lkp/linux/commits/alucerop-amd-com/cxl-make-memdev-creation-type-agnostic/20250205-233651
base:   6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46
patch link:    https://lore.kernel.org/r/20250205151950.25268-17-alucerop%40amd.com
patch subject: [PATCH v10 16/26] cxl: define a driver interface for DPA allocation
config: i386-buildonly-randconfig-006-20250206 (https://download.01.org/0day-ci/archive/20250207/202502070213.8GNIAg8A-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502070213.8GNIAg8A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502070213.8GNIAg8A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/hdm.c:743: warning: Function parameter or struct member 'alloc' not described in 'cxl_request_dpa'
>> drivers/cxl/core/hdm.c:743: warning: Excess function parameter 'min' description in 'cxl_request_dpa'


vim +743 drivers/cxl/core/hdm.c

   722	
   723	/**
   724	 * cxl_request_dpa - search and reserve DPA given input constraints
   725	 * @cxlmd: memdev with an endpoint port with available decoders
   726	 * @is_ram: DPA operation mode (ram vs pmem)
   727	 * @min: the minimum amount of capacity the call needs
   728	 *
   729	 * Given that a region needs to allocate from limited HPA capacity it
   730	 * may be the case that a device has more mappable DPA capacity than
   731	 * available HPA. So, the expectation is that @min is a driver known
   732	 * value for how much capacity is needed, and @max is the limit of
   733	 * how much HPA space is available for a new region.
   734	 *
   735	 * Returns a pinned cxl_decoder with at least @min bytes of capacity
   736	 * reserved, or an error pointer. The caller is also expected to own the
   737	 * lifetime of the memdev registration associated with the endpoint to
   738	 * pin the decoder registered as well.
   739	 */
   740	struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
   741						     bool is_ram,
   742						     resource_size_t alloc)
 > 743	{
   744		struct cxl_port *endpoint = cxlmd->endpoint;
   745		struct cxl_endpoint_decoder *cxled;
   746		enum cxl_partition_mode mode;
   747		struct device *cxled_dev;
   748		int rc;
   749	
   750		if (!IS_ALIGNED(alloc, SZ_256M))
   751			return ERR_PTR(-EINVAL);
   752	
   753		down_read(&cxl_dpa_rwsem);
   754		cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
   755		up_read(&cxl_dpa_rwsem);
   756	
   757		if (!cxled_dev)
   758			return ERR_PTR(-ENXIO);
   759	
   760		cxled = to_cxl_endpoint_decoder(cxled_dev);
   761	
   762		if (!cxled) {
   763			rc = -ENODEV;
   764			goto err;
   765		}
   766	
   767		if (is_ram)
   768			mode = CXL_PARTMODE_RAM;
   769		else
   770			mode = CXL_PARTMODE_PMEM;
   771	
   772		rc = cxl_dpa_set_part(cxled, mode);
   773		if (rc)
   774			goto err;
   775	
   776		rc = cxl_dpa_alloc(cxled, alloc);
   777		if (rc)
   778			goto err;
   779	
   780		return cxled;
   781	err:
   782		put_device(cxled_dev);
   783		return ERR_PTR(rc);
   784	}
   785	EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

