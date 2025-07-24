Return-Path: <netdev+bounces-209575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350EB0FE40
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2121CC710B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B314502A;
	Thu, 24 Jul 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYmR6lJb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB517BA9;
	Thu, 24 Jul 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318067; cv=none; b=FrEoph269vW2dTSM3+sNn86u3BkksX4QV4JZXCWdBm5hxSh/2F/TfFY+8gqfAxM3BizRJYcigJ21wPvMDaJpnV96/SLGPLJf1ufu5eeTTLnz9wLfSFB8s/2H65gJFse/ewbQSA668f+QRXPMJCz4tLcDLrLM2J39UXIplwugXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318067; c=relaxed/simple;
	bh=BmMmbppmGyaXZsmxkGbnEXQFP5vbfJ1gnIi9OAhLHlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4cpvrleBEDe1oteOEVNZyf8Nsm3v0iMRZpdYHO/AL7d8TjV+NCIxXNWml3o05vV0VT4UpPI9hdXZuB8ZCaJ2wZk5TwFAYap0uUPAGx6IkK4PrFonsNJaIoUi4dFOqReFfdRZ8+RqH0nEBP7WfKRlGbmylGhnKORBAE2n5fqfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYmR6lJb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753318066; x=1784854066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmMmbppmGyaXZsmxkGbnEXQFP5vbfJ1gnIi9OAhLHlc=;
  b=QYmR6lJbtDiNOXgy+WtcaeKMYVBI0OYa1JSb7r1ldxo2f/A5JT5KFYo9
   tL3T0oI9JjklF9x74n0bGv2eCEnjDK97plis1zNLhz2g1jKDN8US7QIHt
   7P2LBEqAzvriyfPQJ9PtK/2QTr13xnl+6NEk1x3NkJ8n+FyXQBEzb2+74
   VWIJHGYH2wOb7dFae5BU+seINBG779k70ks9Yysh6KBdy1amBfKzuHIaL
   nAijXdnk9VO8gfUnqmD/1tL/X4VOAck2DoGyjwhq1xqKPJ5kyQVPSwN4R
   Dp1oafEwCvH9dLDTRUVA85G48quq0Z1lpgE0W2I3P+AKrJxXhyh88GL1P
   A==;
X-CSE-ConnectionGUID: yRRjJthsTfCZu7P5tzA3IQ==
X-CSE-MsgGUID: 42bH1MjlROWVSUL5ZdGyCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67043685"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="67043685"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 17:47:46 -0700
X-CSE-ConnectionGUID: kQ0H7RmCT/684unnTbWIxw==
X-CSE-MsgGUID: /RXN2o4wSUGRTQkIqVRPBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="163990975"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2025 17:47:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uek7Y-000Jxd-2p;
	Thu, 24 Jul 2025 00:47:40 +0000
Date: Thu, 24 Jul 2025 08:46:55 +0800
From: kernel test robot <lkp@intel.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, git@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vineeth.karumanchi@amd.com
Subject: Re: [PATCH net-next 6/6] net: macb: Add MACB_CAPS_QBV capability
 flag for IEEE 802.1Qbv support
Message-ID: <202507240825.lVN6sSiB-lkp@intel.com>
References: <20250722154111.1871292-7-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722154111.1871292-7-vineeth.karumanchi@amd.com>

Hi Vineeth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vineeth-Karumanchi/net-macb-Define-ENST-hardware-registers-for-time-aware-scheduling/20250722-234618
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250722154111.1871292-7-vineeth.karumanchi%40amd.com
patch subject: [PATCH net-next 6/6] net: macb: Add MACB_CAPS_QBV capability flag for IEEE 802.1Qbv support
config: parisc-randconfig-r131-20250724 (https://download.01.org/0day-ci/archive/20250724/202507240825.lVN6sSiB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250724/202507240825.lVN6sSiB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240825.lVN6sSiB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/cadence/macb_main.c:282:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bottom @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/cadence/macb_main.c:282:16: sparse:     expected unsigned int [usertype] bottom
   drivers/net/ethernet/cadence/macb_main.c:282:16: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/cadence/macb_main.c:284:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] top @@     got restricted __le16 [usertype] @@
   drivers/net/ethernet/cadence/macb_main.c:284:13: sparse:     expected unsigned short [usertype] top
   drivers/net/ethernet/cadence/macb_main.c:284:13: sparse:     got restricted __le16 [usertype]
   drivers/net/ethernet/cadence/macb_main.c:3645:39: sparse: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3650:39: sparse: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3655:40: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3655:69: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3680:20: sparse: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3684:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] w0 @@     got restricted __be32 [usertype] ip4src @@
   drivers/net/ethernet/cadence/macb_main.c:3684:20: sparse:     expected unsigned int [assigned] [usertype] w0
   drivers/net/ethernet/cadence/macb_main.c:3684:20: sparse:     got restricted __be32 [usertype] ip4src
   drivers/net/ethernet/cadence/macb_main.c:3694:20: sparse: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3698:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] w0 @@     got restricted __be32 [usertype] ip4dst @@
   drivers/net/ethernet/cadence/macb_main.c:3698:20: sparse:     expected unsigned int [assigned] [usertype] w0
   drivers/net/ethernet/cadence/macb_main.c:3698:20: sparse:     got restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/cadence/macb_main.c:3708:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3708:50: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3714:30: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3715:30: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3722:36: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3723:38: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3726:38: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/cadence/macb_main.c:3762:9: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/cadence/macb_main.c:3762:9: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/cadence/macb_main.c:3816:25: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/cadence/macb_main.c:3816:25: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:5352:42: sparse: sparse: Initializer entry defined twice
   drivers/net/ethernet/cadence/macb_main.c:5353:10: sparse:   also defined here

vim +5352 drivers/net/ethernet/cadence/macb_main.c

  5348	
  5349	static const struct macb_config versal_config = {
  5350		.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
  5351			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
> 5352			MACB_CAPS_QUEUE_DISABLE, MACB_CAPS_QBV,
  5353		.dma_burst_length = 16,
  5354		.clk_init = macb_clk_init,
  5355		.init = init_reset_optional,
  5356		.jumbo_max_len = 10240,
  5357		.usrio = &macb_default_usrio,
  5358	};
  5359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

