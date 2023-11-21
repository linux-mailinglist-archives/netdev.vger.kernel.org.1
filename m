Return-Path: <netdev+bounces-49666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419747F3034
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A15B21996
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046A54F95;
	Tue, 21 Nov 2023 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK8A6Nhr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E07D72;
	Tue, 21 Nov 2023 06:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700575487; x=1732111487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ev5J9pqM959jLPv9OxsMqh6WPAkw7w5WSOvzKMBKQ6A=;
  b=GK8A6NhrMptIlpeVRcTltwWCRtDiqyt4+aev7VZI2tOXiyxgJke5mkkx
   amjSgtWplP5g2+TbneVAvH5EgfD5y7H7MPvVa40UkJmc45UXdINNe8TYd
   moX9YN3mNXn+SJ+zTprLKbAd5LNC0lUu9X6eRIDM4MB5ny0ZO6nVLH1Py
   HNiXhEb6vtvwhEQg9NgarNByts7OvdqcF9PHCj2vhDliIy9vnrmlinhYo
   9G8frjeXFswY59Xw3nuauvVSn6+1vVLG/kMVWolujdocbcksvdQ39jCXB
   UKpT4jkDyp+O+daYTBPC7rsq8s3amxDWcvyu2uPr1BEBKuf7NuFuMcfQ7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="422939276"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="422939276"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890261426"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="890261426"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Nov 2023 06:04:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5RMj-0007tc-0O;
	Tue, 21 Nov 2023 14:04:37 +0000
Date: Tue, 21 Nov 2023 22:04:03 +0800
From: kernel test robot <lkp@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202311212153.jL7dVRss-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231121/202311212153.jL7dVRss-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311212153.jL7dVRss-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212153.jL7dVRss-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/qca/qca8k-8xxx.c:1982:5: warning: no previous prototype for function 'qca8k_dsa_port_fdb_dump' [-Wmissing-prototypes]
    1982 | int qca8k_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
         |     ^
   drivers/net/dsa/qca/qca8k-8xxx.c:1982:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1982 | int qca8k_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
         | ^
         | static 
>> drivers/net/dsa/qca/qca8k-8xxx.c:1988:6: warning: no previous prototype for function 'qca8k_dsa_port_stp_state_set' [-Wmissing-prototypes]
    1988 | void qca8k_dsa_port_stp_state_set(struct dsa_switch *ds, int port,
         |      ^
   drivers/net/dsa/qca/qca8k-8xxx.c:1988:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1988 | void qca8k_dsa_port_stp_state_set(struct dsa_switch *ds, int port,
         | ^
         | static 
>> drivers/net/dsa/qca/qca8k-8xxx.c:1995:6: warning: no previous prototype for function 'qca8k_dsa_port_fast_age' [-Wmissing-prototypes]
    1995 | void qca8k_dsa_port_fast_age(struct dsa_switch *ds, int port)
         |      ^
   drivers/net/dsa/qca/qca8k-8xxx.c:1995:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1995 | void qca8k_dsa_port_fast_age(struct dsa_switch *ds, int port)
         | ^
         | static 
>> drivers/net/dsa/qca/qca8k-8xxx.c:2000:5: warning: no previous prototype for function 'qca8k_dsa_set_ageing_time' [-Wmissing-prototypes]
    2000 | int qca8k_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
         |     ^
   drivers/net/dsa/qca/qca8k-8xxx.c:2000:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2000 | int qca8k_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
         | ^
         | static 
>> drivers/net/dsa/qca/qca8k-8xxx.c:2005:5: warning: no previous prototype for function 'qca8k_dsa_port_vlan_filtering' [-Wmissing-prototypes]
    2005 | int qca8k_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
         |     ^
   drivers/net/dsa/qca/qca8k-8xxx.c:2005:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2005 | int qca8k_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
         | ^
         | static 
>> drivers/net/dsa/qca/qca8k-8xxx.c:2012:5: warning: no previous prototype for function 'qca8k_dsa_vlan_add' [-Wmissing-prototypes]
    2012 | int qca8k_dsa_vlan_add(struct dsa_switch *ds, int port,
         |     ^
   drivers/net/dsa/qca/qca8k-8xxx.c:2012:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2012 | int qca8k_dsa_vlan_add(struct dsa_switch *ds, int port,
         | ^
         | static 
   6 warnings generated.


vim +/qca8k_dsa_port_fdb_dump +1982 drivers/net/dsa/qca/qca8k-8xxx.c

  1981	
> 1982	int qca8k_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
  1983				    dsa_fdb_dump_cb_t *cb, void *data)
  1984	{
  1985		return qca8k_port_fdb_dump(ds->priv, port, cb, data);
  1986	}
  1987	
> 1988	void qca8k_dsa_port_stp_state_set(struct dsa_switch *ds, int port,
  1989					  u8 state)
  1990	{
  1991		qca8k_port_stp_state_set(ds->priv, port, state,
  1992					 dsa_to_port(ds, port)->learning, true);
  1993	}
  1994	
> 1995	void qca8k_dsa_port_fast_age(struct dsa_switch *ds, int port)
  1996	{
  1997		qca8k_port_fast_age(ds->priv, port);
  1998	}
  1999	
> 2000	int qca8k_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
  2001	{
  2002		return qca8k_set_ageing_time(ds->priv, msecs);
  2003	}
  2004	
> 2005	int qca8k_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
  2006					  bool vlan_filtering,
  2007					  struct netlink_ext_ack *extack)
  2008	{
  2009		return qca8k_port_vlan_filtering(ds->priv, port, vlan_filtering);
  2010	}
  2011	
> 2012	int qca8k_dsa_vlan_add(struct dsa_switch *ds, int port,
  2013			       const struct switchdev_obj_port_vlan *vlan,
  2014			       struct netlink_ext_ack *extack)
  2015	{
  2016		return qca8k_port_vlan_add(ds->priv, port, vlan, extack);
  2017	}
  2018	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

