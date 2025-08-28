Return-Path: <netdev+bounces-217682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FDEB39859
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455C97AC318
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8F26F46F;
	Thu, 28 Aug 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ1Mdz6O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5581DEFF5;
	Thu, 28 Aug 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373673; cv=none; b=MUVRgiB7jFgAxZ+He0j1j2ydV78A/pxbTyg+ZVFAk/A6pNCpTzap9PkvZyY/dKnk7AaSo46CZ15xUrT4vFuyN9YOtKFGvAuFtRWh6zJ8/4dItieJjftQf4wdDSfFtE9afH3Hso0S1ylFEKScb7sYBM1hnpVe7mVb5i5KPj72BiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373673; c=relaxed/simple;
	bh=yuynSKYGfxPDARXbNkOVcirGGnm9MJdjYgpoYNnyvqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj7cnJnBmNhRwRXYDlYEWE77dTf9Aay+gpz1AYDqm7m36rnmQq/gV0fzCl241lXPnidK4xchehgni4DeAvnmwfp+QPydyRoFHbYRjs7u+sRxE3v+zrHZ927l/ywkOLL4i0qrbjvkT5E5ZvIRx77TuPPN3f8ix5wh4TAEawKKASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ1Mdz6O; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756373672; x=1787909672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yuynSKYGfxPDARXbNkOVcirGGnm9MJdjYgpoYNnyvqk=;
  b=HZ1Mdz6OFFA8/lzdG0aL4m0xFGMIpSf8wZRD4PxHF0NbY8Y0ktjo8RNs
   Uex8rCJkuUA+1rhmESloQlKPqM9lZIbo6SHhyUYUpsNbU+gnkUpEB1UJJ
   Pkpl1cGPI26RQBbMzH4eH/ttUVHnaOg5YluLoWoZDEPJk4my0mDObr2na
   IUuETNUph1ZwsFkzTkJqGzX4Ye845UwsFSVfX+5kGh2KSKxD/6N+pUKOT
   vhI/x2oEn0zNOXZ9TdlfiqejnHo2u3petb4diyFgTNPneAqIuSvm8Q0CO
   ZZpCsLZQX3A6x2IaWojIAvxnpuspA53oJ//Ax3W3WC0rKWIIA66rgMj3G
   g==;
X-CSE-ConnectionGUID: vg4Qi5rMQW2Mu6yBtHBIcg==
X-CSE-MsgGUID: 08H2IFlgS/iYTFG/10Oy3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58787359"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58787359"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:34:31 -0700
X-CSE-ConnectionGUID: 3oW4vjZ0SqCDl3Ptz+McUg==
X-CSE-MsgGUID: M5KpuRq8SLWF14awLIFgLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170462631"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 02:34:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urZ0v-000Tbr-1n;
	Thu, 28 Aug 2025 09:33:57 +0000
Date: Thu, 28 Aug 2025 17:32:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Message-ID: <202508281615.ExryCwiA-lkp@intel.com>
References: <20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>

Hi Gatien,

kernel test robot noticed the following build errors:

[auto build test ERROR on 242041164339594ca019481d54b4f68a7aaff64e]

url:    https://github.com/intel-lab-lkp/linux/commits/Gatien-Chevallier/drivers-net-stmmac-handle-start-time-set-in-the-past-for-flexible-PPS/20250827-190905
base:   242041164339594ca019481d54b4f68a7aaff64e
patch link:    https://lore.kernel.org/r/20250827-relative_flex_pps-v3-1-673e77978ba2%40foss.st.com
patch subject: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time set in the past for flexible PPS
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250828/202508281615.ExryCwiA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508281615.ExryCwiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508281615.ExryCwiA-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "timespec64_add_safe" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

