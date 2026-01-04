Return-Path: <netdev+bounces-246825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54879CF16C5
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA133009815
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6283161A2;
	Sun,  4 Jan 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N62eSF0V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9127E077;
	Sun,  4 Jan 2026 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767566376; cv=none; b=swhXE+E4UW2ivBTb7XjnqUgJ+sHoIfxKIDv5QwYtTOMQSX5W5ZSiWIKtv/T0Y+8RnFxcLP6I53o3XBWylwFs57Wcrisj024n126+r4f7SXXsZ9NVArFIsPDNC1IngM8lAjuIh/XJ65iHCN3sfXCVaSRjjL6IvgFPu6tH5IT4tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767566376; c=relaxed/simple;
	bh=17Ezu8/N3Z3LZM7I+XRKl0i15UkVlNBbcXgYP8T38Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKR/vpJRNv1LM8T6Uy+35VbQ+nH7dcU3DP1HheIKZsISpaA0xscZgXDa7VKltffwMoAeLFw3j2xTnjalPqbqtevAZKN1PHZoYZlH6J19zmUdpKVZyQ7rYCt7WjiDtD8ZDpts2qxUFroL4lzCylTvhMP1iTnQTVVOrIYI15nU77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N62eSF0V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767566375; x=1799102375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17Ezu8/N3Z3LZM7I+XRKl0i15UkVlNBbcXgYP8T38Jw=;
  b=N62eSF0Va2kK6nwaTz+gpI6gJ8rCosARb3xEaPKE3D5iVfvJ1VJ8Om+H
   Q79wowUeIwjCNlTrVJngIMWVyLnkO0bgg9V4D1jGq/0Lp2VZ/fEO3MSOe
   urloAPGnbZQ8yGJstu11hkeR4YsKMkL5AUzc4w4oIVy7Stfms+17KktTR
   /tL6u83py+b4D6vQtN4nV/gnN0LnVlilcO29RpL7gzIo6d+TsnsrIZVHe
   osE7IV+3zXHM35wFPbmT/DSKuGWERXPej0qc/qRhYQ1TO0TjwMWwlqoW3
   Qj8PRg3/t3woYkI3RvvYxYJOC6BXUyVvT3yJ51HoHzXBtgjzrKRdK5vJv
   Q==;
X-CSE-ConnectionGUID: yIb1hq/KQ+yq/62FOLF14A==
X-CSE-MsgGUID: A2bfI7HuSICoIIWKfhj45w==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="67953289"
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; 
   d="scan'208";a="67953289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2026 14:39:34 -0800
X-CSE-ConnectionGUID: vC+DQ5pkSwaMyp0CWDmDhw==
X-CSE-MsgGUID: nqfsVbT7Q0GXrxuNhBNw5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; 
   d="scan'208";a="203217809"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jan 2026 14:39:30 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vcWky-000000000y9-1BPW;
	Sun, 04 Jan 2026 22:39:28 +0000
Date: Sun, 4 Jan 2026 23:38:51 +0100
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
Message-ID: <202601042339.7aMa6atC-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260104/202601042339.7aMa6atC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260104/202601042339.7aMa6atC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601042339.7aMa6atC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/realtek/realtek_main.c:1261:16: error: use of undeclared identifier 'mmdreg'; did you mean 'mmdrop'?
    1261 |                                           devnum, mmdreg);
         |                                                   ^~~~~~
         |                                                   mmdrop
   include/linux/sched/mm.h:47:20: note: 'mmdrop' declared here
      47 | static inline void mmdrop(struct mm_struct *mm)
         |                    ^
   drivers/net/phy/realtek/realtek_main.c:1270:19: error: use of undeclared identifier 'mmdreg'; did you mean 'mmdrop'?
    1270 |                                 MII_MMD_DATA, mmdreg);
         |                                               ^~~~~~
         |                                               mmdrop
   include/linux/sched/mm.h:47:20: note: 'mmdrop' declared here
      47 | static inline void mmdrop(struct mm_struct *mm)
         |                    ^
   drivers/net/phy/realtek/realtek_main.c:1309:17: error: use of undeclared identifier 'mmdreg'; did you mean 'mmdrop'?
    1309 |                                            devnum, mmdreg, val);
         |                                                    ^~~~~~
         |                                                    mmdrop
   include/linux/sched/mm.h:47:20: note: 'mmdrop' declared here
      47 | static inline void mmdrop(struct mm_struct *mm)
         |                    ^
   drivers/net/phy/realtek/realtek_main.c:1318:19: error: use of undeclared identifier 'mmdreg'; did you mean 'mmdrop'?
    1318 |                                 MII_MMD_DATA, mmdreg);
         |                                               ^~~~~~
         |                                               mmdrop
   include/linux/sched/mm.h:47:20: note: 'mmdrop' declared here
      47 | static inline void mmdrop(struct mm_struct *mm)
         |                    ^
   4 errors generated.


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

