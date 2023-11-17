Return-Path: <netdev+bounces-48529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A19B7EEAE1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827AC1C20905
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB645440C;
	Fri, 17 Nov 2023 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKYYpi2J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC065C2;
	Thu, 16 Nov 2023 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700186899; x=1731722899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e0TD894Ys+/2QUm0Jps1did0LDQgAFnw45pq0b7d2YE=;
  b=NKYYpi2J+fem1nmnYa7qo9lw5K8notWuPrtiE/rEVlqbJ2Y03WgHGtb+
   hqJfCd4yLOms1Srgo7EbMDnKTFNqLkSEJQS7WHjLL3qqwnkQtIgq5Zt/1
   AF8tYr+GKmscGqV6Ndz85Sj48RrGVPY8pegq7XR3v9WtqduhrQm66sKRv
   piBc+JfyeBAu9sQXquOqgREUznQU4cC1FYvUv26MH+2sLorXdeQKv/kvc
   I66S/+yiKMi7kX8KPogo9Dy/4DJcdykUxC4iAttKOYz9eY+xd78iC8O6J
   cdGJ0hBqIdFQ1KJ3AsBBlQSfpVapgWJPnHEyp+y60jnf6kH18BdasprcW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4296730"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="4296730"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="6716717"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2023 18:08:13 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3oHC-0002H9-1t;
	Fri, 17 Nov 2023 02:08:10 +0000
Date: Fri, 17 Nov 2023 10:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 5/8] net: qualcomm: ipqess: add bridge
 offloading features to the IPQESS driver
Message-ID: <202311170937.Pyml72i2-lkp@intel.com>
References: <20231114105600.1012056-6-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-6-romain.gantois@bootlin.com>

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/dt-bindings-net-Introduce-the-Qualcomm-IPQESS-Ethernet-switch/20231114-185953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231114105600.1012056-6-romain.gantois%40bootlin.com
patch subject: [PATCH net-next v3 5/8] net: qualcomm: ipqess: add bridge offloading features to the IPQESS driver
config: i386-kismet-CONFIG_NET_SWITCHDEV-CONFIG_QCOM_IPQ4019_ESS-0-0 (https://download.01.org/0day-ci/archive/20231117/202311170937.Pyml72i2-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231117/202311170937.Pyml72i2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170937.Pyml72i2-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_SWITCHDEV when selected by QCOM_IPQ4019_ESS
   
   WARNING: unmet direct dependencies detected for NET_DSA
     Depends on [n]: NET [=y] && (BRIDGE [=n] || BRIDGE [=n]=n) && (HSR [=n] || HSR [=n]=n) && INET [=n] && NETDEVICES [=y]
     Selected by [y]:
     - QCOM_IPQ4019_ESS [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_QUALCOMM [=y] && (OF [=y] && ARCH_QCOM || COMPILE_TEST [=y])
   
   WARNING: unmet direct dependencies detected for NET_SWITCHDEV
     Depends on [n]: NET [=y] && INET [=n]
     Selected by [y]:
     - QCOM_IPQ4019_ESS [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_QUALCOMM [=y] && (OF [=y] && ARCH_QCOM || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

