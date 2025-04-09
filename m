Return-Path: <netdev+bounces-180566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F27A81B0C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF37C3B4C1A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1F19CC20;
	Wed,  9 Apr 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6qgTGza"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472F29D0E;
	Wed,  9 Apr 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165962; cv=none; b=Dvab4xnqeOLxBtlJdGVwBWp5A2FlnyMiXWd2ONSvZrvb/nD0knEvEn6Rf/gvRYca/RWQbBiRxQ0kFmwTyzQUTsjwSdYvzKvzRnoKpEYftqjTH0Cm9RQZojgW2+SsqaWx040tdUHI19Kp3wR1QQ7XIYCRF3SbV7BCndnCqdaDol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165962; c=relaxed/simple;
	bh=vnaDNkCLPpmH76yQp56KQf7WqL8mrYB+8sRUh34dcGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI5WYNHXTVJzqVe10LJinmQ2gREX5zi5uzxTVkBwBXtK8Ar6lyQ5H9B0S8f499QRtOiAGiJmae5/gM6DR0RICrGa66MF3mmlf2NmCu7q2ak47ZdT41L0uQNvOzmVFonRXlxEXezfCvdhWVPr7bs9LGWKoqwqmdVSh2ckxV8ywS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6qgTGza; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744165960; x=1775701960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vnaDNkCLPpmH76yQp56KQf7WqL8mrYB+8sRUh34dcGc=;
  b=P6qgTGzaq1oFnypmWHPMeDDkPCphjrDRqSnBygJic0NXVwZiFiTlMVIP
   OYSr5l+Ak81jM90K9L6KQoZ7j7FL9U988ifUynMJaIphqKz0oKpuxaROz
   nPdXs2P0im5KMjqiLqpPhpkmrR+nabXS4gpZMjXKevq8zErGV02cvgDak
   8uu4bjs3rQuqPZ0/iCbrBsV2OvXlIPB+G+e3pHMwOdEEUOcPL4I3OYla5
   K1MhfH00k0xhydT6K7rx8ESzZEDdtZm93gXrPP9c2UPtiZIuAMRCeddnE
   fe+5RzQqOTqwXZ4uDqCnjkW31GNP4w8YuXZf7FegC4ZhOTSthIJdRzrWL
   w==;
X-CSE-ConnectionGUID: c1jEaNKlSgekA1mR5WPwkw==
X-CSE-MsgGUID: 7xa7UVUrQBWVizrYkZk1kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49465359"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49465359"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 19:32:37 -0700
X-CSE-ConnectionGUID: thhpgLzqTnyYqgpIXkTxAQ==
X-CSE-MsgGUID: 9HlMwltuT7uIdLoQ6jkFpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151634018"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2025 19:32:33 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2LEt-0008CT-07;
	Wed, 09 Apr 2025 02:32:31 +0000
Date: Wed, 9 Apr 2025 10:32:03 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
	upstream@airoha.com, Kory Maincent <kory.maincent@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS
 subsystem
Message-ID: <202504091007.RSwPrfcI-lkp@intel.com>
References: <20250407232058.2317056-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407232058.2317056-1-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250408-072650
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250407232058.2317056-1-sean.anderson%40linux.dev
patch subject: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS subsystem
config: arm-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504091007.RSwPrfcI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504091007.RSwPrfcI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504091007.RSwPrfcI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/xilinx/xilinx_axienet_main.c:38:0:
   include/linux/pcs.h: In function 'pcs_get':
>> include/linux/pcs.h:165:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return -EOPNOTSUPP;
            ^
   include/linux/pcs.h: In function 'pcs_get_by_fwnode':
   include/linux/pcs.h:178:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return -EOPNOTSUPP;
            ^
   include/linux/pcs.h: In function 'pcs_get_by_dev':
   include/linux/pcs.h:191:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return -EOPNOTSUPP;
            ^


vim +165 include/linux/pcs.h

b7da98b4ee6f2f Sean Anderson 2025-04-07  162  
b7da98b4ee6f2f Sean Anderson 2025-04-07  163  static inline struct phylink_pcs *pcs_get(struct device *dev, const char *id)
b7da98b4ee6f2f Sean Anderson 2025-04-07  164  {
b7da98b4ee6f2f Sean Anderson 2025-04-07 @165  	return -EOPNOTSUPP;
b7da98b4ee6f2f Sean Anderson 2025-04-07  166  }
b7da98b4ee6f2f Sean Anderson 2025-04-07  167  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

