Return-Path: <netdev+bounces-221041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6DB49EEE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B201B21C0C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3A23BD1B;
	Tue,  9 Sep 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHEHdINP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF12236FA;
	Tue,  9 Sep 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383461; cv=none; b=TU0z2kLYYz8YRNDZRDDYo1/bGIjxUrw+E9BWzVNubBnD/+O/s8wa8SlB9KZcvIPdCkG/yKAN/Ad/8T5YujwwW7L1NFO6OFCfCB6c1mqw3ZJIGqdBwBh3PxjeFuSx416NTrtKxoZxPCK7Feumn2A3mIgEh0cxSl3lmRd8OUMIFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383461; c=relaxed/simple;
	bh=XaLdDMyMjcEDsIK6hHSfev70tFApOS15+jpM3QcAt9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4HhMNqUDPbpr8tSYGEvIwm5TmeRZlfh01lcujJgsQEUTOfeUIcFM81SRUU8kDToIAMQrIu3ukzx1B3v2iZKagMwY0uqfJzYNlBYB3LqYnSAYfjvc4pEbmArR8d+j3GQj84wD4VctzI1vEQkN44TwizcUmQZLSRrnvuYNa8941E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHEHdINP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757383459; x=1788919459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XaLdDMyMjcEDsIK6hHSfev70tFApOS15+jpM3QcAt9I=;
  b=DHEHdINPASaNZuKOTWdLweKMGbSMhLkto5DodtNb8SARCT8lYKarbelU
   mCzMW5U68JzZ5BRITFN54AQ/KvrkzZEd9rq06+KiLaor871HHYo7HgS4S
   lYTcPYwJ9KVYqIDTfz4LfTlg/aHnCX8Vp9skHLQGdlPVFQnKZjWHr2rIo
   h3r6Cu+8J4FEspPAWxy3KpERrdl0zwnmG8q6h6BGaqrgslpHvTh05x7TB
   koJVX9qzpCVL3eryNYFACWXtAMXsfn4HlJHldIzGgt3V8Vhqa8mZ0zCF9
   UaDaLj9AXGUeJSuGm4E9gE6zhaQMTUj3dgV6rdtRztICjbQV5FOQ6a0gr
   Q==;
X-CSE-ConnectionGUID: GwZduhbbQkW+tzTeTmeGqg==
X-CSE-MsgGUID: bvIwJF9uRkaofrdVQMWiGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="47231417"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="47231417"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 19:04:18 -0700
X-CSE-ConnectionGUID: OCOjcUSCRSiDPlICZfe1DQ==
X-CSE-MsgGUID: Wf2JILLQRVSFMJqGQHIJzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="172535064"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2025 19:04:15 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvniN-0004KJ-1u;
	Tue, 09 Sep 2025 02:04:11 +0000
Date: Tue, 9 Sep 2025 10:03:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v5 2/5] dpll: zl3073x: Add low-level flash
 functions
Message-ID: <202509090902.7k4O454a-lkp@intel.com>
References: <20250908093924.1952317-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908093924.1952317-3-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Add-functions-to-access-hardware-registers/20250908-174338
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250908093924.1952317-3-ivecera%40redhat.com
patch subject: [PATCH net-next v5 2/5] dpll: zl3073x: Add low-level flash functions
config: s390-randconfig-001-20250909 (https://download.01.org/0day-ci/archive/20250909/202509090902.7k4O454a-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090902.7k4O454a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509090902.7k4O454a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/dpll/zl3073x/flash.c:42 function parameter 'component' not described in 'zl3073x_flash_download'
>> Warning: drivers/dpll/zl3073x/flash.c:42 function parameter 'addr' not described in 'zl3073x_flash_download'
>> Warning: drivers/dpll/zl3073x/flash.c:42 function parameter 'data' not described in 'zl3073x_flash_download'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

