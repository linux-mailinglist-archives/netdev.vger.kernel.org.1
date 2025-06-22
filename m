Return-Path: <netdev+bounces-200072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E502AE2FF0
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C875171A0E
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80A1DE4E0;
	Sun, 22 Jun 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrkzJc+W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49B72636;
	Sun, 22 Jun 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595989; cv=none; b=ie1NhH84vfUMqkY6LjWe4GcJ/MvzNE+xoLNJYx07egXmG0ZrLbGUiBb2+NZ8wf2lv0yv9Cvn15d8Zf62d4ySPs9+ZRiVRat1/Aj5nVmh/TlYeYO0xdG8Rn6xRjwUBH/B8Sw9w9L2S30UHGio/5AQTWj57qcv3JqdTvzjdXTd6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595989; c=relaxed/simple;
	bh=+tGeE4TYJbzGe6jjsVcsSnRnbjEOtu2V64nnqedjAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3zMK9rThVNP8p33Vb7mYk6TFaXN+Zm3FDaJQ2xU8yzTTRuvfPqKBl81CvFkiXEILaRn8+p2yjsmb/gT8yfE5dzxYi6Po9L+YouyoyhKFCXXhqD6ytnkzE0Y9npvIoyCcSNPvxiy/G9696fz7BykIKwoQ6evSaf8aO67YZUHgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrkzJc+W; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750595986; x=1782131986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+tGeE4TYJbzGe6jjsVcsSnRnbjEOtu2V64nnqedjAmE=;
  b=nrkzJc+WxS/+cUSbfich7onzhT0xC2NR90Rkb9SIa+e5K1KLccamnNDp
   I20+L62qTeG5sKx7loYmjyo0jDw8QM44NszzGHaa8RcdrpCVC6eILB4mo
   t45+aSToyOsvZilCyFd/UFN0ISSqdLxUIsUQOs5WNCMGhruyKhapFxIoh
   3qCFCaWmkbnupraJXZvdbEm6yBoRvDziiarwptolOQv+K+5Y+5fF/z1h/
   O2sY40o0NZRwLsPHmGHuBGB0FfNn+CDpe/j0d5RG9C4yj1WLNb5rdK7e5
   4y8V/ec1NcvnEajQVjIrClMkZclhRLjfn+0GxWlvFZNlJ4ItDa5IryKNg
   g==;
X-CSE-ConnectionGUID: KFFe6dtvSrSJhb0GOdhQuw==
X-CSE-MsgGUID: NIw7sxRnQhelTAaLcfcvKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52952455"
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="52952455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 05:39:45 -0700
X-CSE-ConnectionGUID: 7jOf0LiDSGuYL0Bb0yoIUA==
X-CSE-MsgGUID: g/0aXbFsRLKPkVKeS/u9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="182371961"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jun 2025 05:39:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTJz1-000NGw-2y;
	Sun, 22 Jun 2025 12:39:39 +0000
Date: Sun, 22 Jun 2025 20:39:04 +0800
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
Message-ID: <202506222025.zd9UxyF7-lkp@intel.com>
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
[also build test WARNING on v6.16-rc2 next-20250620]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-10-vikas.gupta%40broadcom.com
patch subject: [net-next, 09/10] bng_en: Initialize default configuration
config: parisc-randconfig-r073-20250619 (https://download.01.org/0day-ci/archive/20250622/202506222025.zd9UxyF7-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506222025.zd9UxyF7-lkp@intel.com/

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

