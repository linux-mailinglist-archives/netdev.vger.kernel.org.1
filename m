Return-Path: <netdev+bounces-221682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D6B5193B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DD616C8CB
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBC324B02;
	Wed, 10 Sep 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qoy49RH8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64941D8E01;
	Wed, 10 Sep 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514212; cv=none; b=kHvIwAk/I7ZIAPrlJwIEa5pMlP2xkpu+ftkCpYkDrfyd2l8zSANzwm1AKjO+YA+Fw9G5LWAWYTFnG34Zc1XtUB7VcdLRQmnfexdB6jqmz/tnz6tsBw1DR0UNs5XvTLSHDs0uYNvLn0qc63v0QPuYEO1MCKLWk41P4QAflaCdD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514212; c=relaxed/simple;
	bh=1bFVZOPAI0hpsGdDGYL11liyhNF/ieQ0EbbfFC6fLJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyLcCb/o0qltiLK3dBI/u83j1SQz52Zr3Mujrgz2o/fZhj+Ha9wbHBilbRRR+crodb+vFcZ07G73QLtsehlroea3Rl52huGBGhHTcd0sduY7Lnp8HFdfSvSg+OneRMygRFO71WjweUksarYyaqq3VMzK4Ej1o/DFOdVQdLbeYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qoy49RH8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757514211; x=1789050211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1bFVZOPAI0hpsGdDGYL11liyhNF/ieQ0EbbfFC6fLJM=;
  b=Qoy49RH8X7Ltcqkb7EZIi+sYsPK0qYTparYg2TgfL5aXVnvL/dCaFq1j
   iShhfnnNWY494dvGXOijRjtFXubDaHxTz0yTcVx0C32tQwPpV2bZd0Zub
   2ms5eZiaGb3lrNfIZlcEXuTO3zjTC3sTSkNJHDMpOgQQUX/EmA9G1UGM0
   h1hGYseZhdT5+r6YLti3OOsw0wNPlZvuFjCUy7vXKErgTkoYbXoiByYsg
   4StIwhsv/NskdSHu/gDEjg1WG9QJokVOtx6mtcr2v06m//9nL88Rw269d
   M4uR6rsRRBTogsrGE6sVKwZjkjCzgXHRSVqK6XAMMHM30/Dqv0A1vYDPD
   A==;
X-CSE-ConnectionGUID: O5OpgW+KTPKPBNKioNcm0A==
X-CSE-MsgGUID: ua3ILOlIS9SGOkmgPzhh8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59968069"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59968069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 07:23:30 -0700
X-CSE-ConnectionGUID: yuIR36rGStyOjEIQAy0eQg==
X-CSE-MsgGUID: mTqMvtgbSNaNQOkbLpYDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="173003238"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Sep 2025 07:23:24 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwLjF-00060l-20;
	Wed, 10 Sep 2025 14:23:21 +0000
Date: Wed, 10 Sep 2025 22:22:33 +0800
From: kernel test robot <lkp@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Luo Jie <quic_luoj@quicinc.com>, Fan Gong <gongfan1@huawei.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Lee Trager <lee@trager.us>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: rpmsg-eth: Add basic rpmsg skeleton
Message-ID: <202509102238.mlNKX2KI-lkp@intel.com>
References: <20250908090746.862407-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908090746.862407-3-danishanwar@ti.com>

Hi MD,

kernel test robot noticed the following build errors:

[auto build test ERROR on 16c610162d1f1c332209de1c91ffb09b659bb65d]

url:    https://github.com/intel-lab-lkp/linux/commits/MD-Danish-Anwar/net-rpmsg-eth-Add-Documentation-for-RPMSG-ETH-Driver/20250908-171329
base:   16c610162d1f1c332209de1c91ffb09b659bb65d
patch link:    https://lore.kernel.org/r/20250908090746.862407-3-danishanwar%40ti.com
patch subject: [PATCH net-next v3 2/7] net: rpmsg-eth: Add basic rpmsg skeleton
config: x86_64-randconfig-r132-20250910 (https://download.01.org/0day-ci/archive/20250910/202509102238.mlNKX2KI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509102238.mlNKX2KI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509102238.mlNKX2KI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rproc_get_by_child" [drivers/net/ethernet/rpmsg_eth.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

