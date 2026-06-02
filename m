Return-Path: <netdev+bounces-294395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZglMtk6H2rQiwAAu9opvQ
	(envelope-from <netdev+bounces-294395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:19:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995C631B32
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:19:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Wg3aQo44;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294395-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294395-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF3E30045BE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E173161BE;
	Tue,  2 Jun 2026 20:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557429AAFA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:19:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431575; cv=none; b=rU4rZj6rMpGWcOP8Lx2+PlmBfRINF3ihIIsZmUXP+TcM6SiBAK1z/SStOQkHFsYWT6/J3pF3gIfTwvdl6L6Ae2OS2YtplarWHZg0exeXmxfzND0Zxusm6W0WDaAOo2BAOzjGEVQbCkB/YQZEg7Cg0TxBVC4pXfb7v+bv1YTwuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431575; c=relaxed/simple;
	bh=aqHQwDV5rT5Ek3B4l8MHHv4feS8QtYxfmPb7FDlRbXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwbq8EgRfP8SsZD3vzqv2mH/b/GiVJLuTOwky1ha56NLKBlq8vlFuQ3RLuojsUu+P10xQKX/wLf7MXePt1HIDbZ+dCuw4HkU5qph60X5RAAXQE7RiLk2MCxYBFJch5/0haDK/DpLHiEhvAHNH2EW2XA+NOhjIqcaUr0w/2Nxzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wg3aQo44; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780431572; x=1811967572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqHQwDV5rT5Ek3B4l8MHHv4feS8QtYxfmPb7FDlRbXQ=;
  b=Wg3aQo44cX/qCN1EkVnYLSb2HAZClDbCSzmEidI6HzCGj6W1od3KLKIe
   1ZTvH9WuhD42WUbbwG3J1xiMyqe6I6X9JU2Bti7SvMbTmD0j3CEVe5RbD
   iUDfwp3C1SZRCj/jUAQQk77TMLWRCKUvPfThtXnEeKNitTilzEMM5eIN2
   DFzmFUNUgWG2O/L8RMm8LLysn0/zYS+it58AzS/Nz6d06lIcLUP7JqTLM
   vsoQh0nN8uVTFleSgVmjADU0O1n9jHk7VTLg+bZ5jkgnI+KhTRrRaEgPQ
   iwjZ1yqbqAgK3WeyCbutcwfmTMFo1N5HPJZVjkck0808PGB3/OggYFlqF
   Q==;
X-CSE-ConnectionGUID: AF5UeuxETfOSpb3jDq8AXQ==
X-CSE-MsgGUID: PuI/PnidSx6XM6kuawpGDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81131876"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81131876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:19:32 -0700
X-CSE-ConnectionGUID: EqTaAbGwTe2RyTRRZqth2g==
X-CSE-MsgGUID: t16Pg07xTuWkrY+6/aJKMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243848539"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 02 Jun 2026 13:19:31 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUVaC-000000001qr-16EZ;
	Tue, 02 Jun 2026 20:19:28 +0000
Date: Tue, 2 Jun 2026 22:18:53 +0200
From: kernel test robot <lkp@intel.com>
To: Lei Zhu <zhulei_szu@163.com>, kuba@kernel.org, sukhdeeps@marvell.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: atlantic: aq_utils_obj_{set|clear}
 optimizations
Message-ID: <202606022254.rqQVht0b-lkp@intel.com>
References: <20260602092949.263270-1-zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602092949.263270-1-zhulei_szu@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294395-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,kernel.org,marvell.com,davemloft.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhulei_szu@163.com,m:kuba@kernel.org,m:sukhdeeps@marvell.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3995C631B32

Hi Lei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lei-Zhu/net-atlantic-aq_utils_obj_-set-clear-optimizations/20260602-174147
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260602092949.263270-1-zhulei_szu%40163.com
patch subject: [PATCH net-next] net: atlantic: aq_utils_obj_{set|clear} optimizations
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260602/202606022254.rqQVht0b-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606022254.rqQVht0b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606022254.rqQVht0b-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/aquantia/atlantic/aq_common.h:17,
                    from drivers/net/ethernet/aquantia/atlantic/aq_main.h:12,
                    from drivers/net/ethernet/aquantia/atlantic/aq_main.c:10:
   drivers/net/ethernet/aquantia/atlantic/aq_utils.h: In function 'aq_utils_obj_set':
>> drivers/net/ethernet/aquantia/atlantic/aq_utils.h:21:45: error: passing argument 2 of 'atomic_try_cmpxchg' from incompatible pointer type [-Wincompatible-pointer-types]
      21 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
         |                                             |
         |                                             long unsigned int *
   In file included from include/linux/atomic.h:82,
                    from include/linux/cpumask.h:10,
                    from arch/x86/include/asm/paravirt.h:19,
                    from arch/x86/include/asm/irqflags.h:100,
                    from include/linux/irqflags.h:18,
                    from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/skbuff.h:15,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/aquantia/atlantic/aq_common.h:13:
   include/linux/atomic/atomic-instrumented.h:1275:38: note: expected 'int *' but argument is of type 'long unsigned int *'
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                 ~~~~~^~~
   drivers/net/ethernet/aquantia/atlantic/aq_utils.h: In function 'aq_utils_obj_clear':
   drivers/net/ethernet/aquantia/atlantic/aq_utils.h:31:45: error: passing argument 2 of 'atomic_try_cmpxchg' from incompatible pointer type [-Wincompatible-pointer-types]
      31 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
         |                                             |
         |                                             long unsigned int *
   include/linux/atomic/atomic-instrumented.h:1275:38: note: expected 'int *' but argument is of type 'long unsigned int *'
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                 ~~~~~^~~
--
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_common.h:17,
                    from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:15,
                    from drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c:10:
   drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h: In function 'aq_utils_obj_set':
>> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h:21:45: error: passing argument 2 of 'atomic_try_cmpxchg' from incompatible pointer type [-Wincompatible-pointer-types]
      21 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
         |                                             |
         |                                             long unsigned int *
   In file included from include/linux/atomic.h:82,
                    from include/linux/cpumask.h:10,
                    from arch/x86/include/asm/paravirt.h:19,
                    from arch/x86/include/asm/irqflags.h:100,
                    from include/linux/irqflags.h:18,
                    from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/skbuff.h:15,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_common.h:13:
   include/linux/atomic/atomic-instrumented.h:1275:38: note: expected 'int *' but argument is of type 'long unsigned int *'
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                 ~~~~~^~~
   drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h: In function 'aq_utils_obj_clear':
   drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h:31:45: error: passing argument 2 of 'atomic_try_cmpxchg' from incompatible pointer type [-Wincompatible-pointer-types]
      31 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
         |                                             |
         |                                             long unsigned int *
   include/linux/atomic/atomic-instrumented.h:1275:38: note: expected 'int *' but argument is of type 'long unsigned int *'
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                 ~~~~~^~~


vim +/atomic_try_cmpxchg +21 drivers/net/ethernet/aquantia/atlantic/aq_utils.h

    13	
    14	static inline void aq_utils_obj_set(atomic_t *flags, u32 mask)
    15	{
    16		unsigned long flags_old, flags_new;
    17	
    18		flags_old = atomic_read(flags);
    19		do {
    20			flags_new = flags_old | (mask);
  > 21		} while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
    22	}
    23	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

