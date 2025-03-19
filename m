Return-Path: <netdev+bounces-176216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E821CA695E1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBAE463B76
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD01E8354;
	Wed, 19 Mar 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kl1G++Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CF1B4138;
	Wed, 19 Mar 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403962; cv=none; b=tNcmigvwJ3XMqGqx0MQpUqO4uQVkLA9JZn7WHM1vEWoRL6GXiOjxNUeQliV4hNwqN7xMpIEL+TPc/uGEVJSYiqk4zkywIfTY5DNZZzntY7vnpXPGBwwP4nHs8Uwh1pqtOwSYQWIj0a7BsHvxslE8I1ppPzm9C0bqgVX40H1GXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403962; c=relaxed/simple;
	bh=XNw9v104Cv6J/m0lCrnonH70/fqdUx+x7sY45hivCcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKyZ/4fSRCWviP74vJ2s1Rh7gfttz8E9v9UW2kB/RrVJNB4jVBHL7NZb6fv82Vnx2Bnk7AWOakpFwMAknPL0/AIVC81ca8fitwUGEQVYNpe0emqbTBAaoUjI9jakuTLImDslmV8zymIhrnThNLce3MVP3pIzaesICGgbKbUfCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kl1G++Nj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742403961; x=1773939961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNw9v104Cv6J/m0lCrnonH70/fqdUx+x7sY45hivCcY=;
  b=Kl1G++NjXgiz4OWiI9rcC0il1YVz9wyoAF0R5XGTfM5NcSsL0fkCihDv
   c9WY1qyvyPN04g8fI2Q0MNvgraFPQ49OUAc9Sw6ldDpIVUEUt+IXcEgXN
   awLEAvTXw4zl1UY++BgiOS/NAwBy3muYmVGe4TQ3TucUWGTewfBXaQKry
   EeMqemsWUkPqcJjHPtM6ybogTzCXo5LSVJywcz04NrbG1pqsKChBm7JvS
   F7Q0ki3o8HWfwdRNA5GJsAFETQ539sXbsOfMEOh3FSgPDYaJmNI6wsd+v
   oL+MfCpVaIIemqjD9jh1YuQg1wvWVlOQquU/3ahx+QZbcxveZjOAfhYpT
   w==;
X-CSE-ConnectionGUID: +gElJzHJTxW7Ftb1+f+1BA==
X-CSE-MsgGUID: JyFaX8lBSpOYr4W8/z8W1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="68960324"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="68960324"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 10:06:00 -0700
X-CSE-ConnectionGUID: ZPFUq9aRTv2NWoRz2V8MzQ==
X-CSE-MsgGUID: GDCkSm1PS0++12vK7fhVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127403489"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2025 10:05:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuwra-000FYM-0E;
	Wed, 19 Mar 2025 17:05:54 +0000
Date: Thu, 20 Mar 2025 01:05:33 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS
 driver
Message-ID: <202503200045.AFf6buBJ-lkp@intel.com>
References: <20250318235850.6411-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-3-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phylink-reset-PCS-Phylink-double-reference-on-phylink_stop/20250319-080303
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250318235850.6411-3-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS driver
config: i386-buildonly-randconfig-002-20250319 (https://download.01.org/0day-ci/archive/20250320/202503200045.AFf6buBJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200045.AFf6buBJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200045.AFf6buBJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phylink.c:989: warning: Function parameter or struct member 'pcs' not described in 'phylink_pcs_release'
>> drivers/net/phy/phylink.c:989: warning: Excess function parameter 'pl' description in 'phylink_pcs_release'


vim +989 drivers/net/phy/phylink.c

   978	
   979	/**
   980	 * phylink_pcs_release() - release a PCS
   981	 * @pl: a pointer to &struct phylink_pcs
   982	 *
   983	 * PCS provider can use this to release a PCS from a phylink
   984	 * instance by stopping the attached netdev. This is only done
   985	 * if the PCS is actually attached to a phylink, otherwise is
   986	 * ignored.
   987	 */
   988	void phylink_pcs_release(struct phylink_pcs *pcs)
 > 989	{
   990		struct phylink *pl = pcs->phylink;
   991	
   992		if (pl) {
   993			rtnl_lock();
   994			dev_close(pl->netdev);
   995			rtnl_unlock();
   996		}
   997	}
   998	EXPORT_SYMBOL_GPL(phylink_pcs_release);
   999	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

