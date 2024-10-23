Return-Path: <netdev+bounces-138049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572E9ABB0C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C99E1F2446E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544D2B9A6;
	Wed, 23 Oct 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+PCe2ow"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9E33991;
	Wed, 23 Oct 2024 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647204; cv=none; b=sqDIaeFfGUoNu7gyWV6cPKmVRjUQ91sJndbdt1PxC8+U0rUe6gqp3RltuR7occMj+zcONg0/BRbg72hKl1ZnZswLfQCi3Q8WwiaTLPfJl4oDg5pXjKCYVEYa2OKp5mMhCw3ZN473uIoZUHqY9RMGqOkhydUQiPl0rPqeWrt+5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647204; c=relaxed/simple;
	bh=XRoAf6X2HyEqZxmQMc4DBFsVl4VgzjUS4h7DQliqcC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEuVMoOvDx67vHMpTTSDbFmYwdV2qepaZnwQulDn1Hb4hC/sQzeBC79gB5Meol6ekWF3UHQn/yAx5DhcrTLGkECbPIq5NLu5IDFSoQdqeI3ELU7sotsetXyj2xmsnTnpeDXR5qfXT4V2NpOmmWclPv1t4ohEMNfFIEsJ3xuQ2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+PCe2ow; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647203; x=1761183203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XRoAf6X2HyEqZxmQMc4DBFsVl4VgzjUS4h7DQliqcC8=;
  b=R+PCe2owkva4+zSiSqRC3097pavFR9RFFkLg5mPw0B/2NWC46BIwsBSV
   Ha/ZFxlARl/MLSREs0inhvNYXPSQyeuXConCINhkHjEnO7GZaTwgHNpYX
   nlz//2uUKfNQSU9KxSafkRhJmWxxVrbFeRZfxnvno5thmeecMN/2WhITC
   SXUyDar9IefOv2p/nqgZw5rvwtGr4hzWo4eBGct5X7g384UPCfRqkeYt1
   CJbPDs/iS6SVCuRtb2LQkkoGO8rPmzJMHlntfMFK1GjapPaqVwCZnso6r
   rGj+2D9NHcogg6QmFLA50l6eSZY9rG9yvly4/xngPKNzfu9SwYFkWqyDh
   Q==;
X-CSE-ConnectionGUID: Rz/qPEheRzW1UfVmnrl2vg==
X-CSE-MsgGUID: fMT2PKuuSImfd6wdbCtx0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="40586852"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="40586852"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:33:22 -0700
X-CSE-ConnectionGUID: CFYRJcb6TlSCw5Cngg1KKA==
X-CSE-MsgGUID: aDemVyNTRCi/J/CTKuvRgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80233140"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Oct 2024 18:33:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3QFN-000UK6-39;
	Wed, 23 Oct 2024 01:33:13 +0000
Date: Wed, 23 Oct 2024 09:32:44 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
Message-ID: <202410230843.lGLDpveC-lkp@intel.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Machon/net-sparx5-add-support-for-lan969x-SKU-s-and-core-clock/20241021-220557
base:   30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7
patch link:    https://lore.kernel.org/r/20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f%40microchip.com
patch subject: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
config: nios2-kismet-CONFIG_SPARX5_SWITCH-CONFIG_LAN969X_SWITCH-0-0 (https://download.01.org/0day-ci/archive/20241023/202410230843.lGLDpveC-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241023/202410230843.lGLDpveC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230843.lGLDpveC-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SPARX5_SWITCH when selected by LAN969X_SWITCH
   WARNING: unmet direct dependencies detected for SPARX5_SWITCH
     Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && NET_SWITCHDEV [=n] && HAS_IOMEM [=y] && OF [=y] && (ARCH_SPARX5 || COMPILE_TEST [=n]) && PTP_1588_CLOCK_OPTIONAL [=y] && (BRIDGE [=n] || BRIDGE [=n]=n [=n])
     Selected by [y]:
     - LAN969X_SWITCH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

