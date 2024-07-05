Return-Path: <netdev+bounces-109325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6B927F55
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2F72834F1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510E139E;
	Fri,  5 Jul 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJqFuOe/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045D17F5;
	Fri,  5 Jul 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720139083; cv=none; b=hYGLnzE7nBk1u/DS4++uSjLnEC44MAsSQg1qyNWUYBPu0sh+b6uixt6C3WsSUdM3y+HOO+O/ax2JjcLaDr+cm6uUjTiBXtBVyNNU/HYQL4Hly4XruHFg/JHUrsEBK3AHz8niL9url9kjY/nHTUjkKXTy4aem+wziNymYtn23BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720139083; c=relaxed/simple;
	bh=jMgU/ldtR+ELFwjG824hgDWZhrXbeGkg9FUM7GIABp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikd40MTpEPds0m3AgdORw2AxAFwn6dJKz/NBZNRoY0YClmPLV1qClztQlApLYjP22u2DkFxJGL0mkHeMA9M7N/5l4Ze9VScmZIIXc+SKLRzmy9Gtt0+NXXullTlMdQLxjET5idwpmIvgSS4wi1dZhSzF5XZtbRTRk0co5BzL//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJqFuOe/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720139082; x=1751675082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jMgU/ldtR+ELFwjG824hgDWZhrXbeGkg9FUM7GIABp0=;
  b=bJqFuOe/y7i0KIl9m9Nd9VpHkr/E1ABalWF5V6QLD5NIHFkil9SxF4YU
   tqmtxJ8Oc9sf+KZ9Gp2ZqlfoeEb/CO2xxuMnLN1/iE/kUXu1JDdGMSXbj
   WmnN05u+fiFusQTvVoZAEHy0KN2xuVHq3ds3Ljr4UyhqlB34BUYrg0WH1
   4GHgQBuYWqjUGPNJs4wmTfkUqvW3Ez+y1DJla/45xTBCz3J8HrNXlMUwA
   g9UD0JEtdAqea8ZNi4isaYjGfeZUthgk06qPVQlNQ7f4zqd6X58H9tE+f
   VqSfqhsEnZveC7jdA6biu8MReb31GAQhHvNUIHzaHokTFIEOjEwxkZsHH
   w==;
X-CSE-ConnectionGUID: 2KmN6b56SkWR/z0OznOWVQ==
X-CSE-MsgGUID: nMxPpuY6R7Spnk12ZFEFqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34966790"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34966790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:24:41 -0700
X-CSE-ConnectionGUID: tUE5TypWSZehOIoWstmt6Q==
X-CSE-MsgGUID: UtUTH6htRceS04V0IsWpYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47158352"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Jul 2024 17:24:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPWkc-000Rgq-1f;
	Fri, 05 Jul 2024 00:24:34 +0000
Date: Fri, 5 Jul 2024 08:23:53 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, willemb@google.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	dwaipayanray1@gmail.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	linux-kernel@vger.kernel.org,
	Igor Bagnucki <igor.bagnucki@intel.com>, joe@perches.com,
	edumazet@google.com, netdev@vger.kernel.org, apw@canonical.com,
	lukas.bulwahn@gmail.com, akpm@linux-foundation.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ice: add Tx hang
 devlink health reporter
Message-ID: <202407050857.OSYEyokn-lkp@intel.com>
References: <20240703125922.5625-4-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-4-mateusz.polchlopek@intel.com>

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Polchlopek/checkpatch-don-t-complain-on-_Generic-use/20240704-184910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20240703125922.5625-4-mateusz.polchlopek%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ice: add Tx hang devlink health reporter
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240705/202407050857.OSYEyokn-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407050857.OSYEyokn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407050857.OSYEyokn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/devlink/devlink_health.c: In function 'ice_tx_hang_reporter_dump':
>> drivers/net/ethernet/intel/ice/devlink/devlink_health.c:76:43: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      76 |         ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)event->tx_ring->dma);
         |                                           ^


vim +76 drivers/net/ethernet/intel/ice/devlink/devlink_health.c

    60	
    61	static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
    62					     struct devlink_fmsg *fmsg, void *priv_ctx,
    63					     struct netlink_ext_ack *extack)
    64	{
    65		struct ice_tx_hang_event *event = priv_ctx;
    66	
    67		devlink_fmsg_obj_nest_start(fmsg);
    68		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
    69		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
    70		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, vsi_num);
    71		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
    72		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
    73		ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
    74		devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
    75		ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
  > 76		ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)event->tx_ring->dma);
    77		devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
    78					     size_mul(event->tx_ring->count,
    79						      sizeof(struct ice_tx_desc)));
    80		devlink_fmsg_obj_nest_end(fmsg);
    81	
    82		return 0;
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

