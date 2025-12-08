Return-Path: <netdev+bounces-243969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599CCABBAC
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 02:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A663008EB8
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825791898F8;
	Mon,  8 Dec 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmyrsQr3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A94883F;
	Mon,  8 Dec 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765157507; cv=none; b=AWyoi5PK38/aabKOnvLwgSYGzYkYc5EpCKxpEE3OWixlJ8/7cBBsQEavZ/DNhEMVe3X1t1MKWNxw+JrBXI6y6Wxiza5kiZlqH5V71pQQu4fpVhZFmEEXP4JfALbHxD5Mo9329klDyNAvYP5z4Wbaj/s7/2eF17pwsZwxId2ffA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765157507; c=relaxed/simple;
	bh=zvJRV6o6Wr9Me71mfIOZJP08UlIKewB4/Sn+iuvZKzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M74mUkImlMMSOFdTvsqbbZ6Z5qg0njTbvFwJHc7Ub1xBq5FhkxqcPHQwLI8K3NGftG6ECHAeDYm6KoGe3oA0SKkXaxlPOrzYbmXj997l9izUtpc+jpIp9T75mErtOH5EeXezPIbQjUSfMGE1ak8p3n2r4tfrEbbdodmC7irvzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmyrsQr3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765157505; x=1796693505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvJRV6o6Wr9Me71mfIOZJP08UlIKewB4/Sn+iuvZKzk=;
  b=fmyrsQr3w1fW9RqiaURqFdQgY5RUdZX2yiwKf1Xv7jTzNIAvjPSHAa5F
   zOqz+ceZD82ISVuR/yg5mXAYCFPlI6LjdXPfYjDGAY1AosPgQtg65qvIm
   gmxPhAgMpBRjwaPKA9zc5TQaB5EkZrN4iCRGtLHsRthiuzeP8InCA8n0r
   UHd8bqEcnr6g8jzmQDeOr6FTlnhps4UY0WYmlXCgeDpxNpJX/J5LhnXS1
   K7EZRPf0rR+U70ctKqFhDVJyhgECp0JQ8htdMSO0cTBHKQNY5QYlhpkYN
   ce1zNgJF5OQp6zWnlMdEDEoz5Iu9CtWw+VAtfEtUTzAT+mqSEfFnQJEL/
   g==;
X-CSE-ConnectionGUID: tBuJ7FHuSO+mz/9LOC+gyA==
X-CSE-MsgGUID: MkwIWbVsRJOzaRDWrH8dNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67135836"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="67135836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 17:31:44 -0800
X-CSE-ConnectionGUID: fynQ8TCeTsWNiPC88ojcfw==
X-CSE-MsgGUID: ohJrw/MOSwauuXVqrsOGaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="200248349"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Dec 2025 17:31:40 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSQ6E-00000000Jmz-1fwz;
	Mon, 08 Dec 2025 01:31:38 +0000
Date: Mon, 8 Dec 2025 09:31:13 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v2] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <202512080800.2VZCNFnY-lkp@intel.com>
References: <a90b206e9fd8e4248fd639afd5ae296454ac99b9.1765060046.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90b206e9fd8e4248fd639afd5ae296454ac99b9.1765060046.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-dsa-mxl-gsw1xx-manually-clear-RANEG-bit/20251207-063852
base:   net/main
patch link:    https://lore.kernel.org/r/a90b206e9fd8e4248fd639afd5ae296454ac99b9.1765060046.git.daniel%40makrotopia.org
patch subject: [PATCH net v2] net: dsa: mxl-gsw1xx: manually clear RANEG bit
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20251208/202512080800.2VZCNFnY-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512080800.2VZCNFnY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512080800.2VZCNFnY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dsa/lantiq/mxl-gsw1xx.c:449:28: error: use of undeclared identifier 'gsw1xx_priv'
           cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
                                     ^
   1 error generated.


vim +/gsw1xx_priv +449 drivers/net/dsa/lantiq/mxl-gsw1xx.c

   444	
   445	static void gsw1xx_pcs_an_restart(struct phylink_pcs *pcs)
   446	{
   447		struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
   448	
 > 449		cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
   450	
   451		regmap_set_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
   452				GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
   453	
   454		/* despite being documented as self-clearing, the RANEG bit
   455		 * sometimes remains set, preventing auto-negotiation from happening.
   456		 * MaxLinear advises to manually clear the bit after 10ms.
   457		 */
   458		schedule_delayed_work(&priv->clear_raneg, msecs_to_jiffies(10));
   459	}
   460	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

