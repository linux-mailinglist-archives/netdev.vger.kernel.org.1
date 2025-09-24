Return-Path: <netdev+bounces-225941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E389B99A16
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29A84A7A82
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391A2FF141;
	Wed, 24 Sep 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3WjJ9bX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9C2FE04C;
	Wed, 24 Sep 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714290; cv=none; b=CrQhX8QUW9qIfXpJkVuJwex7XBlf39IvxiVS6eedSi59yC4TE9cPScMgXKplvzuwa63nG6W1bsXxR4+z5hElFWIHLAMUiOstDE51KAxmMilfIacHZyl1PHXp78BKFPIN/pkaJ1hfsxOXsFhJv8+zyoFbJoyrmfCOG1nTJqagBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714290; c=relaxed/simple;
	bh=2r6nKLaH2V7Wgf0Cze0yBmmog7bds/FSzcDmhG9RCdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkVZD2R9nzyobQCtfND7g44oSpYzAiNWrxPE05mAwciyvVBFYvUgqiQTOdIif/zrjeoU3H+4cT+YadglstNFK+S1k2YuV+v4FoHyp5gl7r36kRiJ+eJ4Q+Csuckh5hb7khHfK50EWhsYgR8Ek6WJsRCftf4PdCTndBuj+Mm/xWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3WjJ9bX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758714285; x=1790250285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2r6nKLaH2V7Wgf0Cze0yBmmog7bds/FSzcDmhG9RCdw=;
  b=U3WjJ9bXg59f6THR8LpMwm+LBz2q4w0uQpSHhOwwztHCiH3liyIUKvUY
   bUxwfbN0bWfG9ZdRFkBAsZ61YoVuz2aFPH6DQxaA3TgzjGOtAfXe1W1ug
   29gCzVHXAS6owijIysbdOAhndlNoRLHQaIfdOQkpB+mYKn9QwMsfOgeSy
   +uqnAG5ux5tsykBMcrnG4Q5Cisfvdv6mr0Rr4SxJnvfXTQvVJck4oIP6J
   pbfiODNHHHqUOFJ9sUzCG2CH9eQIoI4tZpU6+/tojX5zVw1j8cOctd9Vi
   fAz1UvwDR5dYYbJecT71Ns0vUBuzfLA+6/goKmdQ9aPBHDwsbRYI0+W41
   Q==;
X-CSE-ConnectionGUID: fzKkyWtAR/2FtbsrpWQ0kw==
X-CSE-MsgGUID: IgKzyFZCRCSoMV5QbBK8gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71685546"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71685546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:44:44 -0700
X-CSE-ConnectionGUID: P4kIzxqYRh2I3ozjgjB3qQ==
X-CSE-MsgGUID: JucmBIuZRCCECjDrpi+MtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="207944954"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2025 04:44:41 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1NvK-00046X-1Q;
	Wed, 24 Sep 2025 11:44:38 +0000
Date: Wed, 24 Sep 2025 19:44:19 +0800
From: kernel test robot <lkp@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, petkan@nucleusys.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: Re: [PATCH net] net: usb: remove rtl8150 driver
Message-ID: <202509241928.kYioHrov-lkp@intel.com>
References: <20250923022205.9075-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923022205.9075-1-viswanathiyyappan@gmail.com>

Hi Viswanath,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/I-Viswanath/net-usb-remove-rtl8150-driver/20250923-102726
base:   net/main
patch link:    https://lore.kernel.org/r/20250923022205.9075-1-viswanathiyyappan%40gmail.com
patch subject: [PATCH net] net: usb: remove rtl8150 driver
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250924/202509241928.kYioHrov-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509241928.kYioHrov-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509241928.kYioHrov-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'drivers/net/usb/rtl8150.o', needed by 'drivers/net/usb/built-in.a'.
   make[6]: Target 'drivers/net/usb/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

