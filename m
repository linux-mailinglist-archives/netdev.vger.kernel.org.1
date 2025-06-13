Return-Path: <netdev+bounces-197354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F813AD839F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03C33B29DE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531424DD1A;
	Fri, 13 Jun 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLGSEuhO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF31EE7C6;
	Fri, 13 Jun 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798307; cv=none; b=KcunoDYB/zqjcka2o23V9xncy+n9+WDDBpoO9g1siqXm6FyJom42yCt9pSNuV9qHAqFfI6TUz94fE/184c0gLgUjzWJoErKp1V8Y9iXwDLoSGWCMqY2DP8qv2hTnZVsHGhtY8y/tghH+oabDWiTaDHQtGe/Bi1O34uvOzIOn9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798307; c=relaxed/simple;
	bh=YPhirRC/fqgXNZyCmveCpTKVmiZA7ueG5zIrOKWu6sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6wQxLDmYgQoh2ByCg0HdTu9h5r/h94ieFntzTemsfBktlNsvCX2RbVbpX+4zI4fsyZwVaDx1f75mBvRAQFHdNF9gXbD0WZK2oMjHtxQhgAxYI8oOg2sXO9HORZPMYESNXBhAOv89oEgBWhTanwriEwTH9/KnOfsmKuvTUgnO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLGSEuhO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749798306; x=1781334306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPhirRC/fqgXNZyCmveCpTKVmiZA7ueG5zIrOKWu6sI=;
  b=LLGSEuhOZQkOb9loS/sqDV6u+2gsn9+KmQEloOyHyYkrFCNwtYRpwemm
   k2NisS9UWEX7DCiE7BlduUa70ZPdLaBY4glT31f+S3Xn9ToEbde5osfmn
   qNwjyFxcM3ePrEj9pdbR4KKwBAnpOc6hgwxrkUapiViHLC9tixCLjNaQX
   +EGTrdL5SS6sQ6vAXMMpZrPEL8/w6JCj94RwCB93P+da6AwZZULR2cz3h
   fY8FecLQby5njqLNkrbCAEZsQksNqU9wKWIVdvuliKJPYjwj05AFHlVfA
   50wOwJm57gUHYaU0zQVYpBPCGsStPYhwkDuXFH94pwYCPcIp0Jl4Hqs2t
   Q==;
X-CSE-ConnectionGUID: 5epJTmOwRuiZ3IfrVJ8Zog==
X-CSE-MsgGUID: FA3JHCVFShK0YF3Wf3VKNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51878656"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51878656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:04:53 -0700
X-CSE-ConnectionGUID: S+YzazeVS0qcM0G9gtFmGQ==
X-CSE-MsgGUID: ZaxUnIRhSNWmOJKg/4rtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="170929459"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Jun 2025 00:04:50 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPyT2-000CJ4-0W;
	Fri, 13 Jun 2025 07:04:48 +0000
Date: Fri, 13 Jun 2025 15:04:02 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (drivers/ethernet/atheros/atl1) test DMA mapping for
 error code
Message-ID: <202506131458.MnU50xNO-lkp@intel.com>
References: <20250612150542.85239-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612150542.85239-2-fourier.thomas@gmail.com>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc1 next-20250612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Fourier/drivers-ethernet-atheros-atl1-test-DMA-mapping-for-error-code/20250612-231733
base:   linus/master
patch link:    https://lore.kernel.org/r/20250612150542.85239-2-fourier.thomas%40gmail.com
patch subject: [PATCH] (drivers/ethernet/atheros/atl1) test DMA mapping for error code
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250613/202506131458.MnU50xNO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250613/202506131458.MnU50xNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506131458.MnU50xNO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/atheros/atlx/atl1.c: In function 'atl1_tx_map':
>> drivers/net/ethernet/atheros/atlx/atl1.c:2315:34: warning: assignment to 'dma_addr_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
    2315 |                 buffer_info->dma = NULL;
         |                                  ^
>> drivers/net/ethernet/atheros/atlx/atl1.c:2317:39: error: 'tdp_ring' undeclared (first use in this function); did you mean 'tpd_ring'?
    2317 |                 if (++first_mapped == tdp_ring->count)
         |                                       ^~~~~~~~
         |                                       tpd_ring
   drivers/net/ethernet/atheros/atlx/atl1.c:2317:39: note: each undeclared identifier is reported only once for each function it appears in


