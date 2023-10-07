Return-Path: <netdev+bounces-38738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A387BC4E8
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 07:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E1F2820DF
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAB6D1B;
	Sat,  7 Oct 2023 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juA1LG2r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EE2568;
	Sat,  7 Oct 2023 05:50:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A166BBB;
	Fri,  6 Oct 2023 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696657851; x=1728193851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkHv+oAcL7tENq1Yd73stD/FY/Ihm49Ba/5lg337PbE=;
  b=juA1LG2rVJuXSQjjiuekToZHAaOk5iTHOzTB9pFa93PHNcyLmxKPd19t
   rtDzVcjWbb0qkOSDNVf7YTTBX/bewG/shOxVsM6dwoNmPToVBHH8k7zKA
   tNF6kULKq1Oledwa3GwymwrtyBaP5nPBUg+DOqRADu4Adg+7eMw5wG+l7
   iD50e3NV7F12JwYiwu/iALhWQbKY8r9sj2F3nBlpbNeciV8qv/jiRcYim
   mvi+SuJ8iPdhAQixYlZID3yOQJhpn0K2GvgRvUlhuEY8g2QgxySx/H/Ha
   yD7Z34t3qcZDobEBDRQEwUXEOpN8dPehEF0iKyiCvL1ODqzvPiOc1k217
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368973970"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="368973970"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 22:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822754753"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="822754753"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2023 22:50:47 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qp0D7-000425-2h;
	Sat, 07 Oct 2023 05:50:45 +0000
Date: Sat, 7 Oct 2023 13:50:44 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v4 3/3] mctp i3c: MCTP I3C driver
Message-ID: <202310071339.iWeOdKQk-lkp@intel.com>
References: <20231004031316.725107-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004031316.725107-4-matt@codeconstruct.com.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Matt,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/dt-bindings-i3c-Add-mctp-controller-property/20231004-111533
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231004031316.725107-4-matt%40codeconstruct.com.au
patch subject: [PATCH net-next v4 3/3] mctp i3c: MCTP I3C driver
config: x86_64-buildonly-randconfig-005-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071339.iWeOdKQk-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071339.iWeOdKQk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071339.iWeOdKQk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-i3c.c:13:0:
>> drivers/net/mctp/mctp-i3c.c:710:12: error: initializer element is not constant
     I3C_CLASS(I3C_DCR_MCTP, NULL),
               ^
   include/linux/i3c/device.h:166:10: note: in definition of macro 'I3C_CLASS'
      .dcr = _dcr,      \
             ^~~~
   drivers/net/mctp/mctp-i3c.c:710:12: note: (near initialization for 'mctp_i3c_ids[0].dcr')
     I3C_CLASS(I3C_DCR_MCTP, NULL),
               ^
   include/linux/i3c/device.h:166:10: note: in definition of macro 'I3C_CLASS'
      .dcr = _dcr,      \
             ^~~~


vim +710 drivers/net/mctp/mctp-i3c.c

   708	
   709	static const struct i3c_device_id mctp_i3c_ids[] = {
 > 710		I3C_CLASS(I3C_DCR_MCTP, NULL),
   711		{ 0 },
   712	};
   713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

