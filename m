Return-Path: <netdev+bounces-265303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JiTKoF2rWkC3QEAu9opvQ
	(envelope-from <netdev+bounces-265303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:15:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ADB2305DB
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46FAD3006F33
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53199382F09;
	Sun,  8 Mar 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyfGYFnx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D83806C0
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975737; cv=none; b=VYqxSff1KxCMoVl+jLXgxKYDpmYgZ4x/TdZ1Dyfm53Wd8O68Ou0BrR/5oaMoJunSSEp3xoCDBGngWPkN1N33bbi8CdGwdYWQhzJDLBKX/W7Zlq8VhXqKNcIUwMXuau8PR5rNgV0dta46nyTHJ0TvJTmb/bU2nlVnQ0scTCIQZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975737; c=relaxed/simple;
	bh=0GOur689d8dOGKE+EPgs3lS+HUhqtViQTTFNzlXpRPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNiw3ozqUicHS98LLb1LFYWqv3Lgh02sIjW4bGiKpkOBknviY50B3MlXzMLb2SnEa0/EBUXCzHIPW8t9spoINH4omGaeg68ZJ/n6/91xV4W2InMm587XapBrb/zCQEduXgyDeevkj3NGSpW/0Yt4FGR3JZ+5BeC+0az2X/+gf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyfGYFnx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772975736; x=1804511736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0GOur689d8dOGKE+EPgs3lS+HUhqtViQTTFNzlXpRPo=;
  b=QyfGYFnx/GtZCu0Kgq3CKSrIHc8lNMWQxHRn9xJHftGBwCarjisFSH2v
   D4fZDcw+uYtdWFsU4RMl82beTFQRgs4ounXMpx+izztHQFusF5Ou1DLYU
   XcjJI9XjXYkhdxJ7eWrCF7EQpmRgNkuqkQyOUU3O1y3HXP0sXAVPcQrCi
   Xo/3OBwhvGo+ArvOdy56PG1QH02cDB3qEu6ZhcMWGBEKT2HsGMRF40XO/
   2+zTeo6WSXyFEty3ipRnQ+aMtvw2VC1/OIpmxwQgcYlvR1mkCGE8rgWRg
   vm35zrUeh6bf+Yt2aV9uXW4ypK6I6tpMsNwz0hU6a/tNAOxjSJ9mE/Qcm
   A==;
X-CSE-ConnectionGUID: bIM0KEXWSvGzFF9GrJoA8w==
X-CSE-MsgGUID: kIgCtzVhR2WtxARFT+J8Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85492799"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="85492799"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 06:15:35 -0700
X-CSE-ConnectionGUID: /tG/f+c1SiSvDmqnEDYYUA==
X-CSE-MsgGUID: 6/tRRvMmT16I5XnQZRCMDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="224432011"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Mar 2026 06:15:32 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzDyj-0000000037s-1ceF;
	Sun, 08 Mar 2026 13:15:29 +0000
Date: Sun, 8 Mar 2026 21:15:07 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH net-next 2/5] net: phy: make mdio_device.c part of libphy
Message-ID: <202603082137.KWkiQ4Ij-lkp@intel.com>
References: <8600cf79-7604-43c1-8cc0-306e58e31153@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8600cf79-7604-43c1-8cc0-306e58e31153@gmail.com>
X-Rspamd-Queue-Id: 22ADB2305DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265303-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,kernel.org,redhat.com,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/net-phy-move-mdio_device-reset-handling-functions-in-the-code/20260308-053505
base:   net-next/main
patch link:    https://lore.kernel.org/r/8600cf79-7604-43c1-8cc0-306e58e31153%40gmail.com
patch subject: [PATCH net-next 2/5] net: phy: make mdio_device.c part of libphy
config: sparc64-randconfig-002-20260308 (https://download.01.org/0day-ci/archive/20260308/202603082137.KWkiQ4Ij-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603082137.KWkiQ4Ij-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603082137.KWkiQ4Ij-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/phy/broadcom/phy-bcm-ns-usb3.o: in function `bcm_ns_usb3_mdio_driver_init':
>> drivers/phy/broadcom/phy-bcm-ns-usb3.c:241: undefined reference to `mdio_driver_register'
   sparc64-linux-ld: drivers/phy/broadcom/phy-bcm-ns-usb3.o: in function `bcm_ns_usb3_mdio_driver_exit':
>> drivers/phy/broadcom/phy-bcm-ns-usb3.c:241: undefined reference to `mdio_driver_unregister'
   sparc64-linux-ld: drivers/phy/broadcom/phy-bcm-ns2-pcie.o: in function `ns2_pci_phy_driver_init':
>> drivers/phy/broadcom/phy-bcm-ns2-pcie.c:82: undefined reference to `mdio_driver_register'
   sparc64-linux-ld: drivers/phy/broadcom/phy-bcm-ns2-pcie.o: in function `ns2_pci_phy_driver_exit':
>> drivers/phy/broadcom/phy-bcm-ns2-pcie.c:82: undefined reference to `mdio_driver_unregister'


vim +241 drivers/phy/broadcom/phy-bcm-ns-usb3.c

af850e14a7ae49 drivers/phy/broadcom/phy-bcm-ns-usb3.c Rafał Miłecki 2017-06-08  240  
36a94760c98954 drivers/phy/broadcom/phy-bcm-ns-usb3.c Rafał Miłecki 2020-11-13 @241  mdio_module_driver(bcm_ns_usb3_mdio_driver);
e5666281d9eadb drivers/phy/phy-bcm-ns-usb3.c          Rafał Miłecki 2016-08-12  242  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

