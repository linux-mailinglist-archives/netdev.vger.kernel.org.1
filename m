Return-Path: <netdev+bounces-163755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C32A2B7C9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970A2166F6C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF647DA67;
	Fri,  7 Feb 2025 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrVaz5iU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA1EAE7;
	Fri,  7 Feb 2025 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891366; cv=none; b=Zy6pjdcpBexGbl6ud6/RQnxX/YYwEg+S7ngkz3tNCXz0tkQuxs5tPiWBmNjI62qwKcsN+WOzOw90d8qKjr/zeVFffwxdcP9TVXmEnrhsY3S4zVp89cy8heOxlaQ83CPU+cQc+XEWKcZTVs3rrGmkDp+vCI3GpJcdYSEnnx3TVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891366; c=relaxed/simple;
	bh=5ut+Ydpor1ahOdNF19/psEAjOTq+kvpzRyrgKmmrAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiLL/228wxluRSJiXPtGuxUKuVUSWganAd7uFLFHUFRSbocW/H4VbZXwthKRWOeanRtMs57HLPdTCNWqOi9JVm2B66SEhW370LUv1tU+u5Lh90qXIhkYZus50ZAmUbqiwrXZPSbfTVdMaecvoxhERKJoFbWa069H9Fd8BAaBZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrVaz5iU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738891365; x=1770427365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ut+Ydpor1ahOdNF19/psEAjOTq+kvpzRyrgKmmrAj0=;
  b=BrVaz5iUlC7yYoUYPWs35bzOm5/0IbeNK2pmEF/2lF2NdYroSlBIVUkT
   ovpAl68h/2VpAKE/qtAWLPLMQIZW226RLHdLPWJ2tIkr9ODmcxeH0q+/z
   rV7r+emhAlMPstqC6o3d6i49KyRYNm0SaQ2YdyBi8Y9evg+VM4Z/Abh1f
   YeOCMZFJ7jwxLdjxXFzd/CwIW2w4d8MpmdKdDFlQplnfqfaikLX38PLW1
   0VWr+yL+ZQwwhngA1bgJOz0CCv3/1eG7LYDF+Ro/dgwVHvFTIp2RBooNZ
   BZCXcrdx2gu8P5T/VUiPYUZssHNcGp8Eu4U6z9O0vyqAWiiHRCTchPYrj
   Q==;
X-CSE-ConnectionGUID: zCW/W4QrRo6OjbssNUy5YA==
X-CSE-MsgGUID: TFPt8IZpRfKslbAz51se2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50163523"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="50163523"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 17:22:44 -0800
X-CSE-ConnectionGUID: 3BgyQzXhS+O8cXOSB2i9Dg==
X-CSE-MsgGUID: TVAGk+wRSrKWwYeco9ojng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="112002202"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Feb 2025 17:22:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgD4n-000xbb-2Y;
	Fri, 07 Feb 2025 01:22:37 +0000
Date: Fri, 7 Feb 2025 09:21:37 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 10/13] net: airoha: Introduce PPE initialization
 via NPU
Message-ID: <202502070935.LuHfHz3M-lkp@intel.com>
References: <20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 135c3c86a7cef4ba3d368da15b16c275b74582d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-airoha-Move-airoha_eth-driver-in-a-dedicated-folder/20250206-022555
base:   135c3c86a7cef4ba3d368da15b16c275b74582d3
patch link:    https://lore.kernel.org/r/20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01%40kernel.org
patch subject: [PATCH net-next 10/13] net: airoha: Introduce PPE initialization via NPU
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250207/202502070935.LuHfHz3M-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502070935.LuHfHz3M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502070935.LuHfHz3M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/airoha/airoha_npu.c:201:30: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     200 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                                                          ~~~
         |                                                          %zu
     201 |                         NPU_EN7581_FIRMWARE_RV32, fw->size);
         |                                                   ^~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/net/ethernet/airoha/airoha_npu.c:221:30: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     220 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                                                          ~~~
         |                                                          %zu
     221 |                         NPU_EN7581_FIRMWARE_DATA, fw->size);
         |                                                   ^~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +201 drivers/net/ethernet/airoha/airoha_npu.c

   187	
   188	static int airoha_npu_run_firmware(struct airoha_npu *npu, struct reserved_mem *rmem)
   189	{
   190		struct device *dev = &npu->pdev->dev;
   191		const struct firmware *fw;
   192		void __iomem *addr;
   193		int ret;
   194	
   195		ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
   196		if (ret)
   197			return ret;
   198	
   199		if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
   200			dev_err(dev, "%s: fw size too overlimit (%ld)\n",
 > 201				NPU_EN7581_FIRMWARE_RV32, fw->size);
   202			ret = -E2BIG;
   203			goto out;
   204		}
   205	
   206		addr = devm_ioremap(dev, rmem->base, rmem->size);
   207		if (!addr) {
   208			ret = -ENOMEM;
   209			goto out;
   210		}
   211	
   212		memcpy_toio(addr, fw->data, fw->size);
   213		release_firmware(fw);
   214	
   215		ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
   216		if (ret)
   217			return ret;
   218	
   219		if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
   220			dev_err(dev, "%s: fw size too overlimit (%ld)\n",
   221				NPU_EN7581_FIRMWARE_DATA, fw->size);
   222			ret = -E2BIG;
   223			goto out;
   224		}
   225	
   226		memcpy_toio(npu->base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
   227	out:
   228		release_firmware(fw);
   229	
   230		return ret;
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

