Return-Path: <netdev+bounces-117303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C194D839
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDEC1F204E1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0079166315;
	Fri,  9 Aug 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7SX8q+F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2F15990E;
	Fri,  9 Aug 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236537; cv=none; b=eApAp1WGjnjfYfuhHckVCDp3MrPR/hPePI68fObQeyXejD6+iAlfLd6tBu5mZGRKl0Bj3c/ZD9rhlyTyMj30KV+BXG96wCCkBLSJNeXPMzNxr/OfkgjGqgqB8pofOiZAVP6AmjgZ4yhzAw0MjnA+A3X9I5pWYtQNG7w2+PzASwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236537; c=relaxed/simple;
	bh=yA87GnSUxoe5EK5WMeN2tad9pO+R6wU9Ve37TpigsVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1kX9VfK2gv/eyfJ2cQPNOMdCsSAj+uepr081zD/b2kZ+rgXj18nscw/T56/KeHSkmtMwMxo3zjKGEXK8nOPhDoHttyBSX+HtROnubrqV5C8cv3xnWGT4cQQKH4U8YNA/PYYnX0XCIwlSOWDXR/UQpoyLroTHQG0t64xpShj19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7SX8q+F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236536; x=1754772536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yA87GnSUxoe5EK5WMeN2tad9pO+R6wU9Ve37TpigsVE=;
  b=c7SX8q+FU9vh7+7U0e9nXK921Up2ho/PY8Zok4ugKVjZfMo36R/E6J0h
   F8xJ7rD/ywx9wPQKyEEja1dr0kx5U+fgjNmUuS2sMDF1fiAtQXgTkc6Lp
   AgBn9HNsFGG/mmnbIuFfBmK9rKI+9J3dp8B1sg+2zL1pb6lT7tGMRWZtz
   AxkwyrWQO2q8TDe/h2TgyvXgqH6EEjqLZcmrZkJnuLURvlelnoArmELwh
   1xIMvr3mOCqN+KCjg4u3/bUDPa4+UX9igIg+Bt+7uvUNqbOEBScgHz8ow
   cHkS5jfYLk1SJYmQ1q5RU1plOzYn0iw4xzA4H0WXc4KMivY0EYucluR25
   w==;
X-CSE-ConnectionGUID: 7E9tTQg0Tme85RchV2k1Fw==
X-CSE-MsgGUID: hIdyHWFsQdmg/Bxa3tPHhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21085998"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21085998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:48:55 -0700
X-CSE-ConnectionGUID: Nqg5w6f5SGSlNh+OReOTag==
X-CSE-MsgGUID: o7noeVyjQT+zYL0eAsS2CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="88528654"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 09 Aug 2024 13:48:52 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scWXZ-0009G1-0t;
	Fri, 09 Aug 2024 20:48:49 +0000
Date: Sat, 10 Aug 2024 04:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	nabijaczleweli@nabijaczleweli.xyz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sunvnet: use ethtool_sprintf/puts
Message-ID: <202408100443.OXvAtrM9-lkp@intel.com>
References: <20240809044502.4184-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809044502.4184-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-sunvnet-use-ethtool_sprintf-puts/20240809-145830
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240809044502.4184-1-rosenp%40gmail.com
patch subject: [PATCH net-next] net: sunvnet: use ethtool_sprintf/puts
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100443.OXvAtrM9-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100443.OXvAtrM9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100443.OXvAtrM9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/sun/sunvnet.c: In function 'vnet_get_strings':
>> drivers/net/ethernet/sun/sunvnet.c:120:36: error: passing argument 2 of 'ethtool_puts' from incompatible pointer type [-Wincompatible-pointer-types]
     120 |                 ethtool_puts(&buf, &ethtool_stats_keys);
         |                                    ^~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    const struct <anonymous> (*)[14]
   In file included from drivers/net/ethernet/sun/sunvnet.c:17:
   include/linux/ethtool.h:1273:49: note: expected 'const char *' but argument is of type 'const struct <anonymous> (*)[14]'
    1273 | extern void ethtool_puts(u8 **data, const char *str);
         |                                     ~~~~~~~~~~~~^~~


vim +/ethtool_puts +120 drivers/net/ethernet/sun/sunvnet.c

   112	
   113	static void vnet_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
   114	{
   115		struct vnet *vp = (struct vnet *)netdev_priv(dev);
   116		struct vnet_port *port;
   117	
   118		switch (stringset) {
   119		case ETH_SS_STATS:
 > 120			ethtool_puts(&buf, &ethtool_stats_keys);
   121	
   122			rcu_read_lock();
   123			list_for_each_entry_rcu(port, &vp->port_list, list) {
   124				ethtool_sprintf(&buf, "p%u.%s-%pM", port->q_index,
   125						port->switch_port ? "s" : "q",
   126						port->raddr);
   127				ethtool_sprintf(&buf, "p%u.rx_packets", port->q_index);
   128				ethtool_sprintf(&buf, "p%u.tx_packets", port->q_index);
   129				ethtool_sprintf(&buf, "p%u.rx_bytes", port->q_index);
   130				ethtool_sprintf(&buf, "p%u.tx_bytes", port->q_index);
   131				ethtool_sprintf(&buf, "p%u.event_up", port->q_index);
   132				ethtool_sprintf(&buf, "p%u.event_reset", port->q_index);
   133			}
   134			rcu_read_unlock();
   135			break;
   136		default:
   137			WARN_ON(1);
   138			break;
   139		}
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

