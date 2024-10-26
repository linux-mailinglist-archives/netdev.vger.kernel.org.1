Return-Path: <netdev+bounces-139315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990059B1768
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 13:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7F61C20F5C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4651D2B15;
	Sat, 26 Oct 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6X+RhuU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1610217F29
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941846; cv=none; b=HEE3s4tJO3lbiasT1GRWdVWPsQBtfuA/q4xEvPwBeGqnNppSWcg0o+iJwDUIrABQzmYTscTA5rGvycConSCWsFYVJ7+UFaSKTmU769jjC6QJ25KdU2u5jVlC3r3keqVek/aPnY1sG1Oc+A5H8HouaPtc57t4Prx25ouq7g3Rcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941846; c=relaxed/simple;
	bh=oaDd5nVlwg+0uPk5/R4/SG4c+QDXrKwzqGw5wefHXzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK1+kiam222zD9Jlicaq/VsHNIZKGWdqLsgiei/WdT6214YRScPaVglDBOlcOXIy/95oIAmcJv7QnvBNw9wyaavW1hA6/WH0w14V77EmBSNm8JJpVBIv/prR45g9Ff0RRiLzcOiH6OshcviLEpIY3JCC7yOxCS2vctVeaeRdup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6X+RhuU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729941843; x=1761477843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaDd5nVlwg+0uPk5/R4/SG4c+QDXrKwzqGw5wefHXzk=;
  b=e6X+RhuUU6FlfvFIrUpMewohJ2SyWdJitqDhEZZj9bnwuuVqAL3iJlj+
   VJIlMO+iu7DeXJ7G1tF4oA7uwjoaU5tHhKn7CSUeOMeEM29zntTwfWDFR
   c3tz6Wwh763RP3Z+vw1vp26WDI5C2QTac0S8dQyj0oXgiA7P5F+p1DfgZ
   EIUUNxOsDxST1kt/Ug6cPAELcTUPYMvO3Wf9DYFVlLWoorn9oecXBw3Ap
   JjlMWGUg5OPkU+F2czVxuyxFVocZhQlZsGi6Q2JnS/LFkaimKb1Yg10JR
   iT3y4jM5dxSt7YjdTpPT5oQYMv+ICPzAS6UYxngRDspoOC0kbvgta85Nn
   g==;
X-CSE-ConnectionGUID: SxxZPKvVTjKtE+iEa3xcqg==
X-CSE-MsgGUID: qG4tvQzKQxS4FSlsT4dcrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="55015387"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="55015387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 04:24:02 -0700
X-CSE-ConnectionGUID: DXdK9i/OQOyWeyVAJDbbYw==
X-CSE-MsgGUID: Ta7gw/x2SZC4KElA3Mi7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="81622502"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Oct 2024 04:23:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4etg-000ZZ6-0n;
	Sat, 26 Oct 2024 11:23:56 +0000
Date: Sat, 26 Oct 2024 19:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] bnxt_en: replace PTP spinlock with
 seqlock
