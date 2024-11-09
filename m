Return-Path: <netdev+bounces-143489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB569C29B9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F41C212B9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579E45025;
	Sat,  9 Nov 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dddN6YZG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D841C71;
	Sat,  9 Nov 2024 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123155; cv=none; b=FQwv9rlAUFaxPd7i9Laxt5lcLibcfme/9Qz44bb3JclirJ0TXeNfU3/ruPDm22y/tSlJj7wuz3a0MPRedrW9CsGf4htAcaOTxAgUxBMITcUFeNDqEdOaEruYHPz0mhCZ5mRnCqtZoLThO7/PnMpSCTvqLloCBzxWoGOcQlgoXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123155; c=relaxed/simple;
	bh=iX8z5vSDUfXMzYpuOkFFCHP72QrDyyxGk1LtH/8Si4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNfck457pl5Ol+fkOXLQ84ShLFac6LAbLwHHpBstltiht9Sg+Tf0pSzxgzlzvsFm969I+v/SItGqVF4XMnfN22KiVjg6O+XfcVr0o94idb8YYxUASYAxE9mqHappw0eJ2WOHwiHKXH9gDhjfiG0j6h6rFZk+obs/0BkdxO9pVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dddN6YZG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731123154; x=1762659154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iX8z5vSDUfXMzYpuOkFFCHP72QrDyyxGk1LtH/8Si4M=;
  b=dddN6YZGF/8xS2SbQgGMczCpFlSnNTJCBzAv74bv7omEEe8YcH8Z6V1I
   7NT8MxGWQ5q4A168J7E0rRrpw4nHKiI8T1Ay+JQ07uUPkksQNnb1deXzi
   lHrNnJG2MDytl2GFiuBGWFW2g75ZvyKZX2iQkoYuvXNINt+NnHnXEJNlB
   cDifsMHTvN+RFjYxNA60HQY/T71jIecXJyZavNSSp/eHCb1sWQd1VoFuJ
   DkcY2kAEORltkVbCywgb4jCCYJuSuaylZnqmG74xTtW3thwZ19kFN6gDM
   61Sd/b1XUZyy6YnJsmUBuAAd8WkG00wHZpP1Ba4KYvxjLz7RKyAzYrUY9
   A==;
X-CSE-ConnectionGUID: PFZ3n2EtTb2gsF7FJXs6ew==
X-CSE-MsgGUID: QQ7mPcIKRoaLMovIUXTNUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30430008"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="30430008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 19:32:33 -0800
X-CSE-ConnectionGUID: gaCnG3htQw6vfA26fFr3WQ==
X-CSE-MsgGUID: kTKDfe4OQy+UmGtj/G43AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="123364173"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2024 19:32:30 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9cD5-000s2I-3C;
	Sat, 09 Nov 2024 03:32:28 +0000
Date: Sat, 9 Nov 2024 11:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
Message-ID: <202411091122.phMAmman-lkp@intel.com>
References: <20241108200217.2761-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108200217.2761-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-dsa-add-devm_dsa_register_switch/20241109-040405
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241108200217.2761-1-ansuelsmth%40gmail.com
patch subject: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
config: i386-buildonly-randconfig-001-20241109 (https://download.01.org/0day-ci/archive/20241109/202411091122.phMAmman-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411091122.phMAmman-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411091122.phMAmman-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/cc81Xoq7.s: Assembler messages:
>> /tmp/cc81Xoq7.s:10: Error: symbol `__export_symbol_dsa_register_switch' is already defined

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

