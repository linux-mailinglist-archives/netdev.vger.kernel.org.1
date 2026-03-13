Return-Path: <netdev+bounces-267572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGtqA85qtGn9ngAAu9opvQ
	(envelope-from <netdev+bounces-267572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7C289716
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156053111598
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECC390999;
	Fri, 13 Mar 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmxXZccK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF240388E59;
	Fri, 13 Mar 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431421; cv=none; b=aQ2P4McvvPMkdayYsV0em1r8xws8z+tjsvddyUq5hkTadZoCp6BYOCSh7JjtvObnOUANEA5MtMLZOIqAJ8AVmZ5DTzZSOt3/PkA5ZQvgf2H15K4W3sizee4BVEgMtLwXyqA+jB0D9WIl8Z0Svpyw35jg/KzFNpwbUXuDYDQS72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431421; c=relaxed/simple;
	bh=2yBCYa2goQHEMmE1k4SHkPwXDkUt+BCmZISdg4ehhOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stL/jVFmb8t+t1M/PLAopHbPHfLzRcLXeqEOZZ7Whu7RTNBJdLSV6yuXDbA0UwdmJY9mBDJIqkakbvXxx5MrXQneU5fi7w8gQ9jR3hWXLQlA1y/Z1gPb5ja5239OCuu/rFF6zsxECVVx2wAh/iaSVsLfdLEzowE4cO+p9lT7nKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmxXZccK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773431420; x=1804967420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yBCYa2goQHEMmE1k4SHkPwXDkUt+BCmZISdg4ehhOU=;
  b=ZmxXZccKNcDONi0wz30JSNU2/nvvEb6gweBApTLz4Ve/9FTa4gmN/y+/
   2FMMQK2c8khbGhoruwa5UernBeCrAWVC/H49q2WIQHfay2ou4WCV/dKAa
   sTvpKBBB7i9O0y1euJgOt1aE2L31GHTCgb6gY6wpZ73e9ua7sulLqUIiq
   T3kxKjwV8Sm3mxLOnsK9/geM65FZSf/eVHJT58HlIeSiFr7P2+AaZjDJ/
   SJPh0ewTU/L/k6H519mzrjx0+yP4tIhjQYetSsxwuZGY8yrTwklQGm1RE
   u9ly9y4foTFFPEskBIEpjDLTfriSDNL4AdCNSm5Y6tVfXUSIOiAE+gwtq
   w==;
X-CSE-ConnectionGUID: 37RmjT/VQhuCp/ZOGZor3g==
X-CSE-MsgGUID: Wp9adUFqRgC/ygvcql9mVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74660086"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74660086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:50:19 -0700
X-CSE-ConnectionGUID: TtppXxqqSbe/6BojyOSYlA==
X-CSE-MsgGUID: kyiZqeEoSI+5J4z8lD5Edg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251775876"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 13 Mar 2026 12:50:15 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w18WT-000000003hV-0A89;
	Fri, 13 Mar 2026 19:50:13 +0000
Date: Fri, 13 Mar 2026 20:50:05 +0100
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 13/15] net: stmmac: add helper to set
 transmit tail pointer
Message-ID: <202603132053.N3kL3UZZ-lkp@intel.com>
References: <E1w0czK-0000000CzH7-19Fb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w0czK-0000000CzH7-19Fb@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267572-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 60F7C289716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-rearrange-stmmac_tx_info-members-to-pack-better/20260313-225823
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1w0czK-0000000CzH7-19Fb%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next v2 13/15] net: stmmac: add helper to set transmit tail pointer
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260313/202603132053.N3kL3UZZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603132053.N3kL3UZZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603132053.N3kL3UZZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:430:26: error: call to undeclared function 'dma_desc_to_edesc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     430 |                 struct dma_edesc *ep = dma_desc_to_edesc(head);
         |                                        ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:430:21: error: incompatible integer to pointer conversion initializing 'struct dma_edesc *' with an expression of type 'int' [-Wint-conversion]
     430 |                 struct dma_edesc *ep = dma_desc_to_edesc(head);
         |                                   ^    ~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/dma_desc_to_edesc +430 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c

   396	
   397	static void dwmac4_display_ring(void *head, unsigned int size, bool rx,
   398					dma_addr_t dma_rx_phy, unsigned int desc_size)
   399	{
   400		dma_addr_t dma_addr;
   401		int i;
   402	
   403		pr_info("%s descriptor ring:\n", rx ? "RX" : "TX");
   404	
   405		if (desc_size == sizeof(struct dma_desc)) {
   406			struct dma_desc *p = (struct dma_desc *)head;
   407	
   408			for (i = 0; i < size; i++) {
   409				dma_addr = dma_rx_phy + i * sizeof(*p);
   410				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
   411					i, &dma_addr,
   412					le32_to_cpu(p->des0), le32_to_cpu(p->des1),
   413					le32_to_cpu(p->des2), le32_to_cpu(p->des3));
   414				p++;
   415			}
   416		} else if (desc_size == sizeof(struct dma_extended_desc)) {
   417			struct dma_extended_desc *extp = (struct dma_extended_desc *)head;
   418	
   419			for (i = 0; i < size; i++) {
   420				dma_addr = dma_rx_phy + i * sizeof(*extp);
   421				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
   422					i, &dma_addr,
   423					le32_to_cpu(extp->basic.des0), le32_to_cpu(extp->basic.des1),
   424					le32_to_cpu(extp->basic.des2), le32_to_cpu(extp->basic.des3),
   425					le32_to_cpu(extp->des4), le32_to_cpu(extp->des5),
   426					le32_to_cpu(extp->des6), le32_to_cpu(extp->des7));
   427				extp++;
   428			}
   429		} else if (desc_size == sizeof(struct dma_edesc)) {
 > 430			struct dma_edesc *ep = dma_desc_to_edesc(head);
   431	
   432			for (i = 0; i < size; i++) {
   433				dma_addr = dma_rx_phy + i * sizeof(*ep);
   434				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
   435					i, &dma_addr,
   436					le32_to_cpu(ep->des4), le32_to_cpu(ep->des5),
   437					le32_to_cpu(ep->des6), le32_to_cpu(ep->des7),
   438					le32_to_cpu(ep->basic.des0), le32_to_cpu(ep->basic.des1),
   439					le32_to_cpu(ep->basic.des2), le32_to_cpu(ep->basic.des3));
   440				ep++;
   441			}
   442		} else {
   443			pr_err("unsupported descriptor!");
   444		}
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

