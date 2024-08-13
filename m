Return-Path: <netdev+bounces-118178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AF950E33
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201B62834EB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AA44C61;
	Tue, 13 Aug 2024 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbFwj5OY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B941A706A;
	Tue, 13 Aug 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582667; cv=none; b=R0Qu63B21d8CF0BNfm2wbmoDa8wTBXWZrUvS05XohZAO+QMW0wP0znO1EoKp1zbo5O63BkIJQU9Wx638tVx/G1DC0EW4Qv6WdrujTYvAAtPPJK6zcTQs8l8D8GYHOl/GrlYxUVYa5OJEMjNs5a0WqLt2fXemOhKMFffoBewYpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582667; c=relaxed/simple;
	bh=FQT+KebYObSkEnpMhMAsJ6OvS03Y+3o431aCHS4Aaec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlytnIbq8PD6ENZFe/NdV5lg/NfGf9wgD2yWu9tEWxp/FlYHFBIGn7cHBJKI+lLmeTY0nMOlHTQMG9MJHTpqf9bFF2ZyO7phdXG6jZKl8AzfbGuM5HIg5mbAIaNNp5nyfGij7/H3Gx+z/hSc5Llgkz8yWOorYQ765bQo3xeYtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbFwj5OY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723582666; x=1755118666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FQT+KebYObSkEnpMhMAsJ6OvS03Y+3o431aCHS4Aaec=;
  b=RbFwj5OYorElY6lRB93z1b8uXFLLxn518tQ4RPSFLDsiojd7irIt1QNL
   bpMg3KtTY79PtZLRTa9k/T3YcYaUdqwppkT82cu36ST1I4Bt3Be4/oHXx
   GnCQF3npZ+7Tu3FHstpcEQB3ip8wMNwnTXhsLx0EBXXDrJJiszelhci2h
   vmYLm2tqrSlFDLc4VVW/muwiled3pJihXXw7AvclhPUUitAxZZFqYYiz4
   t9LGIrrn7N1eJmtGFDKnNQbd01zK3zBKR50/nMetwMIiRFlNPVTRv3Vyr
   V/AmsO7rq+nR52Lu/Gm/KOM6XzzUkWuUPSgCwxmRSgmiM4+Vktto5kRJl
   g==;
X-CSE-ConnectionGUID: ikMK1fehS1C9ifXnMNSEtg==
X-CSE-MsgGUID: 7mNTCYReTKy1KNnFT2A3gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21639489"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21639489"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:57:45 -0700
X-CSE-ConnectionGUID: 1JjFaYRYRUqKD464Ry3nEg==
X-CSE-MsgGUID: iN+E3gbFRW+hzbH402Lbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58891446"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2024 13:57:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdyaG-0000iy-2c;
	Tue, 13 Aug 2024 20:57:36 +0000
Date: Wed, 14 Aug 2024 04:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, eladwf@gmail.com,
	daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in
 LRO rings release
Message-ID: <202408140408.smKpJgMF-lkp@intel.com>
References: <20240812152126.14598-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812152126.14598-1-eladwf@gmail.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Yifee/net-ethernet-mtk_eth_soc-fix-memory-leak-in-LRO-rings-release/20240813-015755
base:   net/main
patch link:    https://lore.kernel.org/r/20240812152126.14598-1-eladwf%40gmail.com
patch subject: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240814/202408140408.smKpJgMF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240814/202408140408.smKpJgMF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408140408.smKpJgMF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:14: error: expected expression
    1768 |                 free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                            ^
   1 error generated.


vim +1768 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1759	
  1760	static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
  1761	{
  1762		if (ring->page_pool)
  1763			page_pool_put_full_page(ring->page_pool,
  1764						virt_to_head_page(data), napi);
  1765		else if (ring->frag_size <= PAGE_SIZE)
  1766			skb_free_frag(data);
  1767		else
> 1768			free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
  1769	}
  1770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

