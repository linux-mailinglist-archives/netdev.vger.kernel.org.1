Return-Path: <netdev+bounces-201494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1EAE98F2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA62A6A57B9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C6295D95;
	Thu, 26 Jun 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMRfvtOA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536A2264CA;
	Thu, 26 Jun 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927664; cv=none; b=WTRSZZF9IwHUu4oJu9NOf5+PKGuxfJyigqnvh5iJdBHxiaJZ7Wb6LZzL3ue/vzkkXXVwSC9FdmQNyUEJJrOzyNghBqbOqd04gFRBzP00OOs8E2oCejwNVkkM30yNbBdqAEcpnPRjzxRS9FStwx+fQnMlVE/b0bx2vXNLc+KuPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927664; c=relaxed/simple;
	bh=9U5EJmrGekA99glFhmw1yFwAVYppR9L38j/mg1yJuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz4w1iWj/cr1I7nLuwrjXMllo6BW3fO1ssfJ6ACagixmWdT9CF/FKnVrWeHVh/AMXqqHQAT2Om/nt9ZiJKhBefDCDEjC3AoJgObSHub0yfepmhtYPByTNaII4cV7CXmQSQPWg5j5bYTI4zaWtGI3VjXCJka/e+4FhOFcnOUssys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMRfvtOA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750927663; x=1782463663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9U5EJmrGekA99glFhmw1yFwAVYppR9L38j/mg1yJuPw=;
  b=JMRfvtOAOK3I/bh6R/TJvazUUhPIhAHISun6Qmc1hNxdPOQ6bg4rFqrf
   h7f5NwWKbNZBgCYiNmHT1zBhYzev6v2B+GFXnjrzKTw2l2hBaxAC4RE1B
   NdObq84Z4rTZVnHEvnjjRGnWpCDz5PleMhuyIEoOX2N+8EHJ+dEJUvfRd
   fv6XBApjaAsBQrnsrfWWhsdvgD3qGJmqGexsDUkiQQ6fNnwwMRFH1Cq4J
   Dbe9QYBNWsKk+6rExREm1O9Uvxx2lfiBkGdjY7RjqApdJljv8msiQouof
   VC3sRvqAuhnoaw/ieuY7Z2uVkrk8sKXTVTgdaSGxV0PdLz5ZNgNlOVa+j
   A==;
X-CSE-ConnectionGUID: MCRTK1owQCWWHr4j0tGstQ==
X-CSE-MsgGUID: 4xj+5SZXTzupyQ4WgYcRkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64275846"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="64275846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 01:47:42 -0700
X-CSE-ConnectionGUID: yntKr3jvRbe5ZE7vwaljQg==
X-CSE-MsgGUID: vu6V/rAoSI+a7Oip97YJTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="176119027"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 01:47:39 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUiGf-000Ttq-08;
	Thu, 26 Jun 2025 08:47:37 +0000
Date: Thu, 26 Jun 2025 16:47:07 +0800
From: kernel test robot <lkp@intel.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, 09/10] bng_en: Initialize default configuration
Message-ID: <202506261600.oLXe1N0I-lkp@intel.com>
References: <20250618144743.843815-10-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618144743.843815-10-vikas.gupta@broadcom.com>

Hi Vikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250625]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-10-vikas.gupta%40broadcom.com
patch subject: [net-next, 09/10] bng_en: Initialize default configuration
config: parisc-randconfig-r073-20250619 (https://download.01.org/0day-ci/archive/20250626/202506261600.oLXe1N0I-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506261600.oLXe1N0I-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/broadcom/bnge/bnge_resc.c:533 bnge_net_init_dflt_rings() warn: always true condition '(rc != -19) => (0-u16max != (-19))'

Old smatch warnings:
drivers/net/ethernet/broadcom/bnge/bnge_resc.c:372 bnge_alloc_irqs() warn: unsigned 'irqs_demand' is never less than zero.
drivers/net/ethernet/broadcom/bnge/bnge_resc.c:542 bnge_net_init_dflt_rings() warn: always true condition '(rc != -19) => (0-u16max != (-19))'

vim +533 drivers/net/ethernet/broadcom/bnge/bnge_resc.c

   511	
   512	static int bnge_net_init_dflt_rings(struct bnge_dev *bd, bool sh)
   513	{
   514		u16 dflt_rings, max_rx_rings, max_tx_rings, rc;
   515	
   516		if (sh)
   517			bd->flags |= BNGE_EN_SHARED_CHNL;
   518	
   519		dflt_rings = netif_get_num_default_rss_queues();
   520	
   521		rc = bnge_get_dflt_rings(bd, &max_rx_rings, &max_tx_rings, sh);
   522		if (rc)
   523			return rc;
   524		bd->rx_nr_rings = min_t(u16, dflt_rings, max_rx_rings);
   525		bd->tx_nr_rings_per_tc = min_t(u16, dflt_rings, max_tx_rings);
   526		if (sh)
   527			bnge_trim_dflt_sh_rings(bd);
   528		else
   529			bd->nq_nr_rings = bd->tx_nr_rings_per_tc + bd->rx_nr_rings;
   530		bd->tx_nr_rings = bd->tx_nr_rings_per_tc;
   531	
   532		rc = bnge_reserve_rings(bd);
 > 533		if (rc && rc != -ENODEV)
   534			dev_warn(bd->dev, "Unable to reserve tx rings\n");
   535		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
   536		if (sh)
   537			bnge_trim_dflt_sh_rings(bd);
   538	
   539		/* Rings may have been reduced, re-reserve them again */
   540		if (bnge_need_reserve_rings(bd)) {
   541			rc = bnge_reserve_rings(bd);
   542			if (rc && rc != -ENODEV)
   543				dev_warn(bd->dev, "Fewer rings reservation failed\n");
   544			bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
   545		}
   546		if (rc) {
   547			bd->tx_nr_rings = 0;
   548			bd->rx_nr_rings = 0;
   549		}
   550	
   551		return rc;
   552	}
   553	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

