Return-Path: <netdev+bounces-269930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJfoKTxZvWkA9QIAu9opvQ
	(envelope-from <netdev+bounces-269930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:27:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 164EE2DBC8C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382C730179DD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE103B9DA8;
	Fri, 20 Mar 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmRGpYMb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EF31F9B9;
	Fri, 20 Mar 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016807; cv=none; b=LYTKXGR94CsMrmENo6B8U7C4XrzfluJc3SQH9LVsfhRXrgb0cXp8oNbSQKngTMVqzO9ZPJL45vRst7edOHdEYUTxaxmG8srk9luhDzSQXmfM2BlhKGY53/+f6Vk11v2btoZlA99r9hMP++PML5l+W3l0RGDhzOsuCEglf/dKlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016807; c=relaxed/simple;
	bh=y1KAz+Qo2KIAojrgIrwzWp+iq0iub9vjOkzH9qUQnOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3q0D0JKQnDOvzdyMbel4FFzgwte4GeK5TH8LK6g6JaimY3MevES0WgMoonxh3742NTkRJSOJEBfzxbVmUihU7z/Il3Uq57PaE66uvlgg5/eSsUAzoggi4Al1uZznplfrWyMbg4Ycfd3HIQH31Fbb/opazE3q68prkcdtJEorwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmRGpYMb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774016806; x=1805552806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y1KAz+Qo2KIAojrgIrwzWp+iq0iub9vjOkzH9qUQnOM=;
  b=WmRGpYMbMstTFdcA+yhGvvIxilivrtr/AnegBdQI7eCnXJXvujKkdIZu
   TQurrUTIfWkuRWfeS0RZPnUA9rvVaP+X10goEZdYItXXCfWfQZmYChgBx
   TwJzD9vHlCMKTZOqxrQvEvWg0T9WdV7S6ZgeAAN/mZEQ5tLknE3FFwL7u
   TxywCGnNuRHaiBm2x0Kmjn6PwPwVZvaTZw1QsLSlMsbsa3qvs1MNZ+ozz
   fcHKCioTPihpYbPZwkfi1mz7cqcgavSCn9lxRtVmFREEMMX4dntbC3vRp
   c2VZNRo9THdrmN6mWymD8c2MrTIa9y7ne56MfVseNofzM/2PdS9yiQV2u
   Q==;
X-CSE-ConnectionGUID: Cq+moa4qTDKELhmydS+0xQ==
X-CSE-MsgGUID: BsT/CdmvTaOsB1EG1iPmUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74994302"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74994302"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:26:45 -0700
X-CSE-ConnectionGUID: DJ9w2MqSQ0SB7oNoKNuhOg==
X-CSE-MsgGUID: nldR9LigRtu7fAmhfFsyXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222392533"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 Mar 2026 07:26:39 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3ank-000000002Sz-0eKM;
	Fri, 20 Mar 2026 14:26:14 +0000
Date: Fri, 20 Mar 2026 22:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
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
Message-ID: <202603202224.XkGRjqgx-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269930-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 164EE2DBC8C
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260320/202603202224.XkGRjqgx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603202224.XkGRjqgx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603202224.XkGRjqgx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:3470:54: error: 'AM64_CPSW_QUIRK_CUT_THRU' undeclared here (not in a function)
    3470 |         .quirks = AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ | AM64_CPSW_QUIRK_CUT_THRU,
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~


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

