Return-Path: <netdev+bounces-234273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E59C1E62D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B436E3B438E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95D32AAB7;
	Thu, 30 Oct 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGZ0FWUV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F2329C53;
	Thu, 30 Oct 2025 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800376; cv=none; b=R3tB8VSSvu0khMIS0SOzvC9mQ6Llt/yzkLbsLFD04ScBoyedSU10n8WrXfrc7dS294CavnEtl3ITsnHzr9gcfXC5QNt4TYic1QlKLeDyzO6Cl0GVnHMRmM+J1aLXQMcnhpWgZgPJs1BKsGw6rzd123SuyV8CSwAQEFbW3D54gIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800376; c=relaxed/simple;
	bh=XrSWWjKUo7m9rj5cc4tuAtsaIQt7tpo1lwMllKwYVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG+SqjiNzjaFH7vDxPV8aZ7qu4Wki9x7AgVXiNNcB6nNUL1PxgD8n9Llzso05jtVuDBS6eizBbsVzlGh1A/PZhtB2iAnEZpyt+HpbUzo8jZ+BBBpSL77Ty6fvS8Vi+N6862Ctpa9+HMKUzkT95bCoXRX3oWP/GanAYDxa7w5LTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGZ0FWUV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761800375; x=1793336375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrSWWjKUo7m9rj5cc4tuAtsaIQt7tpo1lwMllKwYVkE=;
  b=kGZ0FWUVqGlr/a7mkdO6JEW2FQQPnJVlOJENyU1f1Mu0691Cdu8gNhxi
   jN0lDgxWVYQ/4HVymEQjQSF46bLWdXtppRvIbNM4DlwtvWzRcgTpFE1pU
   yJHJA54WHyXHFsb6SisWgOKLCsp6ehJp8l852QEm15/kqnFC8P4GYU7Xc
   ScGnbieJMXcgnCuwswP8QkbYI+wpLHr7GaJuBCthZYzVLk6ugtx6TQdLh
   p2QQNSTWQESgPjaOVtesKg4ARfWmZ+5lZ3YDqqtmTCWGaIRR+2I8krMa8
   hLenuesmqtUcFiLtk+K2x1SL/OMw6S74fgIOf/KUl+RMMRY0jWMOHQz6r
   A==;
X-CSE-ConnectionGUID: LST+datSTeOwkFCegHvyMQ==
X-CSE-MsgGUID: Mg9ugy55SaqpG6cxHSRUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64030004"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64030004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:59:34 -0700
X-CSE-ConnectionGUID: bQZdnZDLReSi76ExYndiCg==
X-CSE-MsgGUID: SQ5nwnfASfK/7dgA9AJjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="223075256"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Oct 2025 21:59:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEKkx-000LTs-0r;
	Thu, 30 Oct 2025 04:59:27 +0000
Date: Thu, 30 Oct 2025 12:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: Re: [PATCH net-next] net: phy: nxp-c45-tja11xx: config_init restore
 macsec config
Message-ID: <202510301246.x4ua5CJ6-lkp@intel.com>
References: <20251029104258.1499069-1-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029104258.1499069-1-andrei.botila@oss.nxp.com>

Hi Andrei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrei-Botila/net-phy-nxp-c45-tja11xx-config_init-restore-macsec-config/20251029-185313
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251029104258.1499069-1-andrei.botila%40oss.nxp.com
patch subject: [PATCH net-next] net: phy: nxp-c45-tja11xx: config_init restore macsec config
config: x86_64-randconfig-076-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301246.x4ua5CJ6-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301246.x4ua5CJ6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301246.x4ua5CJ6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/nxp-c45-tja11xx.c:20:
>> drivers/net/phy/nxp-c45-tja11xx.h:42:6: warning: no previous prototype for function 'nxp_c45_macsec_link_change_notify' [-Wmissing-prototypes]
      42 | void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
         |      ^
   drivers/net/phy/nxp-c45-tja11xx.h:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      42 | void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
         | ^
         | static 
   1 warning generated.


vim +/nxp_c45_macsec_link_change_notify +42 drivers/net/phy/nxp-c45-tja11xx.h

    33	
    34	#if IS_ENABLED(CONFIG_MACSEC)
    35	void nxp_c45_macsec_link_change_notify(struct phy_device *phydev);
    36	int nxp_c45_macsec_config_init(struct phy_device *phydev);
    37	int nxp_c45_macsec_probe(struct phy_device *phydev);
    38	void nxp_c45_macsec_remove(struct phy_device *phydev);
    39	void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
    40					     irqreturn_t *ret);
    41	#else
  > 42	void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
    43	{
    44	}
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

