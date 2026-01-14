Return-Path: <netdev+bounces-249867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89357D1FE88
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88494300A782
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4739E6EF;
	Wed, 14 Jan 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPIrzyM+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222D39E6C2;
	Wed, 14 Jan 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405205; cv=none; b=AN3DSejkH7T7F1ItnwdG98QOwvbQ7nvWSMsr4W5/9BeeGLBBcDFkB/xs3mYbd/LVI9oGxe8grivoyREJOZ3mbV3tWEEg08/7OmhdE+SVj5doRosiubBHcbUp7MT3u+iq2fSXygdEsHTO0bhTdS55W8d1hPWzXThxBexQ+1H94AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405205; c=relaxed/simple;
	bh=YtJUauv1Cw27xxlVauAE+YEqBi1wz01WVrhktnBdEBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7uamACKBvELOzr+9LnEmzwYrO9pye+mozhHrQZ5PVjpdYaDZPqlrVRSDt4SXKZjKEe3+ZHcTwga7laZYkyfjqtizfpYXfuZwnuYQM1ZrbOWc/54Hw+2m3V+vAr6hHE3l9twZCHRiTKqDMtrXoaGe2DrKjXy1/d9Urh0tl9nxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPIrzyM+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768405202; x=1799941202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtJUauv1Cw27xxlVauAE+YEqBi1wz01WVrhktnBdEBE=;
  b=RPIrzyM+BlOlsOaphwkWAEu3DTkKKbgLHryxUy6SxeCZUFxfuCOogwY5
   gaH6bz6aHniGTbpgA6Vs/OjYy5Xk2/o63gKPlh7MgGlM1T1tBQHn63U1t
   lxmCKrdc8+gQzIWYt8uQ28/KgW2nY163aEJ7cJpUFSQ36Dgjb+DwkyJ0f
   d+S6Tv4DXoxexE6yMUguekzMUemAX/4wRO3KUgjhzS5GaYMvO5lL54qhm
   4lXaDFxAUztT6RPozfMPs2Dd7b7tg7xgBwiGCjBZS5Pp+prg5eHTirzoX
   Z+PWtvTbGZWbvcVISCoF2jGV0jhbyNSH4+beZHWXhUD7Twx+a2yWQmwE1
   w==;
X-CSE-ConnectionGUID: ANi0ROZ5Q0GwMKOi830qwQ==
X-CSE-MsgGUID: 4SX/Q4QIRYifyF3Wo51oaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69791868"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69791868"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 07:39:59 -0800
X-CSE-ConnectionGUID: VSPdVfSCRamKaF3FSy+c/A==
X-CSE-MsgGUID: FUF3sQHyTnCm/05iHIZarA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235965159"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jan 2026 07:39:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg2yP-00000000GYy-34PK;
	Wed, 14 Jan 2026 15:39:53 +0000
Date: Wed, 14 Jan 2026 23:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	sgoutham@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Message-ID: <202601142356.TWrRByBh-lkp@intel.com>
References: <20260114065743.2162706-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114065743.2162706-3-hkelam@marvell.com>

Hi Hariprasad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hariprasad-Kelam/octeontx2-af-Mailbox-handlers-to-fetch-DMAC-filter-drop-counter/20260114-150046
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260114065743.2162706-3-hkelam%40marvell.com
patch subject: [net-next 2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260114/202601142356.TWrRByBh-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601142356.TWrRByBh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601142356.TWrRByBh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:31,
                    from drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:22:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h:30:40: warning: 'otx2_trap_groups_arr' defined but not used [-Wunused-const-variable=]
      30 | static const struct devlink_trap_group otx2_trap_groups_arr[] = {
         |                                        ^~~~~~~~~~~~~~~~~~~~


vim +/otx2_trap_groups_arr +30 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h

    29	
  > 30	static const struct devlink_trap_group otx2_trap_groups_arr[] = {
    31		/* No policer is associated with following groups (policerid == 0)*/
    32		DEVLINK_TRAP_GROUP_GENERIC(L2_DROPS, 0),
    33	};
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

