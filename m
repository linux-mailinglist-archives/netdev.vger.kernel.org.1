Return-Path: <netdev+bounces-234261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD741C1E3BF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657D83B206D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193232D4807;
	Thu, 30 Oct 2025 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqDlxjYU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE782D29CE;
	Thu, 30 Oct 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795887; cv=none; b=KtI9LFDWUqiRSXxNSNotagccAp721uPuH0H2+e+xlgAwz5NeeCbgg8zuKhdf6fljsgbZrrLSIrA1xgnGdZCDiGKaEDRiZxkQFaPZI7SCe/xS1pR0f0CPtlqdsamb9TjS+6HURSL/XOZkc0nu+PW+kxkyqsJ9njeHU9dpBtdeoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795887; c=relaxed/simple;
	bh=WGWDLBInj4AeDxMqQZfEbkb/bL4NlHKUMLTObwQcNZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEUBAktUaoVik4lVBSzeSfUUquCiXwEYvsHDekC2/+MnhK1/lYvLG0xce0W3wJBBDmml09Qt5Ezlsa4zUfkoqwcM6TNxo473DnvkNpx4HzUfbEy4AJWubfRoVvyYI+iRVvZIvC26V1Ty35Q1f1xrWjIbWIzPDy+xjyPAxwOkTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqDlxjYU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761795885; x=1793331885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WGWDLBInj4AeDxMqQZfEbkb/bL4NlHKUMLTObwQcNZU=;
  b=lqDlxjYUpYifY3L3vTwh3pkZATAVwDVo3zXMKAbnWPaLpY8OIdQVf+ru
   osYf6wDFbCB4TnROgIWWTPamy0vv2wLwwv5/tD5sR2RzQsmAfV68cwTa/
   gohN8g8I0BiEiiGmaN56pmUEhOCtjFfPU41hdtBQ+ppPBYMb0OTdTJUg6
   SqhD98al/QVHAMfqXz0eBnlxRgICTGOSOatmdsyjQdbYLYMreohoQ/R+z
   8w9f+wXOVQlc0dOWZZ/C44d5gYqcBN9NYb5LadB326af6zNaYTOul31mh
   QlR2ui5JTLZb2/SPtTL3+zktwgfWcmVWWPwZOuw54+1F/UcWBg7skHGOh
   A==;
X-CSE-ConnectionGUID: ooGHP3PmQ56eYnrxWQxz4w==
X-CSE-MsgGUID: i6hMcadJRHuK5l3Iz3ZSdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66545794"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="66545794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:44:45 -0700
X-CSE-ConnectionGUID: eD4jHOo8QreLa0vp562jGA==
X-CSE-MsgGUID: fyuA3sPBT7Sg3uyTLILpzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="189912456"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Oct 2025 20:44:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEJXh-000LQO-1h;
	Thu, 30 Oct 2025 03:42:16 +0000
Date: Thu, 30 Oct 2025 11:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: Re: [PATCH net-next] net: phy: nxp-c45-tja11xx: config_init restore
 macsec config
Message-ID: <202510301118.CxEGtEGI-lkp@intel.com>
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
config: parisc-randconfig-r053-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301118.CxEGtEGI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301118.CxEGtEGI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301118.CxEGtEGI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/nxp-c45-tja11xx.c:20:
>> drivers/net/phy/nxp-c45-tja11xx.h:42:6: warning: no previous prototype for 'nxp_c45_macsec_link_change_notify' [-Wmissing-prototypes]
      42 | void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

