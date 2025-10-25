Return-Path: <netdev+bounces-232739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A6C08802
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D057C35483A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C11221290;
	Sat, 25 Oct 2025 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR/eTxwS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6321C176;
	Sat, 25 Oct 2025 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761355484; cv=none; b=ZgnNyYriI0LZh5PDdWnyP8l1//CEeJVG92uNir1N5PfrbOTd2KHBbf62TnIjYTC2qp7JGLEF0zsref4X2j5xzzuCKaizmqdmkJ8lJPGgnMTXYLR0VRRpPrAr4nQSQf9EQaU/S3Qjxf7uLCDUiL4GF4hFqZm+PjrvQ2fnLpsNwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761355484; c=relaxed/simple;
	bh=4wJiRpV76BWHfYan02c8jXUwoPYpQ0sqXJ0i0TUx8mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhsxR5S8vyI52RUlf3yI3zIoh7XHiI3QJBAlMV+JPpJjGAsaM+RbiuEQ7tnIJctXjxcbzEq75Al6mGSpZWcyRp/+QSSqZQi8e0W2907w+6CXOMTutv/CafebkIa5DCuiJNFNQuPFjXnyGWCLyTTCOqTHC9vA3zltRo2gfuahb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR/eTxwS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761355481; x=1792891481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wJiRpV76BWHfYan02c8jXUwoPYpQ0sqXJ0i0TUx8mY=;
  b=QR/eTxwSEsIhPeoKzrojB4AdaOSxbDARMWyfBD/yUL6DoXZwGEFqMqR6
   AuQJhzXbYpF5E9AfXbFEyupqHgwqxkgoOFbYSnPsU8soVJnZ+J3mj3hK2
   13j2yh7CRo/SUeCgc6KfrtaZuALJdvIU9hgbWTCT2/AcD/jRJkgmvSAt7
   CoUSCtQfjZRjWPqR05hDoB5EiIUJeinM0wcNTSZHX490LerclX0tw2dHD
   PkxcyC0PRH9Nv2i7pEyK4FZmxffSRfRDqTJLTeLscwivoMFV8lfsEu7wC
   y9bm2AG06xCm46K1YrqeIOVmTKYCCn/LipDTXOdU9CRmKeWEKrmWWlqFi
   A==;
X-CSE-ConnectionGUID: RLsGoOdHQAueDZOwAZlg8g==
X-CSE-MsgGUID: dhWtH/fpSzamHYNCufYnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74138770"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74138770"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 18:24:41 -0700
X-CSE-ConnectionGUID: QruXPJ9VRemTjqY0VU6FjQ==
X-CSE-MsgGUID: sipqxXv4SZGf5bLGYluPZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="221765079"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2025 18:24:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCT1G-000F2N-2L;
	Sat, 25 Oct 2025 01:24:34 +0000
Date: Sat, 25 Oct 2025 09:23:54 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Message-ID: <202510250959.Yk9JusD0-lkp@intel.com>
References: <20251024033237.1336249-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024033237.1336249-2-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-yt921x-Add-STP-MST-support/20251024-113613
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251024033237.1336249-2-mmyangfl%40gmail.com
patch subject: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251025/202510250959.Yk9JusD0-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250959.Yk9JusD0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510250959.Yk9JusD0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:6,
                    from include/linux/kernel.h:23,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/dsa/yt921x.c:11:
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_vlan_msti_set':
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.c:2154:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
    2154 |         mask64 = YT921X_VLAN_CTRL_STP_ID_M;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.c:2154:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
    2154 |         mask64 = YT921X_VLAN_CTRL_STP_ID_M;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
      69 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
      69 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:577:23: note: in definition of macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mdio.h:10,
                    from drivers/net/dsa/yt921x.c:16:
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:597:45: error: call to '__compiletime_assert_943' declared with attribute error: FIELD_PREP: mask is zero
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:578:25: note: in definition of macro '__compiletime_assert'
     578 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +48 include/linux/bits.h

31299a5e021124 Vincent Mailhol 2025-03-26  35  
19408200c09485 Vincent Mailhol 2025-03-26  36  /*
19408200c09485 Vincent Mailhol 2025-03-26  37   * Generate a mask for the specified type @t. Additional checks are made to
19408200c09485 Vincent Mailhol 2025-03-26  38   * guarantee the value returned fits in that type, relying on
19408200c09485 Vincent Mailhol 2025-03-26  39   * -Wshift-count-overflow compiler check to detect incompatible arguments.
19408200c09485 Vincent Mailhol 2025-03-26  40   * For example, all these create build errors or warnings:
19408200c09485 Vincent Mailhol 2025-03-26  41   *
19408200c09485 Vincent Mailhol 2025-03-26  42   * - GENMASK(15, 20): wrong argument order
19408200c09485 Vincent Mailhol 2025-03-26  43   * - GENMASK(72, 15): doesn't fit unsigned long
19408200c09485 Vincent Mailhol 2025-03-26  44   * - GENMASK_U32(33, 15): doesn't fit in a u32
19408200c09485 Vincent Mailhol 2025-03-26  45   */
19408200c09485 Vincent Mailhol 2025-03-26  46  #define GENMASK_TYPE(t, h, l)					\
19408200c09485 Vincent Mailhol 2025-03-26  47  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
19408200c09485 Vincent Mailhol 2025-03-26 @48  	     (type_max(t) << (l) &				\
19408200c09485 Vincent Mailhol 2025-03-26  49  	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
19408200c09485 Vincent Mailhol 2025-03-26  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

