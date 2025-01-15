Return-Path: <netdev+bounces-158591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72026A129C3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DDD7A1C90
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC219CC2A;
	Wed, 15 Jan 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CimIxMIY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4918E057;
	Wed, 15 Jan 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961848; cv=none; b=hkc7ZUKxslNQtxvgUvjQZGGWj113w5Ho8T8+46EAd3b66YglTOyrR9rUNttUJx2MG9+uokMojRDWvBcETVFsgk5DkVDLOzy760fjgPJzzmwfJDKCWXpfJMXWClyHNAQJFyndid/RuFM7zDLkcTIgz66AUfJamgenDhB75//xBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961848; c=relaxed/simple;
	bh=PetJo8Be1KiEEulVJDWE9X2rE6cvcMh747nUEylv704=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSTJc79UJ83lzXVjh5Dmc3j1iSt2B3SDnq2lBGvA7IYvHqZtDKzsoj6Qw1GoDJBmS0LuvVr2bwoyZ8pOpYEpSM07ZCmFaShNT6o4eO3g40ZDP+xXa8z1Lp9KMqZY3TbQjiUXbmbIbyadOVEjsjhHNoyakF4M9eod44Qi1XS3pRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CimIxMIY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736961845; x=1768497845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PetJo8Be1KiEEulVJDWE9X2rE6cvcMh747nUEylv704=;
  b=CimIxMIY90FkNKhToWDENoPdJP6Gqn9kW3fWmRMt+W3E/4wWFPZL27Gj
   dMJpNHXZIuIyrXEWDxkfybFBKvc4Wrrl5PRUYNbwN0IOqqnETKkLms1bF
   YIs/3alk4dLx9Ph6ryxr6MLpT1YkPtGy4GF3hQAQaIpfod2+dUXz3aQri
   hzhZxzKQZoabg006OFOoXojNyaOQfKXG+v1YahHE4sV/h5ZyIOP5HJm0W
   HY204IlpApVqm92N2M6+F46ArnCeQmQhbUcfUe58DiJwhYmkRNPePTFyL
   Z7LwlZ1u88iDts40coCnNPVVzqPTINrDhev0zwmUEzi1p3TX7S/ksvTAs
   w==;
X-CSE-ConnectionGUID: se2cCYBMSxGB+8ZiZCpN9A==
X-CSE-MsgGUID: knasSs+uSkiereQhI+Bm1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37538856"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37538856"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:24:04 -0800
X-CSE-ConnectionGUID: 4p9P0zNxRVWhlm0PwgmnzQ==
X-CSE-MsgGUID: j6BNgqSuTEeTYOLm8tO0YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106058260"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Jan 2025 09:24:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tY77W-000Qel-08;
	Wed, 15 Jan 2025 17:23:58 +0000
Date: Thu, 16 Jan 2025 01:23:14 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <202501160112.KjQc3mDq-lkp@intel.com>
References: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7d0da8f862340c5f42f0062b8560b8d0971a6ac4]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau-via-B4-Relay/dt-bindings-net-dp83822-Add-support-for-changing-the-transmit-amplitude-voltage/20250113-134317
base:   7d0da8f862340c5f42f0062b8560b8d0971a6ac4
patch link:    https://lore.kernel.org/r/20250113-dp83822-tx-swing-v1-2-7ed5a9d80010%40liebherr.com
patch subject: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing the transmit amplitude voltage
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250116/202501160112.KjQc3mDq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160112.KjQc3mDq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501160112.KjQc3mDq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/dp83822.c:207:18: warning: 'tx_amplitude_100base_tx' defined but not used [-Wunused-const-variable=]
     207 | static const u32 tx_amplitude_100base_tx[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/tx_amplitude_100base_tx +207 drivers/net/phy/dp83822.c

   206	
 > 207	static const u32 tx_amplitude_100base_tx[] = {
   208		1600, 1633, 1667, 1700, 1733, 1767, 1800, 1833,
   209		1867, 1900, 1933, 1967, 2000, 2033, 2067, 2100,
   210	};
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

