Return-Path: <netdev+bounces-150520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86649EA7C2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E02D1889360
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08622616B;
	Tue, 10 Dec 2024 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXf6BTqq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BD1D9A40;
	Tue, 10 Dec 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808291; cv=none; b=GrjLwaCSbS4Px0X53OCohhW0e3rL9bpPuPco77jiALvCc3L3fC2hJJ1K7T3T6Lll72s2pOHBCkMdNtXQhYjjXslKEAtTkaqP/ZTml4a8JlTVCPGKWI6LcX5jsD2MyfQj5750i73avyuTNrvLNVE9dZT4dJc7aMEr2q0xig9kU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808291; c=relaxed/simple;
	bh=DAxhrU8nYe3wIVwTN/sHDUPcQXoFKKbHmXYU8frJH4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTCKoZKvZivP+V4GlMSiLa+JSYMjZlhySwRHLAU2ZsSyr4NX7U+43e1RtuKyEAL8gwJeKtq67Tbculv5P6EUae9jpTaosgNQEQe2Q9T1X75NpNv2xx0wAHR3uujr/Z7z8QjMoLmHVdODDJGXYxl37SA4kuIb6ccPb5PrnojnYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXf6BTqq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733808291; x=1765344291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DAxhrU8nYe3wIVwTN/sHDUPcQXoFKKbHmXYU8frJH4s=;
  b=SXf6BTqqt3Qnx3YmO1u/cfFRn+xCztCQ5xfxwojDjulJxscLVjgAgzx7
   Gun9e9QGeJ/MA8cJT6TKI9JvUJTRPauaNipUInZoNkEUK0mNnfBjKedZK
   wwiCSs2rmSyzJtvImtdCV3ulcPhBGQlYsdhR+Gqd+8XC6QsGZiqfCgVwh
   AKNUF82JswU1SvYJQhCygzDVZ8caoKE2f7/VKQjGNIwJBDbVdtzGAT0Ld
   GsDndVgB/l6/GtyX4ISQ6kPWtGB4Wd8x/jjgi2O518Mn46vOeIl6RJ+kj
   iCXpgt43ngpYR7YDdg5PwzDuPV+HkYVCpKTZzNgw8aB1LaMpohVXOe4qL
   w==;
X-CSE-ConnectionGUID: B/JfgfNNTOah+X7GUT2+ug==
X-CSE-MsgGUID: O4zHj/q/TcKCAKB6+A1B0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45517234"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45517234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 21:24:50 -0800
X-CSE-ConnectionGUID: yT3wQW55SUqvh5zoMS2Sng==
X-CSE-MsgGUID: atNr2jojQd+IxiaOFRtDGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="95490968"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Dec 2024 21:24:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKsjj-00058n-1q;
	Tue, 10 Dec 2024 05:24:43 +0000
Date: Tue, 10 Dec 2024 13:23:47 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] clk: sophgo: Add clock controller support for SG2044
 SoC
Message-ID: <202412101358.czZY7XmR-lkp@intel.com>
References: <20241209082132.752775-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209082132.752775-3-inochiama@gmail.com>

Hi Inochi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sophgo/for-next]
[also build test WARNING on sophgo/fixes clk/clk-next robh/for-next linus/master v6.13-rc2 next-20241209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-clock-sophgo-add-clock-controller-for-SG2044/20241209-162418
base:   https://github.com/sophgo/linux.git for-next
patch link:    https://lore.kernel.org/r/20241209082132.752775-3-inochiama%40gmail.com
patch subject: [PATCH 2/2] clk: sophgo: Add clock controller support for SG2044 SoC
config: parisc-randconfig-r053-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101358.czZY7XmR-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412101358.czZY7XmR-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/clk/sophgo/clk-sg2044.c:133:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
>> drivers/clk/sophgo/clk-sg2044.c:149:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

vim +133 drivers/clk/sophgo/clk-sg2044.c

   126	
   127	static unsigned long sg2044_pll_calc_vco_rate(unsigned long parent_rate,
   128						      unsigned long refdiv,
   129						      unsigned long fbdiv)
   130	{
   131		u64 numerator = parent_rate * fbdiv;
   132	
 > 133		do_div(numerator, refdiv);
   134	
   135		return numerator;
   136	}
   137	
   138	static unsigned long sg2044_pll_calc_rate(unsigned long parent_rate,
   139						  unsigned long refdiv,
   140						  unsigned long fbdiv,
   141						  unsigned long postdiv1,
   142						  unsigned long postdiv2)
   143	{
   144		u64 numerator, denominator;
   145	
   146		numerator = parent_rate * fbdiv;
   147		denominator = refdiv * (postdiv1 + 1) * (postdiv2 + 1);
   148	
 > 149		do_div(numerator, denominator);
   150	
   151		return numerator;
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