vim +2317 drivers/net/ethernet/atheros/atlx/atl1.c

  2192	
  2193	static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
  2194		struct tx_packet_desc *ptpd)
  2195	{
  2196		struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
  2197		struct atl1_buffer *buffer_info;
  2198		u16 buf_len = skb->len;
  2199		struct page *page;
  2200		unsigned long offset;
  2201		unsigned int nr_frags;
  2202		unsigned int f;
  2203		int retval;
  2204		u16 next_to_use;
  2205		u16 first_mapped;
  2206		u16 data_len;
  2207		u8 hdr_len;
  2208	
  2209		buf_len -= skb->data_len;
  2210		nr_frags = skb_shinfo(skb)->nr_frags;
  2211		next_to_use = atomic_read(&tpd_ring->next_to_use);
  2212		first_mapped = next_to_use;
  2213		buffer_info = &tpd_ring->buffer_info[next_to_use];
  2214		BUG_ON(buffer_info->skb);
  2215		/* put skb in last TPD */
  2216		buffer_info->skb = NULL;
  2217	
  2218		retval = (ptpd->word3 >> TPD_SEGMENT_EN_SHIFT) & TPD_SEGMENT_EN_MASK;
  2219		if (retval) {
  2220			/* TSO */
  2221			hdr_len = skb_tcp_all_headers(skb);
  2222			buffer_info->length = hdr_len;
  2223			page = virt_to_page(skb->data);
  2224			offset = offset_in_page(skb->data);
  2225			buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
  2226							offset, hdr_len,
  2227							DMA_TO_DEVICE);
  2228			if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
  2229				goto dma_err;
  2230	
  2231			if (++next_to_use == tpd_ring->count)
  2232				next_to_use = 0;
  2233	
  2234			if (buf_len > hdr_len) {
  2235				int i, nseg;
  2236	
  2237				data_len = buf_len - hdr_len;
  2238				nseg = (data_len + ATL1_MAX_TX_BUF_LEN - 1) /
  2239					ATL1_MAX_TX_BUF_LEN;
  2240				for (i = 0; i < nseg; i++) {
  2241					buffer_info =
  2242					    &tpd_ring->buffer_info[next_to_use];
  2243					buffer_info->skb = NULL;
  2244					buffer_info->length =
  2245					    (ATL1_MAX_TX_BUF_LEN >=
  2246					     data_len) ? ATL1_MAX_TX_BUF_LEN : data_len;
  2247					data_len -= buffer_info->length;
  2248					page = virt_to_page(skb->data +
  2249						(hdr_len + i * ATL1_MAX_TX_BUF_LEN));
  2250					offset = offset_in_page(skb->data +
  2251						(hdr_len + i * ATL1_MAX_TX_BUF_LEN));
  2252					buffer_info->dma = dma_map_page(&adapter->pdev->dev,
  2253									page, offset,
  2254									buffer_info->length,
  2255									DMA_TO_DEVICE);
  2256					if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
  2257						goto dma_err;
  2258					if (++next_to_use == tpd_ring->count)
  2259						next_to_use = 0;
  2260				}
  2261			}
  2262		} else {
  2263			/* not TSO */
  2264			buffer_info->length = buf_len;
  2265			page = virt_to_page(skb->data);
  2266			offset = offset_in_page(skb->data);
  2267			buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
  2268							offset, buf_len,
  2269							DMA_TO_DEVICE);
  2270			if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
  2271				goto dma_err;
  2272			if (++next_to_use == tpd_ring->count)
  2273				next_to_use = 0;
  2274		}
  2275	
  2276		for (f = 0; f < nr_frags; f++) {
  2277			const skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
  2278			u16 i, nseg;
  2279	
  2280			buf_len = skb_frag_size(frag);
  2281	
  2282			nseg = (buf_len + ATL1_MAX_TX_BUF_LEN - 1) /
  2283				ATL1_MAX_TX_BUF_LEN;
  2284			for (i = 0; i < nseg; i++) {
  2285				buffer_info = &tpd_ring->buffer_info[next_to_use];
  2286				BUG_ON(buffer_info->skb);
  2287	
  2288				buffer_info->skb = NULL;
  2289				buffer_info->length = (buf_len > ATL1_MAX_TX_BUF_LEN) ?
  2290					ATL1_MAX_TX_BUF_LEN : buf_len;
  2291				buf_len -= buffer_info->length;
  2292				buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
  2293					frag, i * ATL1_MAX_TX_BUF_LEN,
  2294					buffer_info->length, DMA_TO_DEVICE);
  2295				if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
  2296					goto dma_err;
  2297	
  2298				if (++next_to_use == tpd_ring->count)
  2299					next_to_use = 0;
  2300			}
  2301		}
  2302	
  2303		/* last tpd's buffer-info */
  2304		buffer_info->skb = skb;
  2305	
  2306		return 0;
  2307	
  2308	 dma_err:
  2309		while (first_mapped != next_to_use) {
  2310			buffer_info = &tpd_ring->buffer_info[first_mapped];
  2311			dma_unmap_page(&adapter->pdev->dev,
  2312				       buffer_info->dma,
  2313				       buffer_info->length,
  2314				       DMA_TO_DEVICE);
> 2315			buffer_info->dma = NULL;
  2316	
> 2317			if (++first_mapped == tdp_ring->count)
  2318				first_mapped = 0;
  2319		}
  2320		return -ENOMEM;
  2321	}
  2322	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

