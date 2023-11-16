Return-Path: <netdev+bounces-48428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5C7EE4F2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9511F23F0C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971B3A8E8;
	Thu, 16 Nov 2023 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNJNgO4T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C61A8;
	Thu, 16 Nov 2023 08:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700150967; x=1731686967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jAC/OAjhM3lZ3eKiniR3cDYGZlMg0wHRHqqAdytbUs=;
  b=XNJNgO4TLZfgLzL+UBt5X30dErXMWbErtHUBGMNIn43Gb2VTCUPCQgHf
   okQooLgxCzKWycOHupOiqc8ccPVIs4u6j+s4Y8fpEY0dOb0A/Ar1EojRi
   lodZAO7lZ9yzohrUgrprIvwaU14PMbHOquAAgLrwl1BudwHXlhy7Sl89O
   TGozdPzDyON7hWxR4lo/Qoykg7H8LLFTSb5BxB1q/9sIg9ypjeiPDKYeu
   OZhCVqBF88kdkgUJgrxlVpJUEoRiSWjb0EDDGMhWRtzXqo1svNttlOrRk
   SUu1ABpWU7JCj10yLbDfXJG8GDw6e/Uol9bu3c/8obQXfEkr4WK8FlkuX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4244382"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="4244382"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 08:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="758878380"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="758878380"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2023 08:09:19 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3evd-0001rX-00;
	Thu, 16 Nov 2023 16:09:17 +0000
Date: Fri, 17 Nov 2023 00:08:41 +0800
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
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
Message-ID: <202311162336.2BYtVL3Q-lkp@intel.com>
References: <20231114105600.1012056-4-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-4-romain.gantois@bootlin.com>

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/dt-bindings-net-Introduce-the-Qualcomm-IPQESS-Ethernet-switch/20231114-185953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231114105600.1012056-4-romain.gantois%40bootlin.com
patch subject: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the Qualcomm IPQESS driver
config: i386-kismet-CONFIG_NET_DSA-CONFIG_QCOM_IPQ4019_ESS-0-0 (https://download.01.org/0day-ci/archive/20231116/202311162336.2BYtVL3Q-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311162336.2BYtVL3Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311162336.2BYtVL3Q-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_DSA when selected by QCOM_IPQ4019_ESS
   
   WARNING: unmet direct dependencies detected for NET_DSA
     Depends on [n]: NET [=y] && (BRIDGE [=n] || BRIDGE [=n]=n) && (HSR [=n] || HSR [=n]=n) && INET [=n] && NETDEVICES [=y]
     Selected by [y]:
     - QCOM_IPQ4019_ESS [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_QUALCOMM [=y] && (OF [=n] && ARCH_QCOM || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

