Return-Path: <netdev+bounces-270040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOXfEZKbvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:10:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50F2DFC27
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93A873046AA1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC332ABC0;
	Fri, 20 Mar 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsnPl9Pu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40F31B838;
	Fri, 20 Mar 2026 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033730; cv=none; b=naLjJGiaoedP4TPVbb0QYCKr83Z9pPmmmdphl0Pg03YLAn09s/a4WLkXaO9xHxokQ4F3BCeFHEkNZNjM7Q6AgTFj2+ExSv6CkBx5s46AhoQNNGDtMimr777PQpRWDCz04xYC192SqfZ0dYM16fkTjdOrg3ToURXPT58NIPPVQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033730; c=relaxed/simple;
	bh=7WNZM6g9R3CLfh6cWhvFwVZyrccgJ4B0ROAyC9BBclU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLhSOgWTfJswcKIgWV8U9RMwAR07ruyW+UwL9CQandMCau3ibFcwi1rsmI79j4BWlMDo6BRsVv/lZc3ACjL2kMirkg865cM1jX8C+bY2mJXnKOUQw4cQc1SLcT3yXGzzAkJ6eKEsziVB0tFEjL4AbkaokAjgQ7/IOE4IOadFtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsnPl9Pu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033729; x=1805569729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WNZM6g9R3CLfh6cWhvFwVZyrccgJ4B0ROAyC9BBclU=;
  b=hsnPl9PuA4ePLELW2nWJeNM/4paj/mzgLVQBsvlULuU/q5oQ3iq4qora
   PattH3FuLG8s5ez6rPi/oX+vUUKqLhtYXaOTEkvnnqlRfUGYikbfI8bHN
   9Rgl25CF12t7BkS4+ckqJeiCtsKpvIRECel3Lyh1WLgZ+4BcpghHKbBft
   IM8GSdFGWIpahpe7b3A3lgqUhOCH7XKJlR6cxDV8WFzhb85wqYN1uYjOc
   ihv+wUEUXXiL4corzrc7ztB185GfTLe9gwY5G/O5NO8DTpTFWJz+iOfKQ
   6/Xcp6ioyHpjS6WFjFQBvsgi2yTfGcmilzp/uwB6+nvWZZ838PjLFB7hr
   w==;
X-CSE-ConnectionGUID: PO9UFf0GTzGSGj6CdwbDnA==
X-CSE-MsgGUID: svTdwtuEQtePT6opWU+CHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74829512"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74829512"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:08:48 -0700
X-CSE-ConnectionGUID: rrwaT2HISvqx5APreFqssA==
X-CSE-MsgGUID: oniAF6+OTwupmekwYzMoCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223404640"
Received: from lkp-server02.sh.intel.com (HELO ef9b23065726) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Mar 2026 12:08:43 -0700
Received: from kbuild by ef9b23065726 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3fBq-0000000006z-2ufW;
	Fri, 20 Mar 2026 19:07:47 +0000
Date: Sat, 21 Mar 2026 03:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 6/7] net: ethernet: ti: am65-cpsw: add support for J722S
 SoC family
Message-ID: <202603210254.ABl6TQWc-lkp@intel.com>
References: <4cc3dd9fab460d35215c8f97496b9ae16c5bcb22.1773751309.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc3dd9fab460d35215c8f97496b9ae16c5bcb22.1773751309.git.nora.schiffer@ew.tq-group.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270040-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: DE50F2DFC27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nora,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on net-next/main net/main linus/master v7.0-rc4 next-20260319]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nora-Schiffer/dt-bindings-phy-ti-phy-j721e-wiz-Add-ti-j722s-wiz-10g-compatible/20260320-033344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/4cc3dd9fab460d35215c8f97496b9ae16c5bcb22.1773751309.git.nora.schiffer%40ew.tq-group.com
patch subject: [PATCH 6/7] net: ethernet: ti: am65-cpsw: add support for J722S SoC family
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260321/202603210254.ABl6TQWc-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603210254.ABl6TQWc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603210254.ABl6TQWc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ti/am65-cpsw-nuss.c:762:9: warning: cast to smaller integer type 'enum am65_cpsw_tx_buf_type' from 'void *' [-Wvoid-pointer-to-enum-cast]
     762 |         return (enum am65_cpsw_tx_buf_type)k3_cppi_desc_pool_desc_info(tx_chn->desc_pool,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     763 |                                                                        desc_idx);
         |                                                                        ~~~~~~~~~
>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:3470:47: error: use of undeclared identifier 'AM64_CPSW_QUIRK_CUT_THRU'
    3470 |         .quirks = AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ | AM64_CPSW_QUIRK_CUT_THRU,
         |                                                      ^
   1 warning and 1 error generated.


vim +/AM64_CPSW_QUIRK_CUT_THRU +3470 drivers/net/ethernet/ti/am65-cpsw-nuss.c

  3468	
  3469	static const struct am65_cpsw_pdata j722s_cpswxg_pdata = {
> 3470		.quirks = AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ | AM64_CPSW_QUIRK_CUT_THRU,
  3471		.ale_dev_id = "am64-cpswxg",
  3472		.fdqring_mode = K3_RINGACC_RING_MODE_RING,
  3473		.extra_modes = BIT(PHY_INTERFACE_MODE_SGMII),
  3474	};
  3475	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

