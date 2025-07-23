Return-Path: <netdev+bounces-209152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE3B0E7AF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53996C5745
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0001624DD;
	Wed, 23 Jul 2025 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKN2bJrx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6E15B0EF
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231568; cv=none; b=L6jhDaisIWsE2EnMCesV998iEeYAG4FC9tI4vqz1qMhXsMETmMMLrDWcjMcn9H6vC5YdYw3NgVXxr7b3mJji5xPkwZgsel2MY3dqmZoxobjXcfdpmsoAc68VTMLQa6JSWlP3fk1iXlycW8BRjb+NdwEtiEFEBvqrSC5zE6cRefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231568; c=relaxed/simple;
	bh=7XyjFlMsulsdWRKzxiiAS8MziCD9vuAz5vMiVUvsDrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR44QBq5hTGmFMsuEfnncpxcvgZshrB28cnlo9IbSoV8FqL+nPMYKu/aLBmR+UmgB3XCTX4AO+5oxSts/C34LP9ns6XxqTIwRDibca+icZ2vqmYD8TjVeqOgO9gMmYvoA/30gSLUk/5+sJrtxhYbYd/Rqh7Oo5c5n0zvTHrYiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKN2bJrx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753231566; x=1784767566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XyjFlMsulsdWRKzxiiAS8MziCD9vuAz5vMiVUvsDrE=;
  b=nKN2bJrxdNaJkUvx8vjtW2LE8vtdY4WlD1dAvDEdys4jziVKbtwVYgD8
   5CDt21dvY8BGVlhZ234nyOvZWJ4Pzgehij3P71azQ6Kd3VaMssxW1bNaL
   vrUwIhUUFQoqQs0JwVgV0VJoJahV0DCtwbSWiTye9pbEh8hawqn6niv3K
   s1OiuOwN3zxPcWWAABP2Af5igCaFtHUcekGIx/lRazAp8NmLjff1ML/Hs
   oL1iYfkSuvVDkZm6hNqp6EucN1Kvkp6InPlNZyZncIlLjRusea9AReHf9
   9s+L14KeXhM39bkFzxdGQtMrUFe82m8en1+iDrdbevCPrgMkUC4Jw5ZIh
   g==;
X-CSE-ConnectionGUID: oaCtHnARRuWf7F2J+xWIVw==
X-CSE-MsgGUID: 81GQKCtHTEKAoX90RykS4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73071000"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="73071000"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:46:06 -0700
X-CSE-ConnectionGUID: gP2NMNzdQ0qN6ZacAGwNYw==
X-CSE-MsgGUID: S+cN/JPRQpSdoF+7BjI3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163521129"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Jul 2025 17:46:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueNcP-000IpX-1p;
	Wed, 23 Jul 2025 00:46:01 +0000
Date: Wed, 23 Jul 2025 08:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 15/15] ixgbe: fwlog support
 for e610
Message-ID: <202507230823.PGjL5fXz-lkp@intel.com>
References: <20250722104600.10141-16-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722104600.10141-16-michal.swiatkowski@linux.intel.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Swiatkowski/ice-make-fwlog-functions-static/20250722-191011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250722104600.10141-16-michal.swiatkowski%40linux.intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v1 15/15] ixgbe: fwlog support for e610
config: powerpc-randconfig-002-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230823.PGjL5fXz-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230823.PGjL5fXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230823.PGjL5fXz-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "libie_aq_str" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
>> ERROR: modpost: "libie_aq_str" [drivers/net/ethernet/intel/iavf/iavf.ko] undefined!
>> ERROR: modpost: "libie_aq_str" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
>> ERROR: modpost: "libie_get_fwlog_data" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
>> ERROR: modpost: "libie_fwlog_init" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
>> ERROR: modpost: "libie_fwlog_deinit" [drivers/net/ethernet/intel/ice/ice.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

