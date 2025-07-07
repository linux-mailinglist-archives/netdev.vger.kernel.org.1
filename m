Return-Path: <netdev+bounces-204694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB8AFBC7A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605F11AA494E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0F21D3CA;
	Mon,  7 Jul 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFS1cZSk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985A21C9E4;
	Mon,  7 Jul 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919930; cv=none; b=g01Ldwu55anlsW6O1bbsuJP+8ycH8Uh3OFzPlSSM23IauZYQ81KMdQv3N/jZ9XRDyQ9BaOWDmRolFIYfmxrpjZ8mtvySdLhU9TqTLg1HwilTPUIYLCwZ316j7udOyC1HHdsRXDrTvJJBqLOIm2OyjNW/pLG4RT3+8A3fMajM+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919930; c=relaxed/simple;
	bh=ALU+dhe7RMxGCeWyGHrchm7rctCqe3A9IXlJ6lhSGrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbLZczth8DhvDmBxGJuG4OqEhiFtJVDGRpP3On5hnCykQbBfX1B19GEA+QAlVOiy7sIU9t3JCyaoIPSRmXJCAg+SvDdEu4cdtHTvYjDW9xgCFjqKN4LaANWO0ms6IKp4CwUAjaIcO9VwKfE3N9xqzXSEIb8Xt1C/Sfed3lRKjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFS1cZSk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919929; x=1783455929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALU+dhe7RMxGCeWyGHrchm7rctCqe3A9IXlJ6lhSGrY=;
  b=RFS1cZSkUIpx2aI04bglM3XjKf/aUP9yIWXxkUgGKre9Kah7MHdXr/gw
   8V/iE4zu2J0fEO/Zrx6jfzmhOQMf7OeHObVm6mtb43W59v3s5Gtyrf2Ct
   sKRzOKx9J2hU2fyNAyh/Siu3qSut0nf+00iyiUaE2kSh/JZn6jc+CzV6d
   pudPnLbHwdSXEyumfMjdtUPJa8p9EFAKFMpUSx6FR+yHRCy2phlp+vk9U
   V0WLWr162YBHzdu9ElfYAueilQoybwY7wJ45tku31m65JJbHwXk6a4KyE
   2DKWrO71epSDqENpY6XskvppA6+eIog2vivmjl2kRJSxf95vffReHealW
   A==;
X-CSE-ConnectionGUID: kvffNH5xT9GOqufedXWIfw==
X-CSE-MsgGUID: IKClOxFZTeOVeNI/42YEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76700290"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="76700290"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:25:28 -0700
X-CSE-ConnectionGUID: K05odVfnT1KfGBLQIyD4vg==
X-CSE-MsgGUID: Nrj/hWGmQjON/Ypi+mr9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155044368"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Jul 2025 13:25:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYsOw-0000it-2k;
	Mon, 07 Jul 2025 20:25:22 +0000
Date: Tue, 8 Jul 2025 04:25:10 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: rzn1_a5psw: add COMPILE_TEST
Message-ID: <202507080426.3RX5BOHi-lkp@intel.com>
References: <20250707003918.21607-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707003918.21607-2-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.16-rc5 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-dsa-rzn1_a5psw-add-COMPILE_TEST/20250707-130922
base:   net/main
patch link:    https://lore.kernel.org/r/20250707003918.21607-2-rosenp%40gmail.com
patch subject: [PATCH 1/2] net: dsa: rzn1_a5psw: add COMPILE_TEST
config: alpha-kismet-CONFIG_PCS_RZN1_MIIC-CONFIG_NET_DSA_RZN1_A5PSW-0-0 (https://download.01.org/0day-ci/archive/20250708/202507080426.3RX5BOHi-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250708/202507080426.3RX5BOHi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507080426.3RX5BOHi-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC when selected by NET_DSA_RZN1_A5PSW
   WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
     Depends on [n]: NETDEVICES [=y] && OF [=n] && (ARCH_RZN1 [=n] || COMPILE_TEST [=y])
     Selected by [y]:
     - NET_DSA_RZN1_A5PSW [=y] && NETDEVICES [=y] && NET_DSA [=y] && (OF [=n] && ARCH_RZN1 [=n] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

