Return-Path: <netdev+bounces-288164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI/bIAWPBmoVkwIAu9opvQ
	(envelope-from <netdev+bounces-288164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7DA548EC8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBC573012553
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E613CC306;
	Fri, 15 May 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ji6+mBKg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899A3CB918
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814720; cv=none; b=ZRdtaM7BkL9kXVKAGixH69tfYFMOUqDs4G5WsF+6L48kUnO/2mHnHw7TaNHDABiYaZdyh2imWOS0+etRKMxT7a1xf4SrLsxy6jWKX6UzBc1Pt8XCWXCryd0x+D5OpNw/5z93LK7AWny7B2zb+keEhakZKwDl0fvQyoypF6HkvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814720; c=relaxed/simple;
	bh=ZAmE1TlWVSf8earAcSnNud/qyU3STr7upmmNnk1CFZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLHKAifCa0sC15qtaXS8LBixbYwPO0v4e5Pfwd+s3GHY6T0HGpbfeR/CsY1aBmdu+0GF8jxZGjFa4V6ayP68oSqzUL2/dq1h7qe2159pMD/kMrfRuLrER3Q1LRjZq+6G6m1PAsyPUYQy2HlHjsf/miglYS5fw3Aju7LIvFWx5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ji6+mBKg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778814718; x=1810350718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAmE1TlWVSf8earAcSnNud/qyU3STr7upmmNnk1CFZs=;
  b=ji6+mBKgqCe7UrdYG/DupSN14bk/CEbCNqls9O858EEvvqmpmXb4GaDb
   T9OzB4vQ/OqZRkMxCPHlEfZON4GZuUXUGkAPEs0b5775SbixvkVJCo8pc
   hbPMhsWpC5q9zdTh97+HAvFASRwT8VrIu42NF2K4OdvzF177pjwpLG6Tv
   sxrxPcIBdNj792hWiyMXiQkbTIL5KISb5Ze6UyHU/YtgVNZZMo5LimVT7
   0Kgy7IDs88x+DXn4S/5+bil50xfeGFAtBVBn0jtI+caeaR0nq6bDrUEgE
   C/KoKtc/cPweXaychCDGBN3CoAgnyKWevSpijSlShmrhphhg2OQaQAo03
   w==;
X-CSE-ConnectionGUID: 4Qzq1KRNT1ObuQfGJOwDdA==
X-CSE-MsgGUID: Bl4Z/Iq8RmOU5xu+K/fETA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91150211"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="91150211"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 20:11:58 -0700
X-CSE-ConnectionGUID: cG7x5w9FRku+pLtuvvhHmA==
X-CSE-MsgGUID: jfwwuftCS1aH47xxQssZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238446336"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 20:11:56 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNiwq-000000000hR-2aAG;
	Fri, 15 May 2026 03:11:04 +0000
Date: Fri, 15 May 2026 11:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch,
	chleroy@kernel.org, qiang.zhao@nxp.com, horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <202605151029.MIApM8zq-lkp@intel.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
X-Rspamd-Queue-Id: 8F7DA548EC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288164-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi Holger,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on v7.1-rc3 next-20260508]
[cannot apply to net/main linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Holger-Brunck/net-wan-fsl_ucc_hdlc-free-tx_skbuff-in-uhdlc_memclean/20260514-055007
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260504161145.2217950-1-holger.brunck%40hitachienergy.com
patch subject: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260515/202605151029.MIApM8zq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151029.MIApM8zq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151029.MIApM8zq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/wan/fsl_ucc_hdlc.c:775:32: error: expected ';' in 'for' statement specifier
     775 |         for (i = 0; i < TX_BD_RING_LEN) {
         |                                       ^
>> drivers/net/wan/fsl_ucc_hdlc.c:775:14: warning: variable 'i' used in loop condition not modified in loop body [-Wfor-loop-analysis]
     775 |         for (i = 0; i < TX_BD_RING_LEN) {
         |                     ^
   1 warning and 1 error generated.


vim +775 drivers/net/wan/fsl_ucc_hdlc.c

   740	
   741	static void uhdlc_memclean(struct ucc_hdlc_private *priv)
   742	{
   743		int i;
   744	
   745		qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
   746		qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
   747	
   748		if (priv->rx_bd_base) {
   749			dma_free_coherent(priv->dev,
   750					  RX_BD_RING_LEN * sizeof(struct qe_bd),
   751					  priv->rx_bd_base, priv->dma_rx_bd);
   752	
   753			priv->rx_bd_base = NULL;
   754			priv->dma_rx_bd = 0;
   755		}
   756	
   757		if (priv->tx_bd_base) {
   758			dma_free_coherent(priv->dev,
   759					  TX_BD_RING_LEN * sizeof(struct qe_bd),
   760					  priv->tx_bd_base, priv->dma_tx_bd);
   761	
   762			priv->tx_bd_base = NULL;
   763			priv->dma_tx_bd = 0;
   764		}
   765	
   766		if (priv->ucc_pram) {
   767			qe_muram_free(priv->ucc_pram_offset);
   768			priv->ucc_pram = NULL;
   769			priv->ucc_pram_offset = 0;
   770		 }
   771	
   772		kfree(priv->rx_skbuff);
   773		priv->rx_skbuff = NULL;
   774	
 > 775		for (i = 0; i < TX_BD_RING_LEN) {
   776			kfree(priv->tx_skbuff[i]);
   777			priv->tx_skbuff[i] = NULL;
   778		}
   779	
   780		kfree(priv->tx_skbuff);
   781		priv->tx_skbuff = NULL;
   782	
   783		if (priv->uccf) {
   784			ucc_fast_free(priv->uccf);
   785			priv->uccf = NULL;
   786		}
   787	
   788		if (priv->rx_buffer) {
   789			dma_free_coherent(priv->dev,
   790					  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
   791					  priv->rx_buffer, priv->dma_rx_addr);
   792			priv->rx_buffer = NULL;
   793			priv->dma_rx_addr = 0;
   794	
   795			priv->tx_buffer = NULL;
   796			priv->dma_tx_addr = 0;
   797	
   798		}
   799	}
   800	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

