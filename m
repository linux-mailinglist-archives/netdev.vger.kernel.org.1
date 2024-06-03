Return-Path: <netdev+bounces-100399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5A8FA629
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0201C23EF7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E41129E66;
	Mon,  3 Jun 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzoN7nI3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560582D7A;
	Mon,  3 Jun 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455774; cv=none; b=XrN98r8Cap+96CSl88rkcuSzV9KveLPZiE0NeErEQJVxlF7nXRKaFdva1epgFcrurkY1ogODUzlwI7bqEjtN1b+JztNuPgNk0XMOy1sdR7GeskaAWQ86xxo2KaTtaO1Hn3tDMWnZL7S3qNY3ir4PwYaSgjWvu23p5JyXdH3oweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455774; c=relaxed/simple;
	bh=3Ncjzb2ZWnsKUDe7He5plc+QeNjITYvtwV7ey/ecEIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rfj84ZcdSzyDDibW7Vx7KnpiaGxhODZnPdm3FGwJq44uBxykD8ArX5GLNALBrMkFM0KBuAsYqwRTT6tNZBL3b6W8ODopmqay/o/qAXtVErJ1sUvv/nTo3PIqegTJCCpA5F1SECNrgKiPoBCUyxRkCbLVzRClFpC+KA7hGCcFChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzoN7nI3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717455773; x=1748991773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Ncjzb2ZWnsKUDe7He5plc+QeNjITYvtwV7ey/ecEIQ=;
  b=UzoN7nI3D35kULVVoe4Y4ioEoeP5zm8hKxsETsusLy65UV8h9oCr2rlL
   u9RIJzXOr0FT+AwPWpDwmgRz6aEUgwCvt76ohIKZYh+W0b8Y0fgF3IgNh
   jL0hLHRW1NwxP+aWQU0xqaKnipBDosQBRufGzwymTAPEVpjLSA0aFYPaA
   uYnasni0NuUETxt8qOJY/uzACuObq3ktmS/IhjXoRSVyADmfIQTWQXWHa
   54is4zSQAaP5kyL1pd9iY8sTg4oNe9xsFge6d0JLcAWCpe/CmLiqfgQrM
   D5MM7FV5+ok0aqyijZfMGzpo33yyfO9q/XgbJM0kUQNWaHT3BtSQ1YQJQ
   A==;
X-CSE-ConnectionGUID: bWDZ6byfQfeEHydFqRS50w==
X-CSE-MsgGUID: lNSX8HFMSsWKc3mkhuEjmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13811784"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13811784"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 16:02:52 -0700
X-CSE-ConnectionGUID: 4OkZhgWhQTyv4X0RBKCwLA==
X-CSE-MsgGUID: SmqE3MnYSzWDHybU8y+hTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="60204759"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2024 16:02:44 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEGhN-000MIf-2j;
	Mon, 03 Jun 2024 23:02:41 +0000
Date: Tue, 4 Jun 2024 07:00:35 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v14 3/5] ethtool: provide customized dim profile
 management
Message-ID: <202406040645.6z95FW1f-lkp@intel.com>
References: <20240603154727.31998-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603154727.31998-4-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240603-235834
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240603154727.31998-4-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v14 3/5] ethtool: provide customized dim profile management
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040645.6z95FW1f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ethtool/coalesce.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

