Return-Path: <netdev+bounces-218499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA23B3CC1E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB577AF77D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD2257834;
	Sat, 30 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdaxGnq2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B022A817;
	Sat, 30 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756568502; cv=none; b=gGzfNa1s754emDh1mMsKe2m7/MCM6uWJZuwaCeHSh/c6UwhCwnRhcYJ7BxqCdNZ5th+bpOoVhMI9N6/SNS1/r3jZgceuDocEkXhWIqEjBrwb39fXajsMnu1Bk7TgX8QP1mK4gI2Fw0cn+Db7J1QMSw1TSxSw9uJqus/9Kc1HO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756568502; c=relaxed/simple;
	bh=+iRaXVzECcvXTDXDtnzHEgBKOBeHUhWKVoYey/7sHQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyBOdYvdl4eoSZrx4WHZqFu1R5Rglb98zUVvEVIS/WcvxmKzl2hbffgzMnS4Kqvy+YHlFn9Y3ZoTrWon8apbg7/nFyR+HkovEVZ8tpAMhx0lrygCSl5rqX4jjEL8baCKwoOv7snkEmFNrPLaUMTkc0mgV9HIVIFIC2/KyfO4BQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdaxGnq2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756568501; x=1788104501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+iRaXVzECcvXTDXDtnzHEgBKOBeHUhWKVoYey/7sHQA=;
  b=YdaxGnq2ce3gkLM6+OdRWKTIcfk9AqhMsLTFCuikvJuwvq+G41xm52fh
   hXVdTeZGqgVASDlBLPf9PUvlGx1SCOIGUZDshVv7MZJaR7h3aY42FkrQy
   ukv10GsxtKC6vM7MVK7ODEg2BNg4NtfOgn15srUq12vGMHSgQ31pPM1Mx
   jiXvF3aCwSKHnhGMxVUNMK8tuq2nHa2RMBAdWs/3LE2VDwq0L1pYJgLMC
   Xoj+o9V9Vcv72bjbz1/2Nohh2GGCtOvhMPqz9BE21XJSUuWceVx6Y2WjG
   jmSGqlki/ocGzlmEVlXM/Wis95irAdtfm/23aP/mJmdDLaEe9w2Y3b2ga
   w==;
X-CSE-ConnectionGUID: 4fkOMggfTECT00BKJNlyGQ==
X-CSE-MsgGUID: vPmtQ51pTnqdeRYJ8oClzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58933705"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58933705"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 08:41:40 -0700
X-CSE-ConnectionGUID: 2BBGvx6DQ/eEQNu3xubSNg==
X-CSE-MsgGUID: fPRSJ2fiRj+oowIs6XSrxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="169912325"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 30 Aug 2025 08:41:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usNhi-000VT3-2q;
	Sat, 30 Aug 2025 15:41:26 +0000
Date: Sat, 30 Aug 2025 23:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
Message-ID: <202508302350.uP3JO7bq-lkp@intel.com>
References: <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/arm64-dts-ls1043a-qds-switch-to-new-fixed-link-binding/20250830-183341
base:   net-next/main
patch link:    https://lore.kernel.org/r/fe4c021d-c188-4fc2-8b2f-9c3c269056eb%40gmail.com
patch subject: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new fixed-link binding
config: arm64-randconfig-002-20250830 (https://download.01.org/0day-ci/archive/20250830/202508302350.uP3JO7bq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project ac23f7465eedd0dd565ffb201f573e7a69695fa3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508302350.uP3JO7bq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508302350.uP3JO7bq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts:212.3-33 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

