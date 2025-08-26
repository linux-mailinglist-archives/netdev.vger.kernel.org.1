Return-Path: <netdev+bounces-217017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A664B370F1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF3A8E413E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260812DAFA1;
	Tue, 26 Aug 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAuxDYdX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528371C8605;
	Tue, 26 Aug 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227971; cv=none; b=afxQTVAwXG6stmhUORTjBkAsBVtqZESI+TftZoQ3dCYWVqmMUB/ond+9PRG18Z0r7P0+HPsT0hIvkfawHOy81EaqKlgNce9UTL021WOnWfU7laPVEoafQtBULqvap4g7FpF0axEfiRqwjEbnPBjdyi91vwR4sj/aa1UF3qe6O10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227971; c=relaxed/simple;
	bh=Mj9egpTW8QvcC822yuVmAghJg+cmMryjaFSykbktxbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj3Ptaj8zYRNOMpSlBqOhxNL/rliEAwkH2QUTqsl5cIlM56Pri73huojhJRWQN/a68V5zhjZPGXDg2Tp54a+mj3rYt4QhTWzJbtu3Phla9PIq30ucKu9J7O3ZK1OjFBikkSpPsTDhecqsf3Yi/E0w0Sx7RWZnE81wOODMhMnVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAuxDYdX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756227969; x=1787763969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mj9egpTW8QvcC822yuVmAghJg+cmMryjaFSykbktxbE=;
  b=CAuxDYdX4/PghNEuGeT8wqRWoeunzQTXYXsx/k1ZEyjGCBo+I3FTLmiv
   ZOwlso6CQYLUAOOmlv1aFHdvGyPy6M0gCH36gKx8fOASVAb1ckL8WjZnb
   8IXuKv4k2FwIEZLbFY+zS3RaAumOS+H9+cp5XusvB99i63/YzXlmG36BM
   wxNfolK7my2tAI2Rjjq+DbRqiJzrICkOWsdzCUpNjcvwvhnvrfS2Z7Gjy
   xkwI7EC/KiU3DYodNwVA5AE5n/E6HUyXDG9crheT2bCtKfYKFC8gK5nd8
   8si/UJQClYZaSmxSvUBnOPKGBFpXZIgsIw3DhNsvYqTcQp5kMQ3sELKUp
   g==;
X-CSE-ConnectionGUID: EBUaeIvnTj6o9jWUFbBcng==
X-CSE-MsgGUID: aZjMooI9RayryfoTa5JchQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="75926124"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75926124"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:06:08 -0700
X-CSE-ConnectionGUID: i127+iinTnezUN+yhfa2Qw==
X-CSE-MsgGUID: UsAkLzssQDyxNOzJo3nNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193295847"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2025 10:06:06 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqx7T-000SFD-22;
	Tue, 26 Aug 2025 17:06:03 +0000
Date: Wed, 27 Aug 2025 01:05:51 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: Re: [PATCH net-next 4/7] net: stmmac: enable ARP Offload on
 mac_link_up()
Message-ID: <202508270007.sExKFhrN-lkp@intel.com>
References: <20250826113247.3481273-5-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826113247.3481273-5-konrad.leszczynski@intel.com>

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Leszczynski/net-stmmac-replace-memcpy-with-strscpy-in-ethtool/20250826-193732
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250826113247.3481273-5-konrad.leszczynski%40intel.com
patch subject: [PATCH net-next 4/7] net: stmmac: enable ARP Offload on mac_link_up()
config: arm-randconfig-004-20250826 (https://download.01.org/0day-ci/archive/20250827/202508270007.sExKFhrN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250827/202508270007.sExKFhrN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508270007.sExKFhrN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "in_dev_finish_destroy" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

