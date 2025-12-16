Return-Path: <netdev+bounces-244891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF81CC1013
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1037030620CD
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0833555C;
	Tue, 16 Dec 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP3rRXs0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39383299952;
	Tue, 16 Dec 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862425; cv=none; b=DbpeCOGKrDj0Qsa+XzCJhiogXc5Am9ITVfsPF2W7nFLCkCns2go3Gg4Qf1zRwjW3eHn2L646jP0N3HIbJKOUSu1FFKBCQcBJTUD5eu2PtpsmEocckVEpfjXX7ysZC1NXOAe6Qm7SRJ+7HE00CilpzKMQYqJu0RD4PTKVvwMvdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862425; c=relaxed/simple;
	bh=xE1dhCsdlPenvPb/QwLxKPIL9ggriBZhbOJquY4jLUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqYli5GScT+3YRKfrRGG9ooIJnQr7ocGlxqpAh5fk8VQY2RiFuc67HDrwYSx3jo+Vn2dZi0/xVWFiYOaF/19CzFVQVQ/LOpB6xXoFQAPAocaLi0FouXDtd60PPJEQ6m9eWTJiCySzzVeNs3lqHZ58JTGUkKRKOLeLk4ZCFp5jfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP3rRXs0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765862419; x=1797398419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xE1dhCsdlPenvPb/QwLxKPIL9ggriBZhbOJquY4jLUA=;
  b=YP3rRXs0wsNKx3febgHHBc5RII179CL1TtcbicO+asJOaJtD/3wkrV2a
   iJ4r4bIuyWtZC8kyO8/2TIgGUZp0ZaEqq9gvIH4NQSApctbm/KGconbW0
   vwK8H8/MQYL4uiq+3dC/JQlaHGkSyd6QMQemI0QbP5jBU7YWdeySoV7sX
   OnzWNT9oZ93z4keVFB3Dx1Vg1TRjdKUP1y3lln+dG2RrgknnXnwmhKhs3
   wvl76wPzNCLHwJcd7pyEZVT1cz/t5zP/ttjVKguq50XbE5/rgIS67z3zX
   AwrXFGOED5DtG4Yt70eNynyVl1Ac+6N2OurYvjwNv3jmTH0DCCx7k++aO
   w==;
X-CSE-ConnectionGUID: cbiJsu2ZTrqP7SA5KzlPAw==
X-CSE-MsgGUID: cwmL92HGTtW7sRo5/l3GWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71404177"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="71404177"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:20:14 -0800
X-CSE-ConnectionGUID: rNZx0CiUTtCYXIYnN27CqQ==
X-CSE-MsgGUID: Wsb/7tfDR4q+03zf9hrv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="197811430"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 15 Dec 2025 21:20:12 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVNTm-0000000031U-2s3b;
	Tue, 16 Dec 2025 05:20:10 +0000
Date: Tue, 16 Dec 2025 06:20:03 +0100
From: kernel test robot <lkp@intel.com>
To: Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dharanitharan725@gmail.com
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <202512160610.CtwITAzk-lkp@intel.com>
References: <20251210053104.23608-2-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210053104.23608-2-dharanitharan725@gmail.com>

Hi Dharanitharan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharanitharan-R/team-fix-qom_list-corruption-by-using-list_del_init_rcu/20251210-133429
base:   net/main
patch link:    https://lore.kernel.org/r/20251210053104.23608-2-dharanitharan725%40gmail.com
patch subject: [PATCH net v2] team: fix qom_list corruption by using list_del_init_rcu()
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251216/202512160610.CtwITAzk-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160610.CtwITAzk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512160610.CtwITAzk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/team/team_core.c: In function '__team_queue_override_port_del':
>> drivers/net/team/team_core.c:827:9: error: implicit declaration of function 'list_del_init_rcu'; did you mean 'hlist_del_init_rcu'? [-Wimplicit-function-declaration]
     827 |         list_del_init_rcu(&port->qom_list);
         |         ^~~~~~~~~~~~~~~~~
         |         hlist_del_init_rcu


vim +827 drivers/net/team/team_core.c

   820	
   821	static void __team_queue_override_port_del(struct team *team,
   822						   struct team_port *port)
   823	{
   824		if (!port->queue_id)
   825			return;
   826		/* Ensure safe repeated deletion */
 > 827		list_del_init_rcu(&port->qom_list);
   828	}
   829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

