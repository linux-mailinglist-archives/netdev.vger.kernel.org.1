Return-Path: <netdev+bounces-214264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4992B28AE5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FF5AE7682
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3D1F4C9F;
	Sat, 16 Aug 2025 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfnaU+KM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AE1F9F51;
	Sat, 16 Aug 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755323919; cv=none; b=lMHFf6uqDP8UT0sBd+GR9OdX24EOKXlMlljei+PkSHE7g+NI3FP1/YeC2M2a4A7jEkVcTBSuA0KF9MGdosZJeJHXnqXEOfMW8uUQESSiPQBC2rwfntv9SUmFvvz4GxGOU+bGLIOOEW5kdWYk3YSTtOdx68CtUTuo+cLi31Det34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755323919; c=relaxed/simple;
	bh=gCT3Vy/InXFik2JESebYvEoHergxHzILaLortPdjdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMsM0T68Mpru8TjNxpoXDIFs3EoxcMVyJL1Cre+wlFVpQ4QV1VrU5t58D6ZQy6W7bVD2SoJTbhm7e0KWeljHe+X0OLbKbt42CdGr77S2QTQPfTjcJn/W5PbNky/iSGzHFhMQtINUM1qFnYUJhhj5JurPy+1LwPNhv3p1qbFZCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfnaU+KM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755323917; x=1786859917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gCT3Vy/InXFik2JESebYvEoHergxHzILaLortPdjdEk=;
  b=CfnaU+KMUI5wxxEI92CqOlFuQ6LI1ExESQz3rCtqKhNxXwbSVNLLgpY9
   b78KyB+MRgpPaYyYR9Vuqg0Bym/msWTjpE4PxT3vVFD8Kue4RDZWNf0N8
   cvgiqM/V/QNBg0JQPN2DjisZGDFbid5AxbffP1DYrMliyj6SSSbn5M4+U
   KOtOKn1Tast4UvJWj8M9Ub7u6eBxbwvJgWztSpfg+uNNJbpYBFItodrzH
   vW0PuC3/YAfsK4XwxfGMWhV8Up/NrE2bN1uS8PvCeebJTe9NLvTbmhzvh
   Gt3BGaKYNr5MtgBps0UzJv6dvSoynUIb2ayTvwgIuGzfwmMlzXAVakc5b
   w==;
X-CSE-ConnectionGUID: 8g34BEzoQeC97GnsJ+WSkQ==
X-CSE-MsgGUID: Pkg6DQbXQNSiJvaBOR9YHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57782707"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57782707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 22:58:36 -0700
X-CSE-ConnectionGUID: QUjKVCBASXajz5+TmQybjw==
X-CSE-MsgGUID: j7G5cbBBTFG13/GWLTPRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172377014"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2025 22:58:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un9vz-000Ccm-1M;
	Sat, 16 Aug 2025 05:58:31 +0000
Date: Sat, 16 Aug 2025 13:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH v2 2/3] nfp: flower: use vmalloc_array() to simplify code
Message-ID: <202508161307.IWBBnNXY-lkp@intel.com>
References: <20250814102100.151942-3-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814102100.151942-3-rongqianfeng@vivo.com>

Hi Qianfeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue net-next/main net/main linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qianfeng-Rong/eth-intel-use-vmalloc_array-to-simplify-code/20250814-183400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250814102100.151942-3-rongqianfeng%40vivo.com
patch subject: [PATCH v2 2/3] nfp: flower: use vmalloc_array() to simplify code
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250816/202508161307.IWBBnNXY-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161307.IWBBnNXY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161307.IWBBnNXY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/vmalloc.h:5,
                    from drivers/net/ethernet/netronome/nfp/flower/metadata.c:8:
   drivers/net/ethernet/netronome/nfp/flower/metadata.c: In function 'nfp_flower_metadata_init':
>> include/linux/stddef.h:24:42: warning: 'vmalloc_array_noprof' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:24:42: note: earlier argument should specify number of elements, later size of each element
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:24:42: warning: 'vmalloc_array_noprof' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:243:24: note: in definition of macro 'alloc_hooks_tag'
     243 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:24:42: note: earlier argument should specify number of elements, later size of each element
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:243:24: note: in definition of macro 'alloc_hooks_tag'
     243 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:24:42: warning: 'vmalloc_array_noprof' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:246:24: note: in definition of macro 'alloc_hooks_tag'
     246 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:24:42: note: earlier argument should specify number of elements, later size of each element
      24 | #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
         |                                          ^
   include/linux/alloc_tag.h:246:24: note: in definition of macro 'alloc_hooks_tag'
     246 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/vmalloc.h:192:33: note: in expansion of macro 'alloc_hooks'
     192 | #define vmalloc_array(...)      alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:17: note: in expansion of macro 'vmalloc_array'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                 ^~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/main.h:29:41: note: in expansion of macro 'sizeof_field'
      29 | #define NFP_FL_STATS_ELEM_RS            sizeof_field(struct nfp_fl_stats_id, \
         |                                         ^~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/flower/metadata.c:567:31: note: in expansion of macro 'NFP_FL_STATS_ELEM_RS'
     567 |                 vmalloc_array(NFP_FL_STATS_ELEM_RS,
         |                               ^~~~~~~~~~~~~~~~~~~~


vim +24 include/linux/stddef.h

3876488444e712 Denys Vlasenko 2015-03-09  17  
4229a470175be1 Kees Cook      2018-01-10  18  /**
e7f18c22e6bea2 Kees Cook      2021-08-19  19   * sizeof_field() - Report the size of a struct field in bytes
4229a470175be1 Kees Cook      2018-01-10  20   *
4229a470175be1 Kees Cook      2018-01-10  21   * @TYPE: The structure containing the field of interest
4229a470175be1 Kees Cook      2018-01-10  22   * @MEMBER: The field to return the size of
4229a470175be1 Kees Cook      2018-01-10  23   */
4229a470175be1 Kees Cook      2018-01-10 @24  #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
4229a470175be1 Kees Cook      2018-01-10  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

