Return-Path: <netdev+bounces-163658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67FFA2B2F4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0344188ACDB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B21CBA02;
	Thu,  6 Feb 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT75D7wB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBC1CAA8A;
	Thu,  6 Feb 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872434; cv=none; b=XOZy4efU3ftV2ED4AxHaTizkQ073HOfQ5m2CLDOqS6JavNkAdlsAjzGSPHG5c0mN0knJzltnjkKTM/9p1lDj88Efh4cbLSAiK0KDpM3p9/JXjgHoYL/0VM0399HAvP5Yaxk8wQYFbmoLeV8wYb4CZa1D95JDy5UvH5eh7LgQBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872434; c=relaxed/simple;
	bh=RKVcCa9bN8nAkks2jAt+e7e/MXCLDh3WzgiZylCL3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=greezPdMGQlhWMG5BQibBEaiWhachnztandH+wTqjY4AIR3Q7ht6hQXb//qzMabaeq2yGjXe/F5Z8gcdIoqnLwfzNhoDPH0LM4E+P7r14K0oglKf9dacfI27Hcxrx1NwazhwN/DyfVD14KCMf24NCGJkupLdAqx8Var5Imq4fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT75D7wB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738872432; x=1770408432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKVcCa9bN8nAkks2jAt+e7e/MXCLDh3WzgiZylCL3FM=;
  b=iT75D7wBPgRVSi4ZX4tduyyS/0iYluqkKMeIAaLw5xTwvV75qtgFQj+v
   81bl9coMdk9sVzT3idLnhvWvfOoQwdMwCHAGfANKfoT9bW0UpdGnDiOss
   WEqu1/jENZYI3LR+N4lSXtwWKnkVevfyMDGpcqBmhFVxcY/u9scxBH5NC
   p2KXMjL6yjp398p8DLOzZngwy921eaMx4C850CA8iFAvzF5f/obDi7x0e
   c7gf5TmFjS731KkgMZllqUewWj/K3sPZ0YAZvZwSN97BU3yp2DxY9tPoh
   v1HsZ4hIcLhZtP5DqpKO98DbYUDps9ktz4YZUl7C6J4pex2qIfXOxyCvA
   g==;
X-CSE-ConnectionGUID: 5VNLyqiBRLmhI0acd8xBjA==
X-CSE-MsgGUID: wkV0uurhRYqJYlXUpb4FFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38696244"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="38696244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 12:07:11 -0800
X-CSE-ConnectionGUID: 5MPmEQkeR6GZg1Zbh3dKjQ==
X-CSE-MsgGUID: HxIxPSJBSU+VcF0oaKtzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="142193227"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Feb 2025 12:07:08 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tg89R-000xHb-1R;
	Thu, 06 Feb 2025 20:07:05 +0000
Date: Fri, 7 Feb 2025 04:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 21/26] cxl: allow region creation by type2 drivers
Message-ID: <202502070349.mdD2BTuL-lkp@intel.com>
References: <20250205151950.25268-22-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-22-alucerop@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46]

url:    https://github.com/intel-lab-lkp/linux/commits/alucerop-amd-com/cxl-make-memdev-creation-type-agnostic/20250205-233651
base:   6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46
patch link:    https://lore.kernel.org/r/20250205151950.25268-22-alucerop%40amd.com
patch subject: [PATCH v10 21/26] cxl: allow region creation by type2 drivers
config: i386-buildonly-randconfig-006-20250206 (https://download.01.org/0day-ci/archive/20250207/202502070349.mdD2BTuL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502070349.mdD2BTuL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502070349.mdD2BTuL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/region.c:3589: warning: Function parameter or struct member 'ways' not described in 'cxl_create_region'


vim +3589 drivers/cxl/core/region.c

  3578	
  3579	/**
  3580	 * cxl_create_region - Establish a region given an endpoint decoder
  3581	 * @cxlrd: root decoder to allocate HPA
  3582	 * @cxled: endpoint decoder with reserved DPA capacity
  3583	 *
  3584	 * Returns a fully formed region in the commit state and attached to the
  3585	 * cxl_region driver.
  3586	 */
  3587	struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
  3588					     struct cxl_endpoint_decoder *cxled, int ways)
> 3589	{
  3590		struct cxl_region *cxlr;
  3591	
  3592		mutex_lock(&cxlrd->range_lock);
  3593		cxlr = __construct_new_region(cxlrd, cxled, ways);
  3594		mutex_unlock(&cxlrd->range_lock);
  3595	
  3596		if (IS_ERR(cxlr))
  3597			return cxlr;
  3598	
  3599		if (device_attach(&cxlr->dev) <= 0) {
  3600			dev_err(&cxlr->dev, "failed to create region\n");
  3601			drop_region(cxlr);
  3602			return ERR_PTR(-ENODEV);
  3603		}
  3604		return cxlr;
  3605	}
  3606	EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
  3607	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

