Return-Path: <netdev+bounces-176285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9705A69A52
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4617B15A2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FD2135A5;
	Wed, 19 Mar 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+G9RBJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6331DED60;
	Wed, 19 Mar 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416953; cv=none; b=flRkMvc9k6lUOsx2iaBHAcU0BHiGKVVA9s2oV+7pab29ewx4ntoxMv718luz3NQnaV7CJk2C/S3MNrpb1jo9iU3Lx1gokgV9MtdvKYb6YbVR45cAB75bZB0JwU5i5qphUhAilU5+MeKAKAfHm3GC3MCjugUrb5Zd0myI1IRaK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416953; c=relaxed/simple;
	bh=PFr45HKKutwFEw7jn6Bw3slxKl9l7TTdnvJ94iSfra8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7GVdBDJbXQBddrhvH7ZWc50Koz5Hh9xZzXfI5pLnjWib6MT5VGbeXcU15wlgolNA1aIcJahmwsTf6yXf/5jFVbcM35n9ULQiXa6hj4oev79fTI2tdMK6DsxmrxEKgdqhZ8fK18bgUwF+Vcnih2f81W2p7kkz6+veX8hRnfhp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+G9RBJ8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742416952; x=1773952952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFr45HKKutwFEw7jn6Bw3slxKl9l7TTdnvJ94iSfra8=;
  b=V+G9RBJ8UOS0Hb7WHJKvVqJQ15flzjGBSLQAy+nikv76XJi0y4eymwDx
   kKgZXMGhykvGvkDh/IF3V9GYA++LwmVUjQMLKFeMZRBVaoDXg7XgPYIhl
   61XpYTnimBsXAFdWMOcGbiKjKNe4Zs6bjifMIiTeVgIvZtukch4AI0CfC
   qgnvxZiU0Hq1UXOPMpk+BwQMV8PfwdK43M05U2wgmxsvVJSeHJybvXjNB
   sH2LX1kCIl1VYVk8yZ2PuFzhIs8DiON88RzXq3U61EiAyYcpPEIUUva9m
   PIcQ82tik4k2l1RHizLJKaYuH1tJV7ouO1gTFIR2RA6bTuXOCIcyzjgU1
   A==;
X-CSE-ConnectionGUID: ka2OJjpmQ0qWqyuz8innVA==
X-CSE-MsgGUID: X9aXJT86TeeNRqYQrzvOEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="66085225"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="66085225"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:42:29 -0700
X-CSE-ConnectionGUID: 4b0/JhOJSJuAE5DnHQWF6w==
X-CSE-MsgGUID: y8moD0ftS/6BPZeGqXvWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122782440"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2025 13:42:24 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv0F3-000FeQ-2v;
	Wed, 19 Mar 2025 20:42:21 +0000
Date: Thu, 20 Mar 2025 04:41:59 +0800
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
Message-ID: <202503200442.3vYzyScu-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phylink-reset-PCS-Phylink-double-reference-on-phylink_stop/20250319-080303
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250318235850.6411-6-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 5/6] net: pcs: airoha: add PCS driver for Airoha SoC
config: x86_64-randconfig-001-20250320 (https://download.01.org/0day-ci/archive/20250320/202503200442.3vYzyScu-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200442.3vYzyScu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200442.3vYzyScu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/pcs/pcs-airoha.c:2542:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    2542 |         default:
         |         ^
   drivers/net/pcs/pcs-airoha.c:2542:2: note: insert '__attribute__((fallthrough));' to silence this warning
    2542 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/net/pcs/pcs-airoha.c:2542:2: note: insert 'break;' to avoid fall-through
    2542 |         default:
         |         ^
         |         break; 
   1 warning generated.


vim +2542 drivers/net/pcs/pcs-airoha.c

  2521	
  2522	static void airoha_pcs_an_restart(struct phylink_pcs *pcs)
  2523	{
  2524		struct airoha_pcs_priv *priv = phylink_pcs_to_airoha_pcs_port(pcs);
  2525	
  2526		switch (priv->interface) {
  2527		case PHY_INTERFACE_MODE_SGMII:
  2528		case PHY_INTERFACE_MODE_1000BASEX:
  2529		case PHY_INTERFACE_MODE_2500BASEX:
  2530			regmap_set_bits(priv->hsgmii_an, AIROHA_PCS_HSGMII_AN_SGMII_REG_AN_0,
  2531					AIROHA_PCS_HSGMII_AN_SGMII_AN_RESTART);
  2532			udelay(3);
  2533			regmap_clear_bits(priv->hsgmii_an, AIROHA_PCS_HSGMII_AN_SGMII_REG_AN_0,
  2534					  AIROHA_PCS_HSGMII_AN_SGMII_AN_RESTART);
  2535			break;
  2536		case PHY_INTERFACE_MODE_USXGMII:
  2537			regmap_set_bits(priv->usxgmii_pcs, AIROHA_PCS_USXGMII_PCS_AN_CONTROL_0,
  2538					AIROHA_PCS_USXGMII_AN_RESTART);
  2539			udelay(3);
  2540			regmap_clear_bits(priv->usxgmii_pcs, AIROHA_PCS_USXGMII_PCS_AN_CONTROL_0,
  2541					  AIROHA_PCS_USXGMII_AN_RESTART);
> 2542		default:
  2543			return;
  2544		}
  2545	}
  2546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

