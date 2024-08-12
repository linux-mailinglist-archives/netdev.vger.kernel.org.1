Return-Path: <netdev+bounces-117599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40F94E776
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A22282A03
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6237154C02;
	Mon, 12 Aug 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNYtOtTM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7115381C;
	Mon, 12 Aug 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446613; cv=none; b=FTagMCA/OCj4pj8+Vh8i2l8ERBHgTgdj+BZnvB+PypmFbPKCIvwQIMBvNvuWdhOkDeLN8I0ur/t3V/dF1xUho0UoSpcFY/KbnkK6lxzBD88l/YMk+4oKJNNlcl9A4mOAa+RlrezmjbaBDdeMIulzTVckD3IeZVavNgVRfDg+nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446613; c=relaxed/simple;
	bh=fYltnFmEiOiKgfSB6EHkrcCpM17ixHxAaRtD3gsQQTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrxOJsUBjm/CNdS+iibPuR6SZRciGDfkvIF7ZK9mA/udqm5zBXO8hS2rNWhu1KrZmBgD2scvmy/7BhqEm6083vfL5yxZxBk3dA25qx9j5Ly4hB3JL6HOgRR0vOCiwF63fxEhknyvZjskIArWSl/sfAGLV6AkhFMJgQrJ8VK5oYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNYtOtTM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723446612; x=1754982612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fYltnFmEiOiKgfSB6EHkrcCpM17ixHxAaRtD3gsQQTM=;
  b=XNYtOtTMD2E6IG5748Z95bC3VrRxPF09LaZIMPLyIHP1H1ml3LjoM896
   O6whQZVBfYBCosYOnxaLQO68lN2AtVbYGoiQgPpjopdDYrXLBC6BJZ/Xb
   I1i3nK2FKURoLhLMM0ukq4u0tmyFsgUblhSLsCeTwwQoHKHciBdJaV0EW
   NwCS50Eam0/5NAoqiPa0UANnbw1phPb8JLbZQBp+rIFNDKMepOndeOSNV
   zeAMfyS1sTGXzmrk405H2PNE03nkQ5yd8pu0nQJyLp0RGgM3vgN98uMX5
   EgriOp4drGFKtwwxJG/IQK+xU5E8v6HXtVfTSC0TyM+h5f59WsN2s3Tlj
   g==;
X-CSE-ConnectionGUID: vieX0jQdQlGFcDsRU7ettw==
X-CSE-MsgGUID: O9OvklItSUyf4JjkaoUYrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32215199"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32215199"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:10:11 -0700
X-CSE-ConnectionGUID: NhLA91O6T8O6vY/mCcDL3w==
X-CSE-MsgGUID: gcvM4RpCRna69SxJqqn3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="81406658"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2024 00:10:07 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdPBt-000BTf-1M;
	Mon, 12 Aug 2024 07:10:05 +0000
Date: Mon, 12 Aug 2024 15:09:44 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, eladwf@gmail.com, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO
 rings release
Message-ID: <202408121439.06IztS3Y-lkp@intel.com>
References: <20240811184949.2799-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811184949.2799-1-eladwf@gmail.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Yifee/net-ethernet-mtk_eth_soc-fix-memory-leak-in-LRO-rings-release/20240812-025108
base:   net/main
patch link:    https://lore.kernel.org/r/20240811184949.2799-1-eladwf%40gmail.com
patch subject: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240812/202408121439.06IztS3Y-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408121439.06IztS3Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408121439.06IztS3Y-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_rx_put_buff':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:28: error: passing argument 1 of 'free_pages' makes integer from pointer without a cast [-Wint-conversion]
    1768 |                 free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                            ^~~~
         |                            |
         |                            void *
   In file included from include/linux/xarray.h:16,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:18,
                    from drivers/net/ethernet/mediatek/mtk_eth_soc.c:9:
   include/linux/gfp.h:372:38: note: expected 'long unsigned int' but argument is of type 'void *'
     372 | extern void free_pages(unsigned long addr, unsigned int order);
         |                        ~~~~~~~~~~~~~~^~~~


vim +/free_pages +1768 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1759	
  1760	static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
  1761	{
  1762		if (ring->page_pool)
  1763			page_pool_put_full_page(ring->page_pool,
  1764						virt_to_head_page(data), napi);
  1765		else if (ring->frag_size <= PAGE_SIZE)
  1766			skb_free_frag(data);
  1767		else
> 1768			free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
  1769	}
  1770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

