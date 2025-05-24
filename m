Return-Path: <netdev+bounces-193204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE470AC2EDE
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D086AA2292E
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068C1DE3AD;
	Sat, 24 May 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtM6fS9l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A301D959B;
	Sat, 24 May 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748082531; cv=none; b=MA8b6QX3g7VppnhW2sy0QVAVwxnDx3Sytimoj/U6kf9aqeZHMOB30QD+JZbo5lBtIz1R1G3o6mMrt53z1QPkb1+NHZezObh1o9TV4YO2BTd009R4BAA5sAnkQBmqnF4o06aYRC4aqqaTiQ1nG6Wds+mjbCXapHf1RiVLK8fkcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748082531; c=relaxed/simple;
	bh=psdi4796Sb+q+ePNVBR6xRLzzJYOhgE+dtwY5fCMdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je2LL8vHmN9En4i9jToY2fOsBGcA9zJQ9H58eAde487yzwFHOXkQ2NsJkVn65xKI2UZT0tB3U7LBCO+Vplb4HNV0juBFo0M5DeBXd9LSpLJ32bqWoS6EK5m+d+0+hLet2RejZhBU2oSYog18Z6IeB0NTF7WAewFcL4WkHidKPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtM6fS9l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748082530; x=1779618530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=psdi4796Sb+q+ePNVBR6xRLzzJYOhgE+dtwY5fCMdYo=;
  b=ZtM6fS9l8BJMhYzGEdUEcL8LN6TrurOnSeTStwBtpfb7oGhyvjP0SjBe
   6wK4bpS8AcFEWWkFzhBbrUgswAVc1TWrDIyYN6EDhJ/Hea0VTJ/epXEcO
   MmDaEdkL9ELqt0fFSUqGZrAq1z5gzeHi4oM7mVs98cPoqlxaaTs11wtA4
   wP+bJAUFK0xUzosZ2Df7unQlRnDhGIBaiEfggzLDdlkqzQIcl15d6kmlL
   UVld0/ShV3+qyxPfNdG8Fpp0SLj7dDZ/rJmCbIiatFeHUKZaL6VHhzO6x
   dq1lCht1F4MGq6EWICtczqRt8hgJ8sLQJii83xtKCdM1HOyNHfBrZOrXU
   A==;
X-CSE-ConnectionGUID: gR7dMSglQUG7sGLPyV5z9g==
X-CSE-MsgGUID: fyDtWy8ATmiqw3lJfKfBOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49380012"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="49380012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 03:28:49 -0700
X-CSE-ConnectionGUID: eWF/ujWEQS+zyKJZ6wq/dA==
X-CSE-MsgGUID: Ja1jVy7xQqW7Dr0Hl6XBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="141381290"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 May 2025 03:28:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIm7N-000R7C-22;
	Sat, 24 May 2025 10:28:41 +0000
Date: Sat, 24 May 2025 18:27:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <202505241840.ILpzEabZ-lkp@intel.com>
References: <20250523203339.1993685-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523203339.1993685-6-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250524-043901
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250523203339.1993685-6-sean.anderson%40linux.dev
patch subject: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO driver
config: x86_64-kismet-CONFIG_OF_DYNAMIC-CONFIG_FSL_FMAN-0-0 (https://download.01.org/0day-ci/archive/20250524/202505241840.ILpzEabZ-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250524/202505241840.ILpzEabZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241840.ILpzEabZ-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for OF_DYNAMIC when selected by FSL_FMAN
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
     Depends on [n]: OF [=n]
     Selected by [y]:
     - FSL_FMAN [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_FREESCALE [=y] && (FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

