Return-Path: <netdev+bounces-243961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D4CAB9A0
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 21:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0352C3014DAD
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD52D73A6;
	Sun,  7 Dec 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxb5ea8H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADF26ED29;
	Sun,  7 Dec 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765138234; cv=none; b=LlCvWJ3OsBi3vp1K+d9xw/t55qQY7y9L+3dWF6lZBwn2Yr9DxxX5ro+Z7LH64OSF0eNPZMYjLPiMvLBR0/xH18qfDN0doAIi/zr4TIeNxpCK+cl8TFFtbtLF+6lf3tOVm5yVVJyI+oMUKWYbr03O5BAug+5uckqrqS8MACFOUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765138234; c=relaxed/simple;
	bh=35W/F/8VbdXLH7Az+KezY2EH8Ryxi2hMJrREwti5yPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5jLaxZ99RDDEJw/MphETC0NRTWSVczsi9QLsSJze0w+1PxaAQdD/LmmEOkGE4ZyS8cOq30XKwSbGBRO7VOvRANGOJ1tJ/SyPEV3qB77nJZ1E/e1+ZXp5v6wxBrl2spwuLBWAaYYpCh3dZP1nqitjG1TRyWLFhQTc7Q/gQwMsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxb5ea8H; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765138232; x=1796674232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=35W/F/8VbdXLH7Az+KezY2EH8Ryxi2hMJrREwti5yPw=;
  b=cxb5ea8H1xJJePdMrq4d45MbW7gDWynLQZBBpHeei1zZ8uy+QJwzcpSp
   U5BpJKBK8MXKlBLYjsZ5Sqy0U8OPl/KJD3XRb8CSy4UZYZpYjySurWzju
   ARZZn76xiI+woLA9nTDPGYr+yD+uoGXEqdCNkeVZdxc6qXF3E1L18pXNR
   DePb3RoeVcVbKz4nxz3sJFlJ5gjiZfoU2JYiR1Iy//TOnZ5eY0ErJrFHz
   CeFMCFcLT5UEjLOSFOeiGf+fA76wnKKOcDGYY3JORSAFCl+Qhl4o+v1DJ
   vdr+sOqx5fufzTmavM1guuJBs5XFIcMAeccJKDAbIq02Z2AAvZgamaIJr
   A==;
X-CSE-ConnectionGUID: fJsYBgjNR7OS4KbgN7v+dA==
X-CSE-MsgGUID: DvUZNM37R5qJ0+3Rv8SVoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77412375"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="77412375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 12:10:32 -0800
X-CSE-ConnectionGUID: cl3n6xIRQ86sk6zfVr991A==
X-CSE-MsgGUID: 5pnB7i6NTSmZgl3mLe+ALQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="195040968"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Dec 2025 12:10:29 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSL5O-00000000Jc9-0jJw;
	Sun, 07 Dec 2025 20:10:26 +0000
Date: Mon, 8 Dec 2025 04:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v2] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <202512080341.Vpa2e40b-lkp@intel.com>
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20251208/202512080341.Vpa2e40b-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512080341.Vpa2e40b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512080341.Vpa2e40b-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/lantiq/mxl-gsw1xx.c: In function 'gsw1xx_pcs_an_restart':
>> drivers/net/dsa/lantiq/mxl-gsw1xx.c:449:35: error: 'gsw1xx_priv' undeclared (first use in this function)
     449 |         cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
         |                                   ^~~~~~~~~~~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:449:35: note: each undeclared identifier is reported only once for each function it appears in


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

