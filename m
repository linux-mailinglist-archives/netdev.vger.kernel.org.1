Return-Path: <netdev+bounces-233652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55492C16D44
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D92F1C26395
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71034FF4B;
	Tue, 28 Oct 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJk1Kswi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7734F24D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684793; cv=none; b=DsWHaejOnr11XY+Os1u2y6VvdyG03CspSzi1s0i4Qm7wtSzYvendagIj6EW35gEKyUBJr78oZ+cbej/1Hk0SMJN1vEY5KNXXC3EhivCyM+b0izgE48EySwoMdVVy5zI4+8RCaRL6xlboZpTFaA8k/l2MXQxF09mm6dlLewZ4DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684793; c=relaxed/simple;
	bh=0sqtP4wSyu3F5zPhdplUYW0XpGW23/JaI+gPQLCaGhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwHGWlUR892UA/mngAKrhZPcdHRGkiHsXCNZMnsRaTs9LnGWNbsH5+SCcieM/p2XuCUBX4+YKjOb43qPlugivUsdrVLEBm1Wl6IFGgynIDQegCe+0NRSaOO7GHMq78yCteJGkyA39MGw4MeuYFfyE1e674mEMCUFP7WxrvZiFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJk1Kswi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761684792; x=1793220792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sqtP4wSyu3F5zPhdplUYW0XpGW23/JaI+gPQLCaGhk=;
  b=YJk1Kswio6FITfPorfArn66unF5AVZAJprxu0eChbyEKRY3ZYz7hSA56
   e5Qg3km8YnogZoCl6ghn3dRvUMTBgFgqAiAVKHTAMSFah+buVtwFhaIij
   ytSN7Vx32fcXINB5Ws5An2vcQ4ZmXitXT9WJGacyFDmgw0KnjdSdUUBlE
   IowmuuKDiEOOQjtHm5dev+BTDCbXSAo8zXFPZU4MNNiyiSdtzlzDBBvOq
   qVbYUmQMAearrumoMTOoTnrB4ib14ZsPMZVozoZR/8uDoCRWyk2MYNcW4
   TsEbBv1z+cqmsxd+f+HzV8hWQgEnUkMitUDAaJK6vvJdjekaJV3W5lrrV
   A==;
X-CSE-ConnectionGUID: Dwv1bObqRZGBXDYF5QS2oA==
X-CSE-MsgGUID: 4uPKUiycSzCAHRQmT/uoeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63892959"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63892959"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:53:09 -0700
X-CSE-ConnectionGUID: ca6V4JHqRR2JODUfFRNkPw==
X-CSE-MsgGUID: lIwuCtDwRh2J06TExPNa5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="216330354"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2025 13:53:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDqgi-000JkH-0B;
	Tue, 28 Oct 2025 20:53:04 +0000
Date: Wed, 29 Oct 2025 04:52:59 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to
 PMA/PMD
Message-ID: <202510290438.wwPPh1zV-lkp@intel.com>
References: <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Duyck/net-phy-Add-support-for-25-50-and-100Gbps-PMA-to-genphy_c45_read_pma/20251025-044506
base:   net-next/main
patch link:    https://lore.kernel.org/r/176133848134.2245037.8819965842869649833.stgit%40ahduyck-xeon-server.home.arpa
patch subject: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to PMA/PMD
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251029/202510290438.wwPPh1zV-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290438.wwPPh1zV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510290438.wwPPh1zV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/meta/fbnic/fbnic_swmii.c:17:6: warning: variable 'aui' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      17 |         if (fbd->netdev) {
         |             ^~~~~~~~~~~
   drivers/net/ethernet/meta/fbnic/fbnic_swmii.c:22:10: note: uninitialized use occurs here
      22 |         switch (aui) {
         |                 ^~~
   drivers/net/ethernet/meta/fbnic/fbnic_swmii.c:17:2: note: remove the 'if' if its condition is always true
      17 |         if (fbd->netdev) {
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/meta/fbnic/fbnic_swmii.c:15:8: note: initialize the variable 'aui' to silence this warning
      15 |         u8 aui;
         |               ^
         |                = '\0'
   1 warning generated.


vim +17 drivers/net/ethernet/meta/fbnic/fbnic_swmii.c

     8	
     9	static int
    10	fbnic_swmii_read_pmapmd(struct fbnic_dev *fbd, int regnum)
    11	{
    12		u16 ctrl1 = 0, ctrl2 = 0;
    13		struct fbnic_net *fbn;
    14		int ret = 0;
    15		u8 aui;
    16	
  > 17		if (fbd->netdev) {
    18			fbn = netdev_priv(fbd->netdev);
    19			aui = fbn->aui;
    20		}
    21	
    22		switch (aui) {
    23		case FBNIC_AUI_25GAUI:
    24			ctrl1 = MDIO_CTRL1_SPEED25G;
    25			ctrl2 = MDIO_PMA_CTRL2_25GBCR;
    26			break;
    27		case FBNIC_AUI_LAUI2:
    28			ctrl1 = MDIO_CTRL1_SPEED50G;
    29			ctrl2 = MDIO_PMA_CTRL2_50GBCR2;
    30			break;
    31		case FBNIC_AUI_50GAUI1:
    32			ctrl1 = MDIO_CTRL1_SPEED50G;
    33			ctrl2 = MDIO_PMA_CTRL2_50GBCR;
    34			break;
    35		case FBNIC_AUI_100GAUI2:
    36			ctrl1 = MDIO_CTRL1_SPEED100G;
    37			ctrl2 = MDIO_PMA_CTRL2_100GBCR2;
    38			break;
    39		default:
    40			break;
    41		}
    42	
    43		switch (regnum) {
    44		case MDIO_CTRL1:
    45			ret = ctrl1;
    46			break;
    47		case MDIO_STAT1:
    48			ret = fbd->pmd_state == FBNIC_PMD_SEND_DATA ?
    49			      MDIO_STAT1_LSTATUS : 0;
    50			break;
    51		case MDIO_DEVS1:
    52			ret = MDIO_DEVS_PMAPMD;
    53			break;
    54		case MDIO_CTRL2:
    55			ret = ctrl2;
    56			break;
    57		case MDIO_STAT2:
    58			ret = MDIO_STAT2_DEVPRST_VAL |
    59			      MDIO_PMA_STAT2_EXTABLE;
    60			break;
    61		case MDIO_PMA_EXTABLE:
    62			ret = MDIO_PMA_EXTABLE_40_100G |
    63			      MDIO_PMA_EXTABLE_25G;
    64			break;
    65		case MDIO_PMA_40G_EXTABLE:
    66			ret = MDIO_PMA_40G_EXTABLE_50GBCR2;
    67			break;
    68		case MDIO_PMA_25G_EXTABLE:
    69			ret = MDIO_PMA_25G_EXTABLE_25GBCR;
    70			break;
    71		case MDIO_PMA_50G_EXTABLE:
    72			ret = MDIO_PMA_50G_EXTABLE_50GBCR;
    73			break;
    74		case MDIO_PMA_EXTABLE2:
    75			ret = MDIO_PMA_EXTABLE2_50G;
    76			break;
    77		case MDIO_PMA_100G_EXTABLE:
    78			ret = MDIO_PMA_100G_EXTABLE_100GBCR2;
    79			break;
    80		default:
    81			break;
    82		}
    83	
    84		return ret;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

