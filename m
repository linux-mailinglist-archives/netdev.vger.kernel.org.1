Return-Path: <netdev+bounces-176675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02286A6B47D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8199E3B890A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE741EB184;
	Fri, 21 Mar 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsOwUOPV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C735184F;
	Fri, 21 Mar 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538972; cv=none; b=o3I3MeGr9YMZ/dSB+2AK5E+sdbODl+7zuPlAsSeES6c5oB/nsOkG5MXyneBrqggWx36E1b5UcinvnInX5dUxg1NnTKUkiXdVcsc2NDfPqoJtA3hKMZybto7/LZOrWxsTM0IN3C1dP6igM+kCDhyPlBE6+SUJp/0KoVzcfs39jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538972; c=relaxed/simple;
	bh=HaWvwtYJ/oU8MJuWlBp9GYIsMVjPAUFk2f+KucFWzzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3ooDmtCYgvWHyAJIPKh4eXz5bIIcyolO01y5lJSfDIeN79Mr+yF88SFx2nxM8S+fVZ5BGkXXbGfrtivARybusfLWAWJtGoL3jao0yc6GcmiKyZ2rrwPbQ1iFm8+8lPADtuZpqjepp0deof9d27ueTsaZEEGD8BcqAjSLERbW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsOwUOPV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742538970; x=1774074970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HaWvwtYJ/oU8MJuWlBp9GYIsMVjPAUFk2f+KucFWzzI=;
  b=TsOwUOPVbJm6EL7zw9ZjdVBlo4UDIrrI0/a5OIbfwJyYebBGkfOXx0NQ
   puB2nsiAwMXrUh7miIX89QTuGv6OobbzH2zYWRpYomQChgaeTf6T6+qxC
   k2kyEJ4D1OwQ78oGWoj2osi5VVhQkHTlT0wwojGcRLbPZER3SyC197cL/
   ynThNNfXBV9djq1Q61W5uZFE9A2kdXNXyaLnzwMsmmVzoF3paPTcyNSMU
   EL9/YosGN1Bd5rgEp8BCLeKFRnPgzMPyUw/Ycp44ANMRicAKFx5JzfX8s
   TZYeDCoebSChl+egmz4t1UMEfWKRZSS6vo4BI3om/Ts945Gf/EwwOgsQZ
   A==;
X-CSE-ConnectionGUID: 8nqMfzwXTha8XWxGp/6l7A==
X-CSE-MsgGUID: pXGu5vz+SsGfhY6sIFUHew==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43985016"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43985016"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:36:09 -0700
X-CSE-ConnectionGUID: YaSh7HXlQ+OnX5jNfa5gzA==
X-CSE-MsgGUID: h72+9HCnRUyhlf7lh60ncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123830796"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Mar 2025 23:36:05 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvVz8-00016A-2R;
	Fri, 21 Mar 2025 06:36:02 +0000
Date: Fri, 21 Mar 2025 14:35:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH 5/6] net: pcs: airoha: add PCS driver for Airoha
 SoC
Message-ID: <202503211416.eZCW1LF6-lkp@intel.com>
References: <20250318235850.6411-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-6-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phylink-reset-PCS-Phylink-double-reference-on-phylink_stop/20250319-080303
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250318235850.6411-6-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 5/6] net: pcs: airoha: add PCS driver for Airoha SoC
config: i386-randconfig-007-20250321 (https://download.01.org/0day-ci/archive/20250321/202503211416.eZCW1LF6-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211416.eZCW1LF6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211416.eZCW1LF6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: of_pcs_simple_get
   >>> referenced by pcs-airoha.c:2818 (drivers/net/pcs/pcs-airoha.c:2818)
   >>>               drivers/net/pcs/pcs-airoha.o:(airoha_pcs_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: of_pcs_add_provider
   >>> referenced by pcs-airoha.c:2818 (drivers/net/pcs/pcs-airoha.c:2818)
   >>>               drivers/net/pcs/pcs-airoha.o:(airoha_pcs_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: of_pcs_del_provider
   >>> referenced by pcs-airoha.c:2828 (drivers/net/pcs/pcs-airoha.c:2828)
   >>>               drivers/net/pcs/pcs-airoha.o:(airoha_pcs_remove) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