Message-ID: <202410261913.KgwVFAOV-lkp@intel.com>
References: <20241025194753.3070604-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025194753.3070604-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bnxt_en-replace-PTP-spinlock-with-seqlock/20241026-035014
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241025194753.3070604-2-vadfed%40meta.com
patch subject: [PATCH net-next v2 2/2] bnxt_en: replace PTP spinlock with seqlock
config: i386-buildonly-randconfig-004-20241026 (https://download.01.org/0day-ci/archive/20241026/202410261913.KgwVFAOV-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410261913.KgwVFAOV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410261913.KgwVFAOV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt.c:21:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:2257:19: warning: unused variable 'flags' [-Wunused-variable]
    2257 |                                 unsigned long flags;
         |                                               ^~~~~
   2 warnings generated.


vim +/flags +2257 drivers/net/ethernet/broadcom/bnxt/bnxt.c

a7445d69809fe3 Michael Chan       2023-12-01  2010  
c0c050c58d8409 Michael Chan       2015-10-22  2011  /* returns the following:
c0c050c58d8409 Michael Chan       2015-10-22  2012   * 1       - 1 packet successfully received
c0c050c58d8409 Michael Chan       2015-10-22  2013   * 0       - successful TPA_START, packet not completed yet
c0c050c58d8409 Michael Chan       2015-10-22  2014   * -EBUSY  - completion ring does not have all the agg buffers yet
c0c050c58d8409 Michael Chan       2015-10-22  2015   * -ENOMEM - packet aborted due to out of memory
c0c050c58d8409 Michael Chan       2015-10-22  2016   * -EIO    - packet aborted due to hw error indicated in BD
c0c050c58d8409 Michael Chan       2015-10-22  2017   */
e44758b78ae814 Michael Chan       2018-10-14  2018  static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
e44758b78ae814 Michael Chan       2018-10-14  2019  		       u32 *raw_cons, u8 *event)
c0c050c58d8409 Michael Chan       2015-10-22  2020  {
e44758b78ae814 Michael Chan       2018-10-14  2021  	struct bnxt_napi *bnapi = cpr->bnapi;
b6ab4b01f53b5f Michael Chan       2016-01-02  2022  	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
c0c050c58d8409 Michael Chan       2015-10-22  2023  	struct net_device *dev = bp->dev;
c0c050c58d8409 Michael Chan       2015-10-22  2024  	struct rx_cmp *rxcmp;
c0c050c58d8409 Michael Chan       2015-10-22  2025  	struct rx_cmp_ext *rxcmp1;
c0c050c58d8409 Michael Chan       2015-10-22  2026  	u32 tmp_raw_cons = *raw_cons;
a7445d69809fe3 Michael Chan       2023-12-01  2027  	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
c0c050c58d8409 Michael Chan       2015-10-22  2028  	struct bnxt_sw_rx_bd *rx_buf;
c0c050c58d8409 Michael Chan       2015-10-22  2029  	unsigned int len;
6bb19474391d17 Michael Chan       2017-02-06  2030  	u8 *data_ptr, agg_bufs, cmp_type;
ee536dcbdce496 Andy Gospodarek    2022-04-08  2031  	bool xdp_active = false;
c0c050c58d8409 Michael Chan       2015-10-22  2032  	dma_addr_t dma_addr;
c0c050c58d8409 Michael Chan       2015-10-22  2033  	struct sk_buff *skb;
b231c3f3414cfc Andy Gospodarek    2022-04-08  2034  	struct xdp_buff xdp;
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2035  	u32 flags, misc;
c13e268c076865 Michael Chan       2023-12-07  2036  	u32 cmpl_ts;
6bb19474391d17 Michael Chan       2017-02-06  2037  	void *data;
c0c050c58d8409 Michael Chan       2015-10-22  2038  	int rc = 0;
c0c050c58d8409 Michael Chan       2015-10-22  2039  
c0c050c58d8409 Michael Chan       2015-10-22  2040  	rxcmp = (struct rx_cmp *)
c0c050c58d8409 Michael Chan       2015-10-22  2041  			&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
c0c050c58d8409 Michael Chan       2015-10-22  2042  
8fe88ce7ab3181 Michael Chan       2019-07-29  2043  	cmp_type = RX_CMP_TYPE(rxcmp);
8fe88ce7ab3181 Michael Chan       2019-07-29  2044  
8fe88ce7ab3181 Michael Chan       2019-07-29  2045  	if (cmp_type == CMP_TYPE_RX_TPA_AGG_CMP) {
8fe88ce7ab3181 Michael Chan       2019-07-29  2046  		bnxt_tpa_agg(bp, rxr, (struct rx_agg_cmp *)rxcmp);
8fe88ce7ab3181 Michael Chan       2019-07-29  2047  		goto next_rx_no_prod_no_len;
8fe88ce7ab3181 Michael Chan       2019-07-29  2048  	}
8fe88ce7ab3181 Michael Chan       2019-07-29  2049  
c0c050c58d8409 Michael Chan       2015-10-22  2050  	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
c0c050c58d8409 Michael Chan       2015-10-22  2051  	cp_cons = RING_CMP(tmp_raw_cons);
c0c050c58d8409 Michael Chan       2015-10-22  2052  	rxcmp1 = (struct rx_cmp_ext *)
c0c050c58d8409 Michael Chan       2015-10-22  2053  			&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
c0c050c58d8409 Michael Chan       2015-10-22  2054  
c0c050c58d8409 Michael Chan       2015-10-22  2055  	if (!RX_CMP_VALID(rxcmp1, tmp_raw_cons))
c0c050c58d8409 Michael Chan       2015-10-22  2056  		return -EBUSY;
c0c050c58d8409 Michael Chan       2015-10-22  2057  
828affc27ed434 Michael Chan       2021-08-15  2058  	/* The valid test of the entry must be done first before
828affc27ed434 Michael Chan       2021-08-15  2059  	 * reading any further.
828affc27ed434 Michael Chan       2021-08-15  2060  	 */
828affc27ed434 Michael Chan       2021-08-15  2061  	dma_rmb();
c0c050c58d8409 Michael Chan       2015-10-22  2062  	prod = rxr->rx_prod;
c0c050c58d8409 Michael Chan       2015-10-22  2063  
a7445d69809fe3 Michael Chan       2023-12-01  2064  	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
a7445d69809fe3 Michael Chan       2023-12-01  2065  	    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
39b2e62be3704d Michael Chan       2023-12-01  2066  		bnxt_tpa_start(bp, rxr, cmp_type,
39b2e62be3704d Michael Chan       2023-12-01  2067  			       (struct rx_tpa_start_cmp *)rxcmp,
c0c050c58d8409 Michael Chan       2015-10-22  2068  			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
c0c050c58d8409 Michael Chan       2015-10-22  2069  
4e5dbbda4c40a2 Michael Chan       2017-02-06  2070  		*event |= BNXT_RX_EVENT;
e7e70fa6784b48 Colin Ian King     2018-01-16  2071  		goto next_rx_no_prod_no_len;
c0c050c58d8409 Michael Chan       2015-10-22  2072  
c0c050c58d8409 Michael Chan       2015-10-22  2073  	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
e44758b78ae814 Michael Chan       2018-10-14  2074  		skb = bnxt_tpa_end(bp, cpr, &tmp_raw_cons,
c0c050c58d8409 Michael Chan       2015-10-22  2075  				   (struct rx_tpa_end_cmp *)rxcmp,
4e5dbbda4c40a2 Michael Chan       2017-02-06  2076  				   (struct rx_tpa_end_cmp_ext *)rxcmp1, event);
c0c050c58d8409 Michael Chan       2015-10-22  2077  
1fac4b2fdbccab Tobias Klauser     2017-09-26  2078  		if (IS_ERR(skb))
c0c050c58d8409 Michael Chan       2015-10-22  2079  			return -EBUSY;
c0c050c58d8409 Michael Chan       2015-10-22  2080  
c0c050c58d8409 Michael Chan       2015-10-22  2081  		rc = -ENOMEM;
c0c050c58d8409 Michael Chan       2015-10-22  2082  		if (likely(skb)) {
ee5c7fb3404724 Sathya Perla       2017-07-24  2083  			bnxt_deliver_skb(bp, bnapi, skb);
c0c050c58d8409 Michael Chan       2015-10-22  2084  			rc = 1;
c0c050c58d8409 Michael Chan       2015-10-22  2085  		}
4e5dbbda4c40a2 Michael Chan       2017-02-06  2086  		*event |= BNXT_RX_EVENT;
e7e70fa6784b48 Colin Ian King     2018-01-16  2087  		goto next_rx_no_prod_no_len;
c0c050c58d8409 Michael Chan       2015-10-22  2088  	}
c0c050c58d8409 Michael Chan       2015-10-22  2089  
c0c050c58d8409 Michael Chan       2015-10-22  2090  	cons = rxcmp->rx_cmp_opaque;
fa7e28127a5ad9 Michael Chan       2016-05-10  2091  	if (unlikely(cons != rxr->rx_next_cons)) {
bbd6f0a9481399 Michael Chan       2021-04-23  2092  		int rc1 = bnxt_discard_rx(bp, cpr, &tmp_raw_cons, rxcmp);
fa7e28127a5ad9 Michael Chan       2016-05-10  2093  
1b5c8b63d6a4a2 Michael Chan       2020-10-04  2094  		/* 0xffff is forced error, don't print it */
1b5c8b63d6a4a2 Michael Chan       2020-10-04  2095  		if (rxr->rx_next_cons != 0xffff)
a1b0e4e684e9c3 Michael Chan       2019-04-08  2096  			netdev_warn(bp->dev, "RX cons %x != expected cons %x\n",
a1b0e4e684e9c3 Michael Chan       2019-04-08  2097  				    cons, rxr->rx_next_cons);
fea2993aecd74d Jakub Kicinski     2023-07-19  2098  		bnxt_sched_reset_rxr(bp, rxr);
bbd6f0a9481399 Michael Chan       2021-04-23  2099  		if (rc1)
fa7e28127a5ad9 Michael Chan       2016-05-10  2100  			return rc1;
bbd6f0a9481399 Michael Chan       2021-04-23  2101  		goto next_rx_no_prod_no_len;
fa7e28127a5ad9 Michael Chan       2016-05-10  2102  	}
a1b0e4e684e9c3 Michael Chan       2019-04-08  2103  	rx_buf = &rxr->rx_buf_ring[cons];
a1b0e4e684e9c3 Michael Chan       2019-04-08  2104  	data = rx_buf->data;
a1b0e4e684e9c3 Michael Chan       2019-04-08  2105  	data_ptr = rx_buf->data_ptr;
6bb19474391d17 Michael Chan       2017-02-06  2106  	prefetch(data_ptr);
c0c050c58d8409 Michael Chan       2015-10-22  2107  
c61fb99cae5195 Michael Chan       2017-02-06  2108  	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
c61fb99cae5195 Michael Chan       2017-02-06  2109  	agg_bufs = (misc & RX_CMP_AGG_BUFS) >> RX_CMP_AGG_BUFS_SHIFT;
c0c050c58d8409 Michael Chan       2015-10-22  2110  
c0c050c58d8409 Michael Chan       2015-10-22  2111  	if (agg_bufs) {
c0c050c58d8409 Michael Chan       2015-10-22  2112  		if (!bnxt_agg_bufs_valid(bp, cpr, agg_bufs, &tmp_raw_cons))
c0c050c58d8409 Michael Chan       2015-10-22  2113  			return -EBUSY;
c0c050c58d8409 Michael Chan       2015-10-22  2114  
c0c050c58d8409 Michael Chan       2015-10-22  2115  		cp_cons = NEXT_CMP(cp_cons);
4e5dbbda4c40a2 Michael Chan       2017-02-06  2116  		*event |= BNXT_AGG_EVENT;
c0c050c58d8409 Michael Chan       2015-10-22  2117  	}
4e5dbbda4c40a2 Michael Chan       2017-02-06  2118  	*event |= BNXT_RX_EVENT;
c0c050c58d8409 Michael Chan       2015-10-22  2119  
c0c050c58d8409 Michael Chan       2015-10-22  2120  	rx_buf->data = NULL;
c0c050c58d8409 Michael Chan       2015-10-22  2121  	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
8e44e96c6c8e8f Michael Chan       2019-04-08  2122  		u32 rx_err = le32_to_cpu(rxcmp1->rx_cmp_cfa_code_errors_v2);
8e44e96c6c8e8f Michael Chan       2019-04-08  2123  
c0c050c58d8409 Michael Chan       2015-10-22  2124  		bnxt_reuse_rx_data(rxr, cons, data);
c0c050c58d8409 Michael Chan       2015-10-22  2125  		if (agg_bufs)
4a228a3a5e58e5 Michael Chan       2019-07-29  2126  			bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
4a228a3a5e58e5 Michael Chan       2019-07-29  2127  					       false);
c0c050c58d8409 Michael Chan       2015-10-22  2128  
c0c050c58d8409 Michael Chan       2015-10-22  2129  		rc = -EIO;
8e44e96c6c8e8f Michael Chan       2019-04-08  2130  		if (rx_err & RX_CMPL_ERRORS_BUFFER_ERROR_MASK) {
a75fbb3aa47a62 Edwin Peer         2024-04-30  2131  			bnapi->cp_ring.sw_stats->rx.rx_buf_errors++;
1c7fd6ee2fe4ec Randy Schacher     2023-11-20  2132  			if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
8d4bd96b54dcb5 Michael Chan       2020-10-04  2133  			    !(bp->fw_cap & BNXT_FW_CAP_RING_MONITOR)) {
8fbf58e17dce8f Michael Chan       2020-10-04  2134  				netdev_warn_once(bp->dev, "RX buffer error %x\n",
19b3751ffa713d Michael Chan       2019-11-18  2135  						 rx_err);
fea2993aecd74d Jakub Kicinski     2023-07-19  2136  				bnxt_sched_reset_rxr(bp, rxr);
8e44e96c6c8e8f Michael Chan       2019-04-08  2137  			}
19b3751ffa713d Michael Chan       2019-11-18  2138  		}
0b397b17a4120c Michael Chan       2019-04-25  2139  		goto next_rx_no_len;
c0c050c58d8409 Michael Chan       2015-10-22  2140  	}
c0c050c58d8409 Michael Chan       2015-10-22  2141  
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2142  	flags = le32_to_cpu(rxcmp->rx_cmp_len_flags_type);
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2143  	len = flags >> RX_CMP_LEN_SHIFT;
11cd119d31a71b Michael Chan       2017-02-06  2144  	dma_addr = rx_buf->mapping;
c0c050c58d8409 Michael Chan       2015-10-22  2145  
b231c3f3414cfc Andy Gospodarek    2022-04-08  2146  	if (bnxt_xdp_attached(bp, rxr)) {
bbfc17e50ba2ed Michael Chan       2022-12-26  2147  		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
4c6c123c9af9c9 Andy Gospodarek    2022-04-08  2148  		if (agg_bufs) {
4c6c123c9af9c9 Andy Gospodarek    2022-04-08  2149  			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
4c6c123c9af9c9 Andy Gospodarek    2022-04-08  2150  							     cp_cons, agg_bufs,
4c6c123c9af9c9 Andy Gospodarek    2022-04-08  2151  							     false);
73011773070999 Jakub Kicinski     2024-04-23  2152  			if (!frag_len)
73011773070999 Jakub Kicinski     2024-04-23  2153  				goto oom_next_rx;
4c6c123c9af9c9 Andy Gospodarek    2022-04-08  2154  		}
ee536dcbdce496 Andy Gospodarek    2022-04-08  2155  		xdp_active = true;
ee536dcbdce496 Andy Gospodarek    2022-04-08  2156  	}
ee536dcbdce496 Andy Gospodarek    2022-04-08  2157  
9f4b28301ce6a5 Andy Gospodarek    2022-04-08  2158  	if (xdp_active) {
1614f06e09ad6b Somnath Kotur      2024-04-02  2159  		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
c6d30e8391b85e Michael Chan       2017-02-06  2160  			rc = 1;
c6d30e8391b85e Michael Chan       2017-02-06  2161  			goto next_rx;
c6d30e8391b85e Michael Chan       2017-02-06  2162  		}
b231c3f3414cfc Andy Gospodarek    2022-04-08  2163  	}
ee536dcbdce496 Andy Gospodarek    2022-04-08  2164  
c0c050c58d8409 Michael Chan       2015-10-22  2165  	if (len <= bp->rx_copy_thresh) {
0ae1fafc8be6d4 Somnath Kotur      2024-04-02  2166  		if (!xdp_active)
6bb19474391d17 Michael Chan       2017-02-06  2167  			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
0ae1fafc8be6d4 Somnath Kotur      2024-04-02  2168  		else
0ae1fafc8be6d4 Somnath Kotur      2024-04-02  2169  			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
c0c050c58d8409 Michael Chan       2015-10-22  2170  		bnxt_reuse_rx_data(rxr, cons, data);
c0c050c58d8409 Michael Chan       2015-10-22  2171  		if (!skb) {
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2172  			if (agg_bufs) {
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2173  				if (!xdp_active)
4a228a3a5e58e5 Michael Chan       2019-07-29  2174  					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
4a228a3a5e58e5 Michael Chan       2019-07-29  2175  							       agg_bufs, false);
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2176  				else
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2177  					bnxt_xdp_buff_frags_free(rxr, &xdp);
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2178  			}
73011773070999 Jakub Kicinski     2024-04-23  2179  			goto oom_next_rx;
c0c050c58d8409 Michael Chan       2015-10-22  2180  		}
c0c050c58d8409 Michael Chan       2015-10-22  2181  	} else {
c61fb99cae5195 Michael Chan       2017-02-06  2182  		u32 payload;
c61fb99cae5195 Michael Chan       2017-02-06  2183  
c6d30e8391b85e Michael Chan       2017-02-06  2184  		if (rx_buf->data_ptr == data_ptr)
c61fb99cae5195 Michael Chan       2017-02-06  2185  			payload = misc & RX_CMP_PAYLOAD_OFFSET;
c6d30e8391b85e Michael Chan       2017-02-06  2186  		else
c6d30e8391b85e Michael Chan       2017-02-06  2187  			payload = 0;
6bb19474391d17 Michael Chan       2017-02-06  2188  		skb = bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
c61fb99cae5195 Michael Chan       2017-02-06  2189  				      payload | len);
73011773070999 Jakub Kicinski     2024-04-23  2190  		if (!skb)
73011773070999 Jakub Kicinski     2024-04-23  2191  			goto oom_next_rx;
c0c050c58d8409 Michael Chan       2015-10-22  2192  	}
c0c050c58d8409 Michael Chan       2015-10-22  2193  
c0c050c58d8409 Michael Chan       2015-10-22  2194  	if (agg_bufs) {
32861236190bf1 Andy Gospodarek    2022-04-08  2195  		if (!xdp_active) {
23e4c0469ad03f Andy Gospodarek    2022-04-08  2196  			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
73011773070999 Jakub Kicinski     2024-04-23  2197  			if (!skb)
73011773070999 Jakub Kicinski     2024-04-23  2198  				goto oom_next_rx;
1dc4c557bfedfc Andy Gospodarek    2022-04-08  2199  		} else {
1dc4c557bfedfc Andy Gospodarek    2022-04-08  2200  			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
1dc4c557bfedfc Andy Gospodarek    2022-04-08  2201  			if (!skb) {
1dc4c557bfedfc Andy Gospodarek    2022-04-08  2202  				/* we should be able to free the old skb here */
a7559bc8c17c3f Andy Gospodarek    2022-04-08  2203  				bnxt_xdp_buff_frags_free(rxr, &xdp);
73011773070999 Jakub Kicinski     2024-04-23  2204  				goto oom_next_rx;
1dc4c557bfedfc Andy Gospodarek    2022-04-08  2205  			}
c0c050c58d8409 Michael Chan       2015-10-22  2206  		}
32861236190bf1 Andy Gospodarek    2022-04-08  2207  	}
c0c050c58d8409 Michael Chan       2015-10-22  2208  
c0c050c58d8409 Michael Chan       2015-10-22  2209  	if (RX_CMP_HASH_VALID(rxcmp)) {
a7445d69809fe3 Michael Chan       2023-12-01  2210  		enum pkt_hash_types type;
a7445d69809fe3 Michael Chan       2023-12-01  2211  
a7445d69809fe3 Michael Chan       2023-12-01  2212  		if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
a7445d69809fe3 Michael Chan       2023-12-01  2213  			type = bnxt_rss_ext_op(bp, rxcmp);
a7445d69809fe3 Michael Chan       2023-12-01  2214  		} else {
c0c050c58d8409 Michael Chan       2015-10-22  2215  			u32 hash_type = RX_CMP_HASH_TYPE(rxcmp);
c0c050c58d8409 Michael Chan       2015-10-22  2216  
a7445d69809fe3 Michael Chan       2023-12-01  2217  			/* RSS profiles 1 and 3 with extract code 0 for inner
a7445d69809fe3 Michael Chan       2023-12-01  2218  			 * 4-tuple
a7445d69809fe3 Michael Chan       2023-12-01  2219  			 */
c0c050c58d8409 Michael Chan       2015-10-22  2220  			if (hash_type != 1 && hash_type != 3)
c0c050c58d8409 Michael Chan       2015-10-22  2221  				type = PKT_HASH_TYPE_L3;
a7445d69809fe3 Michael Chan       2023-12-01  2222  			else
a7445d69809fe3 Michael Chan       2023-12-01  2223  				type = PKT_HASH_TYPE_L4;
a7445d69809fe3 Michael Chan       2023-12-01  2224  		}
c0c050c58d8409 Michael Chan       2015-10-22  2225  		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
c0c050c58d8409 Michael Chan       2015-10-22  2226  	}
c0c050c58d8409 Michael Chan       2015-10-22  2227  
a7445d69809fe3 Michael Chan       2023-12-01  2228  	if (cmp_type == CMP_TYPE_RX_L2_CMP)
a7445d69809fe3 Michael Chan       2023-12-01  2229  		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
a7445d69809fe3 Michael Chan       2023-12-01  2230  	skb->protocol = eth_type_trans(skb, dev);
c0c050c58d8409 Michael Chan       2015-10-22  2231  
c2f8063309da9b Michael Chan       2023-12-01  2232  	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
c2f8063309da9b Michael Chan       2023-12-01  2233  		skb = bnxt_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
c2f8063309da9b Michael Chan       2023-12-01  2234  		if (!skb)
96bdd4b9ea7ef9 Michael Chan       2021-07-18  2235  			goto next_rx;
96bdd4b9ea7ef9 Michael Chan       2021-07-18  2236  	}
c0c050c58d8409 Michael Chan       2015-10-22  2237  
c0c050c58d8409 Michael Chan       2015-10-22  2238  	skb_checksum_none_assert(skb);
c0c050c58d8409 Michael Chan       2015-10-22  2239  	if (RX_CMP_L4_CS_OK(rxcmp1)) {
c0c050c58d8409 Michael Chan       2015-10-22  2240  		if (dev->features & NETIF_F_RXCSUM) {
c0c050c58d8409 Michael Chan       2015-10-22  2241  			skb->ip_summed = CHECKSUM_UNNECESSARY;
c0c050c58d8409 Michael Chan       2015-10-22  2242  			skb->csum_level = RX_CMP_ENCAP(rxcmp1);
c0c050c58d8409 Michael Chan       2015-10-22  2243  		}
c0c050c58d8409 Michael Chan       2015-10-22  2244  	} else {
665e350ddbfde8 Satish Baddipadige 2015-12-27  2245  		if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L4_CS_ERR_BITS) {
665e350ddbfde8 Satish Baddipadige 2015-12-27  2246  			if (dev->features & NETIF_F_RXCSUM)
a75fbb3aa47a62 Edwin Peer         2024-04-30  2247  				bnapi->cp_ring.sw_stats->rx.rx_l4_csum_errors++;
c0c050c58d8409 Michael Chan       2015-10-22  2248  		}
665e350ddbfde8 Satish Baddipadige 2015-12-27  2249  	}
c0c050c58d8409 Michael Chan       2015-10-22  2250  
c13e268c076865 Michael Chan       2023-12-07  2251  	if (bnxt_rx_ts_valid(bp, flags, rxcmp1, &cmpl_ts)) {
1c7fd6ee2fe4ec Randy Schacher     2023-11-20  2252  		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2253  			u64 ns, ts;
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2254  
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2255  			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2256  				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
4ab3e4983bcc9d Vadim Fedorenko    2024-10-16 @2257  				unsigned long flags;
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2258  
e3c23abd87fef3 Vadim Fedorenko    2024-10-25  2259  				ns = bnxt_timecounter_cyc2time(ptp, ts);
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2260  				memset(skb_hwtstamps(skb), 0,
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2261  				       sizeof(*skb_hwtstamps(skb)));
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2262  				skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2263  			}
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2264  		}
7f5515d19cd7aa Pavan Chebbi       2021-06-27  2265  	}
ee5c7fb3404724 Sathya Perla       2017-07-24  2266  	bnxt_deliver_skb(bp, bnapi, skb);
c0c050c58d8409 Michael Chan       2015-10-22  2267  	rc = 1;
c0c050c58d8409 Michael Chan       2015-10-22  2268  
c0c050c58d8409 Michael Chan       2015-10-22  2269  next_rx:
6a8788f25625ea Andy Gospodarek    2018-01-09  2270  	cpr->rx_packets += 1;
6a8788f25625ea Andy Gospodarek    2018-01-09  2271  	cpr->rx_bytes += len;
e7e70fa6784b48 Colin Ian King     2018-01-16  2272  
0b397b17a4120c Michael Chan       2019-04-25  2273  next_rx_no_len:
0b397b17a4120c Michael Chan       2019-04-25  2274  	rxr->rx_prod = NEXT_RX(prod);
c09d22674b9420 Michael Chan       2023-11-20  2275  	rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
0b397b17a4120c Michael Chan       2019-04-25  2276  
e7e70fa6784b48 Colin Ian King     2018-01-16  2277  next_rx_no_prod_no_len:
c0c050c58d8409 Michael Chan       2015-10-22  2278  	*raw_cons = tmp_raw_cons;
c0c050c58d8409 Michael Chan       2015-10-22  2279  
c0c050c58d8409 Michael Chan       2015-10-22  2280  	return rc;
73011773070999 Jakub Kicinski     2024-04-23  2281  
73011773070999 Jakub Kicinski     2024-04-23  2282  oom_next_rx:
a75fbb3aa47a62 Edwin Peer         2024-04-30  2283  	cpr->sw_stats->rx.rx_oom_discards += 1;
73011773070999 Jakub Kicinski     2024-04-23  2284  	rc = -ENOMEM;
73011773070999 Jakub Kicinski     2024-04-23  2285  	goto next_rx;
c0c050c58d8409 Michael Chan       2015-10-22  2286  }
c0c050c58d8409 Michael Chan       2015-10-22  2287  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

