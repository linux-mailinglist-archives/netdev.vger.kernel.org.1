Return-Path: <netdev+bounces-85963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC65189D0D0
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A3C281752
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 03:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6538548E9;
	Tue,  9 Apr 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuWeWw1w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99956454
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632537; cv=none; b=qPqrUwQ/ld7StBXTGt5DphM9YAlbK1tKkatxfkoJEP0qngGjxhDohY8DYcQZYH827AmIR56Bj9P+RdTcBmye5Ik+uLkhu7zw7rD/Z/mn+ccyCe1kkuUfq5ZidkEh2ibnMPq6KWYbK0oxUWBgFWU7T0Y4I17KvJicFw86b0UT+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632537; c=relaxed/simple;
	bh=QqeHzXMVJ0irSOqoEDbTXP6pf9dzwvyBcaGWTv6ysbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO5yUt0MnFMO08rrp1FraJuWj7FauqagFIlApujvzlypNlKmU9OZ5g+CyY95ZtjW6YJRq6YYOE3z/uTHSgs4BLPdk5QVatuIl329maQpbivvXF0ymjLkAoWUrbai6APo9wRQK+s6W+49OojM42hqncHRNT//w47HrGEQiSzarXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuWeWw1w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632536; x=1744168536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqeHzXMVJ0irSOqoEDbTXP6pf9dzwvyBcaGWTv6ysbU=;
  b=DuWeWw1wKkQB3hTgGaT3Iawbzkax1qqsjl4giDm8LxpX3jnyXj7jBfnx
   iApA2peh4xz9349e/6bM1BehnhUtGpDySeNa997x0waUIXgAx//zICcsq
   PYeUDpM1exLpyY45QBLvTQwil74j+H2HOAnkTAE3eMQcYexaOt8hrOLNy
   CZTRdaddVs/8kCUi16QECVuYxlrr5Q9g7svryjw1vfv/UWBZl4DgsVakh
   telgBH9qenBVfauwT5BX3IjhhG9MpRe418mnRgULce4GK7bjIuAvzP5se
   D57/oq9apL/IlUa4Xce8B4ZuQ5K4CcndRHG2jaW/swhdPwO/WTnMvxs4S
   w==;
X-CSE-ConnectionGUID: yX3wkeeST1GcHN2tu4/Dpg==
X-CSE-MsgGUID: Tclw1KChTZqe9ffyjlkS6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18654784"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="18654784"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:15:36 -0700
X-CSE-ConnectionGUID: S/Pa6DX7QJK0zfKzU+XnZw==
X-CSE-MsgGUID: XpsFjjNeSYW23JqQkmILkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20655425"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Apr 2024 20:15:32 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru1xK-0005fs-0e;
	Tue, 09 Apr 2024 03:15:30 +0000
Date: Tue, 9 Apr 2024 11:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <202404091147.pdi8izJ3-lkp@intel.com>
References: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-dsa-introduce-dsa_phylink_to_port/20240408-232316
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1rtn25-0065p0-2C%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to provide their own phylink mac ops
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240409/202404091147.pdi8izJ3-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091147.pdi8izJ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404091147.pdi8izJ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/dsa/port.c:1981:6: warning: unused variable 'port' [-Wunused-variable]
           int port = dp->index;
               ^
   1 warning generated.


vim +/port +1981 net/dsa/port.c

3a506cb7012a98 Russell King (Oracle  2024-04-08  1975) 
770375ff331111 Vladimir Oltean       2022-08-18  1976  int dsa_shared_port_link_register_of(struct dsa_port *dp)
57ab1ca2159717 Vivien Didelot        2017-10-26  1977  {
0e27921816ad99 Ioana Ciornei         2019-05-28  1978  	struct dsa_switch *ds = dp->ds;
e09e9873152e3f Vladimir Oltean       2022-08-18  1979  	bool missing_link_description;
e09e9873152e3f Vladimir Oltean       2022-08-18  1980  	bool missing_phy_mode;
3be98b2d5fbca3 Andrew Lunn           2020-04-14 @1981  	int port = dp->index;
0e27921816ad99 Ioana Ciornei         2019-05-28  1982  
e09e9873152e3f Vladimir Oltean       2022-08-18  1983  	dsa_shared_port_validate_of(dp, &missing_phy_mode,
e09e9873152e3f Vladimir Oltean       2022-08-18  1984  				    &missing_link_description);
e09e9873152e3f Vladimir Oltean       2022-08-18  1985  
e09e9873152e3f Vladimir Oltean       2022-08-18  1986  	if ((missing_phy_mode || missing_link_description) &&
e09e9873152e3f Vladimir Oltean       2022-08-18  1987  	    !of_device_compatible_match(ds->dev->of_node,
e09e9873152e3f Vladimir Oltean       2022-08-18  1988  					dsa_switches_apply_workarounds))
e09e9873152e3f Vladimir Oltean       2022-08-18  1989  		return -EINVAL;
e09e9873152e3f Vladimir Oltean       2022-08-18  1990  
a20f997010c4ec Andrew Lunn           2020-03-11  1991  	if (!ds->ops->adjust_link) {
e09e9873152e3f Vladimir Oltean       2022-08-18  1992  		if (missing_link_description) {
e09e9873152e3f Vladimir Oltean       2022-08-18  1993  			dev_warn(ds->dev,
e09e9873152e3f Vladimir Oltean       2022-08-18  1994  				 "Skipping phylink registration for %s port %d\n",
e09e9873152e3f Vladimir Oltean       2022-08-18  1995  				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
e09e9873152e3f Vladimir Oltean       2022-08-18  1996  		} else {
3a506cb7012a98 Russell King (Oracle  2024-04-08  1997) 			dsa_shared_port_link_down(dp);
e09e9873152e3f Vladimir Oltean       2022-08-18  1998  
770375ff331111 Vladimir Oltean       2022-08-18  1999  			return dsa_shared_port_phylink_register(dp);
3be98b2d5fbca3 Andrew Lunn           2020-04-14  2000  		}
a20f997010c4ec Andrew Lunn           2020-03-11  2001  		return 0;
a20f997010c4ec Andrew Lunn           2020-03-11  2002  	}
0e27921816ad99 Ioana Ciornei         2019-05-28  2003  
0e27921816ad99 Ioana Ciornei         2019-05-28  2004  	dev_warn(ds->dev,
0e27921816ad99 Ioana Ciornei         2019-05-28  2005  		 "Using legacy PHYLIB callbacks. Please migrate to PHYLINK!\n");
0e27921816ad99 Ioana Ciornei         2019-05-28  2006  
33615367f378fe Sebastian Reichel     2018-01-23  2007  	if (of_phy_is_fixed_link(dp->dn))
770375ff331111 Vladimir Oltean       2022-08-18  2008  		return dsa_shared_port_fixed_link_register_of(dp);
33615367f378fe Sebastian Reichel     2018-01-23  2009  	else
770375ff331111 Vladimir Oltean       2022-08-18  2010  		return dsa_shared_port_setup_phy_of(dp, true);
33615367f378fe Sebastian Reichel     2018-01-23  2011  }
57ab1ca2159717 Vivien Didelot        2017-10-26  2012  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

