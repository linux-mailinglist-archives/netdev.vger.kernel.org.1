Return-Path: <netdev+bounces-246827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C298CF186C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 01:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 537C03007FF1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 00:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA2C29D29F;
	Mon,  5 Jan 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8tabEbM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5E1D63F3;
	Mon,  5 Jan 2026 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767574417; cv=none; b=udwATxWL/qIC4oOA63eFGqi9b15QiFfwCUsZ+lcXY+RIFN2FHh/QYZz2CvHTsDnrsT7AnonWEjH2N4INm0AV01oa2KYPVCv5meLN4q3NKjZTBZEGGerof19ZAo6eYqFWCBPIvQgSS+8z5r+W60Z9fi2LXXB9Q4Nwq1rIXp79bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767574417; c=relaxed/simple;
	bh=mV+LX90N2b2d0OM7EZ0H3tJaZAgxqgrXy940pxy+7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKHmzZm8DFNcBUphBe/7KcpFoPe42Hyuxnr8nIlNTRjU6V+Og7h13+UimntH/YbO/ncF7yuKc+/rbqeX5mL9OYXIEw4BEtNAeY6DW8v5AyRmawExG9SvKOqrA9HzY5guEfrM3Krl/AK6C1cNAr00ENEXKko3JLuT92Nu49GswV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8tabEbM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767574416; x=1799110416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mV+LX90N2b2d0OM7EZ0H3tJaZAgxqgrXy940pxy+7Yg=;
  b=V8tabEbMzhIxFEw8s/S/mHvF0vwUBfkZu8YasuRqP5PkL2uHq3Valueg
   Cm2sqD0MWKYGfLQtydJ0G+bnp8TOiDoRpS0HLruSpyj9y8AxYSyRmbUff
   CXjMuvubsfVK5xFcB2o3xLTjYicpOEXD2xFagG4Uy5rTXCSfq6xHdxKvC
   6bWcYDfXgZIriYmbIp6dODr9WPiBlZpT6u6SfQfSUWyw1JBVGxi9gCQY6
   Q7l8Irbc7pr24p8nvItBHpdf+SfLQXpvo/OadAChbla+xtufvnuTRLzVr
   6MuChX4WMCQBp0mVG5rYmXZN9OZol5yFK/6otXPjTtvehSf9UOTid6TxX
   g==;
X-CSE-ConnectionGUID: fCkiL4DlQ/mWq+YFPYM3dg==
X-CSE-MsgGUID: YpzfAmrWTE+0M38cCqGXXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="68853147"
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; 
   d="scan'208";a="68853147"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2026 16:53:35 -0800
X-CSE-ConnectionGUID: YytvGQReSU+QUtiEbiNvAw==
X-CSE-MsgGUID: 9XuCYaWlQiy0s/uw0dL/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; 
   d="scan'208";a="206812987"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 04 Jan 2026 16:53:32 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vcYqf-000000000zR-24dB;
	Mon, 05 Jan 2026 00:53:29 +0000
Date: Mon, 5 Jan 2026 01:52:33 +0100
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
Message-ID: <202601050128.DGivvUie-lkp@intel.com>
References: <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-realtek-fix-whitespace-in-struct-phy_driver-initializers/20260104-211500
base:   net-next/main
patch link:    https://lore.kernel.org/r/d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel%40makrotopia.org
patch subject: [PATCH net-next 3/4] net: phy: realtek: use paged access for MDIO_MMD_VEND2 in C22 mode
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260105/202601050128.DGivvUie-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260105/202601050128.DGivvUie-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601050128.DGivvUie-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/realtek/realtek_main.c: In function 'rtl822xb_read_mmd':
>> drivers/net/phy/realtek/realtek_main.c:1261:51: error: 'mmdreg' undeclared (first use in this function); did you mean 'mmdrop'?
    1261 |                                           devnum, mmdreg);
         |                                                   ^~~~~~
         |                                                   mmdrop
   drivers/net/phy/realtek/realtek_main.c:1261:51: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/phy/realtek/realtek_main.c: In function 'rtl822xb_write_mmd':
   drivers/net/phy/realtek/realtek_main.c:1309:52: error: 'mmdreg' undeclared (first use in this function); did you mean 'mmdrop'?
    1309 |                                            devnum, mmdreg, val);
         |                                                    ^~~~~~
         |                                                    mmdrop


vim +1261 drivers/net/phy/realtek/realtek_main.c

  1248	
  1249	/* RTL822x cannot access MDIO_MMD_VEND2 via MII_MMD_CTRL/MII_MMD_DATA.
  1250	 * A mapping to use paged access needs to be used instead.
  1251	 * All other MMD devices can be accessed as usual.
  1252	 */
  1253	static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
  1254	{
  1255		int oldpage, ret, read_ret;
  1256		u16 page;
  1257	
  1258		/* Use Clause-45 bus access in case it is available */
  1259		if (phydev->is_c45)
  1260			return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> 1261						  devnum, mmdreg);
  1262	
  1263		/* Use indirect access via MII_MMD_CTRL and MII_MMD_DATA for all
  1264		 * MMDs except MDIO_MMD_VEND2
  1265		 */
  1266		if (devnum != MDIO_MMD_VEND2) {
  1267			__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
  1268					MII_MMD_CTRL, devnum);
  1269			__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
  1270					MII_MMD_DATA, mmdreg);
  1271			__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
  1272					MII_MMD_CTRL, devnum | MII_MMD_CTRL_NOINCR);
  1273	
  1274			return __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
  1275					       MII_MMD_DATA);
  1276		}
  1277	
  1278		/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
  1279		page = RTL822X_VND2_TO_PAGE(reg);
  1280		oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
  1281		if (oldpage < 0)
  1282			return ret;
  1283	
  1284		if (oldpage != page) {
  1285			ret = __phy_write(phydev, RTL821x_PAGE_SELECT, page);
  1286			if (ret < 0)
  1287				return ret;
  1288		}
  1289	
  1290		read_ret = __phy_read(phydev, RTL822X_VND2_TO_PAGE_REG(reg));
  1291		if (oldpage != page) {
  1292			ret = __phy_write(phydev, RTL821x_PAGE_SELECT, oldpage);
  1293			if (ret < 0)
  1294				return ret;
  1295		}
  1296	
  1297		return read_ret;
  1298	}
  1299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

