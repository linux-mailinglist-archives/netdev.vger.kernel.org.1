Return-Path: <netdev+bounces-174097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDDA5D671
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835B5189B7D5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B31E5B66;
	Wed, 12 Mar 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPwAIg+g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A302C182;
	Wed, 12 Mar 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761770; cv=none; b=Iaz97sstRwVq/ObT7tXTAu7fWIY4HPZg0wGSIa1tHoY2r/56xIvrAx6tZnc2kGYUZuEOF9420IA4UTEST5k91l0VIWyE2C3eG49pUbx/3WnnM7+//GIXEyUgCwgTCv5OMOEs60kJHxuyLsYdey9jK/1TiWfr/cKwhhmZ+iTzRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761770; c=relaxed/simple;
	bh=+0kb6hprsvRt3Ann0dpGja/F2LgMfmRYXyZsPkWNVmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrS+iU93hRrG5LDwpndcihDLFbe56tAONDZ7g9PD8yUb84HEVAzY8MkRD0tuXrfDGqp8gcfjUe7iE3QSbP+Dy+vCqn7dHtEDHnZwMeSNpRM8y9fD+CYxBuSEiiDkVnFjl7+DLZwZ25c8s01pP9WSjU5kcSOJTi1zEYP0XZSxIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPwAIg+g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741761770; x=1773297770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+0kb6hprsvRt3Ann0dpGja/F2LgMfmRYXyZsPkWNVmA=;
  b=dPwAIg+gjQaSAXBGz5JtjyQW8INGiXUB/TdmC8hzi47kUMoL3oQVD7RI
   2F7WikXk9CXZKEQ0qg6Ful8QZdgVKGqS5RlPcUNXkzPsIyTNZw9H+DF9u
   JC08LSFN6NeoPyDm9RLZ1ptbyZvlnaS8/Q8/WE45oJ1C+0eZgSJriSIDg
   KaRDO0rjfwBS+DR+WoRnm3BmIv7smEP7JtlhK8n2JZIM4OhjIycMAX/lk
   p7TDk67WXBHYz2WcpBFr2HqP8B2HP5DmN/60UTy8+xOWzKGDq3AcefCvt
   LysHiXYKpDaQJpTswoR4DePcJ5DaIkcifmYeLWgUWZTnDLHBXH9WPTLTo
   A==;
X-CSE-ConnectionGUID: m4Y2c3axRZaeZWzC/pzFQg==
X-CSE-MsgGUID: fcgx8DXWT7mYuWNaz8a+cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42682013"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42682013"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:42:49 -0700
X-CSE-ConnectionGUID: 5+7kawooS0ScDp3uA+u/ng==
X-CSE-MsgGUID: VW6yWhDOTUe5fA99Ecs9gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121050021"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 11 Mar 2025 23:42:44 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsFne-0008CO-0F;
	Wed, 12 Mar 2025 06:42:42 +0000
Date: Wed, 12 Mar 2025 14:42:07 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v11 23/23] sfc: support pio mapping based on cxl
Message-ID: <202503121456.SDEFIg2L-lkp@intel.com>
References: <20250310210340.3234884-24-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310210340.3234884-24-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a14566be090ca51a32ebdd8a8e21678062dac08]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20250311-050914
base:   0a14566be090ca51a32ebdd8a8e21678062dac08
patch link:    https://lore.kernel.org/r/20250310210340.3234884-24-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v11 23/23] sfc: support pio mapping based on cxl
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20250312/202503121456.SDEFIg2L-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121456.SDEFIg2L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121456.SDEFIg2L-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/net/ethernet/sfc/ef10.o: in function `efx_cxl_init':
>> (.text.efx_cxl_init+0x0): multiple definition of `efx_cxl_init'; drivers/net/ethernet/sfc/efx.o:(.text.efx_cxl_init+0x0): first defined here
   hppa-linux-ld: drivers/net/ethernet/sfc/ef10.o: in function `efx_cxl_exit':
>> (.text.efx_cxl_exit+0x0): multiple definition of `efx_cxl_exit'; drivers/net/ethernet/sfc/efx.o:(.text.efx_cxl_exit+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

