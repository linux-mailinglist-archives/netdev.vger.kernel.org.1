Return-Path: <netdev+bounces-125934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DE96F4DE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3511C2433C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9501CCB45;
	Fri,  6 Sep 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuHJKbvd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFE1CBEB5
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627560; cv=none; b=jIj9G4SGdUgWuNfpbe/NS1Afw/e/xnEqEMVvz49kgWkcZdE8jA/EYPONpJzskdtegqXOpFX5FLTppOlZh2Ni9Dtne6neXXbrLDwOZifm1m5VHdy4bU4XnE3p67tkaKjc0EaWtYHI/0ZoPDiziNUjCzDh1Nz2VC34EzWx/g6Ui8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627560; c=relaxed/simple;
	bh=5Q1pSZMTmvZcoC6YtWgNn0TSfuvsAu07of5tEvsbdR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnlTm3J9InO/RWD2kxe+SCEePrwb1DL9wcwDLQMHUv/AvxNl6yC838eAXQqYpCBIUeK5BSQ4i9z3aNy1TytyETVkOhpudJ3ChyWNcDXYmmnLH+wBzKypWP9hq9BEH7CSbFE+qH9GyXHnzEm5GCivxjJVy7+J8IiZQM5JOL5UQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuHJKbvd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725627559; x=1757163559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Q1pSZMTmvZcoC6YtWgNn0TSfuvsAu07of5tEvsbdR4=;
  b=EuHJKbvdhtRyv468Mv01cygAULmZucSAvVhm63/XaOR6PZqLQTT1Fb7k
   uYds7qsWs/4VqSZsLRCXRB+bcFMdKw3TpjFXyc/srfNk0Apf2cx/jQgBu
   O2Jb28X1qhfEBMEXCxEnyOnnbzMzeXGOXGK01ffuTEiSVkOChA9uwy/O0
   mJVyJHQuQoOetKuCWZwAfi/3v8Ay+s8wB/4s17Me1LvvklHXYDoJQWeYs
   jWGUQkSLimZba9WV3uwxkd6LyjoTOmDbAotpZo1iiPgRayZXsFeb2Mvzv
   SPq8S/QtjgDGJPDZVhJST99Csk/yUEk9c1QMkvLG7GYM+dSeOUZuCbpuh
   Q==;
X-CSE-ConnectionGUID: HnYex61STnmeM6yPctZ88w==
X-CSE-MsgGUID: FeAUkW+GToaPrQqoreJQ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="46912416"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="46912416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 05:59:18 -0700
X-CSE-ConnectionGUID: 4KcTGZj5SfqkvGNBKos/iQ==
X-CSE-MsgGUID: +oU/Oe7RT/yR3KwEKBkdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70361362"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 05:59:16 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smYYT-000BFx-31;
	Fri, 06 Sep 2024 12:59:13 +0000
Date: Fri, 6 Sep 2024 20:58:48 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <202409062041.8g7uYSEJ-lkp@intel.com>
References: <20240904113153.2196238-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904113153.2196238-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/net_tstamp-add-SCM_TS_OPT_ID-to-provide-OPT_ID-in-control-message/20240904-193351
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240904113153.2196238-2-vadfed%40meta.com
patch subject: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240906/202409062041.8g7uYSEJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409062041.8g7uYSEJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409062041.8g7uYSEJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/net_tstamp.h:46:36: error: expected ')' before '!=' token
      46 | static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));
         |                                    ^~~
         |                                    )

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

