Return-Path: <netdev+bounces-196713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62843AD6076
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419261BC1F33
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB32BFC7B;
	Wed, 11 Jun 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F59lHlMM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096B2BF3C7;
	Wed, 11 Jun 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675460; cv=none; b=cXg+E2nkoocZI6P2o/zhiwp2868KoHdLeQhg8M1AyoDkB+cWzpmauu6ZMTsgBK5uMXUFX7fSQQbeQ1yFnK/J6bLjfJrI3Ii2w2cn7x73z1J3q3qCIXsHTHpa5FArLpKv+nMDt5D+1aFuspYIilSbS6KGESj1yJfalKqjeui0BlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675460; c=relaxed/simple;
	bh=dWBcdnJcsF1wZyPPcP5u/i5J0eHQX2+KLoffvskyitU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIcwcs8enuty8gVfT5E8nn9YkrQVLb3AZ/BFh3OMQh54s3v5iVn7rJyZ5QmU5zOHVTNBatv4RYmacZ/6GZeXbFI/xxtx7VlsqP+XXLMj8KvLmByye47R6p24LMN0Sx+odKFDCsuL3Ae7mjHmp8Zf8n3p+5j03ELtN3r5LgqFN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F59lHlMM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749675459; x=1781211459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWBcdnJcsF1wZyPPcP5u/i5J0eHQX2+KLoffvskyitU=;
  b=F59lHlMMV/A+y7olCRBcQILSBn9OH3xcCABpimxcKrIuXKQG/+ReAMcP
   kXLUCGN6u6i8yb1+Q5xbYI0mTBSXmEaf6orN/5qVhCbziB9WU0uJ/hw1m
   fJL50vy+cXAlPomcIrfvLGrG3YynU5CK0aDX2grN/7b6Z5kUEYFcMiyIc
   M4NKu8ivrnKLpOWansAtBObackRXLYGkaiG2MQc6w2HUXqjqVS04hTDvk
   c9PFErAQ8EtuwLSBAk7Vv1t/dHLsuH8LdQMnq8fytQMTgJo22R5OYt8ji
   0wVmER8hhtueTSxDxOkYFpR9LQDhdlNB9EuRBmLw/PGMruH344FDfr+/2
   w==;
X-CSE-ConnectionGUID: qqM+pOvbQN2rd5u2TLpFVA==
X-CSE-MsgGUID: ezncE7xbQh28PVOKplrong==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51931386"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51931386"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 13:57:38 -0700
X-CSE-ConnectionGUID: wueuEkXlQKapcrFcczwfJA==
X-CSE-MsgGUID: s3VAqUaqSlmh/sgJgx5fHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147178731"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Jun 2025 13:57:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPSVm-000ArO-27;
	Wed, 11 Jun 2025 20:57:30 +0000
Date: Thu, 12 Jun 2025 04:56:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <monstr@monstr.eu>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH v6 07/10] net: axienet: Convert to use PCS
 subsystem
Message-ID: <202506120442.emFFyhZj-lkp@intel.com>
References: <20250610233134.3588011-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610233134.3588011-8-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250611-143544
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250610233134.3588011-8-sean.anderson%40linux.dev
patch subject: [net-next PATCH v6 07/10] net: axienet: Convert to use PCS subsystem
config: alpha-kismet-CONFIG_OF_DYNAMIC-CONFIG_XILINX_AXI_EMAC-0-0 (https://download.01.org/0day-ci/archive/20250612/202506120442.emFFyhZj-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250612/202506120442.emFFyhZj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120442.emFFyhZj-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for OF_DYNAMIC when selected by XILINX_AXI_EMAC
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
     Depends on [n]: OF [=n]
     Selected by [y]:
     - XILINX_AXI_EMAC [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_XILINX [=y] && HAS_IOMEM [=y] && XILINX_DMA [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

