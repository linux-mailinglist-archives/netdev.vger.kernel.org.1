Return-Path: <netdev+bounces-139183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135939B0C2B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FEAB22413
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678418C02E;
	Fri, 25 Oct 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXUWkmMB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2B20C326;
	Fri, 25 Oct 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878747; cv=none; b=qs1ZVP/d/+a/2ybQ2SRc4cfDr09qMJlSIFZFGCHOFIBgrM4M8ZESzs7rh2a7eVYpGa+Rfd8o3b+qeiVVDZA7h3EVlXotKkY2rbiJp0mh/yFsoNCGOHovcNrIL1ONtABOarVxBs8w9SsgY69CtwMLaZAs3Aa2gc8w3O4EZWbp41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878747; c=relaxed/simple;
	bh=UtYL6tEz9hl+CXKoYPC2/xOLlz0ZwZXSI2NVSNsyDNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP4cye8ZooPQ4sdjH0Sz1RwziMHaeoDTC+Yhp45NYsxVJMCCpZrsNDYjW+YfRSpCA6a84/2F1xQ+VGQLcdqa6eSoXhoXfp3WtC4ESrge51ggMV93Xnws9EdU03PJuYqieUvRJctQeZUbniEFSjBuaFRWLzR/hD3aLUf77SFZi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXUWkmMB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729878745; x=1761414745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UtYL6tEz9hl+CXKoYPC2/xOLlz0ZwZXSI2NVSNsyDNo=;
  b=nXUWkmMBw6Nks6x0wIihAyfervUNQDgd9m+9jeRZRlbmoqWhGJTc15ME
   o40UiC1HgmkixgGtxJLf4JQhlKuZfaqbn9C1wgIkqg4sJY64QECoyhX1i
   /w+aSOgFGsMLZlaGVE8redZpUT0MdAteK9D9PfX5NfIukum+KxeZ2rA1S
   LFSmUa1FRLy/9qq2E9K4Iwh+c9a4QtQX5bvWxeXF0TXoA4ei+URKBa1bg
   7VyqrUGOA+oJDuoQmLkoqC0xImP6xoOWAasCzZy1OmN7gzRS/gcrgtjPU
   a3fwc5ZjHuaGt2Sa+K8B6yeApnQnD8paTq73obtfJvF/3Gi226aRfBlL6
   Q==;
X-CSE-ConnectionGUID: SjQYijDXRmy4eKpgKGiCdQ==
X-CSE-MsgGUID: +aX+wiiPSee1c81AMjLDhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52110101"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52110101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:52:25 -0700
X-CSE-ConnectionGUID: Gs8fPh/5Qa2QeLM9/DlmTQ==
X-CSE-MsgGUID: ec3pH9vCSLGfxnnHMxOYFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81405415"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Oct 2024 10:52:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4OTy-000YhM-1w;
	Fri, 25 Oct 2024 17:52:18 +0000
Date: Sat, 26 Oct 2024 01:51:45 +0800
From: kernel test robot <lkp@intel.com>
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: Re: [PATCH net-next v4 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <202410260107.eXOai3Uw-lkp@intel.com>
References: <cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207@gmail.com>

Hi Furong,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Furong-Xu/net-stmmac-Introduce-separate-files-for-FPE-implementation/20241024-163526
base:   net-next/main
patch link:    https://lore.kernel.org/r/cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207%40gmail.com
patch subject: [PATCH net-next v4 3/6] net: stmmac: Refactor FPE functions to generic version
config: arm-sunxi_defconfig (https://download.01.org/0day-ci/archive/20241026/202410260107.eXOai3Uw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260107.eXOai3Uw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260107.eXOai3Uw-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.o: in function `stmmac_fpe_configure':
>> stmmac_fpe.c:(.text+0x140): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

