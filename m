Return-Path: <netdev+bounces-258026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIcTATCoimlBMwAAu9opvQ
	(envelope-from <netdev+bounces-258026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:38:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA0116C3E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0053009B15
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3C306D3F;
	Tue, 10 Feb 2026 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQGWFaXx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013E2D73B9;
	Tue, 10 Feb 2026 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694701; cv=none; b=h8YvXZ7DDqAXEx8njH48sYhdMffeT+tMS5RTARhCTZsEGL/dJ0RFFLB9/MJzAjCbAZGEkMcMhthc1qQgdeT/7xsVA8vE4lNxH6OqoAIqiioYIg1hImC47k9WeuVV+5BW1YYT8A1/+JavXZzYpwjLuJiSJ4TZU94PoBp1MABxMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694701; c=relaxed/simple;
	bh=sFVY9uRlv/uOoCrFACyildgxjy5ned4sBwWRXbHJXbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxJHdgpbeaGmv0hjEyBy3+CN3FnquB5AaE7bWygIHwE/vhEGvFddAb01r6Ize2gFmP9A1AaIU9wy9DUpcp8Zrr3duYQWTQ8BoN+W4whoNG5HIR1MDGIAI984dXEkYQpZBF5faiSgKOthAxuT1VOdojTI41gf5SnIKdFkQYEWkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQGWFaXx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770694700; x=1802230700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFVY9uRlv/uOoCrFACyildgxjy5ned4sBwWRXbHJXbw=;
  b=kQGWFaXxAwvG64aFynzuDSUnunS9qqyhSayTFmDKPyOVU1avfreERNo5
   jNcXhSMDTffJCupuBhTPR7qmB5HXN2tFdEYeomLNryWrvFnbua2wpfo7j
   05BI0jemHp0ETycypompsABoIiO7dOlY0PjAsM9WnGwzzX3HP3InrCsQl
   TmOaGXg7dgREBt+E6wzQzanko2BhpfQCDnKKngioJNEVghLb06hEEH5D2
   Ikhc6LX8ng/RDONBqaRcXpYIfcnl3RbYmzQMqXMRrXRF1MVMI1k+8r6Ol
   sRPcKmDoECV1TAb4KVoBxEjV+yVmf2FUNZzKPYe/ofx2QEGPXQCDjo2oP
   g==;
X-CSE-ConnectionGUID: UxPjRO+1QqyK5fzGgggVsA==
X-CSE-MsgGUID: Pik20103QWqL/iYFdTc4rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75440726"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75440726"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 19:38:20 -0800
X-CSE-ConnectionGUID: wMXu1XltQ82QgfR5f5jb6Q==
X-CSE-MsgGUID: 3FJlgQBrQ2WxlsuH9/BaKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211465296"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2026 19:38:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpeZr-00000000oae-2DNE;
	Tue, 10 Feb 2026 03:38:15 +0000
Date: Tue, 10 Feb 2026 11:37:57 +0800
From: kernel test robot <lkp@intel.com>
To: Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, shaojijie@huawei.com,
	Duoming Zhou <duoming@zju.edu.cn>, stable@kernel.org
Subject: Re: [PATCH net v3] atm: fore200e: fix use-after-free in tasklets
 during device removal
Message-ID: <202602101146.NCGz3JHc-lkp@intel.com>
References: <20260209094512.33847-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209094512.33847-1-duoming@zju.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,lists.sourceforge.net,vger.kernel.org,huawei.com,zju.edu.cn,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258026-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 47FA0116C3E
X-Rspamd-Action: no action

Hi Duoming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Duoming-Zhou/atm-fore200e-fix-use-after-free-in-tasklets-during-device-removal/20260209-174706
base:   net/main
patch link:    https://lore.kernel.org/r/20260209094512.33847-1-duoming%40zju.edu.cn
patch subject: [PATCH net v3] atm: fore200e: fix use-after-free in tasklets during device removal
config: i386-randconfig-141-20260210 (https://download.01.org/0day-ci/archive/20260210/202602101146.NCGz3JHc-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602101146.NCGz3JHc-lkp@intel.com/

smatch warnings:
drivers/atm/fore200e.c:367 fore200e_shutdown() warn: inconsistent indenting

vim +367 drivers/atm/fore200e.c

   353	
   354	
   355	static void
   356	fore200e_shutdown(struct fore200e* fore200e)
   357	{
   358	    printk(FORE200E "removing device %s at 0x%lx, IRQ %s\n",
   359		   fore200e->name, fore200e->phys_base, 
   360		   fore200e_irq_itoa(fore200e->irq));
   361	    
   362	    if (fore200e->state > FORE200E_STATE_RESET) {
   363		/* first, reset the board to prevent further interrupts or data transfers */
   364		fore200e_reset(fore200e, 0);
   365	    }
   366	#ifdef FORE200E_USE_TASKLET
 > 367		if (fore200e->state >= FORE200E_STATE_IRQ) {
   368			tasklet_kill(&fore200e->tx_tasklet);
   369			tasklet_kill(&fore200e->rx_tasklet);
   370		}
   371	#endif
   372	    /* then, release all allocated resources */
   373	    switch(fore200e->state) {
   374	
   375	    case FORE200E_STATE_COMPLETE:
   376		kfree(fore200e->stats);
   377	
   378		fallthrough;
   379	    case FORE200E_STATE_IRQ:
   380		free_irq(fore200e->irq, fore200e->atm_dev);
   381	
   382		fallthrough;
   383	    case FORE200E_STATE_ALLOC_BUF:
   384		fore200e_free_rx_buf(fore200e);
   385	
   386		fallthrough;
   387	    case FORE200E_STATE_INIT_BSQ:
   388		fore200e_uninit_bs_queue(fore200e);
   389	
   390		fallthrough;
   391	    case FORE200E_STATE_INIT_RXQ:
   392		fore200e_dma_chunk_free(fore200e, &fore200e->host_rxq.status);
   393		fore200e_dma_chunk_free(fore200e, &fore200e->host_rxq.rpd);
   394	
   395		fallthrough;
   396	    case FORE200E_STATE_INIT_TXQ:
   397		fore200e_dma_chunk_free(fore200e, &fore200e->host_txq.status);
   398		fore200e_dma_chunk_free(fore200e, &fore200e->host_txq.tpd);
   399	
   400		fallthrough;
   401	    case FORE200E_STATE_INIT_CMDQ:
   402		fore200e_dma_chunk_free(fore200e, &fore200e->host_cmdq.status);
   403	
   404		fallthrough;
   405	    case FORE200E_STATE_INITIALIZE:
   406		/* nothing to do for that state */
   407	
   408	    case FORE200E_STATE_START_FW:
   409		/* nothing to do for that state */
   410	
   411	    case FORE200E_STATE_RESET:
   412		/* nothing to do for that state */
   413	
   414	    case FORE200E_STATE_MAP:
   415		fore200e->bus->unmap(fore200e);
   416	
   417		fallthrough;
   418	    case FORE200E_STATE_CONFIGURE:
   419		/* nothing to do for that state */
   420	
   421	    case FORE200E_STATE_REGISTER:
   422		/* XXX shouldn't we *start* by deregistering the device? */
   423		atm_dev_deregister(fore200e->atm_dev);
   424	
   425		fallthrough;
   426	    case FORE200E_STATE_BLANK:
   427		/* nothing to do for that state */
   428		break;
   429	    }
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

