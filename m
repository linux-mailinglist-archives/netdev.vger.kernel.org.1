Return-Path: <netdev+bounces-217060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B24B37360
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318BE7C7C55
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90434F463;
	Tue, 26 Aug 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCYFgRkK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB922EA170;
	Tue, 26 Aug 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237557; cv=none; b=es3OCBF5p6R9FA0q2EPqn4JCAZwK/Zz6JpE4hw0oQ6Eb9H1PC0X2AnoDnar+8wjV8BMhao957KE//YDas8X3XgQ4Xf4qgPGiox7FShCf8vq0Nz1lyOsML3CcMdJk7lpr/ByDVetVBCMHIucwTlcuSUki2HXMACZ0Laiw5a6O5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237557; c=relaxed/simple;
	bh=cFWS2QE4iSaLBHJfpDP0+CSDZ4ubcqaQtIbpYGK528I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBJEh6P2raEuiPysaSRMatKqM6Txaz5nx90OtT0C1vTCUMMUNyJNjWgFdxMgIVbk6ZibN1glEKMo8M72EKG/rPNQ0+zx3yqPFHJjyXwH7kojK7k1Q8q+EzUvTbcYZ0qM9OlgrI7AjDav901QJVjfqNrkWrFVxyTKUY9YMiShfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCYFgRkK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756237557; x=1787773557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cFWS2QE4iSaLBHJfpDP0+CSDZ4ubcqaQtIbpYGK528I=;
  b=RCYFgRkK6jM4B7QVK8WLjyEep6BDzykjDgtFz+60kVdkbg9Tx8bDG8Sq
   nq2/yilwxuj9IDR/hFpTJQkcU10WOwPVoejti1sH9Qkg21mXnF4PnmVD3
   VaUO3snlRop7uAvd/cStfwB+2SGJs+sAHs4T2B3NsjVRRNznypqAsT4r3
   Bwaj/uvjwqC1KcxJ7A+CIzQi8gibPC4U+EPA9TVuhSSwSuZAkkeOOYcDv
   0r6kvVqbrqN8nEFCX4rXhmzDv/MS8Iw2WWMD/aFnnH05w/UxhEhdWf02n
   rj6lyjXNJZxLbjjVJccmCBiD9LxvUASLcEl9hO6V/DKv73OSMJep1RN7t
   Q==;
X-CSE-ConnectionGUID: ajUe3+9DQEGIxDQeCRkyrw==
X-CSE-MsgGUID: hosl2LoQQ/2diHS1/AHzqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58196731"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58196731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:45:56 -0700
X-CSE-ConnectionGUID: xxeCi0ckSjyYtDWqUo1YZg==
X-CSE-MsgGUID: zdxvqFecRxianNLM+C+iZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174919769"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 26 Aug 2025 12:45:50 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqzc4-000SLD-1m;
	Tue, 26 Aug 2025 19:45:48 +0000
Date: Wed, 27 Aug 2025 03:43:32 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 2/6] net: dsa: lantiq_gswip: support
 model-specific mac_select_pcs()
Message-ID: <202508270335.PG3eJBYD-lkp@intel.com>
References: <7576c237814016ee5e18572b2788f955071a922c.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7576c237814016ee5e18572b2788f955071a922c.1756163848.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/MAINTAINERS-lantiq_gswip-broaden-file-pattern/20250826-081728
base:   net-next/main
patch link:    https://lore.kernel.org/r/7576c237814016ee5e18572b2788f955071a922c.1756163848.git.daniel%40makrotopia.org
patch subject: [PATCH net-next 2/6] net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
config: alpha-randconfig-r133-20250826 (https://download.01.org/0day-ci/archive/20250827/202508270335.PG3eJBYD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250827/202508270335.PG3eJBYD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508270335.PG3eJBYD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/lantiq_gswip.c:1607:30: sparse: sparse: symbol 'gswip_phylink_mac_ops' was not declared. Should it be static?

vim +/gswip_phylink_mac_ops +1607 drivers/net/dsa/lantiq_gswip.c

  1606	
> 1607	const struct phylink_mac_ops gswip_phylink_mac_ops = {
  1608		.mac_config		= gswip_phylink_mac_config,
  1609		.mac_link_down		= gswip_phylink_mac_link_down,
  1610		.mac_link_up		= gswip_phylink_mac_link_up,
  1611		.mac_select_pcs		= gswip_phylink_mac_select_pcs,
  1612	};
  1613	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

