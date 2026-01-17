Return-Path: <netdev+bounces-250698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F410D38E0C
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3093015A82
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733F30DD00;
	Sat, 17 Jan 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIWV31P1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022F2040B6;
	Sat, 17 Jan 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768648620; cv=none; b=Qy+XDIO5YpDCw51Ofp9BvL7t+QFQt3wTmVz9Q3F0psjW7Mixhim/oOGhjF1d3oVdEX3eSGAVXPNNZnja+3vN4U87vwFH0rhwD/TF1jd3C6WBCCoHAsERf5M898QtVV68o7yPT6C2SVpPQKB4Ii8lSgvmyYB2a0tO1Ov0fpYzPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768648620; c=relaxed/simple;
	bh=vG3VbTxQ0ezcKDCJQGrIOXOv+kGGPwQY7ihkAARSdBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO2JSUNFTFMV85Bou7pldHTA+fYL7DZLFCTaPbFGpUzQsqJkI7+ysnL7z70PdRopxCkjTTfR0CKupjYp6HsBZs0tyielr5I0IYZS1PDpYNKAkeB7t1nwmXcw6pIm0ISEIPBgXU7sosZyqnBkN6aFxT9xAf31oSex+z8XWUPncfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIWV31P1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768648618; x=1800184618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vG3VbTxQ0ezcKDCJQGrIOXOv+kGGPwQY7ihkAARSdBk=;
  b=MIWV31P1HXNKlIK7soOHXiMd7l4oUho4CJdmyhHR/nu38bOFd3opFGvF
   /LC8Up/bdTT5J/OmOjEI9XLyNYZiROw6n48miWNpxRA/p1K7l+NXYsFeF
   MTnvEsl8+7bkwu7inMOHlHxh8fqSZ9oyBFi6HfVwcWDRouCAGOcDN6bx1
   nexWbk/4CNtSSxm+2Rqc9xaF3hG0fisxNTUGJiAVaOcDQ/TGPUdhlAV9y
   hyhTPqM5p4CONowKHLf8XZ7Zi638cF4eTH5X1XRWd2ud5kOMFMM6jDkkL
   n87e76lA74JylGFq2k6BJGMMyjxAe/Y5CqxUWLt6kDovbLgMFFEE9+zdV
   g==;
X-CSE-ConnectionGUID: ekT//rodTi+rl39ovKxTeQ==
X-CSE-MsgGUID: iW76IBhqQeWpWGq4RkKz4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73574098"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="73574098"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 03:16:57 -0800
X-CSE-ConnectionGUID: 8I64+JI3TPGuBWDcQKRiyQ==
X-CSE-MsgGUID: 4aTy5/cXTzmvMWyl8MNMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="205066079"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jan 2026 03:16:53 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh4IU-00000000LnQ-34V8;
	Sat, 17 Jan 2026 11:16:50 +0000
Date: Sat, 17 Jan 2026 19:15:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Chen Minqiang <ptpt52@gmail.com>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v4 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <202601171803.vxrrhXdF-lkp@intel.com>
References: <d5cbb8c5917197d44b62d39c9799212d1b3fe390.1768612113.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cbb8c5917197d44b62d39c9799212d1b3fe390.1768612113.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/dt-bindings-net-dsa-lantiq-gswip-use-correct-node-name/20260117-092406
base:   net-next/main
patch link:    https://lore.kernel.org/r/d5cbb8c5917197d44b62d39c9799212d1b3fe390.1768612113.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v4 3/6] net: dsa: lantiq: allow arbitrary MII registers
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260117/202601171803.vxrrhXdF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601171803.vxrrhXdF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601171803.vxrrhXdF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dsa/lantiq/mxl-gsw1xx.c:708:28: error: array designator index (7) exceeds array bounds (7)
     708 |                 [GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS] = -1,
         |                                          ^~~~~~~~~~~~~~~
   drivers/net/dsa/lantiq/lantiq_gswip.h:246:26: note: expanded from macro 'GSWIP_MAX_PORTS'
     246 | #define GSWIP_MAX_PORTS         7
         |                                 ^
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:713:28: error: array designator index (7) exceeds array bounds (7)
     713 |                 [GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS] = -1,
         |                                          ^~~~~~~~~~~~~~~
   drivers/net/dsa/lantiq/lantiq_gswip.h:246:26: note: expanded from macro 'GSWIP_MAX_PORTS'
     246 | #define GSWIP_MAX_PORTS         7
         |                                 ^
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:749:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     749 |                 [GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
         |                                     ^~~~~~~~~~~~~~~~~
   drivers/net/dsa/lantiq/lantiq_gswip.h:60:28: note: expanded from macro 'GSWIP_MII_CFGp'
      60 | #define GSWIP_MII_CFGp(p)               (0x2 * (p))
         |                                         ^~~~~~~~~~~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:748:33: note: previous initialization is here
     748 |                 [0 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                               ^~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:750:51: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     750 |                 [GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                                                 ^~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:748:33: note: previous initialization is here
     748 |                 [0 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                               ^~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:754:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     754 |                 [GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
         |                                     ^~~~~~~~~~~~~~~
   drivers/net/dsa/lantiq/lantiq_gswip.h:80:27: note: expanded from macro 'GSWIP_MII_PCDU0'
      80 | #define GSWIP_MII_PCDU0                 0x01
         |                                         ^~~~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:753:33: note: previous initialization is here
     753 |                 [0 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                               ^~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:755:51: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     755 |                 [GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                                                 ^~
   drivers/net/dsa/lantiq/mxl-gsw1xx.c:753:33: note: previous initialization is here
     753 |                 [0 ... GSWIP_MAX_PORTS - 1] = -1,
         |                                               ^~
   4 warnings and 2 errors generated.


vim +708 drivers/net/dsa/lantiq/mxl-gsw1xx.c

   701	
   702	static const struct gswip_hw_info gsw12x_data = {
   703		.max_ports		= GSW1XX_PORTS,
   704		.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
   705		.mii_cfg = {
   706			[0 ... GSW1XX_MII_PORT - 1] = -1,
   707			[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
 > 708			[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS] = -1,
   709		},
   710		.mii_pcdu = {
   711			[0 ... GSW1XX_MII_PORT - 1] = -1,
   712			[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
   713			[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS] = -1,
   714		},
   715		.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
   716		.phylink_get_caps	= &gsw1xx_phylink_get_caps,
   717		.supports_2500m		= true,
   718		.pce_microcode		= &gsw1xx_pce_microcode,
   719		.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
   720		.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
   721	};
   722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

